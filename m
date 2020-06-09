Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE35E20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgFIOW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:22:57 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgFIOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:22:56 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MowSu-1j9t9G2UcY-00qT1I for <linux-kernel@vger.kernel.org>; Tue, 09 Jun
 2020 16:22:52 +0200
Received: by mail-qv1-f50.google.com with SMTP id ec10so10148765qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:22:52 -0700 (PDT)
X-Gm-Message-State: AOAM532/5D1xi6PARJUidZLITM3bep6H9HVKKlJUVeInJFHfQiw7kkKs
        TeZK3FtinAfi63RbrLEO4hXR46ksyBr4vXCxYpM=
X-Google-Smtp-Source: ABdhPJzx+z0bcXYPuVlwRHOD6yM3S4Ldg2eDOed2FGAJyrwsRqttQVklksdSbVPsCNsJw/sXsvOlcAmaM4SRPmpBk0o=
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr3849476qvw.211.1591712571533;
 Tue, 09 Jun 2020 07:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc> <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc> <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc> <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
 <20200608111834.GB5736@afzalpc> <CAK8P3a1q51=_DUS1A8k67c3TyQ+7LTpeo98LmzoFK=qg+8Fktw@mail.gmail.com>
 <20200608151727.GA5017@afzalpc> <20200609121506.GA7846@afzalpc>
In-Reply-To: <20200609121506.GA7846@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Jun 2020 16:22:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2YKifKbt4-CUODe4YYPxT-+pRwkj0BAvbw1P8vUg9x1A@mail.gmail.com>
Message-ID: <CAK8P3a2YKifKbt4-CUODe4YYPxT-+pRwkj0BAvbw1P8vUg9x1A@mail.gmail.com>
Subject: Re: ARM: vmsplit 4g/4g
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dYKT4xLZJZzUO8UrZZkxtVwWMkYUu72Ces2H0O/ea5kH26b5FtR
 /unv/1zrXT3kyKLS0J287yhzxa+ByK9PTMR8hmSupj386h+30jEYvOn34tKlRhNuaLY4FhM
 ascVsWdQ0RScJrvw//1anza1z7NJlekYUQj0DrXlIayLG0l+SaeHobj6+rdxRdkeI9jY2U+
 kaMUF+dEGfOC1gqGLJjaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:phX8Nb+0Bg0=:fwxf5ymuX67quHzFmeQUDa
 0PfY1J6frCXXv+o+OQgC0xqBhGHju5jy41uFz8YmaD8T0wpfqUGSq/l0CI3Er1oxwspP4vjL7
 3Spmr4evB5pnNr37wDxngJmAsXldNJShQEpGuOLT0ptHv5gpKRgusHgMjdjwEOt+vWlfhBjIy
 Nqms7sWUXfZm3K6wAdp/Ix1AQK2kTb0qfhsKh8QvVXV2x/kpzTrO7CWU+EnmvLGw/dibGm0G/
 qifaX8EWzYQ4GHOKLX1rZ5PqNPxvxwGb5u4R0Pq9zAe53abXjvcF+1uz87F5OH4teFEH7D0Or
 Ha01c6ql3PG603llV3va0K8a/OT/u6mGqaSbKJWXzcqGYHMtCycIcs6Eu4/Dj4k3Eknx2Q4kK
 5ACf5dPazPtxAHdHeRAXkz/EQrdZV0kzMCs2rftInLZz5JbxcW2g1vyu2EsC4Db2SE2tBWDGh
 ZcvEzR7psjltiXithikChKkQERDJVz/5sxngVLKBdQvLkc72Gu6i9/226B/D3+TIgsWFpDIe1
 y9I/h2nKV5em18zPh9pyO+JAVlNtQyHOVAKQ2RWq/u8wJeGIGjE/UVtIaqcSAsMF4eF5AGSV6
 oZ92nTmMryFaYyhPoEEM0lSmQ/FXVnkWiVeZAhDA0rPzIeNlwuVNe/6/EGvEobDTmDkdCOV9x
 e8E63uJLhFKKPJur6+7YhdhC6SSLw4BZ6WjqWl5MeToBxLmKkPADITX7Ax4P3kTlJI0qGj+Af
 Pmqmcg/mNEINnr5Op+EWuuU+6+C+Qsmg86bfPRK4rHvY/0lz4hs9wdutZg3+nmKj68+mnh3De
 eU03Oz/N1+veqONrNaAMOulZaEdfDNBBDfMM9kR8X7fpEbnqHg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 2:15 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Mon, Jun 08, 2020 at 08:47:27PM +0530, afzal mohammed wrote:
> > On Mon, Jun 08, 2020 at 04:43:57PM +0200, Arnd Bergmann wrote:
>
> > > There is another difference: get_user_pages_fast() does not return
> > > a  vm_area_struct pointer, which is where you would check the access
> > > permissions. I suppose those pointers could not be returned to callers
> > > that don't already hold the mmap_sem.
> >
> > Ok, thanks for the details, i need to familiarize better with mm.
>
> i was & now more confused w.r.t checking access permission using
> vm_area_struct to deny write on a read only user page.
>
> i have been using get_user_pages_fast() w/ FOLL_WRITE in copy_to_user.
> Isn't that sufficient ?, afaiu, get_user_pages_fast() will ensure that
> w/ FOLL_WRITE, pte has write permission, else no struct page * is
> handed back to the caller.

Ah, that does make a lot of sense, I had just never used that flag
myself so I wasn't aware of this.

> Am i missing something or wrong in the analysis ?

As far as I can tell, you are absolutely right, and get_user_pages_fast()
is the best way to handle this correctly and efficiently.

      Arnd
