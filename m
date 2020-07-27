Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC59C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D3720663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgG0MdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:33:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgG0MdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:33:21 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M89P1-1jvNcB0l5X-005GPJ for <linux-kernel@vger.kernel.org>; Mon, 27 Jul
 2020 14:33:20 +0200
Received: by mail-qk1-f176.google.com with SMTP id b79so14969284qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:33:20 -0700 (PDT)
X-Gm-Message-State: AOAM531pOCX9l+ufy7hELAGDP4IX4txvqMLlhyjRcXQOQLBLOUDurgAe
        RPZrsrWksedSH0+ml4cIFZ+3tCZ6yIMwu6Ws/yo=
X-Google-Smtp-Source: ABdhPJw68VCiW/DLtcLu54gOPUDyNjx9WjqRGVPgaVxT5FTBfLZHpsK5EK0oQPC06J4wwQ7/UDL2L/aUU5eRdI+1QIg=
X-Received: by 2002:a37:b484:: with SMTP id d126mr22577670qkf.394.1595853199094;
 Mon, 27 Jul 2020 05:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200726043948.1357573-1-daniel@0x0f.com>
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 14:33:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0K6LmNkGPdKeBcFTgi5wJz8T0rzO=Kg2Fmz=NtyFWAfQ@mail.gmail.com>
Message-ID: <CAK8P3a0K6LmNkGPdKeBcFTgi5wJz8T0rzO=Kg2Fmz=NtyFWAfQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] ARM:mstar: DT filling out
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:g89A2meFQUYj24PvclTBRpwayZ/OpuSy/06YpEvZClzaEjyKDBp
 0OYxzttfDc68F7fw5L4zLJAklMox2GUD2mWj5DqGb7sQUsckXJZVxsHITvT1wKzGMa0tQ4x
 7gTZjjlNXp6o1ciEfZGNkZzUcSBLvp6WgbbjN8ycbXovKtfPaZ3MTjqnhdEiIXZdLJMzx15
 Ll6Eg9ay7oeCOPsnRPF9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mcHDhi9sHiY=:tzHKnbEQffvQcxcSGgmLGn
 wAIfTEy0+lFW/6oTXYZNf3cPKSVasKptq0/PcbXXtTzm58OzAbaPsMlOc+TDfdZoTSKCYVBnK
 IW+e5N5/yrBpyj6vaWZSQ1/fpEVRKREKX5othN5jw9ICL3qvfL2x7nfCDWU/6K62DhlE07eDk
 ZMYDrVi5AeH4nMAkBu1wT8oQSqsh9ddz/FFRSYSv2YB9cBL13I24CLdvZVm6JjgVtLj2t+LEi
 5e+a3gj1+SIU1dcaN78TAZ+CoeXYjvbDplTUUC0fUHOR5j1RkdbEuTYIz6psR9XzM614TlCIk
 1nlL8IhzKSEt7QM37ZSAVvXPxbwtg9K4YLQOeV23lSXkj/oPYEhZ81FGSRT92Z0VOe7njyrz2
 mGTjA6mFzDHUB7PDZpP5GvNDf5CP3BQj+iBRatH2tnEZb1SifrgLTxKRMKBHPi6QiDbGo6i33
 dBRLfcuVg8ucdaSltuS9p/UbFrrY8D+0jPxUqJEwwhGiBFgPFrQ/E7rqGaN6JHPWVWjSuFGSi
 9HklBrvzgo583rTbBKVvz/YAfRzU84UDZn4YyRN6kxgCZOxQ/dunIUoQYqQVxOGFRq2ZdYqoR
 2gVkeA/J08dzJVbv0wWdemenhxl2tI7H5SF19pUwAMjRCrLNKjiqTwz4D74oHz+p5rVgk1En/
 x76szKxBdc+ho8GGXlrEem+mct30QSKfH8U5xdwYYiYIDFalppk12Ejif24WbmhIO8YSeXevF
 R0C7d9keQSbIkjOAPQDGW9H6Sh2Ze4y7dT4n7D02qd7rBt6wv4C2hyAYmWgw72bYCBgBhIW6b
 wOWq72Gfeao4hdBG3HgNaB4thX6byEQ1FIYWUqUPFLU4d94DUFimejWlRDoNXJD+DX2yzfU6L
 XpvKasMTmdivvdO6zMGZz8Poo2s7XIr9YAX92PUJTtLmYBnu3IWEAIwAmxJ5WAw0XXz4hSfWI
 PesalNsa4mQjmWnf86ronZ/4MkconjOutMRv400UMshs2wczPwe2f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 6:39 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> This series adds a few low hanging fruit that are purely DT changes to
> keep the ball rolling while I work on series for more complicated things
> like the interrupt controllers.
>
> Summary of changes:
>
> - Adds the IMI SRAM region and sets the right size for each family
> - Adds the ARM PMU
> - Adds a syscon for a lump of registers called "pmsleep"
> - Uses the pmsleep syscon to enable reboot

I had one comment for the last commit in this list and have therefore
not applied the series (yet).

I also noticed that the subject lines are slightly inconsistent, please
add  a space between "ARM:" and "mstar:" as you did for the first
set of patches.

      Arnd
