Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFBEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F5621D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583174431;
	bh=6DLnZ2Zf66pt7VKVRWxot04T4F3DGFl1pn1DT9jHh7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mLGgJf+8D9/6X+3AnficbYNxLs8dyy/1s9FABOOgb1gCl3LedHsVFgMvt1FBIcCT7
	 klWWeBFfco1eCtSQ6nKBjdbOXhNbN1+3q7erKBN9QPyIbkMRTE8zFMgV9XBDhwfFtR
	 9Z6tXRzDLN3PEtTiGYZpsJQDUDmE0Dlg3jtuZbo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCBSka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgCBSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:40:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4058C2166E;
        Mon,  2 Mar 2020 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583174429;
        bh=6DLnZ2Zf66pt7VKVRWxot04T4F3DGFl1pn1DT9jHh7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tue91unT4DUxXF/pJjA0movpxeFA7lsfEyrSjfNN69R8oLyXfqMXQIl2ZfHkb9WSJ
         I4L34YzSQjdERZqP7opT1z5y55mwOlXmyaQbOmJI09XpxmDxoYLd5KaU1ysCPn1b6c
         TCnUDk3v/KkjZKjxKWlBIQi8OvXp+vIbSjJuHnj4=
Date:   Mon, 2 Mar 2020 19:39:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Todd Kjos <tkjos@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2 3/3] sched/wait: avoid double initialization in
 ___wait_event()
Message-ID: <20200302183954.GA166273@kroah.com>
References: <20200302130430.201037-1-glider@google.com>
 <20200302130430.201037-3-glider@google.com>
 <CAHRSSEwe=jZAEVhGw4ACBU0m-76TzZfJFv1Rzw=_UVm6HbTvAw@mail.gmail.com>
 <CAG_fn=W96H3kMcoTxfqVq9Ec=1HZsJjnTjuX74dhZJe0QNuMrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=W96H3kMcoTxfqVq9Ec=1HZsJjnTjuX74dhZJe0QNuMrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 07:03:19PM +0100, Alexander Potapenko wrote:
> > >         case BINDER_SET_MAX_THREADS: {
> > > -               int max_threads;
> > > +               int max_threads __no_initialize;
> >
> > Is this really needed? A single integer in a rarely called ioctl()
> > being initialized twice doesn't warrant this optimization.
> 
> It really does not, and I didn't have this bit in v1.
> But if we don't want this diff to bit rot, we'd better have a
> Coccinelle script generating it.
> The script I added to the description of patch 2/3 introduced this
> annotation, and I thought keeping it is better than trying to teach
> the script about the size of the arguments.

Please fix the script, don't add stuff to the kernel that is not needed.

thanks,

greg k-h
