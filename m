Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE58C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540292073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opbKVcBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgC2KwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:52:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54837 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC2KwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:52:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so16522555wmd.4;
        Sun, 29 Mar 2020 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GYK6OoyIGphy+gx0ZS0v2Sg7a9MvIdcLKhTU3e6hj5U=;
        b=opbKVcBxQpuRTKSwx0TW8bd+ERJl3qv8xl3JdiG2+JCx++HDG6NgGfVzCb4KwtGQlS
         grxqxYTDT9PEdT1GD8jMCJT25s+qn9oCJ7JsZAPvmmbOLoGRmfNuD5NHP0hbuDF4+2Qn
         tFInmWxZeDFG7QTSCFF04g00GNPExx+phFXhwbhfrvq5nYKIFHOCwZmDN1yzwqs+iIE6
         SrClVTbMSj59VFOIoAr5N2U4cwXFmQUO4fiIKR/PEWs7Q3vZhVLGit+1wwwLteSlzX1x
         5AnmSB/IcQOBC48GPGqD68KrgGkAA4dpkbMEutQNxGRggfwIYWFUqZDf2gIhDLpN1CNa
         Hssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GYK6OoyIGphy+gx0ZS0v2Sg7a9MvIdcLKhTU3e6hj5U=;
        b=QHejLNQdNUxkjBeJNLRDzaMPRRv0EYJQhLUDIHjT9O3JM5a1JXIIvdQbbATtBoWBzq
         xwAF+Yazwfw+AIG/QidVo2w6PjfUkWWGQ3+xvns0p+AXcVZAmgnNCriv9vKy31N2NChv
         amoFTyXgv1PdfKkKumlvTrLuLIgmpxz9BbowUVWo4X7B3+SiPA7lGpG6x0lkJDqyBWiP
         xpraDN8DTFF5ekUMXBpMz1XoitF59KmYHznBZ7NsH0l977YfYX1edeUyZ6Z8nrKofxOn
         7I0tJHInBIODOI1f9xXDscMeKd1TcLIyznUQcn1ZlpXfjh6AIo0ZcJtVyMa94+dxUOrF
         hOmQ==
X-Gm-Message-State: ANhLgQ1cjCLwcwmcJxhJ7qm/Vw13wLVe873peF/macBW9bPEN4CpOUQv
        hVHg7kEopUylbWZi7YQnwZo=
X-Google-Smtp-Source: ADFU+vtW47EUx9njW8MeadjmUXMaFOM4gQXvVTwETUVlQ1532Wlv+1hyuWWklVA6HSOYRLC8PlppYw==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr7655166wmd.166.1585479121324;
        Sun, 29 Mar 2020 03:52:01 -0700 (PDT)
Received: from debian ([197.34.208.250])
        by smtp.gmail.com with ESMTPSA id 195sm16438909wmb.8.2020.03.29.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 03:52:00 -0700 (PDT)
Message-ID: <ab06bc216dc07b2b070bc2635aaabb1942c6089c.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with
 preferred usleep_range
From:   Sam Muhammed <jane.pnx9@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Soumyajit Deb <debsoumyajit100@gmail.com>
Cc:     John Wyatt <jbwyatt4@gmail.com>, outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Mar 2020 06:51:58 -0400
In-Reply-To: <alpine.DEB.2.21.2003291235590.2990@hadrien>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
         <alpine.DEB.2.21.2003291127230.2990@hadrien>
         <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
         <alpine.DEB.2.21.2003291144460.2990@hadrien>
         <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
         <alpine.DEB.2.21.2003291235590.2990@hadrien>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-29 at 12:37 +0200, Julia Lawall wrote:
> 
> On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> 
> > I had the same doubt the other day about the replacement of udelay() with
> > usleep_range(). The corresponding range for the single argument value of
> > udelay() is quite confusing as I couldn't decide the range. But as much as I
> > noticed checkpatch.pl gives warning for replacing udelay() with
> > usleep_range() by checking the argument value of udelay(). In the
> > documentation, it is written udelay() should be used for a sleep time of at
> > most 10 microseconds but between 10 microseconds and 20 milliseconds,
> > usleep_range() should be used. 
> > I think the range is code specific and will depend on what range is
> > acceptable and doesn't break the code.
> >  Please correct me if I am wrong.
> 
> The range depends on the associated hardware.  Just because checkpatch
> suggests something doesn't mean that it is easy to address the problem.
> 
> julia
> 

Hi all, i think when it comes to a significant change in the code, we
should at least be familiar with the driver or be able to test the
change.

In the very beginning of the Documentation/timers/timers-howto.rst
there is the question:
"Is my code in an atomic context?"
It's not just about the range, it's more of at which context this code
runs, for atomic-context -> udelay must be used.
for non-atomic context -> usleep-range is better for power-management.

unless we are familiar with the driver we wouldn't really know in what
context this code is run at.

This thread though had the same conversation about this change, for the
same driver.
https://patchwork.kernel.org/patch/11137125/

Sam

> >
> > More clarification on this issue will be helpful.
> >
> > On Sun, 29 Mar 2020, 15:17 Julia Lawall, <julia.lawall@inria.fr> wrote:
> >
> >
> >       On Sun, 29 Mar 2020, John Wyatt wrote:
> >
> >       > On Sun, 2020-03-29 at 11:28 +0200, Julia Lawall wrote:
> >       > >
> >       > > On Sun, 29 Mar 2020, John B. Wyatt IV wrote:
> >       > >
> >       > > > Fix style issue with usleep_range being reported as
> >       preferred over
> >       > > > udelay.
> >       > > >
> >       > > > Issue reported by checkpatch.
> >       > > >
> >       > > > Please review.
> >       > > >
> >       > > > As written in Documentation/timers/timers-howto.rst udelay
> >       is the
> >       > > > generally preferred API. hrtimers, as noted in the docs,
> >       may be too
> >       > > > expensive for this short timer.
> >       > > >
> >       > > > Are the docs out of date, or, is this a checkpatch issue?
> >       > > >
> >       > > > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> >       > > > ---
> >       > > >  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
> >       > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >       > > >
> >       > > > diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > b/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > index eeeeec97ad27..019c8cce6bab 100644
> >       > > > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> >       > > >   dev_dbg(par->info->device, "%s()\n", __func__);
> >       > > >
> >       > > >   gpiod_set_value(par->gpio.reset, 0);
> >       > > > - udelay(20);
> >       > > > + usleep_range(20, 20);
> >       > >
> >       > > usleep_range should have a range, eg usleep_range(50,
> >       100);.  But it
> >       > > is
> >       > > hard to know a priori what the range should be.  So it is
> >       probably
> >       > > better
> >       > > to leave the code alone.
> >       >
> >       > Understood.
> >       >
> >       > With the question I wrote in the commit message:
> >       >
> >       > "As written in Documentation/timers/timers-howto.rst udelay is
> >       the
> >       > generally preferred API. hrtimers, as noted in the docs, may
> >       be too
> >       > expensive for this short timer.
> >       >
> >       > Are the docs out of date, or, is this a checkpatch issue?"
> >       >
> >       > Is usleep_range too expensive for this operation?
> >       >
> >       > Why does checkpatch favor usleep_range while the docs favor
> >       udelay?
> >
> >       I don't know the answer in detail, but it is quite possible that
> >       checkpatch doesn't pay any attention to the delay argument. 
> >       Checkpatch is
> >       a perl script that highlights things that may be of concern.  It
> >       is not a
> >       precise static analsis tool.
> >
> >       As a matter of form, all of your Please review comments should
> >       have been
> >       put below the ---.  Currently, if someone had wanted to apply
> >       the patch,
> >       you would make them do extra work to remove this information.
> >
> >       julia
> >
> >       >
> >       > >
> >       > > julia
> >       > >
> >       > > >   gpiod_set_value(par->gpio.reset, 1);
> >       > > >   mdelay(120);
> >       > > >  }
> >       > > > --
> >       > > > 2.25.1
> >       > > >
> >       > > > --
> >       > > > You received this message because you are subscribed to
> >       the Google
> >       > > > Groups "outreachy-kernel" group.
> >       > > > To unsubscribe from this group and stop receiving emails
> >       from it,
> >       > > > send an email to
> >       outreachy-kernel+unsubscribe@googlegroups.com.
> >       > > > To view this discussion on the web visit
> >       > > >https://groups.google.com/d/msgid/outreachy-kernel/20200329092204.770405-1-
> >       jbwyatt4%40gmail.com
> >       > > > .
> >       > > >
> >       >
> >       >
> >
> >       --
> >       You received this message because you are subscribed to the
> >       Google Groups "outreachy-kernel" group.
> >       To unsubscribe from this group and stop receiving emails from
> >       it, send an email to
> >       outreachy-kernel+unsubscribe@googlegroups.com.
> >       To view this discussion on the web visithttps://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.21.20032911
> >       44460.2990%40hadrien.
> >
> >
> >
> 


