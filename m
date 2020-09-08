Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC7C215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEc205CC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgIHIlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgIHIlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:41:12 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D347CC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:41:11 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s127so3884375vkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRTNSAPWPCI5iQTaMgS28e7ZlEiCgAQz9GOhoqHIZ8c=;
        b=dEc205CC8/4AIZ8O0GSYBNX7L5fb8sHXU5jEhBMJScwpGfMVei74/KwzvqX0QW349P
         85kuC0osIJECUKgljnPnnZE1WvIGKtL4W7GLWDPrpsAuYBGgq2FlCI/dXKE93aCZ964w
         0o6rlIfF/xRlcygOaU6HJtORZ/LZE6mhwADhuasXUBA7Xnyx2QbTrPX8LkgidS500DbM
         WdP/dSQEtuy/mwGgtiyhhuWrLX6PZ+AOgTTGItFwMsOb7vXbC8Krk5JPQnsX4hMLtmCK
         0OVobASijrwcRYvu7tik2WhEQRnXeklYoPH0LJ5FDKX0m1WjW0SvXJqT+i3MMVnav8/0
         FI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRTNSAPWPCI5iQTaMgS28e7ZlEiCgAQz9GOhoqHIZ8c=;
        b=C9NmXfv+plDN2yI468RVCmTjcafYfu+HdKe3GXeKZqenICAl4Si4QhMwKDnBsFObtO
         xgiHoqblhZWuyD/Gw2Gvr+PmBjqhiz75yThwPHD8yY9zy/adq+BsZ2nuAFNiXKYtsxpA
         9HRioTQJzqAciokZCfCJ3FGoeHAUcR57/bxIe/u9BG9LrbphWayT7rlm94MVTOfKdH+N
         JTZGhoTbV6luvvYQhbhlECxer+NuMY/1G0wGQ7B+RlhqHuHG8ceAVaGuUoRrRoZX00pk
         GnoMvYZ3MHkvGLfXqj+aUnmZLpXTlL1VsPwrPeAKhLxHzIXPM2SMYGOhzxHDEfHssL64
         2C3A==
X-Gm-Message-State: AOAM533l7xCUM8OO4AnSNV0rQtizcYxa8w/MnhkFfIkAVVwdBddS61qz
        +G6HdbQb6YmVl74/c35UluWBYz0ChDRAOA==
X-Google-Smtp-Source: ABdhPJxSZjDNIgmNCx2bcOb7St5h1g7JtumK+PpttjT9VfiLNtRWmkvXiblqFaqWn1BigJU76Aw0vw==
X-Received: by 2002:a1f:600d:: with SMTP id u13mr12314394vkb.3.1599554467382;
        Tue, 08 Sep 2020 01:41:07 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id b62sm20892vkg.29.2020.09.08.01.41.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 01:41:06 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id c127so2835686vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:41:06 -0700 (PDT)
X-Received: by 2002:a05:6102:150:: with SMTP id a16mr12591106vsr.99.1599554465860;
 Tue, 08 Sep 2020 01:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJht_EOu8GKvdTAeF_rHsaKu7iYOmW8C64bQA21bgKuiANE5Zw@mail.gmail.com>
 <CAJht_EP=g02o2ygihNo=EWd1OuL3HSjmhqgGiwUGrMde=urSUA@mail.gmail.com>
 <CA+FuTSdm35x9nA259JgOWcCWJto9MVMHGGgamPPsgnpsTmPO8g@mail.gmail.com> <CAJht_EPEqUMXNdQLL9d5OtzbZ92Jms7nSUR8bS+cw2Ah5mv6cQ@mail.gmail.com>
In-Reply-To: <CAJht_EPEqUMXNdQLL9d5OtzbZ92Jms7nSUR8bS+cw2Ah5mv6cQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Sep 2020 10:40:28 +0200
X-Gmail-Original-Message-ID: <CA+FuTSeJS22R2VYSzcEVvXiUhX79RYE0o3G6V3NKGzQ4UGaJQg@mail.gmail.com>
Message-ID: <CA+FuTSeJS22R2VYSzcEVvXiUhX79RYE0o3G6V3NKGzQ4UGaJQg@mail.gmail.com>
Subject: Re: Question about dev_validate_header used in af_packet.c
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 11:17 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Mon, Sep 7, 2020 at 2:06 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > The CAP_SYS_RAWIO exception indeed was requested to be able to
> > purposely test devices against bad inputs. The gmane link
> > unfortunately no longer works, but this was the discussion thread:
> > https://www.mail-archive.com/netdev@vger.kernel.org/msg99920.html
> >
> > It zeroes the packet up max_header_len to ensure that an unintentional
> > short packet will at least not result in reading undefined data. Now
> > that the dust has settled around the min_header_len/max_header_len
> > changes, maybe now is a good time to revisit removing that
> > CAP_SYS_RAWIO loophole.
>
> Thank you for your explanation! I can now understand the logic of
> dev_hard_header. Thanks!
>
> Do you mean we can now consider removing the ability to bypass the
> header_ops->validate check? That is what I am thinking about, too!
>
> I looked at the link you gave me. I see that Alan Cox wanted to keep
> the ability of intentionally feeding corrupt frames to drivers, to
> test whether drivers are able to handle incomplete headers. However, I
> think after we added the header validation in af_packet.c, drivers no
> longer need to ensure they can handle incomplete headers correctly
> (because this is already handled by us).

Which header validation are you referring to?

The intent is to bypass such validation to be able to test device
drivers. Note that removing that may cause someone's test to start
failing.

>  So there's no point in
> keeping the ability to test this, either.

I don't disagree in principle, but do note the failing tests. Bar any
strong reasons for change, I'd leave as is.
