Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB889C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C572E20772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594293100;
	bh=vny+SWwydOWXgQEpMtX94zFAywVQ53nMMZrFLu+KCfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BhPDlgjKCwNtbDqQEMCQCXD5L2VNvdI1vhY54nTxLnzjFGskDZK+GNcXPHQ20qKnO
	 oLCitRA7a0eY9/Sk1eJDzUmCxPKAHhhsqr2h1gfnd4oBi6HDSdToqjp2Lz8IZ1c4u5
	 gEqNIF8T7eIQxOaJKZCvRDKIdiHuLnYvt3DgRnJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGILLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgGILLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:11:39 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16B92076A;
        Thu,  9 Jul 2020 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594293098;
        bh=vny+SWwydOWXgQEpMtX94zFAywVQ53nMMZrFLu+KCfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ylOe5/KHwchiM+tEwXVN+LYL6Znb1MK7HBpvsQgqLWOOmVnaquIrHYwDMyFldYkk2
         oejy8Ava9G1TXJPWjaj9zMjIDGrPwZWzJp+MkdY/tDNoHp62PAKRJbHEpJBOhOWqd4
         5rBr9E10yVPBow0R8ZjriiSvK7fXmljt/q79n2OY=
Date:   Thu, 9 Jul 2020 13:11:33 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Matthew Wilcox <willy6545@gmail.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200709131133.1bbb9c63@coco.lan>
In-Reply-To: <10eeae911ab653036554f5599ba34406572acaa9.camel@perches.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
        <87h7ul15le.fsf@notabene.neil.brown.name>
        <20200706072221.GA1947246@kroah.com>
        <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
        <CAFhKne9vswg3Q4mTOz4WP6QWJ8tDH+SNx1Pu7LotLagoNURKgw@mail.gmail.com>
        <d6f56f5f5e0790ee9c7579eb05c7d92e071ee15a.camel@perches.com>
        <CAFhKne_p_rKN4adhsuyUyBfrS0YwCtoNFNn-x4aFajPmnkR6iQ@mail.gmail.com>
        <10eeae911ab653036554f5599ba34406572acaa9.camel@perches.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 06 Jul 2020 06:30:01 -0700
Joe Perches <joe@perches.com> escreveu:

> On Mon, 2020-07-06 at 09:04 -0400, Matthew Wilcox wrote:
> > On Mon, Jul 6, 2020 at 8:59 AM Joe Perches <joe@perches.com> wrote:  
> > > On Mon, 2020-07-06 at 08:51 -0400, Matthew Wilcox wrote:  
> > > > In terms of number of lines of code using the word, it's only seventh
> > > > in drivers/:
> > > > 
> > > > $ for i in drivers/*; do c=$(find $i -type f |xargs grep slave |wc
> > > > -l); echo "$c $i"; done |sort -rn |head
> > > > 5218 drivers/net
> > > > 1341 drivers/dma
> > > > 988 drivers/i2c
> > > > 695 drivers/gpu
> > > > 666 drivers/soundwire
> > > > 665 drivers/spi
> > > > 559 drivers/w1
> > > > 461 drivers/infiniband
> > > > 389 drivers/media
> > > > 301 drivers/scsi  
> > > 
> > > I get rather different and much lower numbers
> > > 
> > > $ git grep -i -w slave drivers | \
> > >   cut -f1,2 -d/ | uniq -c | sort -rn | head -20 | cat -n  
> > 
> > That's because you're using grep -w which excludes, for example,
> > slave_configure in drivers/scsi.  
> 
> upper/lower case uses too...  (anyway, there are a lot)
> 
> $ git grep -i -w -P '\w*slave\w*' drivers | \
>   cut -f1,2 -d/ | uniq -c | sort -rn | head -20 | cat -n
>      1	   5683 drivers/net
>      2	   2118 drivers/gpu
>      3	   1807 drivers/dma
>      4	   1389 drivers/i2c
>      5	    866 drivers/interconnect
>      6	    835 drivers/soundwire
>      7	    821 drivers/spi
>      8	    698 drivers/w1
>      9	    508 drivers/media
>     10	    481 drivers/infiniband
>     11	    440 drivers/ata
>     12	    317 drivers/scsi
>     13	    267 drivers/fsi
>     14	    240 drivers/tty
>     15	    225 drivers/vme
>     16	    223 drivers/staging
>     17	    157 drivers/mmc
>     18	    155 drivers/usb
>     19	    141 drivers/video
>     20	    140 drivers/char

It sounds that, as soon after this patch gets merged, the mailing lists
will be flooded by lots of patches replacing such terms with something
else :-(

Doing a quick look at the media subsystem, it sounds that most terms
come from I2C master/slave and DiSEqC terminology, as defined by their
specs (and the others seem to be derived from some hardware vendor 
specific terminology).

As they're all supported by the current specs, if one would want
to replace them, it should first ensure that the supporting specs
should be using a different terminology, as otherwise replacing
them would just make harder for anyone trying to understand the
code.

Thanks,
Mauro
