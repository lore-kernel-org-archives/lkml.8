Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE09FC2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809902137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7cOmnVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgIHFg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 01:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgIHFg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:36:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC5C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 22:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tnIhBm/D9q30OCjl0Uvk6IczrpKqywtr99E3Z7cDOcY=; b=A7cOmnVXCZtWAnsWTe66XL2mO2
        EfgFVttWjeSLSSOW7M36RucpwOpruW5Go8mkpQ5cD7T0J+07ypNo8hiB1Xuxa62/LM3ciqjLddxHv
        xRrWNTfI9+FCCIHBqmRat5fAniV5XoT3gd4rkXV0XBIex7sniDbxfzTpR9WqhPmTk0d8tJXk7y1oZ
        jwShC3NettOOKABfpiYOFXx730naA1c5vdvjOVfcLXmzLB70bqh/LkhPpc6V6jKL77EIL+9N/T6Fi
        lxgKjyEDm7kq9V2R/eQojzNIjMHQCRKlWOLKzMxzwKo6SZzs1YMFkDgc6hzdfs7ZnDpdIS3qBRgdJ
        WWIrZI2g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFWIl-00044r-4s; Tue, 08 Sep 2020 05:36:19 +0000
Date:   Tue, 8 Sep 2020 06:36:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
Message-ID: <20200908053619.GA15418@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:18:50PM +0100, Tom Murphy wrote:
> Yeah we talked about passing an attr to map_sg to disable merging at
> the following microconfernce:
> https://linuxplumbersconf.org/event/7/contributions/846/
> As far as I can remember everyone seemed happy with that solution. I
> won't be working on this though as I don't have any more time to
> dedicate to this. It seems Lu Baolu will take over this.

I'm absolutely again passing a flag.  Tha just invites further
abuse.  We need a PCI ID based quirk or something else that can't
be as easily abused.
