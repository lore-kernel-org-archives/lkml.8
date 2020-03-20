Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D61C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AF420777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584710569;
	bh=hjJLihgB3nvtxE5EuEWSzg0rcZPRkXtuLZ1+KrdHL8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0UlrFXSZFjvm1wn5WEAGfdPLR6UScIrXto9UwEEBrZEYdwtnVN4m8HPwihmvD6MJt
	 a9fTsoFVovfrBk2eI51sufdudE+Z5lXbX0jE4twn5q7m0XP/D/U6dbP1qmaK2fturu
	 BoG+TbDjfqTuMW161bWl8Tp05xtlmq7j5smOrcMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCTNWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgCTNWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:22:47 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D2F2076E;
        Fri, 20 Mar 2020 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584710567;
        bh=hjJLihgB3nvtxE5EuEWSzg0rcZPRkXtuLZ1+KrdHL8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j4RgFdzE3cBPdPHFE4iwAwZXR12WlJZZLPnJd6qUHm2pe2mnDYuoZLIMy5OQR1q/2
         IPdve/me6HZH5zZWkFc9z3gDGVP1g5MyKUGa0mdM+h8c+DSs1ZdFtnr7OXDIfuLCLj
         j6qQB4u/bvbEOC4YdjkuDNJu4j9wW4xhL1SnpvUU=
Date:   Fri, 20 Mar 2020 14:22:43 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: conf.py: avoid thousands of duplicate label
 warning on Sphinx
Message-ID: <20200320142243.52107842@coco.lan>
In-Reply-To: <20200320125918.5eb5af04@coco.lan>
References: <20200320112122.48244ec4@coco.lan>
        <16f1c270a9077032de379b1cb30dfbb3e3670aee.1584702515.git.mchehab+huawei@kernel.org>
        <3508337.2CZTLhteCP@harkonnen>
        <20200320125918.5eb5af04@coco.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 20 Mar 2020 12:59:18 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 20 Mar 2020 12:24:45 +0100
> Federico Vaga <federico.vaga@vaga.pv.it> escreveu:
> 
> > On Friday, March 20, 2020 12:12:35 PM CET Mauro Carvalho Chehab wrote:
> > > The autosectionlabel extension is nice, as it allows to refer to
> > > a section by its name without requiring any extra tag to create
> > > a reference name.
> > > 
> > > However, on its default, it has two serious problems:
> > > 
> > > 1) the namespace is global. So, two files with different
> > >    "introduction" section would create a label with the
> > >    same name. This is easily solvable by forcing the extension
> > >    to prepend the file name with:
> > > 
> > > 	autosectionlabel_prefix_document = True
> > > 
> > > 2) It doesn't work hierarchically. So, if there are two level 1
> > >    sessions (let's say, one labeled "open" and another one "ioctl")
> > >    and both have a level 2 "synopsis" label, both section 2 will
> > >    have the same identical name.
> > > 
> > >    Currently, there's no way to tell Sphinx to create an
> > >    hierarchical reference like:
> > > 
> > > 		open / synopsis
> > > 		ioctl / synopsis
> > > 
> > >   This causes around 800 warnings. So, the fix should be to
> > >   not let autosectionlabel to produce references for anything
> > >   that it is not at level one, with:
> > > 
> > > 	autosectionlabel_maxdepth = 1  
> > 
> > So, for level 1 headers is fine to use autosectionlabel, but if we want to 
> > refer to level 2,3... we have to create labels manually.
> 
> Yes.

Hmm... actually no. maxdepth = 1 will only get the title of each
document.

It should be at least maxdepth = 2, but this is producing some warnings
here (part on some new patches I wrote, that aren't upstream yet).

I'll run some tests and send a new version of this patch.


> 
> If we want to use it for other levels, the autosectionlabel extension
> would need to be modified to work on an hierarchical way, creating an
> unique label that would contain the entire hierarchy, starting from
> the filename.
> 
> Also, ideally, it should also handle cross-reference locally, searching
> first for a reference at the same hierarchical level, then at level - 1
> and so on.
> 
> I suspect that, even with that, we may still have some troubles, as
> right now some files may have explicitly defined a reference like
> that, but those would likely be easy to fix.
> 
> Thanks,
> Mauro



Thanks,
Mauro
