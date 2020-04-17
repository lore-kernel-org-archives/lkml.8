Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CABEC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C2B22250
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1NVhna9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgDQKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgDQKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:41:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB24C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EUsPqAz2CAwrpD3T6QffV2gx1aiwSG8eKPhjQi/6B+8=; b=J1NVhna9GYMmhBBZbJe/JHazic
        AfX6xvryGnz34nCQFLd+jT7u/v1eDYi2ZU30NP2zicuWiVC5daJ7IhzY58NOVbRz4tkbc1OfnRMk8
        7nQdu3Eus+savcHoGbHwBw8uMH+0RPl34XA2pIaQFlMh/09g17BomSlzyLTg1XBsRGecywYLtfxoP
        VLbbQeb3who1/Ks4ay5hA8JHNStZCuOcJDlEBljPxt86qMsu5/qnGvXeT2L5GufKrTwUCd9/0157T
        vg+v1mOpJv1F7zcMTsQypctKs6cvBOpJnX3D3VcR95q09AVkRKxcCPwB3WGZTWwyd5doPtYtGJjgO
        3VBHGaFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPOR6-0005pt-6c; Fri, 17 Apr 2020 10:41:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94F973010BC;
        Fri, 17 Apr 2020 12:41:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DDA82B0DED2D; Fri, 17 Apr 2020 12:41:26 +0200 (CEST)
Date:   Fri, 17 Apr 2020 12:41:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200417104126.GX20730@hirez.programming.kicks-ass.net>
References: <20200326223501.GK11398@zn.tnic>
 <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
 <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf>
 <20200417075739.GA7322@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417075739.GA7322@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:57:39AM +0200, Borislav Petkov wrote:

> Yeah, Peter and I have been discussing something like the below
> yesterday. I don't like the additional exports too much but would
> disable stack protector only for the one function...

I did do promise you bike-shedding... so here goes :-)

> -obj-$(CONFIG_SMP)		+= smpboot.o
> +
> +nostackprot := $(call cc-option, -fno-stack-protector)
> +CFLAGS_smpboot_aux.o := $(nostackprot)
> +
> +smpboot_all-y			:= smpboot.o smpboot_aux.o

So how about we call that file: smpboot_nostack.c or, since it only has
the one function in: start_secondary.c ?

