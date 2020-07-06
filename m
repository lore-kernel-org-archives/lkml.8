Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E81C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252BD206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9EoK0fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgGFO7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgGFO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:59:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E32C061755;
        Mon,  6 Jul 2020 07:59:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t18so19051816otq.5;
        Mon, 06 Jul 2020 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ly03rVdFQZQZEzVS8ZzCtaoVt13O7+0BUw8XNPJWMK8=;
        b=R9EoK0fa9Z++JThkR5FKP1qYU/9TIgD3WeTrbgZFENW7JFTScXN/gLqD9Rv/AwIzKJ
         KUykzhblpZLE1bmkyp8UAYL5rwIghmE5Ql5df4hd389nsT6e13JxsySDzLto/UmqOjL0
         Wk4RyMWs67rwheZnSxcr/c2b8NDQCH+fQOrgK0Iji/m8bFJcMYbiYhcGX6jMdt//6PKZ
         xhSe3iwCCF6mN7b68mXkFhrFd045gJhNcpohEYlAo2do6v+YYY/G61UL6ruqsbSH/AEC
         qUkdqIohw0iH+a4bXaLYW95RtIKbwWLrUm6XuQtu0SDUtrvPp9NC6VRo2PE5xP439i9X
         WAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ly03rVdFQZQZEzVS8ZzCtaoVt13O7+0BUw8XNPJWMK8=;
        b=rZDMyhGpm5E9efNNLz8HyR6Irk3y9ltxtoRkwytCcZF/bu+Qyt2yat7LpCcna2XQNe
         OIXtvCPumCGVoHB2zUl2xTROBLsX+zccpMImYvYmZC7CiO411EAIgxooPyNwUss72slY
         7qFJLXmZMRRNQyPrwjvqvbgZhmrCa1yXpqI+qV4pVYcxIqYaNCeFG3eWQxAsIjR/CawP
         EEtzpJESC++WpTQxzehPM2r0L+d95LVv6qvnEpirYqXqQgijHwummDqC7YK7a9rI+6aD
         J+EmHgzLlNIOYTUQq2TlFpxPA0fJ6iwkeDKPTAfLlHy8MhYNMm7fLPSxHGu8rx+GyWdy
         ZDAw==
X-Gm-Message-State: AOAM532WeoD9h57XqEbboq0ctqS2iF9cNnkgi+BzgHhz1lfu2wonPX/Z
        8jnrcLRzhKnqHSC2/y/zTkcUdhMPsRwXBESdmno=
X-Google-Smtp-Source: ABdhPJx6HvqkKPk89a4sqbpGujQgm6H45OJwozxgw+lVqfKgYNdzjqzfMw1NP4lEXKSBrFeezzESieFNYIvIKLSWIB8=
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr32125945otr.116.1594047585387;
 Mon, 06 Jul 2020 07:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200702175352.19223-1-TheSven73@gmail.com> <20200702175352.19223-3-TheSven73@gmail.com>
 <CAOMZO5DxUeXH8ZYxmKynA7xO3uF6SP_Kt-g=8MPgsF7tqkRvAA@mail.gmail.com>
 <CAGngYiXGXDqCZeJme026uz5FjU56UojmQFFiJ5_CZ_AywdQiEw@mail.gmail.com>
 <AM6PR0402MB360781DA3F738C2DF445E821FF680@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiWc8rNVEPC-8GK1yH4zXx7tgR9gseYaopu9GWDnSG1oyg@mail.gmail.com>
 <AM6PR0402MB36073F63D2DE2646B4F71081FF690@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5ATv9o197pH4O-7DV-ftsP7gGVuF1+r-sGd2j44x+n-Ug@mail.gmail.com> <CAGngYiVeNQits4CXiXmN2ZBWyoN32zqUYtaxKCqwtKztm-Ky8A@mail.gmail.com>
In-Reply-To: <CAGngYiVeNQits4CXiXmN2ZBWyoN32zqUYtaxKCqwtKztm-Ky8A@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 6 Jul 2020 10:59:34 -0400
Message-ID: <CAGngYiX9Hx413BX-rgaaUjD9umS9hGg=gMLbM+QmdyEt2Nut5A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v5 3/3] ARM: imx6plus: optionally enable
 internal routing of clk_enet_ref
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andy Duan <fugang.duan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 10:58 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Hi Fabio,
>
> On Mon, Jul 6, 2020 at 9:46 AM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Would it make sense to use compatible = "mmio-mux"; like we do on
> > imx7s, imx6qdl.dtsi and imx8mq.dtsi?
>
> Maybe "fixed-mmio-clock" is a better candidate ?

Actually no, the mmio memory there only controls the frequency...

I don't think the clock framework has a ready-made abstraction
suitable for a GPR clock mux yet?
