Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B5C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8042321D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752955;
	bh=ONj7aKbHlOlgWW2rGPQ0J/OhBHcYbrSt/+Ss/muTSBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WAvNgJ7X4Gfc/LdHCs2+NzzC45y4kYZC9HxIbBPa11WIxlebCWKcoLaWf4xzyY+5a
	 mZ8PdI9XBKiXCDcRrXwFPu4oT+peFHZZYfCX8dtLHUzHQsB3hoyk7sK4UCPUdcsXFh
	 nIwsFwO98Qv5fVGRGaqMfXa3NXLDaFISh4ur6RE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgGNSzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbgGNSzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:55:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC4321D79;
        Tue, 14 Jul 2020 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752948;
        bh=ONj7aKbHlOlgWW2rGPQ0J/OhBHcYbrSt/+Ss/muTSBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pllvgva5P8cG0dc2ov9uJHIzlRgL/p85VJWi+6ULeH/v39D7sf2OzrOmVE1qs+ytU
         ARlKIUP+MBWnW+bmjhHRIFu0Dt1V8PKs1m9fL+lxeT9+ScqUA36c9kwhS3VYXkBDy4
         LuLgBADwlSMjNluWjLI/26wR/hzzxRF5A85lY/lw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH 5.7 031/166] s390/kasan: fix early pgm check handler execution
Date:   Tue, 14 Jul 2020 20:43:16 +0200
Message-Id: <20200714184117.367925529@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 998f5bbe3dbdab81c1cfb1aef7c3892f5d24f6c7 ]

Currently if early_pgm_check_handler is called it ends up in pgm check
loop. The problem is that early_pgm_check_handler is instrumented by
KASAN but executed without DAT flag enabled which leads to addressing
exception when KASAN checks try to access shadow memory.

Fix that by executing early handlers with DAT flag on under KASAN as
expected.

Reported-and-tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/early.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index cd241ee66eff4..0782772318580 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -170,6 +170,8 @@ static noinline __init void setup_lowcore_early(void)
 	psw_t psw;
 
 	psw.mask = PSW_MASK_BASE | PSW_DEFAULT_KEY | PSW_MASK_EA | PSW_MASK_BA;
+	if (IS_ENABLED(CONFIG_KASAN))
+		psw.mask |= PSW_MASK_DAT;
 	psw.addr = (unsigned long) s390_base_ext_handler;
 	S390_lowcore.external_new_psw = psw;
 	psw.addr = (unsigned long) s390_base_pgm_handler;
-- 
2.25.1



