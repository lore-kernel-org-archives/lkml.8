Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE41C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E728620663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljd4Hsqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgFBXEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgFBXEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:04:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A06C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:04:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z5so121884ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hK2pkd+Z5BdN7BnkioQ9YwCnK+wEkzGRT8j006e30o=;
        b=ljd4Hsqvv4x5t7BIYVJ6FLNvaDXQrMEbry287T3fN6kYs67RvbQmTqSw/PVJRC5X68
         MHQ1pm5h7g+Q8RDXtS+4/NnhH58+Vo7o7Zc09S3z82/AS6bhP1iuVQ3u0bdgNFYdZBL9
         YcN0TmV4PUV+MrOXfu6gG1QjJSWvgZ0g+2C4HwCk1Uw3fNnNAqTZ9rLzzkSoEP1HoDsE
         Z6Fiq8W5XF1fWuHxqkGHBLZlYeT1FuCWdLZ5uM6y70IRTsucFmZLqRrx4G3PlBxOc4/R
         d8dC8L3t9sUkJ5WfNwNTCfgCNatEsCmRYz21Q9SDQnaxR+1hEKUQb+8rOgtLBo7KmOQE
         CVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hK2pkd+Z5BdN7BnkioQ9YwCnK+wEkzGRT8j006e30o=;
        b=CsTVeKa9UaS1YwhZpOwgZqAQ227QMcRIEV3ZtJsO40Co1WR9l2eX4vbgsStzf2aJxC
         jlUaihJkhLjEDYMBP1nSvZWtKU418N1Z+WqMyNAyYdwD+5LgPFfbcesjSpSyrJuuqLbe
         ff10Pfg/eY6PnjUnCmJJVDzM3/M8g4+nXVyMGDS6dQ03b+kqTXwxYwnHyqmrXSC2BAc6
         +Y/I+t14dwbWUMdHx5/Bneab4GGsaxzAtFM7aNSbmFzZr1mdl5C9tgoVD4iff6ux54rk
         W4Odsid4kkEfrZYm2d/yR7CM21F4OepOxiK1EwLWJEa6HbXiTrlceaD6ho1cn4soltFP
         W4CQ==
X-Gm-Message-State: AOAM530HlyozoTGMQBuMeyqkng4qQ0PKay1tv6yzfq/nb4xEj89hQjOt
        A+DPIGYMcfpsmLVhUvYWQrhnNnjqeFj2fRXOi0U=
X-Google-Smtp-Source: ABdhPJzf3Hv7N6HXtJDyQa56Qx3EnDu/soSg6vJ5rPIOxB9nSWoyz7vRoutiNnKn/K9s3XdAsmFQcuHsZsK+kpjE4aU=
X-Received: by 2002:a17:906:a44:: with SMTP id x4mr15211068ejf.237.1591139045061;
 Tue, 02 Jun 2020 16:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <CAHk-=winp5YQv7rFmUe2z=xYSuzF9t1mMt+_C_1iFwxjoqG6gw@mail.gmail.com>
In-Reply-To: <CAHk-=winp5YQv7rFmUe2z=xYSuzF9t1mMt+_C_1iFwxjoqG6gw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 3 Jun 2020 09:03:53 +1000
Message-ID: <CAPM=9txAkrg7KiJu4V32Gf4h04ku_Lez8dZFFG3u1JcTm-4Tmg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 08:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jun 1, 2020 at 11:06 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > I've pushed a merged by me tree here, which I think gets them all
> > correct, but please let me know if you think different.
> > https://cgit.freedesktop.org/~airlied/linux/log/?h=drm-5.8-merged
>
> Ok, I get the same result, except my resolution to the simple encoder
> issue was slightly different. I removed the simple helper header
> include too as part of basically undoing the whole simple encoder
> conversion.

Yes sounds like my experience.

I spent time on the tides and it was a revert pretty much of the
commit in next, I just missed the header include line.

I also realised I'd likely mismerged earlier when fixing this up, I'm
going to have to put more time into merge fixing up, I'm still not
always happy with my methods of figuring out what the correct answer
is.

> But other than that we're identical, which is a good sign. Apparently
> the drm mis-merge in the middle got fixed up.

Cool, thanks for redoing it, since this was definitely one of the more
conflicty ones I've had in a while.

Dave.
