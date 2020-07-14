Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE11C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572ED20720
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594757275;
	bh=ygYbAYLGtGi7VTNZOTi8yA86zw5Ek9sxpF/WVqk+Yn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TQq+hAqlaEbP+VNT2mFLphMb1Gt8vDnA+BHyV57hiJACqHgv40wamidhZR0e3XAVe
	 hmpEvpFsgsJLEvye2Ol3OvizPZhe7W+qfVmJ0grr118HZpQjor0JeIWTkb6J2rUfZx
	 GPuPt/LrIzEb6cyXWdlJRQ1FflEQpmibGnapubHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgGNUHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbgGNUHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:07:53 -0400
Received: from embeddedor (unknown [201.162.240.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC4320720;
        Tue, 14 Jul 2020 20:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594757273;
        bh=ygYbAYLGtGi7VTNZOTi8yA86zw5Ek9sxpF/WVqk+Yn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2jLxk+PHM89Y7wfEZBVvTrSPCdxreCNs0ELZdOLeAZOFolpHFxcZ7/g2T5+ujmcxy
         oxjwBxxgR3qY2BNocFAGQa75DXj7xGFS0txlKfRADEE7cI7yj8so/OPwGF7s3QCbGU
         4ursNvzTIFslQ+CI4mAUqFzS0q+1qSepYkx7g3Sg=
Date:   Tue, 14 Jul 2020 15:13:24 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] mei: Avoid the use of one-element arrays
Message-ID: <20200714201324.GA31673@embeddedor>
References: <20200714174644.GA30158@embeddedor>
 <fe3b8d4a4eb04ead83ffcefe12fd218e@intel.com>
 <20200714180855.GA31158@embeddedor>
 <32f85e185c2244a19a1705d0db315c69@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f85e185c2244a19a1705d0db315c69@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 07:57:51PM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Jul 14, 2020 at 05:54:32PM +0000, Winkler, Tomas wrote:
> > > >
> > > > There is a regular need in the kernel to provide a way to declare
> > > > having a dynamically sized set of trailing elements in a structure.
> > > > Kernel code should always use “flexible array members”[1] for these
> > > > cases or, as in this particular case, replace the one-element array
> > > > with a simple value type u8 reserved once this is just a placeholder
> > > > for alignment. The older style of one-element or zero-length arrays
> > should no longer be used[2].
> > > >
> > > > Also, while there, use the preferred form for passing a size of a struct.
> > > > The alternative form where struct name is spelled out hurts
> > > > readability and introduces an opportunity for a bug when the
> > > > variable type is changed but the corresponding sizeof that is passed as
> > argument is not.
> > > >
> > > > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > > > [2] https://github.com/KSPP/linux/issues/79
> > > >
> > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > I'm okay with the patch but in this case the description is a bit off.
> > > In this case there was no intention for a flexible arrays its just a reserved
> > field.
> > >
> > 
> > The reserved field is actually mentioned in the description:
> > 
> > "... or, as in this particular case, replace the one-element array with a simple
> > value type u8 reserved once this is just a placeholder for alignment."
> 
> Right, but it looks not connected to overall context, it looks like not very clean reuse of a commit message.
> I would say that this reserved[1] rather had confused the detection scripts you are using for the  cleanup you are doing. 
> Again, I'm okay with the patch, but if you can  reword the commit message it would be even more okay.
> 

Yep; I've come up with a more concise text for these sorts of cases:

"One-element arrays are being deprecated[1]. Replace the one-element
array with a simple value type u8 reserved, once this is just a
placeholder for alignment.

[1] https://github.com/KSPP/linux/issues/79"

I'll send v2 with the text above, shortly.

Thanks for the feedback.
--
Gustavo
