Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2300FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEEB2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590765279;
	bh=RJdL767KxH8dI0Qw9KvkgUOQcFogBsU089xi5ix/oCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EsmNhdcNgrC0W8gUjFQWpczmGtyV5FOLTVDzdgN3PYfBntwhsezRTqe0c33z0FnH2
	 GyOyXyS5k0wvd5q3sTJlbY1Qz1Kj3EpKaH5FSpSOTZ4y+0MDaZPznFqqcga8EPsESA
	 04HDDtHfrTFPZCR3Ou6HRWqSm+mgLtz4bubDmi/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgE2POi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgE2POh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:14:37 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD045206A4;
        Fri, 29 May 2020 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590765277;
        bh=RJdL767KxH8dI0Qw9KvkgUOQcFogBsU089xi5ix/oCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RqeKGVYz4sjZQ00euKuzqca2eRBKKuP9OnwZ0cJH5p+PJ83gVTNzYeHYUmd4Sx087
         CDBrfinIhfg9Mxb3flDtuuNiBT3ELXXCfykj+RGCptlfe9vDKRRzcFcC8pMivxV+vH
         20Yest2vPx1OixzOfXMMz7TqWW5mWntG3TDDtMck=
Date:   Fri, 29 May 2020 17:14:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: please revert "Revert "media: staging: atomisp: Remove driver""
Message-ID: <20200529171433.06f12925@coco.lan>
In-Reply-To: <20200529144615.GA2168030@kroah.com>
References: <20200529140907.GA2916@lst.de>
        <20200529144615.GA2168030@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 29 May 2020 16:46:15 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Fri, May 29, 2020 at 04:09:07PM +0200, Christoph Hellwig wrote:
> > Hi Mauro and Greg,
> > 
> > the commit mentioned in the subject (commit id ad85094b293e in
> > linux-next) contains the grave offense of adding a new set_fs address
> > space override in "new" code.  It also doesn't have an Ack from Greg
> > despite showing up in drives/staging, which looks very suspicious.
> > 
> > Please don't just add crap like this back if it doesn't pass the
> > most basic sanity tests.  
> 
> Mauro "owns" drivers/staging/media/ which is where this ended up in,
> right?  And I thought he had a bunch of follow-on patches that fixed up
> crud like set_fs and friends.
> 
> Mauro, is your fixes not pushed in your tree as well?

Yes, I'm pushing the fixes on my tree too, after giving them some time
for review at the mailing lists.

In any case, feel free to ping me if you find anything as bad as this
one.

Thanks,
Mauro
