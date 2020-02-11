Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB4FC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4BD2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBKCn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:43:26 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:36438 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727655AbgBKCnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:43:25 -0500
Received: from [100.112.192.239] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 56/1B-51549-AC4124E5; Tue, 11 Feb 2020 02:43:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsVy8MN7Xd1TIk5
  xBscni1rMOd/CYtG8eD2bxaqF19gsLu+aw2bx/lMnk8X/PTvYHdg8tqy8yeTRcuQtq8emVZ1s
  HvvnrmH3+LxJLoA1ijUzLym/IoE149W3xywFszgrds7aydbAOIuji5GLQ0hgLaPE8puHmboYO
  YCcSomp/bpdjJwcvAIREp+uvWcEsTkFzCQO975hBrGFBEwlNt97zwpiswnoSDyauZ4JxGYRUJ
  V4vPUaWI2wQIpE696ZbCDzRQQuMko8efyHDSTBLBAnMathOSvEAkGJkzOfsEDEJSQOvngBtUB
  L4tyaVYwTGHlnISmbhaRsASPTKkaLpKLM9IyS3MTMHF1DAwNdQ0MjXUNLU10jAwO9xCrdRL3U
  Ut3y1OISXUO9xPJiveLK3OScFL281JJNjMCwTSk4fGIH49Hl7/UOMUpyMCmJ8m447BgnxJeUn
  1KZkVicEV9UmpNafIhRhoNDSYL3mrBTnJBgUWp6akVaZg4whmDSEhw8SiK8riBp3uKCxNzizH
  SI1ClGXY6dR+ctYhZiycvPS5US550IUiQAUpRRmgc3AhbPlxhlpYR5GRkYGIR4ClKLcjNLUOV
  fMYpzMCoJ8/qCTOHJzCuB2/QK6AgmoCOumziAHFGSiJCSamBauNKeu2gyl9/e0NLO6cxBibqh
  v5faTF561OXgf37XjOPF+YkcQlfjs0omeBWGrtecznhbek3xtopDT8Nv9AtvWaNXyd7k/V0+u
  c7CyyJlNrcny2+Hh4xVC30ZmOdXBZ3Lyp736B9/J0Ot/rsTJextN3SPFRXNPSLxLNvoRlpdBf
  /iE5t4zjvtSGiwrrZgyj604aNMQ/B2s53+3msqA1Vk9UNWBtxIV3gdeC8yYlHX46Kg/53L3u/
  Zs/HG2qI3ljdeqIWd99I32OTiyPI+SviBkqOz2hfR+7/Vvl1ZIL/11LYIX95Pm/5Nis1T4tGM
  y2NifVprIaPEN1HtlYZwmsS17h2FwjZxJw3P1HPsV2Ipzkg01GIuKk4EAPqUfr5iAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-15.tower-262.messagelabs.com!1581389001!1529582!3
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6618 invoked from network); 11 Feb 2020 02:43:22 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-15.tower-262.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 11 Feb 2020 02:43:22 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 11 Feb 2020 03:43:20 +0100
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 2688413F670; Tue, 11 Feb 2020 11:43:19 +0900 (KST)
Message-ID: <43fb0155545edb2b722456cee1f1e97e13d14a56.1581383604.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1581383604.git.Roy.Im@diasemi.com>
References: <cover.1581383604.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 11 Feb 2020 10:13:23 +0900
Subject: [RESEND PATCH V8 1/3] MAINTAINERS: da7280 updates to the Dialog
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
end-of-patch for RESEND PATCH V8

