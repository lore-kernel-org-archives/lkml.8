Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287EBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B839220775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ca7KOSLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgF3VcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:32:00 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45118 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgF3VaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:30:10 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E17508011F;
        Wed,  1 Jul 2020 09:30:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1593552606;
        bh=a9s+V2nzli8tsrcb0f2+rV3tw5YwE41Dqit8SLbbkqE=;
        h=From:To:Cc:Subject:Date;
        b=Ca7KOSLa8qcaM7G6uXP/Uf6OcU2/o107X/xBAUZuN7VCfORCIXCCKOGRmyBKkH06B
         PSijTfk35h8DoUScsrf6RBRQzV5VoAouAXyF5jSsk2TOspkWF6fFN5dXzbRzlsVPyk
         MAVlfRLd3tzRddhPTWHJqV8aARHBcYfsO+ER0jxTxSVPScgq+YojlCpPOviLc1/PhP
         N/gKzJHmzcQQ6P0StzYI4KKaW1mGxiS2sZ3Rv5LNXKH7jJCNZhio3Llx6EsvObUyC1
         ZDT+zSHhzo00z/mOPJEhoYo364AxoW6GAguzY3EpedrcPcO/t6fMQbnOSfOcdHFuVe
         XP4P93b7DPyFg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5efbaeda0000>; Wed, 01 Jul 2020 09:30:06 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id CC9E013EF9B;
        Wed,  1 Jul 2020 09:30:00 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id D06D333E9BD; Wed,  1 Jul 2020 09:30:01 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] pinctrl: initialise nsp-mux earlier.
Date:   Wed,  1 Jul 2020 09:29:58 +1200
Message-Id: <20200630212958.24030-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO specified in the DTS file references the pinctrl, which is
specified after the GPIO. If the GPIO is initialised before pinctrl,
an error message for the -EPROBE_DEFER ends up in the kernel log. Even
though the probe will succeed when the driver is re-initialised, the
error can be scary to end users. To fix this, change the time the
pinctrl is probed, so that it is always before the GPIO driver.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c b/drivers/pinctrl/bcm/=
pinctrl-nsp-mux.c
index f1d60a708815..7586949f83ec 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
@@ -639,4 +639,4 @@ static int __init nsp_pinmux_init(void)
 {
 	return platform_driver_register(&nsp_pinmux_driver);
 }
-arch_initcall(nsp_pinmux_init);
+postcore_initcall(nsp_pinmux_init);
--=20
2.27.0

