Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C5FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAF620774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597346479;
	bh=FQN0B/ey4O8Rwk6F4qaKsP92DVc8fZlCG5oN82cz/E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L887KndZS8ZI8XgXIa7sFkgy9lokQN0pazniwd2GaeJ6p+Tj+Yf/YUCo0M0kIcUAe
	 Xa2voeV7dMFfXPoBkUOtmgl0O82bVmYBszh8S5yadXkVcMcUsbvcezxXQPxWxeaJ1o
	 M8uf1GvxxeMA8YcP2wLEB2HPS6zXu+YsyhuEc4UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHMTVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHMTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:21:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9ADC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:21:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so7354061ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XVrQlhbY2LBFm8eHP/4vv+LthPgeA+gEbL08m7IjfDA=;
        b=dFl7oWZFR+WUBCcPOXjfJ3ft448yYTYqwF2qOidfjPsC1xtdhVVADigmDF3GxG9fFl
         TbzxunMt0NuLbOuobQ2aS+8kI40a0dZdQak9HqDE5HaI11NTOCCCssmQrTAJRIK1KaK1
         7k4aim5YRDKz7Y5x6EbZ9JjjrIXlCc6GRfRN9mhHrTCOcRzfaRKnvvirs6vz9rh1cYIB
         iFpF61K5/O9xmgiAf7CFlPxMB0ZFAPsaks1KAfosSE3B4u8xzP/JpQ+9t+LvE+bIF+p3
         C8hwP9t3fGRvbTxonruJU5+oPT1lBUzO8f9nT9gk6edreGFptjOX2yVlOZpPTbpkafC8
         x3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XVrQlhbY2LBFm8eHP/4vv+LthPgeA+gEbL08m7IjfDA=;
        b=tlXfJ+21NgPkJpObb4NZ15pkYLVuG0/Ao0zx6+5yiSsJqXxKm8aqLBOQ9sbgo2ArF9
         SnuU0/VmX75qJuzWumZm9s9X9wy3knClwPoJhjqxETpp49ycuMrXbKvk7m2WILKcq1gb
         2LSUDVpyZSRXfx6Df7yFfAAuIyny0+R3MnCMQ6LEMTWqvGvd5pJK7udlWfV5Z6hYLDFf
         +z0DnSkLFNBva3p3/hekQRFwaEtw4HlKeYIc1RFvWj5DLU26VVkT81chs1eZuGgRpn+i
         qLUDQvEWH14+ETssLM5MjLZtf0oevHf0TNfgMpt1Ai6KfOUO8VOMFjfIPXny+49+YuUW
         jjWg==
X-Gm-Message-State: AOAM533v0A0AnIfg8FH7sPGoqn1pecL1086Ccz0DQIW/rOURf7yIy5hU
        AqMb8oWck3OsIiMN0mklkdw=
X-Google-Smtp-Source: ABdhPJyAxeKX9NGt9vH1NFQKDb9fsfPKL5yAtXSLMvjIPvLl2BhhjZr1lnZA1Atv3Q8e+/BuOWeRZg==
X-Received: by 2002:a17:906:2a04:: with SMTP id j4mr6566953eje.440.1597346476253;
        Thu, 13 Aug 2020 12:21:16 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t3sm4674617edq.26.2020.08.13.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 12:21:15 -0700 (PDT)
Date:   Thu, 13 Aug 2020 21:21:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, hpa@zytor.com,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason@zx2c4.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [PATCH] x86/mm/64: Do not dereference non-present PGD entries
Message-ID: <20200813192113.GA2338781@gmail.com>
References: <20200807084013.7090-1-joro@8bytes.org>
 <165106f9-392f-9ca5-52c8-8d58c41c5f79@intel.com>
 <20200810155359.GV163101@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810155359.GV163101@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Rapoport <rppt@linux.ibm.com> wrote:

> On Mon, Aug 10, 2020 at 07:27:33AM -0700, Dave Hansen wrote:
> > ... adding Kirill
> > 
> > On 8/7/20 1:40 AM, Joerg Roedel wrote:
> > > +		lvl = "p4d";
> > > +		p4d = p4d_alloc(&init_mm, pgd, addr);
> > > +		if (!p4d)
> > > +			goto failed;
> > >  
> > > +		/*
> > > +		 * With 5-level paging the P4D level is not folded. So the PGDs
> > > +		 * are now populated and there is no need to walk down to the
> > > +		 * PUD level.
> > > +		 */
> > >  		if (pgtable_l5_enabled())
> > >  			continue;
> > 
> > It's early and I'm a coffee or two short of awake, but I had to stare at
> > the comment for a but to make sense of it.
> > 
> > It feels wrong, I think, because the 5-level code usually ends up doing
> > *more* allocations and in this case, it is _appearing_ to do fewer.
> > Would something like this make sense?
> 
> Unless I miss something, with 5 levels vmalloc mappings are shared at
> p4d level, so allocating a p4d page would be enough. With 4 levels,
> p4d_alloc() is a nop and pud is the first actually populated level below
> pgd.
> 
> > 		/*
> > 		 * The goal here is to allocate all possibly required
> > 		 * hardware page tables pointed to by the top hardware
> > 		 * level.
> > 		 *
> > 		 * On 4-level systems, the p4d layer is folded away and
> > 		 * the above code does no preallocation.  Below, go down
> > 		 * to the pud _software_ level to ensure the second
> > 		 * hardware level is allocated.
> > 		 */

Would be nice to integrate all these explanations into the comment itself?

Thanks,

	Ingo
