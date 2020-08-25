Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591AFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC882075B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598349619;
	bh=irTYt5O2PpoAUCYR7EarbcRXvDjUj6OwT+D7o1nIg/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C6o5VyfJLLBDY+CQ1w+lAIWRWT3R8LuWHbbddnLDiM84NaXEWUxQ6ylUIQDGvvOZw
	 juOP5a+N7mozciNVrvfIOzk89ak2us22v/Szxns/kgwSI+6w3lUEffc3uyrosZtmwe
	 7z/B/GbeDI0VW1YeJazp61KQNWiDeJE7wD6fyzYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgHYKAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgHYKAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:00:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7132068F;
        Tue, 25 Aug 2020 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598349615;
        bh=irTYt5O2PpoAUCYR7EarbcRXvDjUj6OwT+D7o1nIg/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y7rvTJHGkvzXFBZYDJ24AtRkX1a+Q6foRrvKrRNsO1QCCNO0Xp26VVZAcf/K3lmek
         FS4RBwbp/AYESFgkxY/NNN8q7bLveN3zGp0UuYogiR5Y3XN4oNtrmLTRSbvr3Ygdb4
         oev1PWF+Z3vfO1jImI8nHjW68ROBVe8Mf5PycaoU=
Date:   Tue, 25 Aug 2020 12:00:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Dongsheng Qiu <dongsheng.qiu@ingenic.com>,
        Felipe Balbi <balbi@kernel.org>,
        qipengzhen <aric.pzqi@ingenic.com>,
        Rick Tyliu <rick.tyliu@ingenic.com>,
        Yanfei Li <yanfei.li@ingenic.com>, zhenwenjin@gmail.com,
        =?utf-8?B?5ZGo5q2j?= <sernia.zhou@foxmail.com>
Subject: Re: [PATCH] USB: PHY: JZ4770: Fix static checker warning
Message-ID: <20200825100030.GA1347872@kroah.com>
References: <96687bd5-aa10-b908-471a-31e8daa01472@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96687bd5-aa10-b908-471a-31e8daa01472@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:35:16AM +0200, Markus Elfring wrote:
> > The commit 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
> > Ingenic SoCs.") introduced the initialization function for different
> > chips, but left the relevant code involved in the resetting process
> > in the original function, resulting in uninitialized variable calls.
> 
> * Can another imperative wording be helpful for the change description?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=d012a7190fc1fd72ed48911e77ca97ba4521bccd#n151
> 
> * How do you think about to mention any source code analysis tool here?
> 
> * Would an other commit subject be more appropriate?
> 
> 
> > Fixes: 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
> > Ingenic SoCs.").
> 
> Please omit a line break for this tag.
> 
> 
> I find that a single patch would not need a cover letter.

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
