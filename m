Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D13C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE5921501
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322688;
	bh=NK+Mdaa2CdV53w/hhIbdJph8kk03NSGYr1vH+bpcorg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UJfws16ZaUhEbrsFj+hIwJbBnkbwe6u/cd2kuQvL9XouqG3UovWvlFGbJ0v38xNal
	 zdUckbaluF+PjMeX9fYGMp3kf8QndmAhHjytUgwCz+HGWAIz0H6hqBD+wABiUGu7P2
	 Nic76h7yyluR7GC2TBlIPqn4vlQQWAj9tGBj0f/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgFPPv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbgFPPvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:51:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE42C208D5;
        Tue, 16 Jun 2020 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322666;
        bh=NK+Mdaa2CdV53w/hhIbdJph8kk03NSGYr1vH+bpcorg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onJZ92jWT5FOUaomUz/CSd6PaZXGsoUpe1raWVpSa1x/dlUQUmyQfp9EsgnJn0l7C
         0xN3b0eUz+wcF0iUDimhQrIDAlmBkuAHyzdivxOGY6IgXxAukaXQHrf86IdSmZbJu/
         e3XBk2T8Pccmq0/8bsRaebHMgfdq1CM/QTQv4qe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.6 056/161] KVM: x86: allow KVM_STATE_NESTED_MTF_PENDING in kvm_state flags
Date:   Tue, 16 Jun 2020 17:34:06 +0200
Message-Id: <20200616153109.048029394@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit df2a69af85bef169ab6810cc57f6b6b943941e7e upstream.

The migration functionality was left incomplete in commit 5ef8acbdd687
("KVM: nVMX: Emulate MTF when performing instruction emulation", 2020-02-23),
fix it.

Fixes: 5ef8acbdd687 ("KVM: nVMX: Emulate MTF when performing instruction emulation")
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4568,7 +4568,7 @@ long kvm_arch_vcpu_ioctl(struct file *fi
 
 		if (kvm_state.flags &
 		    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE
-		      | KVM_STATE_NESTED_EVMCS))
+		      | KVM_STATE_NESTED_EVMCS | KVM_STATE_NESTED_MTF_PENDING))
 			break;
 
 		/* nested_run_pending implies guest_mode.  */


