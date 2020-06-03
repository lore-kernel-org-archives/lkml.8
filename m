Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B2FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AB52074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591171988;
	bh=zzy/zVrSF2Dp/bJhh/n521Hso2QWb2yJ6lL75H4p9y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GVkYQU3Q7dfN6SgghA8dyZb1icDiEcsodyNdiNzH2vYXh2/N0Gt3cQ0xkWk+Af1rO
	 G0caPp01l7saPyxvl//Hhi7g/hBA1cHmZ8CcmL1Df4E8gJfD+KNcZvzBDQTKx9rumm
	 4Q/EmrpDeUn9lgb7wWzsqsLQi5NhVtsKqvgxT4ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgFCINI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgFCINH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:13:07 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50042067B;
        Wed,  3 Jun 2020 08:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591171986;
        bh=zzy/zVrSF2Dp/bJhh/n521Hso2QWb2yJ6lL75H4p9y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mcVPfJc1UJdKlerptC9aZGjCBqIICBT/TkvDlmrX+sOZyqZijbUInD0hiEwIe0HGq
         b9kfq3dygVfgTOUQbq0ADh/51K/JqW4qXpN7RcgrrOUvNxDLZ1YThsB89onD0zY+nM
         5E0VakpXYcjTPD3QBJBt300rhO+Rc3l6n23jsv7c=
Date:   Wed, 3 Jun 2020 10:13:03 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v4l-dvb-next tree
Message-ID: <20200603101303.1759d782@coco.lan>
In-Reply-To: <20200603124646.4ce0ca8b@canb.auug.org.au>
References: <20200603124646.4ce0ca8b@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 3 Jun 2020 12:46:46 +1000
Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> After merging the v4l-dvb-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/staging/media/atomisp/pci/atomisp_compat_css20.c: In function 'atomisp_css_isr_thread':
> drivers/staging/media/atomisp/pci/atomisp_compat_css20.c:4196:9: error: 'atomisp_hw_is_isp2401' undeclared (first use in this function)
>  4196 |    if (!atomisp_hw_is_isp2401)
>       |         ^~~~~~~~~~~~~~~~~~~~~
> drivers/staging/media/atomisp/pci/atomisp_compat_css20.c:4196:9: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   be1fdab273a9 ("media: atomisp: change the detection of ISP2401 at runtime")
> 
> interacting with commit
> 
>   7ef17aa55fc3 ("media: atomisp: atomisp_compat_css20.c: detect ISP at runtime")
> 
> I have used the version of the v4l-dvb-next tree from next-20200602
> for today.

Sorry for that. 

The v4l-dvb-next currently contains some atomisp patches that are
waiting for review at linux-media, while v4l-dvb contains the patches
already reviewed, ready for merging.

The PR for v4l-dvb was submitted today.

I forgot to rebase v4l-dvb-next when some of the patches there 
were moved to v4l-dvb. Hopefully, it will be OK on tomorrow's 
linux-next, as I did the needed rebase.

Thanks,
Mauro
