Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110DFC433E4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00392224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596806065;
	bh=FtlvdFU0rYHu3NtmhLjOvAgzY9+CtYRM9ziRa0ODO0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LW9HXLn2GAsaEwepU/bCI83CFOb2f/5mCVV70Y8XzrPM9ostNh9G1P3JoHTCmznZq
	 54t1UgSRjFUPuiWE0TwYLqOfX6vRL2FyxvNNUH++l05/JgiIvtcalVgGDgpzkFTn/B
	 7Ea/4kRuWT/E86/gruADlusKhFmtTfP4ysj+lakY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHGNOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgHGNOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:14:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D31C22C9F;
        Fri,  7 Aug 2020 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596806056;
        bh=FtlvdFU0rYHu3NtmhLjOvAgzY9+CtYRM9ziRa0ODO0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmZIGCEcgfuVdz+6J2O7xd/KbPIF8Kt0i6lVH1/0GwDcP4ahviudYfWt2hAY9j7B+
         aWdmlsXly326kOqV/BPhToRn3VR8LfDF+AQAJNY0pdH7uq8FP5GpGuc8TV3OPPvqvs
         KY2003KRA8He4FRGu9xn2B11aFr5mnbTQA8dFXSc=
Date:   Fri, 7 Aug 2020 15:14:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>
Subject: Re: [PATCH stable v4.9 v2] arm64: entry: Place an SB sequence
 following an ERET instruction
Message-ID: <20200807131429.GB664450@kroah.com>
References: <20200709195034.15185-1-f.fainelli@gmail.com>
 <20200720130411.GB494210@kroah.com>
 <df1de420-ac59-3647-3b81-a0c163783225@gmail.com>
 <9c29080e-8b3a-571c-3296-e0487fa473fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c29080e-8b3a-571c-3296-e0487fa473fa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:00:54PM -0700, Florian Fainelli wrote:
> 
> 
> On 7/20/2020 11:26 AM, Florian Fainelli wrote:
> > On 7/20/20 6:04 AM, Greg KH wrote:
> >> On Thu, Jul 09, 2020 at 12:50:23PM -0700, Florian Fainelli wrote:
> >>> From: Will Deacon <will.deacon@arm.com>
> >>>
> >>> commit 679db70801da9fda91d26caf13bf5b5ccc74e8e8 upstream
> >>>
> >>> Some CPUs can speculate past an ERET instruction and potentially perform
> >>> speculative accesses to memory before processing the exception return.
> >>> Since the register state is often controlled by a lower privilege level
> >>> at the point of an ERET, this could potentially be used as part of a
> >>> side-channel attack.
> >>>
> >>> This patch emits an SB sequence after each ERET so that speculation is
> >>> held up on exception return.
> >>>
> >>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> >>> [florian: Adjust hyp-entry.S to account for the label
> >>>  added change to hyp/entry.S]
> >>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>>
> >>> - added missing hunk in hyp/entry.S per Will's feedback
> >>
> >> What about 4.19.y and 4.14.y trees?  I can't take something for 4.9.y
> >> and then have a regression if someone moves to a newer release, right?
> > 
> > Sure, send you candidates for 4.14 and 4.19.
> 
> Greg, did you have a chance to queue those changes for 4.9, 4.14 and 4.19?
> 
> https://lore.kernel.org/linux-arm-kernel/20200720182538.13304-1-f.fainelli@gmail.com/
> https://lore.kernel.org/linux-arm-kernel/20200720182937.14099-1-f.fainelli@gmail.com/
> https://lore.kernel.org/linux-arm-kernel/20200709195034.15185-1-f.fainelli@gmail.com/

Nope, I was waiting for Will's "ack" for these.

thanks,

greg k-h
