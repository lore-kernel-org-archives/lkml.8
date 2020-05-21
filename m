Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B173C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527362070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgEUMaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:30:08 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:48050 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgEUMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:30:04 -0400
Received: from [100.112.196.46] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id E6/6B-40520-84476CE5; Thu, 21 May 2020 12:30:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsVy8MN7XV2PkmN
  xBr8vM1vMOd/CYtG8eD2bxaqF19gsLu+aw2bx/lMnk8X/PTvYHdg8tqy8yeTRcuQtq8emVZ1s
  HvvnrmH3+LxJLoA1ijUzLym/IoE14+G63UwFvVwVX1tfszcw/uLoYuTiEBJYyygxsfEZaxcjJ
  5BTKdF4+gJzFyMHB69AhET/IX6QMKeAmcScmRfYIUpMJT4e7GABsdkEdCQezVzPBGKzCKhK7N
  q8GKxGWCBVYn5rDzvIfBGBi4wSTx7/YQNJMAvEScxqWA62i1dAUOLkzCcsEHEJiYMvXjBDLNC
  SOLdmFeMERt5ZSMpmISlbwMi0itEiqSgzPaMkNzEzR9fQwEDX0NBI19DSUtfIyFgvsUo3SS+1
  VLc8tbhE11AvsbxYr7gyNzknRS8vtWQTIzBsUwqO39/BeHzte71DjJIcTEqivAf8j8UJ8SXlp
  1RmJBZnxBeV5qQWH2KU4eBQkuDNLwbKCRalpqdWpGXmAGMIJi3BwaMkwrupCCjNW1yQmFucmQ
  6ROsWoy7Hz6LxFzEIsefl5qVLivJIgMwRAijJK8+BGwOL5EqOslDAvIwMDgxBPQWpRbmYJqvw
  rRnEORiVh3gyQKTyZeSVwm14BHcEEdIT0sUMgR5QkIqSkGpiEppf0pLQ9murVGTt/cbTz3J+P
  VaQdPs+7rNfdEP7c4djd2ya3eWte8V703nN4aYZZx1FdC+0Uo/y7Z1hvSqxfkqrvpC77oIiB3
  UZvjcuZdfO4glQYzrKyKFr3Mkn+Y190XOlvlo5YwBW+z2xbFq2vypj3sGdaz8WVDz3Sc/9bvj
  X4yxeyuPcka85prkiWO73xEmw9LIpnE+69u9p89n3SN5GVK688U5ac9yg+f13MjXtzI8UzuOL
  2dqn2bRTQeOo38dQ6Dd60hQoiCgsrTiWvaOn26P135PECrq3/1h689tn6zf1ZxblVLubavGqf
  1gcvElZu5J15+dWltwFZP2JjlK7dmMIz8897ltDbQTlKLMUZiYZazEXFiQCuE9YLYgMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-21.tower-282.messagelabs.com!1590064199!5520835!3
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26082 invoked from network); 21 May 2020 12:30:00 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-21.tower-282.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 21 May 2020 12:30:00 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Thu, 21 May 2020 14:29:57 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 8441E13F670; Thu, 21 May 2020 21:29:55 +0900 (KST)
Message-ID: <34108f195fa50261e32fccf7ab08ba0ff78facce.1590053093.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1590053093.git.Roy.Im@diasemi.com>
References: <cover.1590053093.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 21 May 2020 18:24:52 +0900
Subject: [RESEND PATCH V13 1/3] MAINTAINERS: da7280 updates to the Dialog
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
v13: No changes.
v12: Corrected file list order.
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
index 2926327..56e83e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4942,6 +4942,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -4952,6 +4953,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for RESEND PATCH V13

