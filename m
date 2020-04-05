Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D7FC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F673206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psSUHWRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDEHvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 03:51:33 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51536 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgDEHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 03:51:32 -0400
Received: by mail-pj1-f65.google.com with SMTP id w9so5123083pjh.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fXHW1b6fO1FXiuIvfxLCGqRbJU/6omAN7vseOtHgP2o=;
        b=psSUHWRluSuqiIOUXhePdO1uO71WyIsrMBA8Bwpc1s1/RHSbWS9NGikzTh9SWUQ4lB
         vKbwIyi85w0j1k5NIMcV9Evw65Jjf5JSXV1lGJfVPqMTnbF7Cor/MSocRiCc7MFvIQgR
         Wrb89k6Sw3LROe5XzNSM5KBgv4X77DaRxPY+At9qMWjUZ1/dmsGZKDLf/hPQBLanE4X/
         scYLCRz7i8S2l9bGdRRSJyWo8xCaZMe8pNUCktkTErivMoBAIH8I6JpoZ5t7a9ki9/GE
         l0Dv1gx0PXHgwDuWdq7IG+wYS/i5MUSGa5Gsgq81JocvMw++a5H2Tj8IWmL60DyBV2QF
         cbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fXHW1b6fO1FXiuIvfxLCGqRbJU/6omAN7vseOtHgP2o=;
        b=fGcpdRnLrLI61QxgZOmkq3hC+t+iIvZzrl1B+g2maNYyhtdy/o24/OvfVlvJVDhwxM
         H7MqCQ+GKW6aBd/mynSdogRmDeaKasf2BuLlMeNOdfsXLUProJCjXvevFoS5welicDPm
         58YWEs5P2DCL8wXpYU9StF6X1BmzfCRTqKbjC6cOZd4kuHQQL+qhX9GSv7cx2B7Voh/K
         Aj8TFLt6ii6g70GXdGKirCpX3e/l2oia1cCOWsu9ueo1Aoviohht+mbY/7D5I9Sbecws
         Wi1yQWztUIjQM1thq62crXAqchWRW+XvnzeILY5I+Yx1SR3W9Obiw2Mw/bFJdtw1SdqH
         /Ybw==
X-Gm-Message-State: AGi0PubLPQAphZRPd2WcauvtfNRXvWVBvbWT+Fdhdix6cnvZjy019rd1
        1+y2On7KdMQjr5+ejv97tn4=
X-Google-Smtp-Source: APiQypJiJTlVByPufukl1A/Ta9MCm98+QEENycaUO/SHTl0iIBzlmJGdGPiwPVcwtddpuhVs9zZfpw==
X-Received: by 2002:a17:90a:faa:: with SMTP id 39mr20560705pjz.190.1586073091494;
        Sun, 05 Apr 2020 00:51:31 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id p7sm9510970pjp.1.2020.04.05.00.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 00:51:30 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.a,
        tglx@linutronix.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] powerpc/powernv: add NULL check after kzalloc in opal_add_one_export
Date:   Sun,  5 Apr 2020 15:51:23 +0800
Message-Id: <20200405075123.28756-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here needs a NULL check.

Issue found by coccinelle.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b3dfd0b6cdd..09443ae3a86e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -811,6 +811,11 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
 		goto out;
 
 	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	name = kstrdup(export_name, GFP_KERNEL);
 	if (!name) {
 		rc = -ENOMEM;
-- 
2.17.1

