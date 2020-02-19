Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5856C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C413721D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBSIAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:00:35 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35412 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgBSIAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:00:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 89B63DFFFE;
        Wed, 19 Feb 2020 08:00:45 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IxgsZhfY5tA0; Wed, 19 Feb 2020 08:00:44 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E83B9E0028;
        Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gsPD3rXW-Suy; Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3AC29DFF72;
        Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] irqchip/mmp: Safeguard against multiple root intc initialization
Date:   Wed, 19 Feb 2020 09:00:23 +0100
Message-Id: <20200219080024.4002-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219080024.4002-1-lkundrak@v3.sk>
References: <20200219080024.4002-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can only handle one root ICU. Let's warn if someone messes up and adds
multiple in the devicetree.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/irqchip/irq-mmp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 4a74ac7b7c42e..f597d96409a1f 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -250,6 +250,11 @@ void __init icu_init_irq(void)
 	int irq;
=20
 	max_icu_nr =3D 1;
+	if (mmp_icu_base) {
+		pr_err("ICU already initialized\n");
+		return;
+	}
+
 	mmp_icu_base =3D ioremap(0xd4282000, 0x1000);
 	icu_data[0].conf_enable =3D mmp_conf.conf_enable;
 	icu_data[0].conf_disable =3D mmp_conf.conf_disable;
@@ -273,6 +278,11 @@ void __init mmp2_init_icu(void)
 	int irq, end;
=20
 	max_icu_nr =3D 8;
+	if (mmp_icu_base) {
+		pr_err("ICU already initialized\n");
+		return;
+	}
+
 	mmp_icu_base =3D ioremap(0xd4282000, 0x1000);
 	icu_data[0].conf_enable =3D mmp2_conf.conf_enable;
 	icu_data[0].conf_disable =3D mmp2_conf.conf_disable;
@@ -380,6 +390,11 @@ static int __init mmp_init_bases(struct device_node =
*node)
 		return ret;
 	}
=20
+	if (mmp_icu_base) {
+		pr_err("ICU already initialized\n");
+		return -EEXIST;
+	}
+
 	mmp_icu_base =3D of_iomap(node, 0);
 	if (!mmp_icu_base) {
 		pr_err("Failed to get interrupt controller register\n");
--=20
2.24.1

