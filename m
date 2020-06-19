Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F282100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584254;
	bh=97KhVImh3fMbPEhCdHz6ESrRxmRllU7uaOXxayOKOV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LFVI99o/Jd7ELBcCVXExYC8HE4uFd+33y+AK1UbnX6y37lfSSYJPNh1zW1GLFZov0
	 KbE45pHiuvA0SxSYM2GUZy9blONcUQZOIBAknOooMloPfAFnFpSBOp701K3h3dYLbV
	 ajmcGG/gYth9+6fqQ3t7IRZF57Ny8qvzK8QXwt8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395022AbgFSQao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389318AbgFSOxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:53:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9C4217D8;
        Fri, 19 Jun 2020 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578405;
        bh=97KhVImh3fMbPEhCdHz6ESrRxmRllU7uaOXxayOKOV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzL5sNXQTrqHhpnq/sesCWmn/f11rf8Zo21fxZ3su9z3QElVbvf8sk1oP0I7vWJq/
         IrY96Io5fAg1g5pNHQO9cTErHkWlQXOLuR/u72+1sGDLTxId8/01pGOSCKnugSkRKl
         Rq3SOXziUwOk8QUWMRd6hcNRqaCujBH3udQ7R7fU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH 4.19 010/267] x86: uaccess: Inhibit speculation past access_ok() in user_access_begin()
Date:   Fri, 19 Jun 2020 16:29:55 +0200
Message-Id: <20200619141649.355495009@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 6e693b3ffecb0b478c7050b44a4842854154f715 upstream.

Commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
makes the access_ok() check part of the user_access_begin() preceding a
series of 'unsafe' accesses.  This has the desirable effect of ensuring
that all 'unsafe' accesses have been range-checked, without having to
pick through all of the callsites to verify whether the appropriate
checking has been made.

However, the consolidated range check does not inhibit speculation, so
it is still up to the caller to ensure that they are not susceptible to
any speculative side-channel attacks for user addresses that ultimately
fail the access_ok() check.

This is an oversight, so use __uaccess_begin_nospec() to ensure that
speculation is inhibited until the access_ok() check has passed.

Reported-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miles Chen <miles.chen@mediatek.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/uaccess.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -717,7 +717,7 @@ static __must_check inline bool user_acc
 {
 	if (unlikely(!access_ok(type, ptr, len)))
 		return 0;
-	__uaccess_begin();
+	__uaccess_begin_nospec();
 	return 1;
 }
 


