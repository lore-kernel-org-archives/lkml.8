Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5BBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995B92070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbgEYTc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:32:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48083 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2390026AbgEYTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:32:26 -0400
Received: (qmail 10074 invoked by uid 1000); 25 May 2020 15:32:25 -0400
Date:   Mon, 25 May 2020 15:32:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rick Mark <rickmark@outlook.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Kernel Development List <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>
Subject: Re: USB Security in the Linux Kernel
Message-ID: <20200525193225.GA8993@rowland.harvard.edu>
References: <MWHPR04MB0687B41BCA703AF5DA6EA7F4DAB30@MWHPR04MB0687.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR04MB0687B41BCA703AF5DA6EA7F4DAB30@MWHPR04MB0687.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:28:33AM +0000, Rick Mark wrote:
> Hey Alan
> 
> You and other previously rejected a patch I submitted 13 months ago 

Nobody rejected your patch.  We pointed out problems with it, and we 
asked you to take a second look and provide more information.  You never 
replied.

> but have later integrated the changes under your name while missing a 
> few key security holes (I am working on another supplemental patch as 
> we speak).

That's not right.  Your changes were never merged into the kernel, in 
any form.

> Can you reconcile this mailing list email with commits made after it 
> in your name?
> 
> https://patchwork.kernel.org/patch/10941901/
> 
> Commit  a03ff54460817c76105f81f3aa8ef655759ccc9a

What is there to reconcile?  Your patch and my commit touched different 
code and addressed different (although similar) problems.  More 
specifically, your patch made changes to these routines:

	find_next_descriptor()
	usb_parse_ssp_isoc_endpoint_companion()
	usb_parse_ss_endpoint_companion()
	usb_parse_endpoint()
	usb_parse_interface()

whereas my commit changed:

	usb_get_bos_descriptor().

Furthermore, the changes you made appeared to be unnecessary (you added 
checks for things that either had already been checked or were checked a 
few lines later), whereas my commit fixed an actual bug, as demonstrated 
by syzbot.

> I find it highly improbable you managed to write that patch the same 
> day as my submission,

Indeed, I did _not_ write that patch the same day as your submission.  
If you check the datestamps on these emails in the archive, you'll see 
that my patch was posted on May 13 2019 and yours was posted on May 14, 
the next day:

	https://marc.info/?l=linux-usb&m=155776767725342&w=2
	https://marc.info/?l=linux-usb&m=155780009303416&w=2

> and the subsequent patches are also based on my 
> original work.

What subsequent patches?

Alan Stern
