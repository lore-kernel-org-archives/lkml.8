Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF8D2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594614355;
	bh=80qKnVUw82dcBYxyVYPFAKYX0oe8Y7tqPYnBcK3ywPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2nPkf49GTUTtC8gybV3WQjXQTyi4Tb0mbDdPKA4rxi09dVoGMF+b21e7Nhm4EgYdH
	 kh/IhU48CIm0iZ+JZOoiTkSoe9bUinhU4Y9zomO3dVMaVNx/qyiT6EfmTOOBSC8a8q
	 vM75cswJ8WdI3T1zIU/bcldLazNTrK8MjQ6l0ib8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgGMEZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMEZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:25:52 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BD82075D;
        Mon, 13 Jul 2020 04:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594614352;
        bh=80qKnVUw82dcBYxyVYPFAKYX0oe8Y7tqPYnBcK3ywPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Na2Iv2pvncocTY8oen/XRYoAVghr9zHx8bJNnr+IkSKuFe0XLpnX9MjMuJrmDIzKa
         ltA8ugIAgnltMG6qjCEvrZmnSeUJlZQbYwhl2fWDEg3TzkblpemhLUZJFvVMdvtM5D
         b2RxZtTRe7bMJYJ1g9/vmGW0nB/OeF7Xg00ICPHw=
Date:   Mon, 13 Jul 2020 09:55:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200713042547.GO34333@vkoul-mobl>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name>
 <20200706072221.GA1947246@kroah.com>
 <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
 <CAFhKne9vswg3Q4mTOz4WP6QWJ8tDH+SNx1Pu7LotLagoNURKgw@mail.gmail.com>
 <d6f56f5f5e0790ee9c7579eb05c7d92e071ee15a.camel@perches.com>
 <CAFhKne_p_rKN4adhsuyUyBfrS0YwCtoNFNn-x4aFajPmnkR6iQ@mail.gmail.com>
 <10eeae911ab653036554f5599ba34406572acaa9.camel@perches.com>
 <20200709131133.1bbb9c63@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709131133.1bbb9c63@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 09-07-20, 13:11, Mauro Carvalho Chehab wrote:
> Em Mon, 06 Jul 2020 06:30:01 -0700
> Joe Perches <joe@perches.com> escreveu:
> > 
> > $ git grep -i -w -P '\w*slave\w*' drivers | \
> >   cut -f1,2 -d/ | uniq -c | sort -rn | head -20 | cat -n
> >      1	   5683 drivers/net
> >      2	   2118 drivers/gpu
> >      3	   1807 drivers/dma
> >      4	   1389 drivers/i2c
> >      5	    866 drivers/interconnect
> >      6	    835 drivers/soundwire
> >      7	    821 drivers/spi
> >      8	    698 drivers/w1
> >      9	    508 drivers/media
> >     10	    481 drivers/infiniband
> >     11	    440 drivers/ata
> >     12	    317 drivers/scsi
> >     13	    267 drivers/fsi
> >     14	    240 drivers/tty
> >     15	    225 drivers/vme
> >     16	    223 drivers/staging
> >     17	    157 drivers/mmc
> >     18	    155 drivers/usb
> >     19	    141 drivers/video
> >     20	    140 drivers/char
> 
> It sounds that, as soon after this patch gets merged, the mailing lists
> will be flooded by lots of patches replacing such terms with something
> else :-(
> 
> Doing a quick look at the media subsystem, it sounds that most terms
> come from I2C master/slave and DiSEqC terminology, as defined by their
> specs (and the others seem to be derived from some hardware vendor 
> specific terminology).
> 
> As they're all supported by the current specs, if one would want
> to replace them, it should first ensure that the supporting specs
> should be using a different terminology, as otherwise replacing
> them would just make harder for anyone trying to understand the
> code.

I think waiting for specs may result in long delays, we all know how
'fast' spec bodies work!

Putting my soundwire maintainer hat, I see more than 1K uses of 'slave'
in the subsystem due to MIPI defined terms of SoundWire Master/Slave, so
I am planning to replace that and not wait for MIPI to update the spec.

A similar approach where we discuss with relevant stakeholder and arrive
at replacement terms and swap them would be great

Thanks
-- 
~Vinod
