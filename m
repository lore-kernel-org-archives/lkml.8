Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D522C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8AD2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595935897;
	bh=VceExswgBJqWkIVorvdj5GpOMEWHtqJCTIcpkyPtNSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gfXDboRnvhBMIX+wMqvx7G1jw81BfFiYowU6OKQrkRhb8Q78Igg8QyWAVXxkceA4h
	 4ypO3XoHKbmfFWTSr4sCIPOWvFYFWXpUu6GqVVmEvXWUw01HTEXMcNO00/zq13AZHN
	 aqPdMYjg06MvL+/vpUWcrT1lbx1Yrr2Bu49dfwzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgG1Lbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgG1Lbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:31:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB96C061794;
        Tue, 28 Jul 2020 04:31:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g11so8513136ejr.0;
        Tue, 28 Jul 2020 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5PIG9gv3+Q65q73c5WJL/D8ixTHr55LzcpS0la2b94=;
        b=P7HSEqdJclVd5Bnzob/XF2RdTn0Nmb3HUJySlROmL68osljlcfCEFlV3HJYGTsfk+b
         VHrJ1f+xMExFZ+YSvv8Rmeh1N5GaQQ3p6pZuSDQBx0nbSt1s4XPLJfYIDrJpBvMTIQ3T
         tnPlkWxuMjJu8J60O/OlnbAruEsKB2973ivyYANGexg1cYLi5G1vwz7DY7w0Hk/PvarE
         qINCzPe5al7+9kODm2QQrbeaDo+Ef9vruELr0bSlzbcnvJrfytMgRRiJ5yKDr3S0B9bh
         pUq4JqHBAw9f6ZNp7JiPY7EX8klIc+e+asMdZK9Yz7BoN21wjEsZd5KQdrrR+TAABie5
         JrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=y5PIG9gv3+Q65q73c5WJL/D8ixTHr55LzcpS0la2b94=;
        b=OOzFgRSu/DvjBP+3eKmGLIftrUVRhrB6OCXZ7oI2ZKitEKe/7hOLHMA2fChf3XyTpy
         C/Th+ceg3zrQt4MJt63pZXHsRvYbvbwIzdi11gA2GVWubw6Bi5U4qLHR1GLlmB5sXo+c
         Qn9yJjRW/dW3grvrpRiPd+RcAzbbu67hXsAIujKJkQqt3jx32eutYjeHmJYMmO3ktPIH
         Te1JETAsO1UKem6WhMYMY//je33oKgHo5SFX3uBFNJ9Q5SnWGqnoyn6NGr3PkBy54Due
         JCanvJO0i8JQollrWJNEvSpGwd1kSRM58A9wC7DP9DKSirPwszFXHRTSqGLAK02rEwn+
         cnNw==
X-Gm-Message-State: AOAM533fxYOvBNmJhet9bMjHRrwqic3bShiFK8FVomFCweRS2L2toODh
        MIrI9LjpDNApb2rNBcUVJ88=
X-Google-Smtp-Source: ABdhPJyQbAVtd7rvh28AKuUuAlpNq5u8pcARe+eVx7W3hTuAzpqofzarCSjsJ0a8Qe+YPenFOSGRUQ==
X-Received: by 2002:a17:906:22c1:: with SMTP id q1mr16036266eja.443.1595935889994;
        Tue, 28 Jul 2020 04:31:29 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id qw19sm7634705ejb.46.2020.07.28.04.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:31:29 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:31:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: Re: [PATCH 14/15] x86/numa: remove redundant iteration over
 memblock.reserved
Message-ID: <20200728113126.GB233444@gmail.com>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-15-rppt@kernel.org>
 <20200728104440.GA222284@gmail.com>
 <20200728105602.GB3655207@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728105602.GB3655207@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Rapoport <rppt@kernel.org> wrote:

> On Tue, Jul 28, 2020 at 12:44:40PM +0200, Ingo Molnar wrote:
> > 
> > * Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > numa_clear_kernel_node_hotplug() function first traverses numa_meminfo
> > > regions to set node ID in memblock.reserved and than traverses
> > > memblock.reserved to update reserved_nodemask to include node IDs that were
> > > set in the first loop.
> > > 
> > > Remove redundant traversal over memblock.reserved and update
> > > reserved_nodemask while iterating over numa_meminfo.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/x86/mm/numa.c | 26 ++++++++++----------------
> > >  1 file changed, 10 insertions(+), 16 deletions(-)
> > 
> > I suspect you'd like to carry this in the -mm tree?
> 
> Yes.
>  
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> Thanks!

Assuming it is correct and works. :-)

Thanks,

	Ingo
