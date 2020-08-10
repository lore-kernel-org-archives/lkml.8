Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BD22311C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrv0m/DU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHJSqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHJSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:46:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491DC061756;
        Mon, 10 Aug 2020 11:46:03 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v22so7159493edy.0;
        Mon, 10 Aug 2020 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ggjU3FMbPE5SbyAI637pqBRTzs0p0XGDl+i3Y6bsrU=;
        b=hrv0m/DUiqS/Wm9VaJIOzz19imALb8BpQw5yXSY7UWBvJLYQrlYMvquF1Y/JTX2lOV
         NaMdOJmfHOy7d7ml5HESptwuWmNG3ZImKxL+93j996XQMG7aOZjWq01igO1dnBy3wCzJ
         q636OKrz36TGirCB7lPZOJ+stOfqctUTgX+DLGbq4vAt7I/mcuMJLonXkVQIiF7aZCTq
         yEGslCVOqjUTxoRLCWICuXxsovVwbo0uHQ3p/f9aWC6FtmCtTWS0tzzP4phtrq8Kzg1x
         NZssgWxsXmGAd8p10j9jWNVBIk9NinDPtrEWu5t3I5c7JhHZCNCKcqqQsUeYJe1mcr6J
         NxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ggjU3FMbPE5SbyAI637pqBRTzs0p0XGDl+i3Y6bsrU=;
        b=RwItHsTywUuBGjxET1q34oTcNI305tKHD/LfZU0UfZuScr4yGXZman9KaHJfjTYzoF
         y/9DiFbmtY84PJ26uAUq4MNZzsetyZrNfrr0gVjO7F9N9nVozumlgcMXqbkWe1HoUCnD
         A3I9QEKVsF956XS1bYkJXS4oYDP9tFGBqq1K7ryyiPWzEPs8Du0i8X1BscIA5xXDiE4R
         ljBICOQujRReO8cTEJy4tnoohibJ1SAXk/AiDPlo7/FhqSGVGU/bIKxSowCFzBWtGoX4
         NWAuGXcjLf5sJqz02cKnDnrMu5+R2f5fFBFvMUCMnznOvSr+O2Svom1Yk4AxTLb3gb7+
         xGvQ==
X-Gm-Message-State: AOAM5312931DZfqd6npIRj4AscHLJTObXOMcS/SDrXdOhUVNxXawSI8n
        nFv5Tst/CyMS1l77vE/8eAba4w9C2CXs1nv6HEc=
X-Google-Smtp-Source: ABdhPJyo0vfZItCVXQ178NPkspm9dRGbwW8YOurEOL9HZiesRrN1QLtjiIpy9ooZ9jdLd1ZSQUtYIbvuRQ4NKoJjUwY=
X-Received: by 2002:aa7:c246:: with SMTP id y6mr23270403edo.78.1597085160405;
 Mon, 10 Aug 2020 11:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
 <20200810122320.GA20549@infradead.org>
In-Reply-To: <20200810122320.GA20549@infradead.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 11 Aug 2020 04:45:48 +1000
Message-ID: <CAPM=9tyDkW5rzz0PVQUXf0EnDoebRnD_Td=ZCWV1-LwvHE3Scg@mail.gmail.com>
Subject: Re: [git pull] drm next for 5.9-rc1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 at 22:23, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 06, 2020 at 11:07:02AM +1000, Dave Airlie wrote:
> > nouveau:
> > - add CRC support
> > - start using NVIDIA published class header files
>
> Where does Nvdia provide them?  I looked into the commits and the
> Nouveau mailing list archives and could not find anything.

https://github.com/NVIDIA/open-gpu-doc

Is I believe the canonical upstream source for them.
>
> Note that various new files with a MIT boilerplate instead of
> an SPDX tag.

Ben might just have imported them directly, so SPDX tags might need to
be sent upstream and see if they accept them.

Dave.
