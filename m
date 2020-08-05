Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2288AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F94204EA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596609079;
	bh=h5Iq/ozeiAYdESxTpL+S/wTuqz8i/cZtypJ8Z55elGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dbn2HuV2w2pYw9iS9N2VVd/m+/SmeDS9GHkWelwna/6rbFzwScP49WY1kWaXQGiMD
	 mOhEoQU2odJN+ybm3Fo58ymnFusCt0DsAS9cJvVBKH+3l6nNlMZ/s0EFYfoAUtANdm
	 pcyb3xD1WSuCqqIz+p6z06VT5svj8cjDvfhB5uDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHEGbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgHEGbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:31:17 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502E8204EA;
        Wed,  5 Aug 2020 06:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596609077;
        bh=h5Iq/ozeiAYdESxTpL+S/wTuqz8i/cZtypJ8Z55elGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktRHCm+lCGtAcAtuDxWuuTtvChQ+YJg+50VVHrdKxjTTpby+I7n/V+LtxSXr8wJXD
         hJchkaspyKmN7kjVzUos/82MYC9ibPUgTl6GzKwjW53LX/obDw1Cpxhg4+ajwx+27k
         lXjSZPymU0kHg5NcDXDY5nQ71ZoOWDlQv+dOrtNg=
Date:   Wed, 5 Aug 2020 12:01:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
Message-ID: <20200805063113.GV12965@vkoul-mobl>
References: <202007150718.6LcA4qZN%lkp@intel.com>
 <C4A103AM9MUU.13PG525K6BK54@atris>
 <CAKm4OoV-DhWS7ajj_xa412E19FQ5EExjYKPRGEu2K9=-7uUFrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKm4OoV-DhWS7ajj_xa412E19FQ5EExjYKPRGEu2K9=-7uUFrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liam,

On 03-08-20, 20:08, Liam Beguin wrote:
> Hi Vinod,
> 
> On Sat, Jul 18, 2020 at 4:18 PM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> >
> > Hi,
> >
> > I sent another patch[1] to try to address this.
> >
> > The issue seems to come from the fact that the parisc architecture
> > doesn't support cmpxchg on u8 pointers. cmpxchg is called by
> > set_mask_bits.
> >
> 
> This patch has been merged.

Okay great

> 
> > Thanks,
> > Liam
> >
> > [1] https://lore.kernel.org/patchwork/patch/1272617/
> >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> Did you get a change to look at the initial tusb1210 patch?

Can you please repost after -rc1 is out and rebase on it

Thanks

-- 
~Vinod
