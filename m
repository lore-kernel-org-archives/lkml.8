Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374DAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F4A20772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597823745;
	bh=svZ7ptEFG3FX9fhrUVJHybJC8gs7DpvECkDw5n41tzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NQGdtkJk1kccj4Y0c7UILrJS5zVpVoVh8zSmPmZgVkHsRlTVZz25ASU71MyiKvDI0
	 G3xIhZQWszv1Rmj/qn6OoIakY1hcXF153K8nndA3DA020BhK7gJzPewExY/ir6a04m
	 XwHDet8n67N8ZD6Qubzk69iVCbukkiMqd/3czdKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHSHzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSHzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:55:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E9FC061389;
        Wed, 19 Aug 2020 00:55:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so25144072ejc.9;
        Wed, 19 Aug 2020 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wg9MrSyy6obfy6oGrt6RtQrj1lX25v4GJApVBQKEDg0=;
        b=FEh5nj5vUybDsbLbZwuomz5/3Sg/csU/fpmYlySqDFYepTFGqt4ifw4axEV9Jo9msh
         tTGzfS17FifS23Yi4Lj3diBTuOKdeWfvRm7OH92fYTq78n8crItm7di1y26eNW3xflyi
         ZyW6mqgdjSQh4w9B3tLVtur2Kh54zpvoaViAs3Y9HtHIeJw/LpCZD27pIsJXDwMcIMaM
         KZvBY4FjSqWjCvoh3YlHI6JI22FIIco1JQj3W6L4OjmbCEm6uSpQ26Q4F9iIF3ZJM10N
         mc8v6MIkCh19CRK1/tALllkCKbB03A+abqUXkM4aD8M8uAeBMBgNhs4pXJ0MYqrAFwNO
         OExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wg9MrSyy6obfy6oGrt6RtQrj1lX25v4GJApVBQKEDg0=;
        b=gXsuva93e6hLBYoSKSmiCrFfxkpiAjyeOHXEcpH0YywPo+zgZfWHwwj+LiRFvQfGTn
         RASDEKqC8jf5wUjSRcjqhTgHI4H2QhOsEh1cZaTuN5WSH00t2h5Jv9RC4IYsmaaKg07T
         7smkd/PWVUJrqdlLiOhngAmXZkFsWWhkKOXOOmNxDOT3sTINCmOTCXyfj+exk2e+er7R
         l7aYScIG59CrhlN7U6TzreBxOn1Smdzk5C4YipXF7P3taSB5xcsSczMurEyIqxyw9/jF
         Se+iav4hKRhsM3zUF3ZgNtCr09UgDvChGcSzy7dZCwcw8yf95y9TohHEE6VMMKEAHFkS
         qyow==
X-Gm-Message-State: AOAM530EkJiGMUrdUpSzJdwKadw8NHnv1xDlcFuvvrUFJ1/0AREc/QNI
        dk+bFhk/nOwW7kwP2To/MZg=
X-Google-Smtp-Source: ABdhPJwUq3oBGOAOblaj/Y2HArL7xs6/VYy52/5rZX7VXUYFjqr4CTKsPweIBoy96OSgP4UC/r1UDw==
X-Received: by 2002:a17:906:260c:: with SMTP id h12mr25237852ejc.457.1597823739987;
        Wed, 19 Aug 2020 00:55:39 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id m13sm17450359edi.89.2020.08.19.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:55:39 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:55:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>
Subject: Re: [PATCH] x86/cpu: Fix typos and improve the comments in
 sync_core()
Message-ID: <20200819075537.GA3188399@gmail.com>
References: <20200807032833.17484-1-ricardo.neri-calderon@linux.intel.com>
 <159767927411.3192.1923111080573965673.tip-bot2@tip-bot2>
 <20200818053130.GA3161093@gmail.com>
 <20200819010019.GA7074@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819010019.GA7074@ranerica-svr.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> > @@ -47,16 +47,19 @@ static inline void iret_to_self(void)
> >   *
> >   *  b) Text was modified on a different CPU, may subsequently be
> >   *     executed on this CPU, and you want to make sure the new version
> > - *     gets executed.  This generally means you're calling this in a IPI.
> > + *     gets executed.  This generally means you're calling this in an IPI.
> >   *
> >   * If you're calling this for a different reason, you're probably doing
> >   * it wrong.
> > + *
> > + * Like all of Linux's memory ordering operations, this is a
> > + * compiler barrier as well.
> >   */
> >  static inline void sync_core(void)
> >  {
> >  	/*
> >  	 * The SERIALIZE instruction is the most straightforward way to
> > -	 * do this but it not universally available.
> > +	 * do this, but it is not universally available.
> 
> Indeed, I missed this grammar error.
> 
> >  	 */
> >  	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> >  		serialize();
> > @@ -67,10 +70,10 @@ static inline void sync_core(void)
> >  	 * For all other processors, there are quite a few ways to do this.
> >  	 * IRET-to-self is nice because it works on every CPU, at any CPL
> >  	 * (so it's compatible with paravirtualization), and it never exits
> > -	 * to a hypervisor. The only down sides are that it's a bit slow
> > +	 * to a hypervisor.  The only downsides are that it's a bit slow

And this one - it's "downsides" not "down sides".

> >  	 * (it seems to be a bit more than 2x slower than the fastest
> > -	 * options) and that it unmasks NMIs.  The "push %cs" is needed
> > -	 * because, in paravirtual environments, __KERNEL_CS may not be a
> > +	 * options) and that it unmasks NMIs.  The "push %cs" is needed,
> > +	 * because in paravirtual environments __KERNEL_CS may not be a
> 
> I didn't realize that the double spaces after the period were part of the
> style.

They are not, but *consistent* use of typographic details is part of 
the style, and here we were mixing two styles within the same comment 
block.

> FWIW,
> 
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks,

	Ingo
