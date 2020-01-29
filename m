Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8D4C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C1620702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NED+k0VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgA2MaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:30:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgA2MaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/DLCZbZyXeUaG9uvsVh5OySzBJhEbHsxxEj+b/w7DtM=; b=NED+k0VGKuY2DwwNj/vl+yD5q
        oXEjSkYnKYldueiJCn/nq03qTEo/8GkvasoKCT1NcCndBOZrV/BGC8TPtvGpwC5EmUeNYyFwebF4Y
        Umxpr8OGMxqsfJoYId3gSnW1rIFFNROPRaLgpj1ULjdJ8o1pqd7DRhw13NJNZQYDaaoii5h2/6PcZ
        WZouPNgNKIxiiTXgPECTil62qRKr7ohnSrruYiZXr0axSOJFF1fUtcuYJ4mnwcd/VRBHYs9h4zQum
        WKzMzyUl1DaSePDQWQT4r3IBDoF9z4z6CLOfurUCKJvQaHrO9p+wjCsXoVSh2HzjYxfPnTKgY1IDe
        vI/vOYAxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwmTx-0002Qp-M0; Wed, 29 Jan 2020 12:30:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F355300DD5;
        Wed, 29 Jan 2020 13:28:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A91B201F06FA; Wed, 29 Jan 2020 13:30:08 +0100 (CET)
Date:   Wed, 29 Jan 2020 13:30:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200129123007.GO14879@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
 <20200129115412.GN14914@hirez.programming.kicks-ass.net>
 <4ea3cdae-f5af-f328-e231-ed3756af32e9@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea3cdae-f5af-f328-e231-ed3756af32e9@physik.fu-berlin.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 01:05:10PM +0100, John Paul Adrian Glaubitz wrote:
> On 1/29/20 12:54 PM, Peter Zijlstra wrote:
> > On Wed, Jan 29, 2020 at 11:49:13AM +0100, John Paul Adrian Glaubitz wrote:
> > 
> >>> [1] https://wiki.debian.org/M68k/QemuSystemM68k
> > 
> > Now, if only debian would actually ship that :/
> 
> Debian should receive the QEMU version that supports full m68k emulation
> soonish.

Excellent!

> > AFAICT that emulates a q800 which is another 68040 and should thus not
> > differ from ARAnyM.
> 
> Right. You could switch to a different CPU emulation though, Laurent
> Vivier should be able to say more on that.

The link you provided only mentioned that Q-88 thing, let me go rummage
through the actual qemu-patch to see if it supports more.

> > I'm fairly confident in the 040 bits, it's the 020/030 things that need
> > coverage.
> 
> I'm currently setting up an Amiga 500 with an ACA-1233n/40 accelerator
> which has an 68030 CPU clocked at 40 MHz and 128 MB RAM which will be
> used for developing a driver for a new network card card for the Amiga
> 500 called X-Surf 500.

I remember playing 'Another World' on the Amiga-500, I'm thinking this
accelerator is a wee bit overkill for that though ;-)

> I can definitely test the patches on that setup, but I certainly won't
> have the time to set everything up until after FOSDEM.

That would be great, thanks!
