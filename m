Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D42C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4658D20754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCQNMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:12:08 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:62921 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgCQNMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:12:07 -0400
Received: from [100.113.4.131] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 25/09-40261-5ACC07E5; Tue, 17 Mar 2020 13:12:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsVy8MN7Xd2lZwr
  iDNrPMVnMOd/CYtG8eD2bxaqF19gsLu+aw2bx/lMnk8X/PTvYHdg8tqy8yeTRcuQtq8emVZ1s
  HvvnrmH3+LxJLoA1ijUzLym/IoE1Y87yB6wFxzgrVp1pZm9g3MfRxcjFISSwllFizoIvTF2Mn
  EBOpcTOXxPYQWxegQiJp/9vgNmcAmYSk+Y/YoaoMZWY1b6FBcRmE9CReDRzPVgvi4CqRO+as2
  A1wgJxEt+nfmQCWSAicJFR4snjP2wgCWagxKyG5awQCwQlTs58wgIRl5A4+OIF1AItiXNrVjF
  OYOSdhaRsFpKyBYxMqxgtk4oy0zNKchMzc3QNDQx0DQ2NdU2BLHO9xCrdJL3UUt3k1LySokSg
  rF5iebFecWVuck6KXl5qySZGYOimFLJm72DcOv+93iFGSQ4mJVHe4DkFcUJ8SfkplRmJxRnxR
  aU5qcWHGGU4OJQkeDVPA+UEi1LTUyvSMnOAcQSTluDgURLh7T4FlOYtLkjMLc5Mh0idYtTl2H
  l03iJmIZa8/LxUKXHe5SBFAiBFGaV5cCNgMX2JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjB
  vC8glPJl5JXCbXgEdwQR0RMWGfJAjShIRUlINTNNy/Dg6/TIiDH8YrBMrlVjw9cZdR/m9rMv5
  GgJnJmy1SBI7fSxA6KxKqu+GNtE5orZpn/bk8C39XKpSdOfynNsc4Sc6k7Q4/jzesdDqe7UJ9
  /Smgnkz0mRzpdqmWwtIOAYckC59rDXnuc/Ut+fFfawtDYtm3g/4WrnW7Z/f6kMP9ipl/krZsz
  1qWtTngknrfd9NZZf6m3XzI/+y/He6XWsS9E7VLstwMs6YuVs67tGn8BUMC+PzlzM4PjrG3XN
  og87BGy+dvh8sDJJ4qJ33L3mOsvfps007p3HrZjgW7GxUvPH6rWrMPw6D6bMt5GZPk3036eZ5
  fRdHhnNKwUICD9Z/jXn0fsFGK/X8z6syYpVYijMSDbWYi4oTAV2MD+FkAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-18.tower-246.messagelabs.com!1584450724!1103421!2
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9047 invoked from network); 17 Mar 2020 13:12:05 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-18.tower-246.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Mar 2020 13:12:05 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 17 Mar 2020 14:12:03 +0100
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 E20F513F670; Tue, 17 Mar 2020 22:12:01 +0900 (KST)
Message-ID: <c7b6acaca7625e22e38e51da97279be2f0ace600.1584445730.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1584445730.git.Roy.Im@diasemi.com>
References: <cover.1584445730.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 17 Mar 2020 20:48:49 +0900
Subject: [PATCH V11 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v11: No changes.
v10: No changes.
v9: No changes.
v8: No changes.
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56765f5..3f71379 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4856,6 +4856,7 @@ S:	Supported
 F:	Documentation/hwmon/da90??.rst
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -4865,6 +4866,7 @@ F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
-- 
end-of-patch for PATCH V11

