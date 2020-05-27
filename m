Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD90207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbgE0Ogr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:36:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389152AbgE0Ogr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:36:47 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MwxNF-1ip7fK26qx-00ySSH for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 16:36:45 +0200
Received: by mail-qt1-f175.google.com with SMTP id j32so4369995qte.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:36:45 -0700 (PDT)
X-Gm-Message-State: AOAM532zAwiZbeCqmBTkRbMEC0HFf8QFQmLNJGUJN6cCdL8npzv4AGec
        Ftqlj04Bh2YscXQH5h/NMkrGcO0SHQ6UGQ4XfIs=
X-Google-Smtp-Source: ABdhPJz5OgKXuoYgmUdLE+csUDsEEOEF0XSfC8Ij+VwLLkemZAcY7xiTkXrFOUDNARvgard005IXgUtkM4rz7IvR6EA=
X-Received: by 2002:ac8:691:: with SMTP id f17mr4501313qth.204.1590590204402;
 Wed, 27 May 2020 07:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134254.854672-1-arnd@arndb.de> <CAKb7Uvhh2JKck524D9S14uNSLykFj+U48AgR+sd2uwchsH_wEQ@mail.gmail.com>
In-Reply-To: <CAKb7Uvhh2JKck524D9S14uNSLykFj+U48AgR+sd2uwchsH_wEQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 16:36:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3kRP6Sg-An5szsN=4Pv1OsG+-YQYa1wgxJCi1c+uedPw@mail.gmail.com>
Message-ID: <CAK8P3a3kRP6Sg-An5szsN=4Pv1OsG+-YQYa1wgxJCi1c+uedPw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] nouveau: add fbdev dependency
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IkTtRky3C2ijnqvAwwC/+tGbWXDIHPSww6i892k0Lnz51LcdXbh
 ZQdI0iNm4vgqvQ0o4RCc0LyWxF0ZuFHdEYmJn9aGPbOtfeNmgae2FIw6Q0IydcLcdjzPDc6
 Hm7LJt3ZT51zWo8Pu9BdpX3x6TgpASDhfAV7D+565LhFBx67r67kID0Is36fpWCOvuFiAtC
 t7FMGTDs3exdOLIxoNWAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZnalMiJdDrQ=:hqm6wrxMUmBXjlwTImbTVr
 R5eK6oRgBs7YRGHA21AWdAJ5ackmba4Ept/xwNYpoUZ8iRS9BA4MpPNZyFTBDRBq7aVFs6XwA
 mrcNosr3bOS7MwAcslCV2Uh37jhfyoBAI1AdtskxJsT+LzqnV5OBB+uOXGc9tKDHI795NSERa
 m6/xYdnyXmio8ZODvgxO0W9XD0r2yIrNHb5cnEdnqOzpyvvd9hLYKNmoHgiwLnibbAKDXlHxw
 LvfPqUFN3UfWOAcRDRYOkmBWepHgJycAG5iia6k5/DLkc5cIR32vCqVRXbdveLfaJNZ6v/UGs
 IJta6SQugFHzJcpY9BEFVoYhswzvn7E5msVXpIbnal2VHxq39KaCMvQTviihout8TLgfoch3U
 SD+uql5ymVGPGC7cWb3VYCS9FKeQGVY9Y2QonwoOL+e6xxkdNIKcyWg/dSSejS8Tt1FpMffr+
 gD6SWORbztUC+7ynurE6QtRFnr7fGr8JpsG5hCtW+1wcPBxlJVZ63fhPebWSOZufVk2991Fgx
 MdFPPDvpzgKf2pTVWKj/K52HBtXtNYM+ZxYIRX22u2Bjv9G+9odKOSPuwKnbQNBglKWV/ye13
 SrniUFa9tX1p9ImRzlVb4UsgLrKR0R/sEPqFPZAwXbDpY8Rolki96JzIhiP8SBDEzI+CqvRac
 r7HNFawN2ilA9GJ6hVzc2AwcLTX8VuMKtTAdVCP9gXrpYOKW4fnqBFDU6NnY0gbjs/zi3i8+G
 X/Vh36zKqcpPZh2/zWMhgkoGSIPO61ikeLmEDJe5tTUxnVvlhWTsc0UpzhjWC1a2qoznWpQvv
 fqwTUjZkk5gj0cMyEsNu1P5pcZn+/0VzKb9Mm5FuBNtmDfSMVo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 4:05 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> Isn't this already fixed by
>
> https://cgit.freedesktop.org/drm/drm/commit/?id=7dbbdd37f2ae7dd4175ba3f86f4335c463b18403

Ok, I see that fixes the link error, but I when I created my fix, that did
not seem like the correct solution because it reverts part of the original
patch without reverting the rest of it. Unfortunately there was no
changelog text in the first patch to explain why this is safe.

Could you double-check if the behavior is still correct after the two patches?

      Arnd
