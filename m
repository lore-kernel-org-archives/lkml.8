Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B115C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4634C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itiBfiXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgCXQLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GbPqE3mfOetHUtuB+gPFjnQNDr1UBAvzbfzHTV0Kr/8=; b=itiBfiXgPdm8X0n4yXqoEyfKan
        BXj/RBY9rPU9Ppf6DE2lcZq19DK6ER+vNfbJAPiKVsuXjKytbCzMMahdszhc9jd6pVa6Jf+/J7t8j
        cW+dewSBfFipfOhKhJav0IJZmDsCOlA5RLQRZssFmDJVIy/xc+Hc/nGLBAp/pIPxA4LHlLE2iau8w
        5Dfu/zZGQtVTEz86zeeF31AJjURcfMNRlfzCnFBO4bT/N/Do9d39UWDGGTXYLu14GJgHan/sfyzEE
        XDzaHMiQ0qDbbMVHogWrlyjOaCKS1gji16jDIU4ROk2gp83CJz5u2T+y5U4P+g7UzA1QK1DWO4dA2
        jiw8R6HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9N-0000CR-Fb; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 794E1307770;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6AE8B20250FC4; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160925.288855432@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 23/26] kbuild/objtool: Add objtool-vmlinux.o pass
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that objtool is capable of processing vmlinux.o and actually has
something useful to do there, (conditionally) add it to the final link
pass.

This will increase build time by a few seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Kconfig.debug       |    5 +++++
 scripts/link-vmlinux.sh |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -379,6 +379,11 @@ config STACK_VALIDATION
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
+config VMLINUX_VALIDATION
+	bool
+	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	default y
+
 config DEBUG_FORCE_WEAK_PER_CPU
 	bool "Force weak per-cpu definitions"
 	depends on DEBUG_KERNEL
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -55,6 +55,29 @@ modpost_link()
 	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
 }
 
+objtool_link()
+{
+	local objtoolopt;
+
+	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
+		objtoolopt="check"
+		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
+			objtoolopt="${objtoolopt} --no-fp"
+		fi
+		if [ -n "${CONFIG_GCOV_KERNEL}" ]; then
+			objtoolopt="${objtoolopt} --no-unreachable"
+		fi
+		if [ -n "${CONFIG_RETPOLINE}" ]; then
+			objtoolopt="${objtoolopt} --retpoline"
+		fi
+		if [ -n "${CONFIG_X86_SMAP}" ]; then
+			objtoolopt="${objtoolopt} --uaccess"
+		fi
+		info OBJTOOL ${1}
+		tools/objtool/objtool ${objtoolopt} ${1}
+	fi
+}
+
 # Link of vmlinux
 # ${1} - output file
 # ${2}, ${3}, ... - optional extra .o files
@@ -244,6 +267,7 @@ ${MAKE} -f "${srctree}/scripts/Makefile.
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
+objtool_link vmlinux.o
 
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1


