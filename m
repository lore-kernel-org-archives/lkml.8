Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1FC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5660C20769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJCHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:07:40 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:49808 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbgDJCHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:07:40 -0400
Received: from [100.113.5.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 7C/FC-36561-AE4DF8E5; Fri, 10 Apr 2020 02:07:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsVy8MN7Xd2XV/r
  jDHpabC3mnG9hsWhevJ7NYtXCa2wWl3fNYbN4/6mTyeL/nh3sDmweW1beZPJoOfKW1WPTqk42
  j/1z17B7fN4kF8AaxZqZl5RfkcCaMWvxfZaCs5wVt8/fZ2pgPMLRxcjFISSwllHi+8V29i5GT
  iCnUqJ70SxmEJtXIELi0KL9bCA2p4CZxJm2HqgaU4lF7fcYQWw2AR2JRzPXM4HYLAIqEvdmbg
  WrFxZIldjw+BEbyAIRgYuMEk8e/wFLMAvEScxqWM4KsUBQ4uTMJywQcQmJgy9eMEMs0JI4t2Y
  V4wRG3llIymYhKVvAyLSK0TKpKDM9oyQ3MTNH19DAQNfQ0FjXFMgy10us0k3SSy3VTU7NKylK
  BMrqJZYX6xVX5ibnpOjlpZZsYgSGbkoha/YOxq3z3+sdYpTkYFIS5T15qj9OiC8pP6UyI7E4I
  76oNCe1+BCjDAeHkgRvwWWgnGBRanpqRVpmDjCOYNISHDxKIrzvLgGleYsLEnOLM9MhUqcYdT
  l2Hp23iFmIJS8/L1VKnDcIZIYASFFGaR7cCFhMX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwag
  kzGsAsoonM68EbtMroCOYgI44HA52REkiQkqqgSk47+zaOc21U1OqDP64brgRqfP48EHlt+JP
  pbb6ZiXFJ5R2bW1bM4VrzYVfe09+mamddnmz0ClffRe1a78us504/qJn21x2xqjNZRt3i0TdE
  c0Tf6ljmxIozMR6y9qJd2uq0GkeizleeZXN5680cxw8m7FbopX3Q8jk/SmNobxdBfulmk8WJI
  dNllBMso0W2mk9pUhRNE3fZeeBhtmvmJZqTa5j2hcurb1o6a2TVx5YhigfCq4qPnBIw3G6+UT
  mW4zbN32oni7xcFXN56zFvI1c4pVbTTtFbW77LRXbfsyzZsV3GUEmsT9sL94xNuVM3N7fW+W8
  uef5jdV6KYcfKofoPlokLhe7TeZec7edpBJLcUaioRZzUXEiAOPE3UdkAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-24.tower-239.messagelabs.com!1586484457!2817432!2
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26340 invoked from network); 10 Apr 2020 02:07:37 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-24.tower-239.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 10 Apr 2020 02:07:37 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 10 Apr 2020 04:07:35 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 7D5FA13F670; Fri, 10 Apr 2020 11:07:34 +0900 (KST)
Message-ID: <efd63d42b7fd2ca15777c9b06a9ea4a162324028.1586439647.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1586439647.git.Roy.Im@diasemi.com>
References: <cover.1586439647.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 9 Apr 2020 22:40:46 +0900
Subject: [RESEND PATCH V11 1/3] MAINTAINERS: da7280 updates to the Dialog
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
index 62a56ba..a3589c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4953,6 +4953,7 @@ S:	Supported
 F:	Documentation/hwmon/da90??.rst
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -4962,6 +4963,7 @@ F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
-- 
end-of-patch for RESEND PATCH V11

