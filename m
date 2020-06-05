Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70506C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40090206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EawcP4Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFEMYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgFEMYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:24:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B0AC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 05:24:43 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e11so4225719ilr.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIfn0QHMP7CK4Hmgml37SRcHqGH4aTtKIuqHQUCLWRQ=;
        b=EawcP4EporkwrqfLPgvSKZWlEE1ID85TieWCHY9LwiKd+HIWVF0QxVSawt8hyzZZA8
         QXJ2pNFwn2Ify3QvL2OneyDAR505YIqjhKzJNYhUVvWgjj9lx52Iq2Aqz4dkftCr4YN5
         esT7/cpbLK9xB2nYLvrPz1qbc1Jt6Uo7VHWrud5qxemkEHW91lVv59CjdFHDnMAbn/BD
         kkCNiXNYmNFMH635f2w+rTyfZuBaHtwXgUEm3k2UI4/y5jZ373klw6RMSRCkefE+qdjy
         RqUsL1NqHhjxO/v4NWOxFztHbXvT7SRoAUQpFoeWdvf/XV9bU9cHguBRm9pITOknMnBd
         2W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIfn0QHMP7CK4Hmgml37SRcHqGH4aTtKIuqHQUCLWRQ=;
        b=Nr3V23ENCxhHjqH9sdB6BX9jl62+rogZh5VyxWvcv6F8qD7S1PskpzWMkZbfWzp2k7
         df7y4fxGvP1g5ISGR8fR06MIxDRUk6mdMSQjWr9qMNvobnU4XJD7Aduh9STRAZou7Jvp
         FwUqu2ZPEbhSVf3OS3VTtBxSFCPvgpV+xbP1bnbn2j/qcGYjEpnwstEi+txrFbHcsHTJ
         K7trL5OpTE6Nj/WRwEP7sybOdvPScpauVaw8PoG+J2CHfiVIMPlyTieSJY0sE2Q+ZHO+
         utrL2wjk7CkwwcDl8bdmtWEwj/aXLHCqAcnystt8jKL6SVg6N8kDsEeixaPzffXOwPgQ
         qXCA==
X-Gm-Message-State: AOAM5302MOEBu4UeeU3vEFZcbI/N1a60xF6hA0cweaiw8foVAS9I3vQN
        Ny4VANf3vIg7WRacu4dJEBpNbFg6OXzlEbGG6PzyQQ==
X-Google-Smtp-Source: ABdhPJxIJRIn8uLBn8iAB1Nr4R5l0zbAftEc1md7w19YTUWpfcp8liEx8XFB8UBZsNB8M/Dg27ZKhc4KMp4ZpswjQ+Q=
X-Received: by 2002:a05:6e02:1350:: with SMTP id k16mr7686913ilr.213.1591359882249;
 Fri, 05 Jun 2020 05:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 5 Jun 2020 20:24:31 +0800
Message-ID: <CA+Px+wV8U6Y-tppLPUdoOgQhpss-DUm-YDQX7TZ1uHHH7JMyZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        howie.huang@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 6:37 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> Jiaxin Yu (2):
>   ASoC: mediatek: mt6358: support DMIC one-wire mode
Has done previous round review on https://crrev.com/c/2230089

>   ASoC: dt-bindings: mediatek: mt6358: add dmic-mode property
Has done previous round review on https://crrev.com/c/2230086

>  Documentation/devicetree/bindings/sound/mt6358.txt |  6 ++++++
>  sound/soc/codecs/mt6358.c                          | 23 +++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)

With that:
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
