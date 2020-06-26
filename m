Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16600C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AE6207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgFZOGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:06:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48993 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgFZOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:06:14 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MgNtR-1jCDeN2fbL-00hsyO for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:06:12 +0200
Received: by mail-qt1-f180.google.com with SMTP id u17so7539876qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:06:12 -0700 (PDT)
X-Gm-Message-State: AOAM531nnFjSP65XdBVG2C/cCtTWSkUr0NiSWSxbvnevLIk93ykEqleD
        5Tt63ulMNzUnNxLUelbuCEELMeezNvP0Ty10ExA=
X-Google-Smtp-Source: ABdhPJxNL7ZazavjDlpdOSqlMFRRcUi8X1RMq/i9YLK2M8N8CjIt4xWMpy7m2sYmwKmLBSKB/GNp1CrJHGh+Kx8dMys=
X-Received: by 2002:ac8:4507:: with SMTP id q7mr2917940qtn.142.1593180371532;
 Fri, 26 Jun 2020 07:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-3-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-3-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:05:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2dTo5G=rSGHgPjAeV=uGPQJAaZCreQA0pTUzqYJ88_Jw@mail.gmail.com>
Message-ID: <CAK8P3a2dTo5G=rSGHgPjAeV=uGPQJAaZCreQA0pTUzqYJ88_Jw@mail.gmail.com>
Subject: Re: [PATCH 02/10] misc: ti-st: st_core: Tidy-up bespoke commentry
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavan Savoy <pavan_savoy@ti.com>,
        Naveen Jain <naveen_jain@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sTG9Wus44eU+jqq+GzFKjBXZCCbTHuOnHMK2qqCQVZH88Phw7NL
 xagmw1EvAA3u6nTnY8H3YaJYKRekwRUKomo9idbmdLbswkzoKFCptMi2D20WcgsqdYbNr1R
 rjOt8WO/L2AjTrGJjf8UOROLVvncw0hQ3cEGPwaqNAzzwUaiECNqRKPSQUilydOr+pOSVk4
 e4JVvm1Shm1nWcULLDvZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Iozp8SeTswA=:Q5e30KZiXE04Nn7Rui6eQg
 GUnlIAU2QOZY3TyCdMWt1MKIPLU10SlaoIrLP3dLYS6m3o6q9/ruiSTbxkaZXxtld3X3aziGv
 boeyqrCvc8zbeD6mz3K2gZGrniDAyWM0kU5HgJtzC0nUkABGiZis7buhto/zscFzNkRLPypWt
 lempBaqe57icDwh3SHBgvLtuX5WyxCypwWrL7b0HEgsAHU/wQrlWMkiUFwK7ouFte2Port6/F
 j2JoKPjBWE39xBFQNj4Kq+9ySnMz8PZcdFslgmAq5XFe63yTuwsOKbH24zuvbaLpBPEgcyt6/
 0vzeMChy3tf6vlHeUG9D6kgIFU+nZdfD5cuJJ0xaXuECgFb6FOrhOswahPZuJvu8lDruWg0/8
 WsbtdJ94ejmgl9L2Wp81LoaxSe+7YvtTSHuNMT6AcCTLOc7U8n245NBaqUzCDV+mN/ZKeTYDq
 5HgwT3HWwUlAyMUfhydbcwj/uEijctO8Fuj/Ue0RyiPBtPz39HiDDjPR1SiOSEoQ1K0pvcfbU
 ofE7YqEgmVJy6LI5PGxHR6to8FxzGXuf9l1/hGYYKxen7PbGLqpxUBYMm9amF7/8WrZxdWCr2
 yj9zqZVMr0tgcp69xfaz7gH6Ar8FzuNVpIXuNkutVRsgwiEe2DgPptOH1YJoAttJl8xS/xmdf
 fSWwWJc4kkqZKouNfb1WZvDQMsby8jmmaz5lwmfZ+RHDe6FG/emE21qrJGl7Kxh1UywszJBh6
 xgRZ+9nBEQ1cTmfLwxt22Dde+/sOmKXoWl44En/EUHSxPo2BAz0por1rTIDw+8SpJ3hiIB3xX
 BuQ8FFE/xcOkZ7dpO7YiknCSWA8GicYlY0iXS/qRdKBdH5QBZ4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> If it's still in use and worth the effort, it sure looks like
> this driver could do with a good scrub (clean).
>
> This patch conserns itself with the non-standard comments located
> thoughout the file.
>
> It also fixes the following W=1 warnings by demoting the kerneldoc
> function headers to standard comments, since there doesn't appear
> to be a requirement for the function args to be documented:
>
>  drivers/misc/ti-st/st_core.c:132: warning: Function parameter or member 'st_gdata' not described in 'st_reg_complete'
>  drivers/misc/ti-st/st_core.c:132: warning: Function parameter or member 'err' not described in 'st_reg_complete'
>  drivers/misc/ti-st/st_core.c:197: warning: Function parameter or member 'st_gdata' not described in 'st_wakeup_ack'
>  drivers/misc/ti-st/st_core.c:197: warning: Function parameter or member 'cmd' not described in 'st_wakeup_ack'
>  drivers/misc/ti-st/st_core.c:226: warning: Function parameter or member 'disc_data' not described in 'st_int_recv'
>  drivers/misc/ti-st/st_core.c:226: warning: Function parameter or member 'data' not described in 'st_int_recv'
>  drivers/misc/ti-st/st_core.c:226: warning: Function parameter or member 'count' not described in 'st_int_recv'
>  drivers/misc/ti-st/st_core.c:387: warning: Function parameter or member 'st_gdata' not described in 'st_int_dequeue'
>  drivers/misc/ti-st/st_core.c:409: warning: Function parameter or member 'st_gdata' not described in 'st_int_enqueue'
>  drivers/misc/ti-st/st_core.c:409: warning: Function parameter or member 'skb' not described in 'st_int_enqueue'
>
> Cc: Pavan Savoy <pavan_savoy@ti.com>
> Cc: Naveen Jain <naveen_jain@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
