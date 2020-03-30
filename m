Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA58920786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585548490;
	bh=NirpMgdQCIcF8LrMlxqs/IuiLw0XFjxXNccBL78UEuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cFmNKfBa5va9CdlKJ4AWc9CgPrqaA4VcW2Lke3Ncjfydd7NvomRyDjpW76BoiRECg
	 JQXuyUkfmzyU+VtozMMuO2nquUR99C8+HlnQSOjogj7Z4fPWPf+lKtZkTeKqKCbClm
	 XgDGvSN05VwYBY2pNrXptz1G1b3S9mdShLIKY2Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgC3GIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgC3GIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:08:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D012073B;
        Mon, 30 Mar 2020 06:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585548488;
        bh=NirpMgdQCIcF8LrMlxqs/IuiLw0XFjxXNccBL78UEuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3MXlKj7c4fmt8PHFIe8GrMi94piULtyZ+tp5mrSjMiy5CdvA4q8B4TfBD0rK7WiV
         704EEE1JE8mq2s2SCT9CEm6koq1Mkn/24J9XuwMUpVFcFg7n1yRiccpP95S2SA6XSb
         OhWvkeNK0VMaLpdaWj9JavBkjKNeafz2lYcNs23g=
Date:   Mon, 30 Mar 2020 08:08:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ashwini Pahuja <ashwini.linux@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH RESEND] usb: gadget: udc: bdc: Remove unnecessary NULL
 checks in bdc_req_complete
Message-ID: <20200330060805.GA107017@kroah.com>
References: <87zhc0j2qi.fsf@kernel.org>
 <20200329011246.27599-1-natechancellor@gmail.com>
 <871rpb4nd1.fsf@kernel.org>
 <20200329144703.GA9720@ubuntu-m2-xlarge-x86>
 <87mu7zdsc7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu7zdsc7.fsf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 07:43:52PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Nathan Chancellor <natechancellor@gmail.com> writes:
> >> > When building with Clang + -Wtautological-pointer-compare:
> >> >
> >> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
> >> > address of 'req->queue' equal to a null pointer is always false
> >> > [-Wtautological-pointer-compare]
> >> >         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
> >> >                              ~~~~~^~~~~    ~~~~
> >> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
> >> > address of 'req->usb_req' equal to a null pointer is always false
> >> > [-Wtautological-pointer-compare]
> >> >         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
> >> >                                                     ~~~~~^~~~~~~    ~~~~
> >> > 2 warnings generated.
> >> >
> >> > As it notes, these statements will always evaluate to false so remove
> >> > them.
> >> >
> >> > Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/749
> >> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> 
> >> It's now in my queue for v5.8. It doesn't really look like a bug fix, so
> >> it's not going in during v5.7-rc
> >> 
> >> -- 
> >> balbi
> >
> > Thank you for picking it up. It would be nice to see it in 5.7 since
> > we're enabling this warning and this is one of two outstanding
> > instances in -next and the other one's patch has been picked up plus the
> > patch itself is rather benign. Not to mention that I did send this patch
> > back in October. However, when it is merged into Linus' tree is
> > ultimately your call so I won't argue as long as it gets there
> > eventually.
> 
> If Greg's okay with this patch going in during v5.7-rc, I can send it as
> a fix, no worries. Greg?

Yes, clang build warnings fixes are valid fixes for the -rc period, and
I take them into stable where needed as well.

thanks,

greg k-h
