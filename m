Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D7C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0252722B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583184269;
	bh=HUZJeRV7z2Se2OXQPYO5AzKepwg1+UFe4jLBbctWGpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gYjkxMz5JxN47T5voEvn88qPpHkz94uAimamgBGRAhhbLVbNnF7Je1gWVHpkyILkF
	 gxtFYCI355zLFmQ09AB0XuupubJY0dYMkXHjbyQSn3GSUdTLXNI45bmfnrN4j34Kqv
	 NOlP3M+hfk5XKESNvQKXnYreA1EEo4BHNqgjCTao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCBVY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:24:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBVY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:24:27 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2904208C3;
        Mon,  2 Mar 2020 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583184267;
        bh=HUZJeRV7z2Se2OXQPYO5AzKepwg1+UFe4jLBbctWGpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtAuVFK6A+DFCP9n1yW0q4IU4tp/OwXka9R0GuthQRuN4m73QqSg19ubiGy3SMZES
         grDaP4bI8NTL4C3dnSEpjutdRtVV/k5PVARJJK5ZcWetEixSASD7BDrfXzZWEvPsKm
         rvFI78QJVMNYqYKJl0IT7t3/o5V+kROt3KoW9JUU=
Date:   Mon, 2 Mar 2020 13:24:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] tty: fix compat TIOCGSERIAL leaking uninitialized
 memory
Message-ID: <20200302212425.GB78660@gmail.com>
References: <20200224181532.GA109047@gmail.com>
 <20200224182044.234553-1-ebiggers@kernel.org>
 <20200224182044.234553-2-ebiggers@kernel.org>
 <6294851f-50e5-eaaa-2182-1ad6ae7234b1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6294851f-50e5-eaaa-2182-1ad6ae7234b1@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 08:30:35AM +0100, Jiri Slaby wrote:
> On 24. 02. 20, 19:20, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Commit 77654350306a ("take compat TIOC[SG]SERIAL treatment into
> > tty_compat_ioctl()") changed the compat version of TIOCGSERIAL to start
> > copying a whole 'serial_struct32' to userspace rather than individual
> > fields, but failed to initialize all padding and fields -- namely the
> > hole after the 'iomem_reg_shift' field, and the 'reserved' field.
> > 
> > Fix this by initializing the struct to zero.
> > 
> > [v2: use sizeof, and convert the adjacent line for consistency.]
> > 
> > Reported-by: syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com
> > Fixes: 77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()")
> > Cc: <stable@vger.kernel.org> # v4.20+
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Acked-by: Jiri Slaby <jslaby@suse.cz>
> 

Thanks.  Greg, are you planning to take these patches?

- Eric
