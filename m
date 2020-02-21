Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DC9C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005DB246BF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbgBUIZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:25:23 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:60347 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388780AbgBUIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:25:17 -0500
Received: from [100.112.198.146] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 75/A4-06294-AE39F4E5; Fri, 21 Feb 2020 08:25:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsVy8MN7Xd1Xk/3
  jDCa+UbOYc76FxaJ58Xo2i1ULr7FZXN41h83i/adOJov/e3awO7B5bFl5k8mj5chbVo9NqzrZ
  PPbPXcPu8XmTXABrFGtmXlJ+RQJrxsT5K5gLFnNWnLm8mbmBcSFHFyMXh5DAWkaJ3ctuMXcxc
  gI5lRI/pxxmArF5BSIk1t1eAGZzCphJPNr7jRWixlRi1cRONhCbTUBH4tHM9WA1LAKqEoeeX2
  cBsYUFYiVuXP7LCrJAROAio8STx3/AGpgF4iRmNSxnhVggKHFy5hMWiLiExMEXL6CO0JI4t2Y
  V4wRG3llIymYhKVvAyLSK0SKpKDM9oyQ3MTNH19DAQNfQ0EjX0NJS18jIWC+xSjdJL7VUtzy1
  uETXUC+xvFivuDI3OSdFLy+1ZBMjMHBTCo7f38F4fO17vUOMkhxMSqK8in3+cUJ8SfkplRmJx
  RnxRaU5qcWHGGU4OJQkeF2BsSAkWJSanlqRlpkDjCKYtAQHj5IIr2MvUJq3uCAxtzgzHSJ1il
  GXY+fReYuYhVjy8vNSpcR5WycBFQmAFGWU5sGNgEX0JUZZKWFeRgYGBiGegtSi3MwSVPlXjOI
  cjErCvD8mAk3hycwrgdv0CugIJqAj3gv7gBxRkoiQkmpgmvi+LXxN2vU3ZVsSfiosEGJcIeB/
  QfpPUaStu9G2bTMYefMWx778HLt+6SSL/evfTuJ7O+fmuoXTahYx2k5leJnQ+8Fey/brt5YHw
  jttwidIRLe9u3R/ljWj+Y9QlXdTLfqulxofjUnsEWHd9rzPJUv/xfH3ay1ueAQFaD/o8/Y98z
  JtpqfLZM4VjqyLc92jZr1VurjxxGepeGlD5trzc9qV5z45nvv/8y2haWeu/JFh5bX4fStC2V3
  uS86mm/lHnzz/Yev81CxnRtMrk2Ynqb22/7rYn9h6BH/Smb1mad//Y8sPczXM5n1gsal0HaPm
  NtmvRw7d26/vsOC4fxLnxFML/DgiH4aI/AgVOD6xb5kSS3FGoqEWc1FxIgADhtlaYwMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-15.tower-288.messagelabs.com!1582273513!731327!3
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22407 invoked from network); 21 Feb 2020 08:25:14 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-15.tower-288.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 21 Feb 2020 08:25:14 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 21 Feb 2020 09:25:13 +0100
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 78F7C13F670; Fri, 21 Feb 2020 17:25:11 +0900 (KST)
Message-ID: <f2bae3b187949785f23dda0076de4b1b0698469e.1582270025.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1582270025.git.Roy.Im@diasemi.com>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Fri, 21 Feb 2020 16:27:05 +0900
Subject: [PATCH V9 1/3] MAINTAINERS: da7280 updates to the Dialog
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
end-of-patch for PATCH V9

