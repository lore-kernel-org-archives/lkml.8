Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD7520882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAUKOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:14:08 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:45691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:14:08 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQuLB-1jEPfd42tT-00Nvvu for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 11:14:07 +0100
Received: by mail-qv1-f53.google.com with SMTP id y8so1161632qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 02:14:06 -0800 (PST)
X-Gm-Message-State: APjAAAUj8RLkfXzoadJLiG5zQFf5w95fsf51lS2Bx7wNp2gmG7EAqxnb
        +mqflYHocKsqkppRTu5Lda8h9dRvJud0gxXScMc=
X-Google-Smtp-Source: APXvYqwfwCFea1IWv9LIK/SM8f8WXdlKMOlTnsHlnRMXe9L0NQXcEkNBWRfAaf0eq0AWZ6EaBabUhBmdmUjx2VZ3f3s=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr3979167qvg.197.1579601645899;
 Tue, 21 Jan 2020 02:14:05 -0800 (PST)
MIME-Version: 1.0
References: <1579596599-258299-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAK8P3a0LJETeKbQvs-EeQ1cF84gVO3JS75SOZYD0F+puWhi9=w@mail.gmail.com> <37f03cf9-5666-7561-13f6-2ff72e936b7a@linux.alibaba.com>
In-Reply-To: <37f03cf9-5666-7561-13f6-2ff72e936b7a@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 11:13:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2u5maFAB_tFX+3BdZFgPFqdKhDPNAuQrsjfVc3wzSYdg@mail.gmail.com>
Message-ID: <CAK8P3a2u5maFAB_tFX+3BdZFgPFqdKhDPNAuQrsjfVc3wzSYdg@mail.gmail.com>
Subject: Re: [PATCH] pcmcia/cm4000: remove useless variable tmp
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Harald Welte <laforge@gnumonks.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t9Z5y7AtUl8d/yB569Wk5NHQ8AD1EeBWrURBLOL/AqdLfguzNyp
 TzGcSt/bEQ18HI1YQ/ugV7Moci6pnAYztCuBB0qmbsvK6JCHi6ezOgqF/PLuH6vBUOYMEui
 iJ6uQn/MhEhGEVuPpB8UxFPsBPtWEKlCXCbKJT3fnTsPZP6Tcn9ON/60BJ6XgpC+KM5r0LX
 2QlL765PoUGwz8ej1kI6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fSfuhm00C90=:grRjbDsin1eJv9oxIoCFcd
 rvGh6oIMBw0hY2lux8MyRzYCSktGfsgXw4wqFfaGm2xi6J33iS5SxNdPh+7oTxo63E0Z1b3TL
 8M3aLT7gFmBwWvRpczh6aGvRRGUZkjQGE5To5KvFX+JQyueHr34y216y0j5KGsnpvYUpvpq7E
 rRZYHzfsUEAgqnBk/Q3/uf75gGEqR8LOzMuDvCK0+c3rfsDGH0olOi5BLURaFUET14xvKelGm
 z19X3q7wSrze8cEvi5HfdLrr5xvVzZnWP2CY8mC0fOxtyQjd5HPjcRfdH81r/KfM5frqkf386
 GsCyVes5AUWmVwhhRXJDwiHwMY4g15cmW2E2YdjN3qS2hVOPpch+jbfbph8cGC1NFxGNmjKrl
 gUGw8QHYXVJiJFLrnYZuuFda9vI3mMPjhVASPzOI8YFgKasblqffhxLwl3rHgCpe26Ox+GR0W
 UaMpEGGiGySvYS3/1+S5U48FU47N7P25sAi7RKskT7MWZx8gz2CLn659wbnjwtggysTirfjtN
 CY7iNvT61Stx1FZeOA29nPhK29HjTZIHbe8cCakoTbZIt0J3MrirDmRZERo92LQN1HHe8L4ai
 HVZvZH0C51j12BAjBxtWCFBaj90LU4z5Gnq4T//hLXBO8KUWr67hTYUupJhZ1aHBLlxgRCQvt
 nU21OaehaGCwyudMIrqIGi0BP93nW5L2E//7FyuINefSJKvGIVEbXdEJU15gusn/GbEXBxPBu
 LTdJUtUISXbuf9sF83WjmEzvgsIPbApgCAkASOJjMSW6NMqAkc7vh4k1iLv87n1oTHuH7nWUE
 8QooNv8evtG6lPFY6SITJz8x34fSYFbtdgdFgdJGXSjfhBHcrvwBZ0oksJhwnCzBckxdIE39G
 1qKz0aKk/UvfUlQirT7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 10:55 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:

>
> From 9e54770c6911ae7da7d2f74774bbef019e459bc9 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Fri, 17 Jan 2020 09:10:47 +0800
> Subject: [PATCH v2] pcmcia/cm4000: remove useless variable tmp
>
> No one care the value of 'tmp' in func cmm_write. better to remove it.
>
> Arnd Bergmann pointed just remove may cause warning in some arch where
> inb is macro, and suggest add a cast '(void)' for this. Thanks!
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Harald Welte <laforge@gnumonks.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
