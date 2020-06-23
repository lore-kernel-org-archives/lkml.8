Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FB12082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942529;
	bh=jppDhtFpMQG5S2oXy6qFfHAOUk3pE5ywoqQQNRTuD/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rk48cMUFvmUg0UXaBglu+VPAVRlpJ3YYcKxzTSFAhaew+9y7XH2I2FYe895Lc5HKv
	 zLg/ALTuDc/V4J8suR1No6qDJbOtx2zMNy5Ks+73KaZOKWKXNs7wiP+h1+FrZel0Mg
	 v5JTQ+xhAFnXqmgyLTwizddHiFg+wmagEkU7KQ0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgFWUCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbgFWUCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:02:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237102078A;
        Tue, 23 Jun 2020 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942524;
        bh=jppDhtFpMQG5S2oXy6qFfHAOUk3pE5ywoqQQNRTuD/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSVA2W+DYdEvenewGLT5mf50eUBUq3q4okTK8mY+SeeW+gZf4uGqcrkiNgW7foPZV
         +6ftDrK06c05Cj559rLuED9QCn+SjwJ+CAiwl4/cgUC01sk0u101dSnqbUIvHG+NJW
         PhX+pRnw0f31Ly5eMd48JQcH4Ru32hM4vWAluVy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, erhard_f@mailbox.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 031/477] powerpc/kasan: Fix stack overflow by increasing THREAD_SHIFT
Date:   Tue, 23 Jun 2020 21:50:28 +0200
Message-Id: <20200623195409.069059360@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit edbadaf0671072298e506074128b64e003c5812c ]

When CONFIG_KASAN is selected, the stack usage is increased.

In the same way as x86 and arm64 architectures, increase
THREAD_SHIFT when CONFIG_KASAN is selected.

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Reported-by: <erhard_f@mailbox.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=207129
Link: https://lore.kernel.org/r/2c50f3b1c9bbaa4217c9a98f3044bd2a36c46a4f.1586361277.git.christophe.leroy@c-s.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 62aca9efbbbed..310957b988e31 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -773,6 +773,7 @@ config THREAD_SHIFT
 	range 13 15
 	default "15" if PPC_256K_PAGES
 	default "14" if PPC64
+	default "14" if KASAN
 	default "13"
 	help
 	  Used to define the stack size. The default is almost always what you
-- 
2.25.1



