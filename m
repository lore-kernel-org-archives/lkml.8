Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6010C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15AD20671
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fXmuXfld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEQVsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgEQVsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:48:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7250AC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:48:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so3363569plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TseoBxNXqkGmc0BKeUpNhNoekdY6lwjjJANkYe94qbs=;
        b=fXmuXfld1C+1UPw1bv9c3bwmjxXKQ31A0dYo8c5KzRXgHDVDq/BETl1kTkVyzT4Izt
         vP9YW8g7iuXzdYnOt9Tx31MSyhBkvlqnenYGMaitwycLw4gdiHYi66Dl4OiTkwb0oTH9
         F1q76kq5IFts9C62noNssP5sjvsEmychJJIgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TseoBxNXqkGmc0BKeUpNhNoekdY6lwjjJANkYe94qbs=;
        b=GoNgo3I4bczlLl8NRaJrp84brjQS5TXnxlqzEptAwLeMUTITe3Yf8rYom+fTYO88Dy
         Nnn7e2mCNK769HBRSpjTlPtOEKc8ehwobU4Ny3Q1mlasuRhCTwvKq+mnBqQZsxNQbxcw
         Sce4YnQcaJmMrKXEG512GacMh/nhGOMfGoHNIYLwjthYD7SbdUCqrAcyNs2J3QtVUJH6
         2SsVSpprdgY2AEvy6wdyRqfXtUhsuPTL7uXTBSQM7Pp8uGHJk5lDQRBehBnWCp28QPLe
         NYP1KsKn6gUkjz8FOSRapuM5iq+o1AqVzddNUJS2LN6t8d7ftsLdHUntTIdER0E2lxEk
         LG6w==
X-Gm-Message-State: AOAM5338kgRJ7CD60Tb/VNtsuSyOI8KWp6kF+xG+6H/Droc7Hs2LYodA
        4Xmbn4q0R3e4gMDCv7V9RiyeCA==
X-Google-Smtp-Source: ABdhPJwu0BwlUzPfekehCQs1ka3ojGBVEk1UZ0Rcu5atUYqn4c22iHglE7ZsiOSiXntjAfphkl4Hcw==
X-Received: by 2002:a17:90a:dc83:: with SMTP id j3mr15509573pjv.59.1589752133982;
        Sun, 17 May 2020 14:48:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i184sm6443327pgc.36.2020.05.17.14.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:48:53 -0700 (PDT)
Date:   Sun, 17 May 2020 14:48:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mhiramat@kernel.org, labbott@redhat.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: kprobes: Avoid fortify_panic() when copying
 optprobe template
Message-ID: <202005171447.00CFE0C@keescook>
References: <20200517153959.293224-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517153959.293224-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 01:09:59AM +0930, Andrew Jeffery wrote:
> As mentioned, a couple of attempts have been made to address the issue
> by casting a pointer to optprobe_template_entry before providing it to
> memcpy(), however gccs such as Ubuntu 20.04's arm-linux-gnueabi-gcc
> 9.3.0 (Ubuntu 9.3.0-10ubuntu1) see through these efforts.

Ah, dang. :P

How about converting them all to unsized arrays, which would also allow
the code to drop the "&" everywhere, I think. This is untested:


diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index 213607a1f45c..e26a278d301a 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -44,20 +44,20 @@ int kprobe_exceptions_notify(struct notifier_block *self,
 			     unsigned long val, void *data);
 
 /* optinsn template addresses */
-extern __visible kprobe_opcode_t optprobe_template_entry;
-extern __visible kprobe_opcode_t optprobe_template_val;
-extern __visible kprobe_opcode_t optprobe_template_call;
-extern __visible kprobe_opcode_t optprobe_template_end;
-extern __visible kprobe_opcode_t optprobe_template_sub_sp;
-extern __visible kprobe_opcode_t optprobe_template_add_sp;
-extern __visible kprobe_opcode_t optprobe_template_restore_begin;
-extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn;
-extern __visible kprobe_opcode_t optprobe_template_restore_end;
+extern __visible kprobe_opcode_t optprobe_template_entry[];
+extern __visible kprobe_opcode_t optprobe_template_val[];
+extern __visible kprobe_opcode_t optprobe_template_call[];
+extern __visible kprobe_opcode_t optprobe_template_end[];
+extern __visible kprobe_opcode_t optprobe_template_sub_sp[];
+extern __visible kprobe_opcode_t optprobe_template_add_sp[];
+extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
+extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
+extern __visible kprobe_opcode_t optprobe_template_restore_end[];
 
 #define MAX_OPTIMIZED_LENGTH	4
 #define MAX_OPTINSN_SIZE				\
-	((unsigned long)&optprobe_template_end -	\
-	 (unsigned long)&optprobe_template_entry)
+	((unsigned long)optprobe_template_end -	\
+	 (unsigned long)optprobe_template_entry)
 #define RELATIVEJUMP_SIZE	4
 
 struct arch_optimized_insn {
diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index 7a449df0b359..c78180172120 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -85,21 +85,21 @@ asm (
 			"optprobe_template_end:\n");
 
 #define TMPL_VAL_IDX \
-	((unsigned long *)&optprobe_template_val - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_val - (unsigned long *)optprobe_template_entry)
 #define TMPL_CALL_IDX \
-	((unsigned long *)&optprobe_template_call - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_call - (unsigned long *)optprobe_template_entry)
 #define TMPL_END_IDX \
-	((unsigned long *)&optprobe_template_end - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_end - (unsigned long *)optprobe_template_entry)
 #define TMPL_ADD_SP \
-	((unsigned long *)&optprobe_template_add_sp - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_add_sp - (unsigned long *)optprobe_template_entry)
 #define TMPL_SUB_SP \
-	((unsigned long *)&optprobe_template_sub_sp - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_sub_sp - (unsigned long *)optprobe_template_entry)
 #define TMPL_RESTORE_BEGIN \
-	((unsigned long *)&optprobe_template_restore_begin - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_restore_begin - (unsigned long *)optprobe_template_entry)
 #define TMPL_RESTORE_ORIGN_INSN \
-	((unsigned long *)&optprobe_template_restore_orig_insn - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_restore_orig_insn - (unsigned long *)optprobe_template_entry)
 #define TMPL_RESTORE_END \
-	((unsigned long *)&optprobe_template_restore_end - (unsigned long *)&optprobe_template_entry)
+	((unsigned long *)optprobe_template_restore_end - (unsigned long *)optprobe_template_entry)
 
 /*
  * ARM can always optimize an instruction when using ARM ISA, except
@@ -234,7 +234,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
 	}
 
 	/* Copy arch-dep-instance from template. */
-	memcpy(code, (unsigned long *)&optprobe_template_entry,
+	memcpy(code, (unsigned long *)optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */

-- 
Kees Cook
