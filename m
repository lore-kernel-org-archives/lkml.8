Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ECEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17FF206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ovPYHpFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbgBNSAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:00:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42339 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgBNP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id r5so7242020qtt.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6jSjfGtvFx4do4NAPL9uHx8+n+x5lxROSkL2jkHQC4Y=;
        b=ovPYHpFItMqqLAWAG5S/QB+rnCBig0/hdfLXqhp+WoudHfMZv8ItTZEURE/T2JN/fG
         hHlcOAIA6218GMm8dOC2tX+c6bzmMfE/SCjST9/1qO+PvQogsKtLhwgPlvrdl+4i2OVp
         BSIo5nZaGtE3HuqY9vBT9rWd+INyAaitqr5Itn9gVkjQ94r/bJ9+I9rGK1cpDJ/0sfq+
         IuxNGkagkPX5nxsu0eN3Aoh2LHQaBA1/Ds3xFYqRMQjs5QmLCZd2Om9GbVTvk2ZJrl4U
         1nJHOAQz+8VSrN0npIApaha+jOG5/VVTiYLsoZQYOA63vasiwiFWXZieLBmcvPvZThio
         JyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6jSjfGtvFx4do4NAPL9uHx8+n+x5lxROSkL2jkHQC4Y=;
        b=gYo0q7XIM4ml2p8O5eIxg80Pg66Sw3shiZCdjjHd9rrVqvjOAn/moH8OdV5xPKxXIJ
         phkLgzfyyy6Bg2ECWJO2LaInY1gAebSuLVt9+aUggo24Frk31fW+/PON4EBNlO7OuB9x
         wvpnQ85SN3/aUneWN80eXncQvfza/iOZyYjH4oO+RfKN5ovw734R27Xjwl7BShLClLie
         b/gE/iJCopN5w830s9x7u1JYD4/qPsL4THK3KSGdQDNIG7pqG5wdM4pYKYOElWsnEGuD
         Q51bRxnAHkP3VwDKSwvtzBNwl2gWlDI8WzYYq3OlwmMyK9AGOhTS1huFxJBUI1//tl5j
         Vi4A==
X-Gm-Message-State: APjAAAWKmOwi7zG+axHJZZTwkx1p2nHvn845s5QErYLWZpXW7LlKwp0m
        JA4jBDEi614FihADrTwdQjrY0A==
X-Google-Smtp-Source: APXvYqwj23CiFbMj1wbnSnflDYnJuNbdcFJZX73WW4OaMAYoszvD8eOpzafx1TSsWDYcMrkV/LvINg==
X-Received: by 2002:ac8:33f8:: with SMTP id d53mr3067141qtb.86.1581695780463;
        Fri, 14 Feb 2020 07:56:20 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w9sm3449497qka.71.2020.02.14.07.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:56:20 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     pbonzini@redhat.com
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] kvm/emulate: fix a -Werror=cast-function-type
Date:   Fri, 14 Feb 2020 10:56:08 -0500
Message-Id: <1581695768-6123-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/kvm/emulate.c: In function 'x86_emulate_insn':
arch/x86/kvm/emulate.c:5686:22: error: cast between incompatible
function types from 'int (*)(struct x86_emulate_ctxt *)' to 'void
(*)(struct fastop *)' [-Werror=cast-function-type]
    rc = fastop(ctxt, (fastop_t)ctxt->execute);

Fixes: 3009afc6e39e ("KVM: x86: Use a typedef for fastop functions")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/kvm/emulate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index ddbc61984227..17ae820cf59d 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5682,10 +5682,12 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 		ctxt->eflags &= ~X86_EFLAGS_RF;
 
 	if (ctxt->execute) {
-		if (ctxt->d & Fastop)
-			rc = fastop(ctxt, (fastop_t)ctxt->execute);
-		else
+		if (ctxt->d & Fastop) {
+			fastop_t fop = (void *)ctxt->execute;
+			rc = fastop(ctxt, fop);
+		} else {
 			rc = ctxt->execute(ctxt);
+		}
 		if (rc != X86EMUL_CONTINUE)
 			goto done;
 		goto writeback;
-- 
1.8.3.1

