Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB5EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EE120659
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBLNBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:01:13 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:01:13 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MzQwa-1jNdkF3YYa-00vQES for <linux-kernel@vger.kernel.org>; Wed, 12 Feb
 2020 14:01:12 +0100
Received: by mail-qk1-f172.google.com with SMTP id v195so1890123qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 05:01:11 -0800 (PST)
X-Gm-Message-State: APjAAAWYxoAgVe4EGlWCBafRiXrFmkjO4+vPF0Y1861O4+IghEAAjVao
        sZw7X7w+mgUdXhzN+cX37ZXRd6UGdbvO09a6hKM=
X-Google-Smtp-Source: APXvYqxHByksB/OA5CrKOk5X5B26sI8QE/r7mocG3I25JeBMPT+bIxUWncQXHdG5LiJDK03k8ShdLVkQl9lKxlxzfIA=
X-Received: by 2002:a05:620a:1530:: with SMTP id n16mr7359064qkk.394.1581512470542;
 Wed, 12 Feb 2020 05:01:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581497860.git.michal.simek@xilinx.com> <c3d70f467907944e2680678f8aacb6d04def3f20.1581497860.git.michal.simek@xilinx.com>
In-Reply-To: <c3d70f467907944e2680678f8aacb6d04def3f20.1581497860.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Feb 2020 14:00:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1r5SCc_Gi=ymN4ToRU08nx9omkJU3Xy9B2GoJF941vmg@mail.gmail.com>
Message-ID: <CAK8P3a1r5SCc_Gi=ymN4ToRU08nx9omkJU3Xy9B2GoJF941vmg@mail.gmail.com>
Subject: Re: [PATCH 06/10] microblaze: Add sync to tlb operations
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Oq6jga6yV9ysvhhVFtaBwPyTvW0Jf5zqbzK4EL55D7utvbUU6p7
 TNqAtybuBCDY5K3O3yQtTYUOORrRJAtbr8RkWFLZ8fX5cV9SUSSqzs//Dp72ZH+GKsAqgW+
 iEpyBfT+SP11UV/UDf7HYgfbN5RpJU6Ur6wZaImitAmiVIhjoJikS6+7qQ3y0g5PicKaA8T
 bEDXM2JJvgGL31rWEXISw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8u9BxQtmAo=:+4gkJ1F9EzTERp/fExiasm
 KZGig6+CInlI7Rm+9BK6TnF7rIxsOoYooHp/tlVsCG+xFqtkge5ny1hxTmiiNwubz2YgsWx3d
 iq4FrXNtiOkSpy1DXgqis9RAqfAQh/fO4Bjaw3T8SDr+twlxQdRKgsCKKGssXuXWvxn/z2Dx5
 5ec99IPJjTKNoOnHHoPlJdH+kexSmJAw+3W897qKyzGZQQKHBQYvFq1MZ5Un4DfbJkUvYlXb3
 Vn3QdAspEb+pmr20O18k3T5M6Iy1cOOkNvPDXyEzEHUsxvWqlXMLJ0EblROIQTq5o8HgrqqJ2
 xPW2kiXXGfOFhJ4CvlNACCIVZ89qutsMAdQbTm10n/TPfd41T8KjIiaOPJVGu+mhtYwemQn1u
 8c5KR7OtIlEKVAvXhyxDNu64xHOMOTO00xpDzoNzmH/Y661lIty/n3MO4wkiEqfm5LnKpt83N
 IvzkkyEfyPRqVJ3sVOALifwfQZhpDbCfEps5B1bGrgR5dN9oqw2326U9ADRPZ6Opi6othvWZ+
 clNcm3EkATBIgIQWUOoKaAZ+LdZ9f84dqyGGFdqShr38RHNyiVA/Litz5RMbISUNrHBRLoxfv
 B6aBEf8bJo3J0q1+fL0Q5KL4+bn83SOACeUir9IkycBn9afCk1ekA9VWsOivfHlKLzmUkIizu
 94ExUHMKAfcvtGlWgXM97xYjKM50dz0JPgnAw6Q6NKOQNhvaMm0COQ+5/pVQy7Z6QsTopVr/S
 I1n5oUvygyaOMYDa4yvwZKCfiEvDQIefd1jC+bK66rknqsfkcEAoGIcqETngB2nXzbR5IGuS+
 PwbXRFgIEA7szK5k97P3mYVWWPq9dYYqWfY8aBNMY8nEE2fqpc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 9:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
> diff --git a/arch/microblaze/kernel/misc.S b/arch/microblaze/kernel/misc.S
> index 6759af688451..1228a09d8109 100644
> --- a/arch/microblaze/kernel/misc.S
> +++ b/arch/microblaze/kernel/misc.S
> @@ -39,7 +39,7 @@ _tlbia_1:
>         rsubi   r11, r12, MICROBLAZE_TLB_SIZE - 1
>         bneid   r11, _tlbia_1 /* loop for all entries */
>         addik   r12, r12, 1
> -       /* sync */
> +       mbar    1 /* sync */
>         rtsd    r15, 8
>         nop
>         .size  _tlbia, . - _tlbia

Is there any effect on non-SMP systems?

     Arnd
