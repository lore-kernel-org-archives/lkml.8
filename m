Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DDBC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A003220719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XDKO5hKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbgDAOjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:39:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37626 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732791AbgDAOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:39:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id u65so19812pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iSahkJrDdRH98cZT/cX3kV0qB8bHq3dASQvxelaFiI=;
        b=XDKO5hKXn2DMYhWrIMoaz0M1LCBQ5bWgbe+A9FWmdvQqBjQ5xzL4tIATz/7ApRHAe7
         LlvzUHEdWS4WLuJd55HvvFFLehO+s4FmlKTJNmr7zec7zFmvZKL/yoCMa6PcHa/hPAMt
         DFHNCajQW8e25GQG+2fkWC9kCI5LjlB6+p5nM2Gf7EZtyq0O1VW3KDSUyqEKc85S5Qkm
         AvrPfq0mHHD9YCoQArnQTPk44andN4j35y7V9mjrJ0Gy1hjdLSsYTWSO+kr0JIVMB0r5
         3dC/sadMWay83rMFwyVpqrUDOTGlw0N//Ii6kj10E45ZkxE3WXTBCOn/EwF6lb9njt7n
         DwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iSahkJrDdRH98cZT/cX3kV0qB8bHq3dASQvxelaFiI=;
        b=ij3AJyfBMXJ/oJhoAMFgter08Npga3FsP6BOghc7nWrfGDjo7Mdm7p8CH0lcfD+WvZ
         caiGhO7b3ttrTlKFYjYI/NyaWZgWJ2lXeRziFK2O5uxA1DWvmIcsTfktkkgpWr/84cXr
         FomqNgRNcih9BRZnUaSXQyxwV0VBE99ZbNAOBZNf+xdo5rtDUIh9Nc8D6KHyXRCmBIbz
         6CC9/IXYFg4j/P0Kj1juCk5vkpM6xic0GQhB2/3fiyXoV3ygB6Buc3tjPLWOu4FZSiXt
         yrJiLoS1K0SSG4IXVidw+Si4XTw134qmTkgYsimYd/KVu1lCR/cJp8V1Y6O8rf/7Y70S
         KEhg==
X-Gm-Message-State: ANhLgQ1MDErEU3mpLKCcv6AF+v0OFqxmk73fD86DAxuJF4gY4j7SL2L4
        RCYl7bSDrD/gABLhitrQ4zUqkxM0izz9Hg==
X-Google-Smtp-Source: ADFU+vs1K3XbUKt2pUIj6nGOeR0U4WdhzPE3aaDRwPfMWcjeCtYwU22aLlfZHAJFof/nWYI3VteC0A==
X-Received: by 2002:aa7:9481:: with SMTP id z1mr22815516pfk.185.1585751948699;
        Wed, 01 Apr 2020 07:39:08 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id f45sm1765981pjg.29.2020.04.01.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:39:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] tty/sysrq: Export sysrq_mask()
Date:   Wed,  1 Apr 2020 15:39:04 +0100
Message-Id: <20200401143904.423450-1-dima@arista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build fix for serial_core being module:
  ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 5e0d0813da55..a0760bcd7a97 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -74,6 +74,7 @@ int sysrq_mask(void)
 		return 1;
 	return sysrq_enabled;
 }
+EXPORT_SYMBOL_GPL(sysrq_mask);
 
 /*
  * A value of 1 means 'all', other nonzero values are an op mask:
-- 
2.25.1

