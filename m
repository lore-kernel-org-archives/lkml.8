Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B8AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433872075A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596545936;
	bh=5GcDtKxhBv4ldUHvEV1E+xCRSF0zyL6ugmx1l+H+odY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dQxgU0sqF5HPHAS9U1Am1YMnRJKF9Why6SUoomfOfXFw8qRDj1ra73DIcKCwC2swq
	 bZrQeGFV/CnVKzb2mWYFiLo2GWnrFs9NSMCU7a2XlhwvHmba5u+7Ost02VD1nRpSR3
	 NpbLLWaJw1WmSVqfOcMoKH+Ne0rR+B76C05WMtHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHDM6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgHDM6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:58:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362202075A;
        Tue,  4 Aug 2020 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596545930;
        bh=5GcDtKxhBv4ldUHvEV1E+xCRSF0zyL6ugmx1l+H+odY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UD6lC1ixvriONP18vGEUxhXmLbyj9SDymf5tE5y6s4XvcPhmj++RndYdRtMCbvHtJ
         lt6CzbrJsFBSnZJlHWxSA46j8NgHvlTiVoOc6P6NGCnA7OIJjSeiGm9W1NALcIi+Ae
         /fIt1MqW/euxPAu0TGCDEdlxn7M0FkzLSgdkyMHY=
Date:   Tue, 4 Aug 2020 14:58:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
Subject: Re: [PATCH] vt: defer kfree() of vc_screenbuf in vc_do_resize()
Message-ID: <20200804125831.GA221149@kroah.com>
References: <1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <0c9d8003-ba3f-8f2d-7c5a-56c5ca7db750@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9d8003-ba3f-8f2d-7c5a-56c5ca7db750@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:15:43PM +0900, Tetsuo Handa wrote:
> Do you think this approach is acceptable? Or, do we need to modify set_origin() ?
> 
> On 2020/07/29 23:57, Tetsuo Handa wrote:
> > syzbot is reporting UAF bug in set_origin() from vc_do_resize() [1], for
> > vc_do_resize() calls kfree(vc->vc_screenbuf) before calling set_origin().
> > 
> > Unfortunately, in set_origin(), vc->vc_sw->con_set_origin() might access
> > vc->vc_pos when scroll is involved in order to manipulate cursor, but
> > vc->vc_pos refers already released vc->vc_screenbuf until vc->vc_pos gets
> > updated based on the result of vc->vc_sw->con_set_origin().
> > 
> > Preserving old buffer and tolerating outdated vc members until set_origin()
> > completes would be easier than preventing vc->vc_sw->con_set_origin() from
> > accessing outdated vc members.
> > 
> > [1] https://syzkaller.appspot.com/bug?id=6649da2081e2ebdc65c0642c214b27fe91099db3
> > 
> > Reported-by: syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  drivers/tty/vt/vt.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 42d8c67..c9ee8e9 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -1196,7 +1196,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
> >  	unsigned int old_rows, old_row_size, first_copied_row;
> >  	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
> >  	unsigned int user;
> > -	unsigned short *newscreen;
> > +	unsigned short *oldscreen, *newscreen;
> >  	struct uni_screen *new_uniscr = NULL;
> >  
> >  	WARN_CONSOLE_UNLOCKED();
> > @@ -1294,10 +1294,11 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
> >  	if (new_scr_end > new_origin)
> >  		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
> >  			    new_scr_end - new_origin);
> > -	kfree(vc->vc_screenbuf);
> > +	oldscreen = vc->vc_screenbuf;
> >  	vc->vc_screenbuf = newscreen;
> >  	vc->vc_screenbuf_size = new_screen_size;
> >  	set_origin(vc);
> > +	kfree(oldscreen);
> >  
> >  	/* do part of a reset_terminal() */
> >  	vc->vc_top = 0;

I think what you have here is fine, as cleaning up set_orgin() might be
hard to do at this point in time.

thanks,

greg k-h
