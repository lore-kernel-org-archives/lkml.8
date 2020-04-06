Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDB2C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A87E2343B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZpkeZbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgDFOGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:06:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgDFOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wuY9sae0NBKX23MLISqZR16SAVntvt/3s72TBLRjUI4=; b=FZpkeZbsvDsBzq7OGL80zOGfqp
        VjT71XyWpoJUPGxLBcSgV7LV4eUDLSqYrtSk1lAiuBdwc3XuZvx6gGSzwU9tcz79UTkCUlIkdgXIn
        bus14IoWCmmVbrgJB87DNgbzjN95EMp85/utaYrdQc4RefF4NTfjvyHnCDVmZazv3eYlsud77L/QS
        HHUb61mFhq5SCBl0Q4crbGcNBv17ox8JfINumy2hHcKYhGsqsnVasHHvN/r4hLmyU//1WPgLmJKgo
        yRvnko/hwMAd+fwhLagl6/QIaziyyFC6XJhgeYL/Ak3HIeVVcbVxqJIMjioK0OHMSZ+gd4VrnRlHW
        pcYBEfEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLSOa-0001I3-W3; Mon, 06 Apr 2020 14:06:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68F7D304121;
        Mon,  6 Apr 2020 16:06:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54A4C2BAC7486; Mon,  6 Apr 2020 16:06:34 +0200 (CEST)
Date:   Mon, 6 Apr 2020 16:06:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200406140634.GM20730@hirez.programming.kicks-ass.net>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
 <20200406130155.GB29306@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406130155.GB29306@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:01:55AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> > 
> > __get_vm_area() is an exported symbol, make sure the callers stay in
> > the expected memory range. When calling this function with memory
> > ranges outside of the VMALLOC range *bad* things can happen.
> > 
> > (I noticed this when I managed to corrupt the kernel text by accident)
> 
> Maybe it is time to unexport it?  There are only two users:
> 
>  - staging/media/ipu3 really should be using vmap.  And given that it
>    is a staging driver it really doesn't matter anyway if we break it.
>  - pcmcia/electra_cf.c is actually using it for something that is not
>    a vmalloc address.  But it is so special that I think prohibiting
>    to build it as module seems fine.

I think I just sent you a patch along those lines ;-)
