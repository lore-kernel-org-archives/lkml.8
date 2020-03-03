Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F69C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C7D21739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583216997;
	bh=48kn/GVmQ3q/p2z9r3bl0AAa2U1PvKi1kdGVR8dz/ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UjAc3ULnDxkCqjT5/dZ6TfO2rCY8Q4iixjCGScZNH0rF6VqxvgX8JfzCMURjKuD5X
	 ic7IOzKhEqKJyUznnaylKguUAJj0vwm0miC49iMTpj2sjkFmtLBPlPTFb/+Fx0HFUc
	 HYM0oALIVxxgP6IvDujic7cKs1GK2q4oVVcpqOJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCCG3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:29:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCCG3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:29:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FB12086A;
        Tue,  3 Mar 2020 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583216994;
        bh=48kn/GVmQ3q/p2z9r3bl0AAa2U1PvKi1kdGVR8dz/ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXe2DiKzNbqrZUWbe8RUGNw3lLLScpKQd4OHwz7uBkaXMY7EoPF84tKX9YLUwrt7B
         2AKx11dMgkO8QufKR5X7xq5HcsBcgDVw7+PjET9XLBxgXOnK4XpK4cILFCu0yU1Ic1
         FI23k8SzZjfrCJyuS/pon1vGqT4AvGS2AB9A8Rz4=
Date:   Tue, 3 Mar 2020 07:29:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] tty: fix compat TIOCGSERIAL leaking uninitialized
 memory
Message-ID: <20200303062951.GA1051270@kroah.com>
References: <20200224181532.GA109047@gmail.com>
 <20200224182044.234553-1-ebiggers@kernel.org>
 <20200224182044.234553-2-ebiggers@kernel.org>
 <6294851f-50e5-eaaa-2182-1ad6ae7234b1@suse.com>
 <20200302212425.GB78660@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302212425.GB78660@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 01:24:25PM -0800, Eric Biggers wrote:
> On Tue, Feb 25, 2020 at 08:30:35AM +0100, Jiri Slaby wrote:
> > On 24. 02. 20, 19:20, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Commit 77654350306a ("take compat TIOC[SG]SERIAL treatment into
> > > tty_compat_ioctl()") changed the compat version of TIOCGSERIAL to start
> > > copying a whole 'serial_struct32' to userspace rather than individual
> > > fields, but failed to initialize all padding and fields -- namely the
> > > hole after the 'iomem_reg_shift' field, and the 'reserved' field.
> > > 
> > > Fix this by initializing the struct to zero.
> > > 
> > > [v2: use sizeof, and convert the adjacent line for consistency.]
> > > 
> > > Reported-by: syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com
> > > Fixes: 77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()")
> > > Cc: <stable@vger.kernel.org> # v4.20+
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Acked-by: Jiri Slaby <jslaby@suse.cz>
> > 
> 
> Thanks.  Greg, are you planning to take these patches?

Yes, please give me a chance to catch up on things :)
