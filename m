Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD78C3F34F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4013121D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811104;
	bh=pwJ+StcW9izmZqBwQ8Amym8xtuOTRPBbZU165E7EjN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A3P8XioyqdWIjc6OPpzKzd0vleg6rUEXnacM0wI4hI4xJzFpNhHic6tUFo8ao/iCo
	 GdMy7KpIA6bH5LKGAsVlxYcSnsFdpfj+nKvuqOOSVucM1iSxPEzFa72qH5NWJmbnVH
	 30ValZ49X/QE+P9Psbi0Y6m4eHyZtyV3de8UcSLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgB0NpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbgB0Noz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:44:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766ED24656;
        Thu, 27 Feb 2020 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811094;
        bh=pwJ+StcW9izmZqBwQ8Amym8xtuOTRPBbZU165E7EjN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsmDGYaNWfbhRZiqxRZnM4izyAN2eYsJFQIdzg4W3C/R1nB7W7AtlFkxhVGuiDODt
         0jZUJqFQqaeP1FopZ3cn5YS2CKO3nrm8UC84ruzgJb8Xuc15pfVOM0R7iaTCOa4KM5
         ZDT+3cKC2XoZ5WaonWlX5uiRjQQxpIkm7AeMHLw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 099/113] KVM: nVMX: Dont emulate instructions in guest mode
Date:   Thu, 27 Feb 2020 14:36:55 +0100
Message-Id: <20200227132227.594460803@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 07721feee46b4b248402133228235318199b05ec ]

vmx_check_intercept is not yet fully implemented. To avoid emulating
instructions disallowed by the L1 hypervisor, refuse to emulate
instructions by default.

Cc: stable@vger.kernel.org
[Made commit, added commit msg - Oliver]
Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10759,7 +10759,7 @@ static int vmx_check_intercept(struct kv
 	}
 
 	/* TODO: check more intercepts... */
-	return X86EMUL_CONTINUE;
+	return X86EMUL_UNHANDLEABLE;
 }
 
 static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)


