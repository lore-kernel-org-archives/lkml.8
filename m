Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B953F20FC3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258374;
	bh=lVVAh9Z9McLW3SoXxl5P+4DwQWEYitbI4AmCQQ3aerw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVabgSPng4YAIaXQw1faa0HxpZE9xuNWfKSNBeeONZvVPqS+zsi5ajdXNDPnZuIFL
	 0ffYDWijOJaQqiqG1v63uczps4qmS1OO8eQYfp2+nJLsyyJh6ICd+r+hSdW6uFaLpT
	 L0uRGe8QRxBvtPQH5RhqQwagGiYsch4OmIbZcLmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgHXIjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgHXIjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:39:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872762177B;
        Mon, 24 Aug 2020 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258364;
        bh=lVVAh9Z9McLW3SoXxl5P+4DwQWEYitbI4AmCQQ3aerw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+Eupww3+KqMvt4UTtKmTwLpOT+EUbUaiJzrMicBAaxqdz9h9wFdB87/E6ot+EUnO
         5expdivR/CwdQWRtuQ96ZKqbe+isgZ1P6jtR2Ds9OWiqh5entt5Pr1dOEgvZbbTIT4
         XNHVA/hyZAPuBbgNabNgnRnreWYghEp6Xwo24ss8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Weijiang <weijiang.yang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.7 021/124] selftests: kvm: Use a shorter encoding to clear RAX
Date:   Mon, 24 Aug 2020 10:29:15 +0200
Message-Id: <20200824082410.462355707@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Weijiang <weijiang.yang@intel.com>

commit 98b0bf02738004829d7e26d6cb47b2e469aaba86 upstream.

If debug_regs.c is built with newer binutils, the resulting binary is "optimized"
by the assembler:

asm volatile("ss_start: "
             "xor %%rax,%%rax\n\t"
             "cpuid\n\t"
             "movl $0x1a0,%%ecx\n\t"
             "rdmsr\n\t"
             : : : "rax", "ecx");

is translated to :

  000000000040194e <ss_start>:
  40194e:       31 c0                   xor    %eax,%eax     <----- rax->eax?
  401950:       0f a2                   cpuid
  401952:       b9 a0 01 00 00          mov    $0x1a0,%ecx
  401957:       0f 32                   rdmsr

As you can see rax is replaced with eax in target binary code.
This causes a difference is the length of xor instruction (2 Byte vs 3 Byte),
and makes the hard-coded instruction length check fail:

        /* Instruction lengths starting at ss_start */
        int ss_size[4] = {
                3,              /* xor */   <-------- 2 or 3?
                2,              /* cpuid */
                5,              /* mov */
                2,              /* rdmsr */
        };

Encode the shorter version directly and, while at it, fix the "clobbers"
of the asm.

Cc: stable@vger.kernel.org
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/kvm/x86_64/debug_regs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -40,11 +40,11 @@ static void guest_code(void)
 
 	/* Single step test, covers 2 basic instructions and 2 emulated */
 	asm volatile("ss_start: "
-		     "xor %%rax,%%rax\n\t"
+		     "xor %%eax,%%eax\n\t"
 		     "cpuid\n\t"
 		     "movl $0x1a0,%%ecx\n\t"
 		     "rdmsr\n\t"
-		     : : : "rax", "ecx");
+		     : : : "eax", "ebx", "ecx", "edx");
 
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");


