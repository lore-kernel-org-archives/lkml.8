Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76836C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD92207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581949116;
	bh=h9Fe4kx1LHPMGbLI3vHtLy7xmcJooeeh18XrtJy7gTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dxh5esZxu/wqZh8m8V7jFYWUEA6q6Phcj3fMJe/uRg2RIsCSnyTHDbH1wsymSiLsG
	 7SMXYT1gV+rTjXpSwd1++VAt024+F71WuwPac1tbuYHA/Vj2V+LCwU3V2qigoR87G9
	 7s9I3Gp1UGz3A+iU9RSdc2OoE7grt8nOT1npRMqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgBQOSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgBQOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:18:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7170C2072C;
        Mon, 17 Feb 2020 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581949113;
        bh=h9Fe4kx1LHPMGbLI3vHtLy7xmcJooeeh18XrtJy7gTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQbPYAQ2qjiB4TzqFAoMr+Q9wskUBh4nz8tdJYizoJtU7Yz81PB2jRa1ZeJVbeZnR
         q7ehePnA7v5f5IV0v+3/uOkylfgnj0EKn5/imhlpgDallDtV8M7RddiES88B9wFG7n
         +A+1DU7IAhDnKZsuDDR1V9HKrpkrFsKmNdGUhaVE=
Date:   Mon, 17 Feb 2020 15:18:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Timur Tabi <timur@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        kbuild test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
 with fallthrough
Message-ID: <20200217141831.GA1123892@kroah.com>
References: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
 <20200213125659.GB3325929@kroah.com>
 <6ab68169-dde6-b5ba-0909-fa685bd24aac@rasmusvillemoes.dk>
 <20200217093836.GA37937@kroah.com>
 <a1f0f024-c1e5-8ff5-f717-f5098b4eb78d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f0f024-c1e5-8ff5-f717-f5098b4eb78d@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 03:12:21PM +0100, Rasmus Villemoes wrote:
> On 17/02/2020 10.38, Greg Kroah-Hartman wrote:
> > On Thu, Feb 13, 2020 at 02:35:18PM +0100, Rasmus Villemoes wrote:
> >> On 13/02/2020 13.56, Greg Kroah-Hartman wrote:
> >>
> >>> Shouldn't this be /* fall through */ instead?
> >>>
> >>> Gustavo, what's the best practice here, I count only a few
> >>> "fallthrough;" instances in the kernel, although one is in our coding
> >>> style document, and thousands of the /* */ version.
> >>
> >> Yes, I went with the attribute/macro due to that, and the history is
> >> that Linus applied Joe's patches directly
> >> (https://lore.kernel.org/lkml/CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com/),
> >> so I assumed that meant the Penguin decided that the attribute/macro is
> >> the right thing to do for new code, while existing comment annotations
> >> can be left alone or changed piecemeal as code gets refactored anyway.
> > 
> > But, to be fair, Gustavo went and fixed up thousands of these, with the
> > /* */ version, not the attribute.
> > 
> > Gustavo, can coverity notice the "fallthrough;" attribute properly?  I
> > don't want to start adding things that end up triggering
> > false-positives.
> 
> I'm not Gustavo, and I don't know the answer, but 1.5 years ago some guy
> named greg k-h suggested that coverity does grok the fallthrough attribute:
> 
> https://patchwork.kernel.org/cover/10651357/#22279095

I wouldn't trust anything that bum says :)

Ok, I don't remember saying that at all, but I'll wait a day or two to
get Gustavo's opinion befor applying the patch.

thanks,

greg k-h
