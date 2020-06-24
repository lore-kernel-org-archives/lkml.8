Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F74C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359ED20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593022332;
	bh=vguMG2Frx6ddvH4sH94HUkTKzOWyajl73pm7n8N9kBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=00x1vYkTeHn8stb/Qaovc3MLGLv7PGb7MQa7T0EAwIQXNqGsinxMaWkvwurf+/l32
	 ecNOkxGfblgTQD2NHhr5kna947qgBdVRMj8dMOZ+ZcA4nmy5TKpVSlprpNAs26oguF
	 6vQBpi5xyxBfsApWN+n4ykBSN3E36LT8VbKX5A0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405932AbgFXSMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405761AbgFXSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:12:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD922C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:12:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x18so3638711lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5O34Bhu+mXlljW4o1n6jAUtWoAilwwsuuBTtWM5EkM=;
        b=X5q/JuuAXzg5cLEyj9l4hKnog2zLaFr6cPK5cIKZiYO1/ckVvp/JHr+ds9iPiDjB+2
         hcA8637lcsrPk11j//mj62+mDzxeVnrD1z58Kyi/e3QQBd8UhOM4HlUaGtI/ZNsmRYg6
         dF2K+SB970XHvOOxNG1Iyqt+exYASwGWsUUTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5O34Bhu+mXlljW4o1n6jAUtWoAilwwsuuBTtWM5EkM=;
        b=OfFWLihGvm6+MFMcMpLL1oqhZUIdogWqK7GW8fwDasZCKakbdtSG1hHSfcy+0uyNzI
         HTyDLU+WBIitpuab8nyJoWhhvfRfv4W2T/D6iRVkVpy1x4vLpKwCM9jbWitl22HuwNIu
         xCtqlhT8rtUYk/sejCMOCK87Dgy8kyA+E8fYwceB4W6KUACj0xBXY1lanbatqGMU1NJ+
         vKnsUOGU8g3Xy2QhTGkclElYeEpgcu551ga9tCS/RgBLSKac4yUftMcYDxMwX/qUavNN
         fWfL/cnPvITQg/AP74NsSNY+olTwjBg7ltJfRkKi0QctIifoMhW/G9nq3fK4o8+Amny6
         p75A==
X-Gm-Message-State: AOAM533siNF77RcjrjivRQAkgyk+FF9PyOsvRR/MZ0ozV4EFJVPEwOpr
        JVqM22UsnOcg2bwoeyXy2kOLUj+T7c4=
X-Google-Smtp-Source: ABdhPJw5gk7U5ODUedYr3miIzW16gtoGZ8A1J8Sg2dmK5dHclb7qgoWvbU88UlSTGeRt8uCG73DiRA==
X-Received: by 2002:a2e:8047:: with SMTP id p7mr2732841ljg.414.1593022328066;
        Wed, 24 Jun 2020 11:12:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d20sm5390790lfi.22.2020.06.24.11.12.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:12:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e4so3632411ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:12:06 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr14351650ljk.314.1593022326362;
 Wed, 24 Jun 2020 11:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de>
In-Reply-To: <20200624175548.GA25939@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 11:11:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
Message-ID: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I don't care at all.  Based on our previous chat I assumed you
> wanted something like this.  We might still need the uptr_t for
> setsockopt, though.

No.

What I mean was *not* something like uptr_t.

Just keep the existing "set_fs()". It's not harmful if it's only used
occasionally. We should rename it once it's rare enough, though.

Then, make the following changes:

 - all the normal user access functions stop caring. They use
TASK_SIZE_MAX and are done with it. They basically stop reacting to
set_fs().

 - then, we can have a few *very* specific cases (like setsockopt,
maybe some random read/write) that we teach to use the new set_fs()
thing.

So in *those* cases, we'd basically just do "oh, ok, we are supposed
to use a kernel pointer" based on the setfs value.

IOW, I mean tto do something much more gradual. No new interfaces, no
new types, just a couple of (very clearly marked!) cases of the legacy
set_fs() behavior.

                Linus
