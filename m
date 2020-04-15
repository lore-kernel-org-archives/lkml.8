Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C4BC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F328320767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNmfCTMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370727AbgDONjm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633377AbgDONjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:39:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFCC061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:39:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m2so2644262lfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYbKtTdIlAS2MrOYv3ktp5ynh9zmAurxtliyxz228HM=;
        b=kNmfCTMrncJz3Mf/q8c7XdNw/+aM367/99PvPs2dC40uoDdbWKW1e5Ka1VrjrIIXZN
         EWKQAeD41UH7JTlXSR2Oni+zm12n4KErP+aTQMcwUQTWszpBTKmX4onmjQL50Dec0ulk
         Oi6VJylUjzXADIznlAe70TVHYFljOlYz5pmYHnDSHHRsshUyyxJR06c+zQkapSjGMpB2
         GtKLORJXT3ydl4ITIvKl3QV77AjyB8MZPzxUdClUdDGnVVgideHJufH3CidXt3Wct8cI
         VK11gylh6XQ1fno/KgxM+rHfVxV2tTg4uxUIPx6NlgWkQ/s19QJrUOzUUOsOInQ5q4B/
         ZY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYbKtTdIlAS2MrOYv3ktp5ynh9zmAurxtliyxz228HM=;
        b=m6ylZM/Frs3ANyahUiH7x9OroYsS59CCy2IsJX3cMsvH4VMKA63suj9OrSpk3cNtyz
         AV6uj9AMV1jn6aGQsvgR4/TQRW3v2Xu9TKnzhtq8j4yQOjBo53yBRai1QLrb7yzUfs4g
         seYQNmD5fiEQ4VIcLy63TJHZNNyhRz4IW7K9WKStrAAXUTbMG2YWXMhYjQfxpFRpjU2X
         2z2WJvU0u8fSQfnyTTQc+1ZQXPGrCJliSwQmhtci7OFYebaIK8eFy5kwLJLTRlEcornx
         iVawnJPNp13bD0rfZg/gtT+WGQFFI7NNLAB+jKHenrsoW/to9QhyySKZQ8JUz9Kj6ERQ
         efDw==
X-Gm-Message-State: AGi0PuZeZSNZcGCI7g9IakMBj8/xVVem+j6Js2MpZt3DYAA+hnFvZLcN
        qaFzQ1qF3lkoAVJ64Qez23Q/YrG3QkjIDmwfO3XuIw==
X-Google-Smtp-Source: APiQypKspEOb/rj3icJNNhJ9x/jVreqO36OImyQUXuDaYRNwL1zpsCDOBI49RUO4ArSUzLvFrl5EOyBzPKgoU8LVqX4=
X-Received: by 2002:ac2:4c34:: with SMTP id u20mr3207171lfq.40.1586957969813;
 Wed, 15 Apr 2020 06:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <1586254255-28713-1-git-send-email-sumit.garg@linaro.org>
 <CABPxzY+hL=jD6Zy=netP3oqNXg69gDL2g0KiPe40eaXXgZBnxw@mail.gmail.com>
 <CAFA6WYMZAq6X5m++h33ySCa6jOQCq_tHL=8mUi-kPMcn4FH=jA@mail.gmail.com>
 <CAFA6WYOW9ne0iffwC1dc48a_aSaYkkxQzyHQXTV2Wkob9KOXQg@mail.gmail.com> <CA+icZUUDm=WPjmwh5ikp8t+xt7dqTgghCeB8F0+czaUh-sHXxA@mail.gmail.com>
In-Reply-To: <CA+icZUUDm=WPjmwh5ikp8t+xt7dqTgghCeB8F0+czaUh-sHXxA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 15 Apr 2020 19:09:18 +0530
Message-ID: <CAFA6WYPdJMt-h=9HrV-DcHZnO7xCu74Dh9FuRMnp16qhotyo0g@mail.gmail.com>
Subject: Re: [PATCH v2] mac80211: fix race in ieee80211_register_hw()
To:     sedat.dilek@gmail.com, Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Matthias=2DPeter_Sch=C3=B6pfer?= 
        <matthias.schoepfer@ithinx.io>,
        "Berg Philipp (HAU-EDS)" <Philipp.Berg@liebherr.com>,
        "Weitner Michael (HAU-EDS)" <Michael.Weitner@liebherr.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 18:49, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Apr 15, 2020 at 3:10 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> [.. ]
>
> > > In case we don't have any further comments, could you fix this nitpick
> > > from Chaitanya while applying or would you like me to respin and send
> > > v3?
> >
> > A gentle ping. Is this patch a good candidate for 5.7-rc2?
> >
>
> Hi Sumit,
>
> it's in [1] (see [2]) with slightly mods by Johannes but not in Linus tree.
>

Thanks Sedat for this information.

> Johannes requested a pull-request means will be merged in a next step
> in net.git and then hopefully land in Linus tree after Dave M.
> requested a pull-request.

I didn't get this PR notification as currently I am not subscribed to
linux-wireless ML. So apologies for the noise here.

BTW, thanks Johannes for picking up this patch.

-Sumit

>
> Thanks for your patch.
>
> Regards,
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/tag/?h=mac80211-for-net-2020-04-15
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?h=mac80211-for-net-2020-04-15&id=52e04b4ce5d03775b6a78f3ed1097480faacc9fd
