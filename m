Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438A6C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE87206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588681038;
	bh=wV8NO8yKKq39WfuQJaqftLyvkr4QFKD5fm91qP3qKzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hu9DuSUWv10yQo+EHde4MXSj4TGru4FpGN8W4BiENY5zQJzKCKRHU8wPUYDD311+p
	 E3RF7ieNGdYfzcdOD9Uxc6akXzfSnmZAlmRszmTH869Tg8qIajJnqgQ/CU/+XbQ1QO
	 KcS2azP1/0WpC+eiXpY7yRCUYoi5+ZLevDyLm4CQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgEEMRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEEMRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:17:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07130206B8;
        Tue,  5 May 2020 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588681036;
        bh=wV8NO8yKKq39WfuQJaqftLyvkr4QFKD5fm91qP3qKzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyZ5Oh4je7m/B3dCXVvoC0F3P1olh76bO4gzgRciwyvY8hwYmzYeiSwT0qjNPSqF1
         R5uZ/amNcLh21u/78qquJ/BejPYyI4XRr5bzdpkPv7Y7BUAoEYzu/pcv90JNadLLL2
         4gFf0LKBWj/JicWNsWPTW6ADfQhp9jkNBLtHSEis=
Date:   Tue, 5 May 2020 14:17:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH USB 2/2] usb: raw-gadget: fix typo in uapi headers
Message-ID: <20200505121714.GA118143@kroah.com>
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
 <059e7e0ff26cc7d6e85275f764e31d85db867c4b.1587690539.git.andreyknvl@google.com>
 <87y2q6akhh.fsf@kernel.org>
 <CAAeHK+y=d_Hu1mwGifYuw6GRSBR=zncGCVOeN6GobP3L1zui=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+y=d_Hu1mwGifYuw6GRSBR=zncGCVOeN6GobP3L1zui=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 02:11:44PM +0200, Andrey Konovalov wrote:
> On Tue, May 5, 2020 at 9:50 AM Felipe Balbi <balbi@kernel.org> wrote:
> >
> > Andrey Konovalov <andreyknvl@google.com> writes:
> >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > return -ENOCHANGELOG
> 
> I've sent v2 with changelog shortly after Greg's response. Would you
> like me to resend all raw-gadget fixes formed as a series?
> 
> BTW, to whom should I send them, to you or to Greg? I've noticed that
> some of my gadget patches from before got into the mainline twice.

They really should all go through Felipe, I was just trying to help out
a bit in the past.  I'll let him deal with all of these :)

thanks,

greg k-h
