Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF9FC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00F32054F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoWFwe/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgECUAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECUAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 16:00:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A0C061A0E;
        Sun,  3 May 2020 13:00:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y4so7633372ljn.7;
        Sun, 03 May 2020 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLPE4D1sK0zsHGMlXa0Pxw17ACXHcfJqsNrgMQ+yusQ=;
        b=MoWFwe/ISoefeYi0uYDrYATw+tIdx6gFDmppAi/CnTIz8roXxfUJ6Ab4QL8hRC3NzN
         PaLN4fwk3uQOqKKH7JJlzdUbItmZbfamGgKniB/eDlzUl6eqIzMSiPcaqykrV/SxjCmY
         aHDX9StPG0YGB5mzlk6IUVPpqjafmjulD+GByo9qpjNb99qXBXXwTruhYco6dEPsq12H
         7X7PTNo9/gWDYcPpZDmqtlrbelvrcy7OyYnXAlhebJNBJdsKKF6brchm6awxOrm4ZVqY
         DHgpQtq4tpInB/trZOG4UlfU7mR4jHrUT4M1k2LesHQL/9V/mJM5YqlpAN+foE7H3Kzj
         YjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLPE4D1sK0zsHGMlXa0Pxw17ACXHcfJqsNrgMQ+yusQ=;
        b=mUfdKYe2Q2f+elb2CHprQPRtSulYVuiESlb/i9S3iW7AVThvKyxV/Ip0yLUiXk6NX3
         rxqCSo8VBHszIPMUjMSeJFb++lYm6oA1k5rNNiQomXMOoMRzt5eOCjSIKczbu07CCY5k
         pB0wrcjLWrBQD0CvkKAv1xcw7vtryQLGtAOfAGSS5mHQlK3TQbbFb44h27FWW04Mzk9S
         wmXgcbtBgkKr+JDoBj0HOFWF6Xso1dWre10BhcxtSJsoWAum6mWuxP7NxS9D+cIhP5MB
         R7Ho3FO05SO9TOfwxqwE0YPXnLnbDVJMpZxSLps87B5UHsdDXqFAi9g+yCVS0fc4bfVO
         a/PA==
X-Gm-Message-State: AGi0PuYMKzRd8e+AVB+AliSta9z4p7oFRlXs7UtVYcNl7hjmtCA9M17E
        oPsOV9ohdLdqKo2YI9174RldCxDo8aJE8M0bU7nleCPdv4c=
X-Google-Smtp-Source: APiQypJdPIGKEeUOvDrKstspkPFWNnHxClOnLOmE9E9/8W4198p/LZr+UDHjXayyyV+8kSNHjmY0HQTKVR4QHTOhKHw=
X-Received: by 2002:a2e:7815:: with SMTP id t21mr8540277ljc.146.1588535998430;
 Sun, 03 May 2020 12:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com> <20200503174040.GA27362@ravnborg.org>
In-Reply-To: <20200503174040.GA27362@ravnborg.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 4 May 2020 01:29:47 +0530
Message-ID: <CAFqt6zb94Wj_dkSb2NJ6TOJczxJErvFRB7OSzZieOTot-EL+qw@mail.gmail.com>
Subject: Re: [PATCH] video/fbdev/matroxfb: Remove dead code
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     b.zolnierkie@samsung.com, Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 11:10 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Souptick
>
> On Sat, May 02, 2020 at 03:28:11AM +0530, Souptick Joarder wrote:
> > These are dead code since 3.15. If there is no plan to use it further
> > it can be removed forever.
> Could you explain why you conclude this is dead code sine 3.15 -
> and maybe point to the commit that made it dead.
> I failed to look it up.
> And I would assume I did not have to look it up, but that you have
> provided enough background to evaluate the patch.

I trace this back till linux version 2.3.9 & 2.4.0 in
drivers/video/matrox/matroxfb_DAC1064.c
(3.15 was the version when this is moved to
drivers/video/fbdev/matrox/matroxfb_DAC1064.c)
and I think this driver support was added mostly in 2.4.0, but as it
is pre git era, unable to provide
commit id. Code commented with *#if 0* in discussion existed since 2.4.0.

First two *#if 0* can be removed as these are just declaration of
variables, never used.

-#if 0
-static int def50 = 0;  /* reg50, & 0x0F, & 0x3000 (only 0x0000,
0x1000, 0x2000 (0x3000 disallowed and treated as 0) */
-#endif

 static void MGAG100_progPixClock(const struct matrox_fb_info *minfo, int flags,
                                 int m, int n, int p)
@@ -843,9 +840,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
        struct matrox_hw_state *hw = &minfo->hw;

         u_int32_t reg50;
-#if 0
-       u_int32_t q;
-#endif

In my opinion 3rd *#if 0 is not for documentation purpose and can be
removed as well.

-#if 0
-               if (mga_readb(minfo->video.vbase, 0x0000) != 0xAA) {
-                       hw->MXoptionReg &= ~0x1000;
-               }
-#endif

There is a 4th *#if 0 in this file. But it wasn't removed as there are
some documentation
comment exists for it.

#if 0
/* HELP! If we boot without DFP connected to DVI, we can
  poweroff TMDS. But if we boot with DFP connected,
  TMDS generated clocks are used instead of ALL pixclocks
  available... If someone knows which register
  handles it, please reveal this secret to me... */
hw->DACreg[POS1064_XPWRCTRL] &= ~0x04; /* Poweroff TMDS */
#endif



>
> Sometimes dead code are kept becasue it documents something etc.
> So it is not always a simple removal.
>
Yes, I agree there are some dead code kept tree wide for documentation purpose,
but many of them are truly dead code as well and it differ from case to case.
