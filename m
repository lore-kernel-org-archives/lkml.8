Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7505C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D7420656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgD0Oir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:38:47 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:40665 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727843AbgD0Oio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:38:44 -0400
Received: from [100.113.0.171] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 80/BC-37389-07EE6AE5; Mon, 27 Apr 2020 14:38:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsVy8MN7Xd2Cd8v
  iDN4c5beYc76FxaJ58Xo2i1ULr7FZXN41h83i/adOJov/e3awO7B5bFl5k8mj5chbVo9NqzrZ
  PPbPXcPu8XmTXABrFGtmXlJ+RQJrxok9L1gKrnJWXH97m7WB8TRHFyMXh5DAWkaJjtOvGbsYO
  YGcSokb756A2bwCERLbfzwFszkFzCSW3VrG1MXIAVRjKvGz3wwkzCagI/Fo5nomEJtFQFXi8Y
  +XrCC2sECcxI2HN5hB5osIXGSUePL4DxtIghkoMathOSvEfEGJkzOfsEDEJSQOvnjBDHGDlsS
  5NasYJzDyzkJSNgtJ2QJGplWMlklFmekZJbmJmTm6hgYGuoaGxrpGukbGxnqJVbqJeqmlusmp
  eSVFiUBZvcTyYr3iytzknBS9vNSSTYzAwE0pZHq5g3Hb2vd6hxglOZiURHlPrl4WJ8SXlJ9Sm
  ZFYnBFfVJqTWnyIUYaDQ0mCl/0tUE6wKDU9tSItMwcYRTBpCQ4eJRHeayBp3uKCxNzizHSI1C
  lGXY6dR+ctYhZiycvPS5US510LUiQAUpRRmgc3AhbRlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYp
  zMCoJ88qBTOHJzCuB2/QK6AgmoCOq5BeDHFGSiJCSamBap1Zce/9T3e497VOmTX5iEpPs/FC2
  WEvrhFGyN6/Fdv5G+Ullq0r4F1z9Esmerbu8Y7Jn/vXA109fct14vTpwgqPY3qvfg1UsJr/RM
  oovT/NujPqyxyFSf8qSU3z3NXP6Y2Q3rc5avi3775bSHetYH82M+8JUIfTiZ3bwFtV1UpcZrA
  z1jnN11fQ9Prv75ZGGu5fVHP+L+quH9wh7XU1j6npXEJ3OrH5Y6qVk5vwLmne55RbXN5lH8kk
  UH1hz+Z/2MlORk/0ZKz0tltsvXri/tGxN3qvWMqslZ7+6O1/hqJ3/P1GPoe3n+1ydxL4jX5SZ
  2fy+Xgk26nkTY/ir7m7ntC+eWloGwhNtL8+vilJiKc5INNRiLipOBADSHGFBYwMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-9.tower-223.messagelabs.com!1587998319!3025129!3
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12870 invoked from network); 27 Apr 2020 14:38:40 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-9.tower-223.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 27 Apr 2020 14:38:40 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 27 Apr 2020 16:38:38 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 789A413F670; Mon, 27 Apr 2020 23:38:36 +0900 (KST)
Message-ID: <0f7b4d55592d1d7ee0a18268f521b7c837778736.1587975654.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1587975654.git.Roy.Im@diasemi.com>
References: <cover.1587975654.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 27 Apr 2020 17:20:53 +0900
Subject: [PATCH V12 1/3] MAINTAINERS: da7280 updates to the Dialog
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
index b816a45..a4fcb21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4943,6 +4943,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -4953,6 +4954,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for PATCH V12

