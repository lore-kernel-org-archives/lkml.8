Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76097C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BF42073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AcTN0MNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbgDCOh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:37:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35882 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgDCOh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RoF2efbTgGwmrX7dboxs0x1HHgR1yO7ZbDcxDy9aJ3U=; b=AcTN0MNfLl2mayveFNdl7KGb0t
        EDtrbhCl21n4jEl43yByQhgl4KrBHSvfYSygdgWcMyhINe/+eh2bZQQYOnejKfFBV6fNVjovro9vr
        Oj56g4UpeHfhjI4MpSnB+UrX0HJr8MqJmpJZ+dKZnrAr88ctKQOsdFG0CZU9QznX9ZVtoxk1YwBhP
        nLYxRxt31QJikR9dwQuABURsgb77cXkAIdQbmfjBJGNcjzKD2Ha3jJrnhFPV2ErFdOiAvGeb7zJOi
        3ARQ3m2hOENDdG/GA+qaK84bzmPsabpkA6wJh/IUwZb7Gb0bk2HgyctVuwANIJgjslnzNTJt5ETW6
        5SpJ7MWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKNS7-0000jO-SG; Fri, 03 Apr 2020 14:37:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 400683010BC;
        Fri,  3 Apr 2020 16:37:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29ECE2B123E34; Fri,  3 Apr 2020 16:37:45 +0200 (CEST)
Date:   Fri, 3 Apr 2020 16:37:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
Message-ID: <20200403143745.GQ20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <20200402154919.2c6shw4hfreagchg@treble>
 <3d075cb2-8d99-5ab7-4842-efef1964247d@redhat.com>
 <20200403124107.GO20730@hirez.programming.kicks-ass.net>
 <efa3b732-f102-9c4a-16e8-ffdb436cb9b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa3b732-f102-9c4a-16e8-ffdb436cb9b1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 01:49:24PM +0100, Julien Thierry wrote:
> 
> 
> On 4/3/20 1:41 PM, Peter Zijlstra wrote:
> > On Fri, Apr 03, 2020 at 09:01:38AM +0100, Julien Thierry wrote:
> > > 
> > > Last I found is in qcom_link_stack_sanitization() [2], but that's just a
> > > workaround for a very specific hardware. In my local tree I just put the
> > > function as STACK_FRAME_NON_STANDARD. But the code just saves the return
> > > address, has 16 call instructions that just call the instruction after them,
> > > restores the return address and lets the C-function return normally (and it
> > > somehow fixes something for that hardware).
> > > 
> > That sounds very much like the RSB flushing we do.
> > 
> 
> Yes, the piece of code you posted reminded me of this. The difference is
> that the RSB part uses a loop and counter while the qcom thing has a fixed
> amount of call instructions (which can make things easier for static
> analysis, if we'd really want to go down that road).

We have different depth RSBs for the various uarchs which is what
necessitates the counter. That is, we could always do the max size (32
IIRC) but then, it's expensive and people already complain etc.. etc..
