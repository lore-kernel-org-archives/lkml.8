Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7EBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167DD207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590214238;
	bh=0ftU1TTGfhFEpNW3NsbgYUbiFGGQHnZ3H3HOeSMeYD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKKiKEWq3KuyMfp4fPBVAwO1jpguzxwtikWhKKcghRvZG0yaFJZQ9AtNnAQvFKxi3
	 YA2YPYnjkettAN/E0rZFK11mWlTqxBsV75vlDRmajvLpZIKpvRYrQeDamzcqaYhbc8
	 50Pz3lW21lyC+81efdAKHCd/ZQyflvGrB0oSKBEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgEWGKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 02:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387446AbgEWGKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 02:10:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377EF2071C;
        Sat, 23 May 2020 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590214235;
        bh=0ftU1TTGfhFEpNW3NsbgYUbiFGGQHnZ3H3HOeSMeYD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LITQkm19MZP146obm5P6vkC9xld35coDBA1g8vKO6/E+elDtZwY3jC4Hmew8a+eAP
         oWyKx01bUx/e+iFq8Zmsx59bpMeroPipa4jiZoms+az3hHYq0YQQ88KQoUKyT6jNak
         UH+SIwYpV+e+o83w34Hi8YuKyAC4XOPoCHF4FBiM=
Date:   Sat, 23 May 2020 08:10:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     stable <stable@vger.kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Kees Cook <keescook@chromium.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        kernel-hardening@lists.openwall.com,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org,
        "Lev R . Oshvang ." <levonshe@gmail.com>
Subject: Re: [PATCH v2] firewire: Remove function callback casts
Message-ID: <20200523061033.GB3131938@kroah.com>
References: <20200519173425.4724-1-oscar.carter@gmx.com>
 <20200520061624.GA25690@workstation>
 <20200522174308.GB3059@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522174308.GB3059@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 07:43:08PM +0200, Oscar Carter wrote:
> Hi,
> 
> On Wed, May 20, 2020 at 03:16:24PM +0900, Takashi Sakamoto wrote:
> > Hi,
> >
> > I'm an author of ALSA firewire stack and thanks for the patch. I agree with
> > your intention to remove the cast of function callback toward CFI build.
> >
> > Practically, the isochronous context with FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL
> > is never used by in-kernel drivers. Here, I propose to leave current
> > kernel API (fw_iso_context_create() with fw_iso_callback_t) as is.

If it's not used by anyone, why is it still there?  Can't we just delete
it?

thanks,

greg k-h
