Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4DDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8A62075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGMSeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:34:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgGMSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:34:15 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MF35K-1k61dN2cJM-00FRyo for <linux-kernel@vger.kernel.org>; Mon, 13 Jul
 2020 20:34:13 +0200
Received: by mail-qv1-f54.google.com with SMTP id m8so6237035qvk.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:34:13 -0700 (PDT)
X-Gm-Message-State: AOAM532+DuFJX+FZuRho5+oX9Hb7gRcS7Gi7DGknWXzQbSgajzfp8+pJ
        GFgyqXN75zfPUPztSlfPUHOysMF0OtTqNp9SKIU=
X-Google-Smtp-Source: ABdhPJxGb/znMb0IbGhuXoPtV4w5UgK/vLzT0a4WgviWSzUTHKNunQGY9YLFWGeMHjXKEaltv2rs1SXe/AbyfDFawpg=
X-Received: by 2002:a05:6214:1926:: with SMTP id es6mr794660qvb.222.1594665252584;
 Mon, 13 Jul 2020 11:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200708183059.32352-1-rppt@kernel.org> <20200713170828.GA832959@kernel.org>
In-Reply-To: <20200713170828.GA832959@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jul 2020 20:33:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0puWPgD8DQbxxxS_dJrrEd5MqfUQJ+eKUs0jrXh4CfEA@mail.gmail.com>
Message-ID: <CAK8P3a0puWPgD8DQbxxxS_dJrrEd5MqfUQJ+eKUs0jrXh4CfEA@mail.gmail.com>
Subject: Re: [PATCH] arm: remove it8152 PCI controller driver
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qvSAErg3LFLaCRmzWocXn3pDUUAdbdG/PcOFWaKZCD1AcHuLR09
 em0+Aqv6aSHuqDOhhaBXuUyncyCmbhQ2WtQHoiiUzTvlMj8bB58L1xPZgvO2JAOApeYb4IB
 RIajfZocaORoEjRBdhu9pyjmDjpONIUJ1Mn2H38ZJDV1wvMZpM8qdjqGRosc0TtkRj7yQip
 ZvDt1TJMVKeIm+3+FL/lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WqkqbxDGLlI=:ZjDqoAQi2sXsvftq3MXF2C
 fvUzjB2ixtjTPrScO175XyG9b+/J8pvpZ9Pu1qTHGE3v8DviHIcbMxGL8qWn55VA+UMO/qsob
 SdRjSOz3yVrCB6jkwrBD1DrXf3qdhK6JVRfpfDRWJiCC3QZcm1F5c4LJ2LN9k/5se7g6MfWFp
 EBGKzgxm5LMeioxO9CfiguDFjubQIg1Q4QGU7KmpfWEpgupf572G3mzDZTbPMsWU0c7K8Yst4
 tdz9i24Gpo/Oc/+jH40NbR6fIidOQ76WnDqPsJa4kP06QQQxqLoO7NFG9iufCAVzZmm0AuC4R
 wgx+Vut4qjQoJ/xkx9uS2tFGFP/FQ5Wnz/d63oLAoj3gH7x9tMDFMrdXG1nCeLvUw++EvY4D2
 8kfRzS9eQjwFmEzXhI29ok7E1T9wbu1wISIzvxOQ7yoOCnQHuknDH2Q3DhONMpRv+b/9O5Ngv
 6a3Fst8G5a/uuAOiNuDcaOBuqd5ZWsa1/dXJv54pUi+Vp7r9WDiCdIgd3CYNONK68/s9IrFxa
 ijYqs/ED2aJkKXU4Qz9vwscl/eX3HVOgRWTJJSxOY5cWbTkQ7zq2KEe3Mr6xxji4iF/7JR/Zr
 A6CLpXNOn9LFeJqGTxo7jFJyPT1jDRUNeGV2OCbQlaWAAzxxh4VdBQrguI19F6o1/tv2Bzw0T
 K9s4bfCmVievQBlrcceJKtJ/xevX7WpwpsUhio/qnHnEByL5HUZ50uyXUhNejg5hxPg+neFl2
 Gzd1u2TFgrFH4xanyhEBNj0MqACrECiQ8X0etO/+7wyo0lFZXSrxYrRf2pdsFbSUDP6NEIUU6
 qwwy+R1az5mNru7wjPw6bPbBkQDOhabpnonltIYnKXNx2PTXd3uL+W1LE+2axTWmTHOlozkVq
 H52AeGPZlMFvyh3H6uHWVoT4W+E8Ligcn/WONK0hQDzTG3LRcRCqo8r3aBb18PlK8JzP119+r
 9+/NtkCyL4dD48rtMIemg1Dhu80r7S07NS+f2DSKrk1Ep2mbqaUxe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 7:08 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> Any comments?

Looks good to me. I actually have a similar patch in my backlog, but
I never got around to sending that, so let's take your version.

Acked-by: Arnd Bergmann <arnd@arndb.de>

>
> Shall I put it into the patch system or will it go via arm-soc tree?

I'd suggest the patch tracker, unless Russell wants me to pick it
up the in the soc tree instead.

       Arnd
