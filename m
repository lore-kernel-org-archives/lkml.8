Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CACEC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1246E206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgG1JYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:24:00 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgG1JYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:24:00 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Myb8N-1kiyLD2Otx-00z2AA; Tue, 28 Jul 2020 11:23:58 +0200
Received: by mail-qv1-f45.google.com with SMTP id dd12so3777896qvb.0;
        Tue, 28 Jul 2020 02:23:58 -0700 (PDT)
X-Gm-Message-State: AOAM532ancdsF8O+eUZUolKPI+4PsKQlGMLclN970tmTI322SMuRulJC
        qTtBK6EGi4SVIAD1hQUafF+3eKXUYbzcYKNM9TU=
X-Google-Smtp-Source: ABdhPJyY5Q9YF6qsl1doujpdYwMBK7La+ynGinP4gHSEUg3Rs82Sos0oP8DFnoxwbNLsN8yHoIHyeunOsCZlbtfrFYE=
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr25230932qvb.210.1595928237439;
 Tue, 28 Jul 2020 02:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200727112236.8199-1-lars.povlsen@microchip.com>
 <CAK8P3a3WJTKH7-KGgp7CuhZv_wtrtY1k+1LEL-62_Rj+wqbrGQ@mail.gmail.com>
 <159587873833.1360974.11729154337431621644@swboyd.mtv.corp.google.com>
 <CAK8P3a27u7UkjGJ32KsRp02FoF34mKW0gRUsms0+YBkxy+L4Gg@mail.gmail.com> <159588781925.1360974.3928941757935200801@swboyd.mtv.corp.google.com>
In-Reply-To: <159588781925.1360974.3928941757935200801@swboyd.mtv.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jul 2020 11:23:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2io+cn0phoGDfpNvp-2gOXDaKyi8Me3Pz0k+VjbmwGFw@mail.gmail.com>
Message-ID: <CAK8P3a2io+cn0phoGDfpNvp-2gOXDaKyi8Me3Pz0k+VjbmwGFw@mail.gmail.com>
Subject: Re: [PATCH linux-next] clk: sparx5: Review changes
To:     Stephen Boyd <sboyd@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Tb5GqJwpfhoqCjuha1/jrkVvJhy4nuhwxSAyyqaq7F6ZHdYxjzv
 Z7V7BI0re5wVGZ4hKSTirUAsmjuRdh3jbk3RrvD6WKBCZRc1/2MFdkvdlWzr3NaPMblUqHN
 QOVUaExKsDsp0mBMc9U5ZecHUjAhluKBqn3S1nIaeEe9GFSxTo3buyQRlqLM//ZQTxSCUCZ
 9XyjpQ6iAq1hbUCVTYaNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ftN3itrlhQU=:KZprfiOIusr84C7rdb+veA
 HZfPqTYpaf7042b3oPgDLR7ix88GX8pBhvAxT7D0c/C8Ft2yEmkDTnemrnQqe+bgOIDlkDLLk
 PAx6iLpDuBc9Ru6AuESO0ytLV4k9NCuQ0dcy7lx6euvoUvel+0lo5zhcL9X3Gnd5Qhn6rmPMj
 KzYmbwsKsE3WsMjSwyBg2afBghLUe+MW14clnphmYSI6QUDhDAKXmyFL36bgoKwL0BKq30+Za
 96QQNoLCcyPaWlH17JWpGHBFNSno4EC2xnxoxRYHzzxnKBXx+A5u0aPRjGIDabWX1w7ucTmFe
 HxDNprSPkU5FbnsCnqXcB3TuJS5t8Spgbs3r9q1jTKlueNAy7ze8Jzx5m0imHLa3lfngDIRHz
 i3sSx8K9gnCVUuICSMFiauAhFRDRVNdZf+vS30UqYJ6iHZuDQMtQrzOHqsVSuZz/Dd800JA0y
 AKAGwnp+LXk3YHyfOboEs1GnnZNB2eCEv3wb2u5p1+S1MQOyXlqB2nhGwpajj9AVCm7S3BRCf
 JS9XyI6UUqZGdstF2vjsicqbPWwyZPhs3GCsTp0CYo3vhkGzlEH5JnFZy3htm1OpQ8rU8z5Bt
 yR2V+E0N4xF6U08J79VdbOc2PcOcG+0su6+okJ3JcaLmGFIrtspNsh0mMBrhgLS+VZ5/j5OkN
 BlumpI7cW0yVH46sFOZK+ux5XRWCOK/58h6iYL1U1RgdR92K0bPuyfMD4TtEuGacRry31Q+Xk
 IthdhNB+dTPZNC+661vKV2XFVr9cw0ahW/irCNJvpY4EqoyYJlVF0Cv4X7AKHvOI2E/fQoIAL
 8x+mHi/yOmAYvJvlmBuJwSX/9++bDxR/TznJ1pklpJMCs6w8p1VcFsYsbG/c6Xx35uuOIbplO
 3obt9ddTfEz7k07l6GRIztQDELNfsIeVg8NIpLgpKxfvkauPgJ8E9xjdDLaK8qO998axUMg/O
 4qyXk2V7egFV9k8PM6v3IBkRuI6lguxpKdDb+5nM3YU0tey0ndQsc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:10 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Arnd Bergmann (2020-07-27 13:11:49)
> > I rebased the 'arm/newsoc' branch the other day to fix another mistake,
> > so if you prefer, I can rebase it again and drop the clk driver or
> > all the sparx5 patches.
> >
>
> Yes, please just drop the clk driver and I can pick it up for the next
> merge window from the list and all the fixes can be rolled into one
> patch.

Done.

     Arnd
