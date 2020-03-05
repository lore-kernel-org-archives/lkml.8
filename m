Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B78C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE56207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCFAQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:16:57 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:50966 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgCFAQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:16:57 -0500
Received: from [100.113.1.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 81/89-64587-576916E5; Fri, 06 Mar 2020 00:16:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsVy8MN7Xd3SaYl
  xBk0npC3mnG9hsWhevJ7NYtXCa2wWl3fNYbN4/6mTyeL/nh3sDmweW1beZPJoOfKW1WPTqk42
  j/1z17B7fN4kF8AaxZqZl5RfkcCasfnSUraCrZwVW7+tYGxg3MDRxcjFISSwhlFiycnvLF2Mn
  EBOpcS0gx+ZQGxegQiJZccmgdmcAmYSUxr+AtkcQDWmEk/bQ0HCbAI6Eo9mrgcLswioSEw8kA
  cSFhaIk9jy6DIzyHgRgYuMEk8e/2EDSTADJWY1LGeFGC8ocXLmExaIuITEwRcvmCFO0JI4t2Y
  V4wRG3llIymYhKVvAyLSK0TKpKDM9oyQ3MTNH19DAQNfQ0FgXRBroJVbpJuqlluomp+aVFCUC
  ZfUSy4v1iitzk3NS9PJSSzYxAsM2pZAhbwdj4/z3eocYJTmYlER5d8QnxgnxJeWnVGYkFmfEF
  5XmpBYfYpTh4FCS4LWeApQTLEpNT61Iy8wBxhBMWoKDR0mEN3oqUJq3uCAxtzgzHSJ1ilGXY+
  fReYuYhVjy8vNSpcR5U0GKBECKMkrz4EbA4vkSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWF
  eb5BLeDLzSuA2vQI6ggnoiPt34kGOKElESEk1MB1oPsQ14cLUZXIKu+/OdWereX8/p64htUXg
  u5TzsV3si1ffWc708+CD3wwRnOpzzOI3xt3zibqTy8ew5YLC8s3u1it7/h5W2LHy9+sb9WKuS
  9u31Tp7X1Gx7fV7OW9ihFX/Tud3/03dHn/ezrf5Q0vd6voV7SZRxYZpLnc8XvsuUc35HC4zpY
  zt0YvAqWziSesbGrcUd2hKaV05sfbzB+1Og0JBb1uXY+UKkcZ+L2RWJa6+FR8Z+NNI0/GwRl6
  Fgk1fOItels2UrxoZe1U1klenfDbYcIh/23pN6Q8a/3zt/NYW9Tw4cMR00+FJLUxfRcUyXh1P
  qV/XuFO/ab19o9Ij+TBRx8myhVGM8jxvlFiKMxINtZiLihMBqNOS/mIDAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-31.tower-229.messagelabs.com!1583453812!553913!2
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9183 invoked from network); 6 Mar 2020 00:16:53 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-31.tower-229.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 6 Mar 2020 00:16:53 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 6 Mar 2020 01:16:51 +0100
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 518A213F670; Fri,  6 Mar 2020 09:16:50 +0900 (KST)
Message-ID: <61bdb616dbfe403f95ce33587e6ce0d5c6959dcd.1583425388.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1583425388.git.Roy.Im@diasemi.com>
References: <cover.1583425388.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Fri, 6 Mar 2020 01:23:07 +0900
Subject: [PATCH V10 1/3] MAINTAINERS: da7280 updates to the Dialog
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
end-of-patch for PATCH V10

