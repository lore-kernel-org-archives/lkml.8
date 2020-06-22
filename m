Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B0020776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgFVTaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:30:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38836 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgFVTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:30:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so3170972oti.5;
        Mon, 22 Jun 2020 12:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+m8WfznoPmZDhpXMJjjF8LFblQRh0TioPpDuSD1pp0=;
        b=cZ5nn/bPlQ38WJLE5/Lfh/ECMriNLGxHjekmOlqKxv8Ry4UtJtu0seF2jKgvE3AhSw
         dZ36TvvVExjo7D0f/2Cnypc+0X4n1yeWUniTCuEYFe3kp7w7OW+RI/Wia1RT+q134YdO
         KLEDJpdPkfGzmvaBxBaqXipjDcfcCL+nIP08vbPJQosUp6hbu/DG86ELHHsZtfObuHSN
         3OvWvXagIaafHyVw9oceZQCT6gtjLMwU4+mXk1Ui1pF+w+lYCHiQmEP80JFrLpkP8y8k
         fdL7PP9UafxBe+/gNSxuxyRfq6dKHBMBg2p7D83W/gjMXwZciFMgtphv8nrPnhZpA6sb
         zWHw==
X-Gm-Message-State: AOAM530p9ntLtAPouQiRpXWHRPq1+kMrY/jrD4gtP/pFYMgNjT/0NkUj
        XsEzolWI4wI+QD6lT4uo6QUyaJ9QJc3+ikqWegU=
X-Google-Smtp-Source: ABdhPJwRxDC7XKOX0GSqgJfIIpa4gxfZ9Mz9zJRml/UI6rLWqLBUvxcLJOOvgyLDgRj/WAdDU+2gFeYTFa4HV4iICjw=
X-Received: by 2002:a9d:62c2:: with SMTP id z2mr15002234otk.145.1592854250122;
 Mon, 22 Jun 2020 12:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <1591554886-21725-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8sMAkhLh9n7d=4QaNLDDJuExcu4ctWX2P1xH6Jqj-D3DA@mail.gmail.com>
In-Reply-To: <CA+V-a8sMAkhLh9n7d=4QaNLDDJuExcu4ctWX2P1xH6Jqj-D3DA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 21:30:38 +0200
Message-ID: <CAMuHMdVPcF4B8SiWPYuT2pRN5i_nn0n2tKrg8+y=XdhFkU-Vsw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add support for HiHope RZ/G2M[N] Rev.3.0/4.0
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Jun 22, 2020 at 7:52 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sun, Jun 7, 2020 at 7:35 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > This patch series adds supports for HiHope RZ/G2M[N] Rev.3.0/4.0
> > boards.
> >
> > Patches are based on top of renesas-arm-dt-for-v5.9 branch [1].
> >
> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (11):
> >   arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename
> >     HiHope RZ/G2M boards
> >   arm64: dts: renesas: r8a774b1-hihope-rzg2n[-ex]: Rename HiHope RZ/G2N
> >     boards
> >   arm64: dts: renesas: hihope-common: Separate out Rev.2.0 specific into
> >     hihope-common-rev2.dtsi file
> >   arm64: dts: renesas: Add HiHope RZ/G2M[N] Rev.3.0/4.0 specific into
> >     common file
> >   arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 main board support
> >   arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 sub board support
> >   arm64: dts: renesas: hihope-rzg2-ex: Separate out lvds specific nodes
> >     into common file
> >   arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 board with
> >     idk-1110wr display
> >   arm64: dts: renesas: Add HiHope RZ/G2N Rev.3.0/4.0 main board support
> >   arm64: dts: renesas: Add HiHope RZ/G2N Rev.3.0/4.0 sub board support
> >   arm64: dts: renesas: Add HiHope RZ/G2N Rev2.0/3.0/4.0 board with
> >     idk-1110wr display
> >
> Thank you for the Ack's for the above patches.
>
> I shall re-spin the new version fixing the comments. I am waiting for
> your feedback on patch 03/11.

I'm sorry, but what exactly is still unresolved for patch 03/11?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
