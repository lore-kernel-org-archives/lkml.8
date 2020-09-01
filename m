Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F1C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635AC2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975529;
	bh=8Wk+bmt0xX8me7mRaxKKwvZ1jApiy/wDFsBuzZh+E9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yj02xxSsAgC3exwJMbUkamdWn9HgVOTm8wh8soOkzNp0jUxipf+EdYhceLVpq3AMK
	 VEL3SeIYkUwbyfqFLkDqW7Vvx5H3PfWZzgvaaic1ZjOK7OioBFLjNS37tiTbkmSNi3
	 ozU44u2MFi4bG9/Nc1M6De9plAMSkAgnQD7xiR0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbgIAPsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731821AbgIAPok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:44:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCBC2064B;
        Tue,  1 Sep 2020 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975079;
        bh=8Wk+bmt0xX8me7mRaxKKwvZ1jApiy/wDFsBuzZh+E9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0JkVAe4OLfP3+kRWZNaTdh2fzgq5sPyPj1dWNMpZDDMk1yw9y7khlS2P1gOnoZFz
         bTL15a4xXgjvOkXHGquKEMEuq80JHPZQsaR91t7lfClvYpxRQboka7FUDk+kMiKB1F
         xN0JaDxxAJOEvRk23+w3jTzij+fKgbjQvvgjuebY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giuseppe Sacco <giuseppe@sguazz.it>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.8 201/255] powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU
Date:   Tue,  1 Sep 2020 17:10:57 +0200
Message-Id: <20200901151010.325266809@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit 4a133eb351ccc275683ad49305d0b04dde903733 upstream.

low_sleep_handler() can't restore the context from virtual
stack because the stack can hardly be accessed with MMU OFF.

For now, disable VMAP stack when CONFIG_ADB_PMU is selected.

Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
Cc: stable@vger.kernel.org # v5.6+
Reported-by: Giuseppe Sacco <giuseppe@sguazz.it>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/ec96c15bfa1a7415ab604ee1c98cd45779c08be0.1598553015.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -36,7 +36,7 @@ config PPC_BOOK3S_6xx
 	select PPC_HAVE_PMU_SUPPORT
 	select PPC_HAVE_KUEP
 	select PPC_HAVE_KUAP
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if !ADB_PMU
 
 config PPC_BOOK3S_601
 	bool "PowerPC 601"


