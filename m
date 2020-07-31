Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D2CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D2D20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJtMgGbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgGaAZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbgGaAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:24:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:24:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so27352158qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCnm2zhl1XL25GtJr/etbA3HQMGW2EG8k+e5UYsAJpw=;
        b=lJtMgGbhxO85pPQ3zmFyvT81x30eZCJUjTqGcbLx9wGlUYe1jJjdPY6ReHw6gFzteV
         PGVcl91LOUNhqC6ggzpRMQ6AloWyvYhtERJOjsT7jyjSwQaTtyqF3aHUeBUqvy/VXOBh
         oblTtIls0ssqkEbpSn4i+FQqshusH5TL4zGs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCnm2zhl1XL25GtJr/etbA3HQMGW2EG8k+e5UYsAJpw=;
        b=DQ5B68/QCIYMFX1nTdNycFg8P3PpbGCpkLG035h7xQX7X6SN0kPId0BT429iZDcitx
         VU7LqnULSjhL2Bl6BvwsY5sytShfjCANc24QWqb3zObcDiuWY3tP0fyq1DXA+4vva/FR
         aEjIx0Ol5wRirFFIMwBxyxcm2syu5AFqeUaEvfGpTiF7foEywe0//KEtrbUi1QTUScXy
         EPUCQ+l3OkZG90uNH7yGq4e8OAz2K/ZzD3YnYDo3798aF7hJceiWKCkaXZ5+/FWFufQk
         hssNb5Ukp+wESR5rw3uHky4nvn3i5s8F6qoOCf3SIfXdJxpqnaMMRoPvbSuE8hL8na/r
         ADAg==
X-Gm-Message-State: AOAM532q5Trq6xAakqhPOgo/kKMd04/1CO/Xul1uT4TV8ycjJeHyVj7c
        wjO67kd6KbcPx32orU06WgepwCpFgOo=
X-Google-Smtp-Source: ABdhPJyIL0MTtcaUNdK2wd95mOUnQjo/jghgD2yDkNb9rtCd4WvmWlGE+97mDfAOgnF+j1dKLYW2Qw==
X-Received: by 2002:a37:8107:: with SMTP id c7mr1774643qkd.22.1596155081528;
        Thu, 30 Jul 2020 17:24:41 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id n184sm5926168qkn.49.2020.07.30.17.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 17:24:40 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id h7so27357831qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:24:39 -0700 (PDT)
X-Received: by 2002:a05:620a:3de:: with SMTP id r30mr1567282qkm.221.1596155079426;
 Thu, 30 Jul 2020 17:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200726110524.151957-1-xie.he.0141@gmail.com>
 <20200728195246.GA482576@google.com> <CAJht_EOcRx=J5PiZwsSh+0Yb0=QJFahqxVbeMgFbSxh+cNZLew@mail.gmail.com>
In-Reply-To: <CAJht_EOcRx=J5PiZwsSh+0Yb0=QJFahqxVbeMgFbSxh+cNZLew@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 30 Jul 2020 17:24:27 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPRLqq=vxnkF4z8=xvuqOKuuoqifvsNsERWg9uYJrFXgg@mail.gmail.com>
Message-ID: <CA+ASDXPRLqq=vxnkF4z8=xvuqOKuuoqifvsNsERWg9uYJrFXgg@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 6:42 PM Xie He <xie.he.0141@gmail.com> wrote:
> On Tue, Jul 28, 2020 at 12:52 PM -0700
> Brian Norris <briannorris@chromium.org> wrote:
> > What is the intention with this X25 protocol? I guess the headers added
> > in lapbeth_data_transmit() are supposed to be "invisible", as with this
> > note in af_packet.c?
...
> This driver is not intended to be used with IPv4 or IPv6 protocols,
> but is intended to be used with a special "X.25" protocol. That's the
> reason the device type is ARPHRD_X25. I used "grep" in the X.25
> network layer code (net/x25) and I found there's nowhere
> "dev_hard_header" is called. I also used "grep" in all the X.25

That well could just be a bug in net/x25/. But from context, it does
appear that X.25 does not intend to expose its headers to higher
layers.

> drivers in the kernel (lapbether.c, x25_asy.c, hdlc_x25.c under
> drivers/net/wan) and I found no driver implemented "header_ops". So I
> think the X.25 networking code doesn't expect any header visible
> outside of the device driver, and X.25 drivers should make their
> headers invisible outside of them.
>
> So I think hard_header_len should be 0 for all X.25 drivers, so that
> they can be used correctly with af_packet.c.
>
> I don't know if this sounds plausible to you. If it does, could you
> please let me have your name in a "Reviewed_by" tag. It would be of
> great help to have your support. Thanks!

Sure, I can do that:

Reviewed-by: Brian Norris <briannorris@chromium.org>

I guess x25 is basically an abandoned project, if you're coming to me for this?
