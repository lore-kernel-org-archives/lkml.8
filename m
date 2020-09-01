Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955FEC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2AF206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598972549;
	bh=iLYgeJMCiPuuCbdXC/mWJ55akOMipGrxGNLRGMp5bnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tQhCZak6f/y+dwdeP6oMR9496NzTCXbtqplCSmntyzb/32EwfWPviNOZsuzgJuESX
	 Lyzs9Bb0ehLhXToXNc42uEpQFm8Q8PL35TeCwsLmQh8d+doL4zUycGVI+J9WZv3hno
	 TmRDSGSH2oAGmH4t2gZAKHtSDQgAwM93l7Y5kCPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgIAPC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIAPC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:02:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027DA206CD;
        Tue,  1 Sep 2020 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598972547;
        bh=iLYgeJMCiPuuCbdXC/mWJ55akOMipGrxGNLRGMp5bnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwqK6om6s8kznzBFJ2v/mn33Pm22W4rRwN+31b100kldIemEmDSRtiW3HsHP2MZ8X
         nVOgFpN8+Q21F83XwfPPDtjbuqm+0K38Rezs7VoqMxYjzAp0WVPHqpq8uJnaJwW1DC
         u74/m6xxpwCg3yDmFSabeARka7dpHuevQgQd3Zp8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1245140D3D; Tue,  1 Sep 2020 12:02:25 -0300 (-03)
Date:   Tue, 1 Sep 2020 12:02:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Al Grant <al.grant@foss.arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200901150225.GA1424523@kernel.org>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 26, 2020 at 03:33:35PM +0100, Al Grant escreveu:
> On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
> > > On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> > > > perf_event.h has macros that define the field offsets in the
> > > > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > > > were both 37. These are distinct fields, and the bitfield layout
> > > > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> > > 
> > > Looks good.
> > > 
> > > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Probably should have a Fixes: header
> > 
> > Please do so, find the patch that introduced the error, add the Fixes
> > tag, will help me not having to do it myself :-)
> 
> Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info
> encodings")

Ok, I'll add that, thanks.

But you forgot to add your Signed-off-by:, can you please provide it?

There was also a minor problem in the patch, there was no separation of
--- from the patch comment section to the patch itself, I'll fix that as
well.

- Arnaldo
