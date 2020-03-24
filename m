Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA599C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916832076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3dUmx8nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgCXPPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:15:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58418 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgCXPPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8TXwLdoUDxOFHArMszYS+qpN9z46iZMtciU0e+inYj0=; b=3dUmx8ntr/oFgCmMcBnnANMTip
        21oGu0KzDc0Yd4MPZHFTTRzmuma8nxyj0/WHXe5fU8WqxJTKHCnKGjBZpOiY+EojAfNnxsg1IKuKj
        kSKVslo7wUy77OdEkkt+aw3rnLT7cH0gsSE82Ijs81BVgx4EYFJBLxLfoI8iiQPm0MPFLLnk5Y9Ly
        XGe9VWA5Y62NThk1OLH9bYisCLNtpucatBQ/0c9O+z2MWH9/02Wc/SbPcbkYb1hoyaTVLBt/Mj9Up
        NFtY11fW51lvEeCM+cMUMNitrPSvFOBWWpUKL/zcTVREDkhgvZ/gP95Wq4ilQtqPoV7balMMqxsMB
        fhzWWfgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGlGg-0004yl-4h; Tue, 24 Mar 2020 15:15:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA687300096;
        Tue, 24 Mar 2020 16:15:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9549F29B3DAFF; Tue, 24 Mar 2020 16:15:00 +0100 (CET)
Date:   Tue, 24 Mar 2020 16:15:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Message-ID: <20200324151500.GQ20696@hirez.programming.kicks-ass.net>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:37:58PM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> rather than relying upon the magic in raw_copy_from_user()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 61d93f062a36..ab8eab43a8a2 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -695,15 +695,6 @@ extern struct movsl_mask {
>  #endif
>  
>  /*
> - * We rely on the nested NMI work to allow atomic faults from the NMI path; the
> - * nested NMI paths are careful to preserve CR2.
> - *
> - * Caller must use pagefault_enable/disable, or run in interrupt context,
> - * and also do a uaccess_ok() check
> - */
> -#define __copy_from_user_nmi __copy_from_user_inatomic
> -
> -/*
>   * The "unsafe" user accesses aren't really "unsafe", but the naming
>   * is a big fat warning: you have to not only do the access_ok()
>   * checking before using them, but you have to surround them with the

Thanks for killing that remnant!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
