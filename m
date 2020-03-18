Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B015FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8352420768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aQBnpb9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCRNSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:18:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCRNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e8OZlUYt9NpXE+7IhSvgOVwhKJLbPwn1osPXL9X+zfc=; b=aQBnpb9cyipV3JxWUZBjkUXvVs
        sodm3NbVUN2mcqx+vxN2ASzBcdncGr+NbwpIwlWTA9O05gFZq+u1VIOR6O7AIoIB6uqtM208Cdeho
        EvRU/Wf5kAjYf2uhaRthHbqhitBHGLcbj9rTzvTgLnxMo8YzGgshbOgY3gXHMywiRMoulwsNwx9Gg
        ijJbE1xGJ8kENC0XYnZZyU9eaci/nDjxT90EM8dYoLR/bYqN/khxjs6hBwrX4k29LNLflKp1aOWaf
        6nkjLjqX2bMc2uS97JQb6bJHT4l2FZ9ay3Usb/sDb5rD+kgHeiSHOu8D7ylzouOVhoqLTqfCjm9V6
        Np4I0Glg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEYat-0001cq-SQ; Wed, 18 Mar 2020 13:18:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A199B30047A;
        Wed, 18 Mar 2020 14:18:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 762B82B4EBEA3; Wed, 18 Mar 2020 14:18:45 +0100 (CET)
Date:   Wed, 18 Mar 2020 14:18:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: [RFC][PATCH v2 20/19] kbuild/objtool: Add objtool-vmlinux.o pass
Message-ID: <20200318131845.GG20730@hirez.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317170234.897520633@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This seems to 'work', must be perfect etc..

---

Subject: kbuild/objtool: Add objtool-vmlinux.o pass
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 18 13:33:54 CET 2020

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
+		if [ -n "${CONFIG_FRAME_POINTER}" ]; then
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
