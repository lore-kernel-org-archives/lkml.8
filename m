Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19403C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A35B23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ennrXqcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgHFRLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:11:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729421AbgHFRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596733870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f88Fq/eenv8sNNn9Tg1gLIIHq9PFrGBC4IOs6PirgI4=;
        b=ennrXqcXuYpV4nyMvoPHkjnQHiiaIohNCCgR4fskJmB9LQBmguX1z8sZlj2LwMq/d/l4z7
        Zdrkj1+XzUtfVGSY63Q1EaOimADWGXZVHw2xS5xjE9UNbLPgYQmSusLN9RynDCnVSI8nS8
        QGLJb0pNXJwc3lLwbxo8biCJnep1t2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-GuX-fLXpNoCnwWHH3KsG0Q-1; Thu, 06 Aug 2020 07:33:26 -0400
X-MC-Unique: GuX-fLXpNoCnwWHH3KsG0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BAE0106B243;
        Thu,  6 Aug 2020 11:33:24 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-96.pek2.redhat.com [10.72.12.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 766A15D9DC;
        Thu,  6 Aug 2020 11:33:19 +0000 (UTC)
Date:   Thu, 6 Aug 2020 19:33:15 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        kexec@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv2] x86/purgatory: don't generate debug info for
 purgatory.ro
Message-ID: <20200806113315.GA2492@dhcp-128-65.nay.redhat.com>
References: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/20 at 01:49pm, Pingfan Liu wrote:
> Purgatory.ro is a standalone binary that is not linked against the rest of
> the kernel.  Its image is copied into an array that is linked to the
> kernel, and from there kexec relocates it wherever it desires.
> 
> Unlike the debug info for vmlinux, which can be used for analyzing crash
> such info is useless in purgatory.ro. And discarding them can save about
> 200K space.
> 
> Original:
>   259080  kexec-purgatory.o
> Stripped debug info:
>    29152  kexec-purgatory.o
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> To: x86@kernel.org
> ---
>  arch/x86/purgatory/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 088bd76..d24b43a 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
>  # make up the standalone purgatory.ro
>  
>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> -PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
>  
> @@ -64,6 +64,9 @@ CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
>  CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
>  
> +AFLAGS_REMOVE_setup-x86_$(BITS).o	+= -Wa,-gdwarf-2
> +AFLAGS_REMOVE_entry64.o			+= -Wa,-gdwarf-2
> +
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>  		$(call if_changed,ld)
>  
> -- 
> 2.7.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

Hi Pingfan,

Looks good, thanks for the patch.

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

