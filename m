Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ABDC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B7720732
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581932321;
	bh=SuXoQe14sUtU4TExPbAcKe1WLOznzq8a2n5/3rFEUrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SJPvaQq498TLek6Bmg02xvysOgchezwDHvM8jDKB8BU6CB0uKtRTN8001SKueHYQV
	 8xDM18QDmk2LxmodGromZg2P6d4ySAxKZe+pzqz70sspT9rCzLxo2g1JAwaJfpfP/M
	 wJSuDQ9SpIwUqivDuyI3WECKjQV37bxIeZkEZVKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBQJik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbgBQJik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:38:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2502070B;
        Mon, 17 Feb 2020 09:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581932319;
        bh=SuXoQe14sUtU4TExPbAcKe1WLOznzq8a2n5/3rFEUrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxI3/gTy9lJamw+rQUW+k+XD45M7AL0Qf+QqRHOetXZDP7JRawLIe6t51RXB79kJg
         txk44xHI1KGlXHe4ZWKzmq0XHhd7CXerwUjyK1nWeMVNeBtjE2ki1ZFhWGtbwEshWn
         ixFtOquvRvRPAt45w8Dmyh2b79SCjaNRSBDzIHxA=
Date:   Mon, 17 Feb 2020 10:38:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Timur Tabi <timur@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        kbuild test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
 with fallthrough
Message-ID: <20200217093836.GA37937@kroah.com>
References: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
 <20200213125659.GB3325929@kroah.com>
 <6ab68169-dde6-b5ba-0909-fa685bd24aac@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab68169-dde6-b5ba-0909-fa685bd24aac@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:35:18PM +0100, Rasmus Villemoes wrote:
> On 13/02/2020 13.56, Greg Kroah-Hartman wrote:
> 
> >> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
> >> index 04733876c9c6..a8e1048278d0 100644
> >> --- a/drivers/usb/host/fhci-hcd.c
> >> +++ b/drivers/usb/host/fhci-hcd.c
> >> @@ -396,6 +396,7 @@ static int fhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
> >>  	case PIPE_CONTROL:
> >>  		/* 1 td fro setup,1 for ack */
> >>  		size = 2;
> >> +		fallthrough;
> > 
> > We have an attribute for that?
> > 
> > Shouldn't this be /* fall through */ instead?
> > 
> > Gustavo, what's the best practice here, I count only a few
> > "fallthrough;" instances in the kernel, although one is in our coding
> > style document, and thousands of the /* */ version.
> 
> Yes, I went with the attribute/macro due to that, and the history is
> that Linus applied Joe's patches directly
> (https://lore.kernel.org/lkml/CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com/),
> so I assumed that meant the Penguin decided that the attribute/macro is
> the right thing to do for new code, while existing comment annotations
> can be left alone or changed piecemeal as code gets refactored anyway.

But, to be fair, Gustavo went and fixed up thousands of these, with the
/* */ version, not the attribute.

Gustavo, can coverity notice the "fallthrough;" attribute properly?  I
don't want to start adding things that end up triggering
false-positives.

thanks,

greg k-h
