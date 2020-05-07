Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEED9C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895B220A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588849658;
	bh=/mtZ5WGXzOosl2v22r9XjAbR7pSmnQHFt3goB++zb3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qF8mAwcxnOubGO46KbHbx4sdCNOfFrq2YJEbVVn2puBQ3DKXj5QRZH1mzAnexoTEe
	 HdzIIyTaNWrbFlyaQpRthuu9drzIr20Jnc2TOQFoywY4jYtAZCulw50v2fIUsfXD5g
	 cvu2FnigGZgRNAX1ktUDFwPy5GFQ0vA5OpGMnfY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEGLHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgEGLHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:07:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA76D20736;
        Thu,  7 May 2020 11:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588849656;
        bh=/mtZ5WGXzOosl2v22r9XjAbR7pSmnQHFt3goB++zb3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNeNNF7Y/NCRmE8u/rkprCOAGhY4BJOCn/v4MIRqiuzP7rCLNghrnwhUffiou7oME
         +clc7XtcOH+NxDRlmbGawLwFU/3RNWps/8ZA6fjah+/ViKzbjSpjlIb/UQbu0275yl
         Ij9NRdR7oOID00T9O3tkqpI1oHNsAbughyNfs2Uk=
Date:   Thu, 7 May 2020 13:07:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>, security@kernel.org,
        syzkaller <syzkaller@googlegroups.com>, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Write in snd_rawmidi_kernel_write1
Message-ID: <20200507110734.GA1490467@kroah.com>
References: <CAFcO6XMGT42wFBxEa01Ee5Msuecm+WiXnn4rc-VWkC4vTzycPg@mail.gmail.com>
 <20200507082302.GF1024567@kroah.com>
 <s5h8si45ard.wl-tiwai@suse.de>
 <20200507101310.GA1311017@kroah.com>
 <s5hsggc3v4p.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsggc3v4p.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 12:19:18PM +0200, Takashi Iwai wrote:
> On Thu, 07 May 2020 12:13:10 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Thu, May 07, 2020 at 11:56:22AM +0200, Takashi Iwai wrote:
> > > On Thu, 07 May 2020 10:23:02 +0200,
> > > Greg Kroah-Hartman wrote:
> > > > 
> > > > On Thu, May 07, 2020 at 04:04:25PM +0800, butt3rflyh4ck wrote:
> > > > > I report a bug (in linux-5.7-rc1) found by syzkaller.
> > > > > 
> > > > > kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.7.0-rc1.config
> > > > > reproducer: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/repro.cprog
> > > > > 
> > > > > I test the reproducer in linux-5.7-rc4 and crash too.
> > > > 
> > > > Great, care to create a fix for this and send it to the proper
> > > > maintainers?  That's the best way to get it fixed, otherwise it just
> > > > goes in the file with the rest of the syzbot reports we are burried
> > > > under.
> > > 
> > > Don't worry, I already prepared a fix patch below :)
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > -- 8< --
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Subject: [PATCH] ALSA: rawmidi: Fix racy buffer resize under concurrent
> > >  accesses
> > > 
> > > The rawmidi core allows user to resize the runtime buffer via ioctl,
> > > and this may lead to UAF when performed during concurrent reads or
> > > writes.
> > > 
> > > This patch fixes the race by introducing a reference counter for the
> > > runtime buffer access and returns -EBUSY error when the resize is
> > > performed concurrently.
> > > 
> > > Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> > > Cc: <stable@vger.kernel.org>
> > > Link: https://lore.kernel.org/r/CAFcO6XMWpUVK_yzzCpp8_XP7+=oUpQvuBeCbMffEDkpe8jWrfg@mail.gmail.com
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  include/sound/rawmidi.h |  1 +
> > >  sound/core/rawmidi.c    | 29 ++++++++++++++++++++++++++++-
> > >  2 files changed, 29 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
> > > index a36b7227a15a..334842daa904 100644
> > > --- a/include/sound/rawmidi.h
> > > +++ b/include/sound/rawmidi.h
> > > @@ -61,6 +61,7 @@ struct snd_rawmidi_runtime {
> > >  	size_t avail_min;	/* min avail for wakeup */
> > >  	size_t avail;		/* max used buffer for wakeup */
> > >  	size_t xruns;		/* over/underruns counter */
> > > +	int buffer_ref;		/* buffer reference count */
> > >  	/* misc */
> > >  	spinlock_t lock;
> > >  	wait_queue_head_t sleep;
> > > diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
> > > index 20dd08e1f675..4185d9e81e3c 100644
> > > --- a/sound/core/rawmidi.c
> > > +++ b/sound/core/rawmidi.c
> > > @@ -120,6 +120,17 @@ static void snd_rawmidi_input_event_work(struct work_struct *work)
> > >  		runtime->event(runtime->substream);
> > >  }
> > >  
> > > +/* buffer refcount management: call with runtime->lock held */
> > > +static inline void snd_rawmidi_buffer_ref(struct snd_rawmidi_runtime *runtime)
> > > +{
> > > +	runtime->buffer_ref++;
> > > +}
> > > +
> > > +static inline void snd_rawmidi_buffer_unref(struct snd_rawmidi_runtime *runtime)
> > > +{
> > > +	runtime->buffer_ref--;
> > > +}
> > 
> > Why not use the reference count structure?
> 
> The context accessing the buffer is always with the spinlock, so we
> don't need expensive atomic ops there.
> 
> Usually this kind of check can be a simple boolean flag, but in this
> case, there is one place that goes out of lock due to
> copy_from/to_user, so a refcount is used in this patch instead.

Ah, ok, thanks for the explanation.

greg k-h
