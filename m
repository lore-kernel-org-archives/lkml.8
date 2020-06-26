Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0A3207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgFZOGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:06:55 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgFZOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:06:54 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1My3In-1iuglu0PZ1-00zYPy for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:06:53 +0200
Received: by mail-qk1-f181.google.com with SMTP id l6so8839468qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:06:52 -0700 (PDT)
X-Gm-Message-State: AOAM533bjI4Zeox2P8E6bTXl3rqGGonr2ZmGaNZc6pnhkIu4nDup+wzQ
        7oFUbbiHq6xL+/2fdUt8DUuYTP+pszpCI5a7Mlk=
X-Google-Smtp-Source: ABdhPJzYcCAMbalkC4bEmdc6PI3qYo752wn5aOmuAao8QvJg/qIdGTqeLRGG60lgw22Pe/M5Pc/in9SVUk7XZJcoJHc=
X-Received: by 2002:a37:a282:: with SMTP id l124mr2729098qke.3.1593180412026;
 Fri, 26 Jun 2020 07:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-4-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-4-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:06:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19M5pW8R01Y-AKEikHfPV1_CFc6em3Sy=Z0FuSHwT9Hg@mail.gmail.com>
Message-ID: <CAK8P3a19M5pW8R01Y-AKEikHfPV1_CFc6em3Sy=Z0FuSHwT9Hg@mail.gmail.com>
Subject: Re: [PATCH 03/10] misc: ti-st: st_kim: Tidy-up bespoke commentry
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavan Savoy <pavan_savoy@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bmboruplK8qERrunEgryuKkwy3mRrBIlnAxwDgVowii3l6L9/60
 Mj31nPNITIgVl30WcdZG83elpNU9J60ELha+vKIiXPWx1O9VnkZj2rIJSaXx7R0V/Hkwv/d
 lB9GDCnzzny0vyggsltFDpe0SNx+5VSuYNkFA8X4Z5luPzMEIJY4I8CYPu7SZ7Flk9Cq9xc
 jmns3seSrnz4FlLicR91Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0fzR1ge7tEg=:CvTJPfDIBpfxQ+eb9Fmb46
 YtjZqUza5aNSSvGnD8yruA+gN8vsxIR+IXaAC+t+f76QWKR2EHSk8aKVFgQXNF157/gc+Fyg4
 kihs6z0EiQTH6ihFOMQxp2cQjOq65wnNDkzUNKo1SAr2eW8/Y+PZoBJFv6m6YJMZSQ8BnICok
 bg5ru5T/X/P2riHPz+X27EvwWlFHJUE2OdA9DWVC/BuVnOWS7zfd8/ttqlAIpoJcP/XREXBbu
 XftpSbWBHtWbt1Iw+ZfDzYEcJHb7Hyz6T783+VKdbvCbnuDw8G3F+cjVXUaXyQ1Mo+Mj12072
 WlsqnyJMshmgbEyaNNiRimhCGCw/G38DJxSGdA6/4DgL/ebAbr3+FEh+idDUuQ7sfllwsikpg
 CTN5w1rpwfs3EXs4k+GwjJLo1A9qDx0uvqaCFNtGgMpMFJFSicy6FFcDBj8dScbuDN+MavGoA
 Gcjinpj1BjrnL6hwiJtp9On45s+VJpXu/xrWJfQ66LIrtIC/RsXsBLokWilwji3Te38CmWaQ0
 5M5uC1OtAnuWIvygLTfBCou6lIUXsuoaweHk8MUtQxPKRj63u6/TcUNpyqR95Edi8/rZn3erE
 StZnXiHNZ7GP2G+tyLO3FGJvVTqGk86ZsPHZCbzGCDabi02DUnAeHyBxHPNyNTSf1/Yy6z5Mg
 Zkv+R6Y8nZXkuTnjsiEuC7OzHM0ta0j4RH3FLkoiK3UQTVppD9vXUU1zUuz6v/c16g0xKo55x
 2eNPEDZhWPk0+Lbix3AkRc/28N70eTEMWcNCnwiA9FZBKcpFj7UKApULETWfJVpoQPPlxCveE
 WWkUpzcB+3hoRvXolJdTKMWFNsRolYOzo6E/3jPW07TIAdX0ZA=
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
>  /drivers/misc/ti-st/st_kim.c:42: warning: Function parameter or member 'id' not described in 'st_get_plat_device'
>  /drivers/misc/ti-st/st_kim.c:53: warning: Function parameter or member 'kim_gdata' not described in 'validate_firmware_response'
>  /drivers/misc/ti-st/st_kim.c:126: warning: Function parameter or member 'kim_gdata' not described in 'kim_int_recv'
>  /drivers/misc/ti-st/st_kim.c:126: warning: Function parameter or member 'data' not described in 'kim_int_recv'
>  /drivers/misc/ti-st/st_kim.c:126: warning: Function parameter or member 'count' not described in 'kim_int_recv'
>  /drivers/misc/ti-st/st_kim.c:272: warning: Function parameter or member 'kim_gdata' not described in 'download_firmware'
>  /drivers/misc/ti-st/st_kim.c:445: warning: Function parameter or member 'kim_data' not described in 'st_kim_start'
>  /drivers/misc/ti-st/st_kim.c:509: warning: Function parameter or member 'kim_data' not described in 'st_kim_stop'
>  /drivers/misc/ti-st/st_kim.c:661: warning: Function parameter or member 'core_data' not described in 'st_kim_ref'
>  /drivers/misc/ti-st/st_kim.c:661: warning: Function parameter or member 'id' not described in 'st_kim_ref'
>
> Cc: Pavan Savoy <pavan_savoy@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
