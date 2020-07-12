Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0951AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9AA206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgGLPef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:34:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgGLPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:34:34 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MrPyJ-1khQtT42qt-00oWzG for <linux-kernel@vger.kernel.org>; Sun, 12 Jul
 2020 17:34:33 +0200
Received: by mail-qt1-f178.google.com with SMTP id e12so8162022qtr.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 08:34:32 -0700 (PDT)
X-Gm-Message-State: AOAM533ekxxlv8n8ygO9/xgh3NzeAs30Wrao/Bybsuv6LP1D2WVbiRXB
        j/hiGD37joYeVx+Z8cCzqt7auyVek5fuuosCJ6I=
X-Google-Smtp-Source: ABdhPJwpOfRjgqhjq4Yk30RcaWkQZI/ogn+szE6CsVb308znsad1MtXHdlsSOtrWCPf+0xspAdoPrUC6HqIohdXOjI0=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr80539856qtq.304.1594568071912;
 Sun, 12 Jul 2020 08:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200712134331.8169-1-gage.eads@intel.com> <20200712134331.8169-10-gage.eads@intel.com>
In-Reply-To: <20200712134331.8169-10-gage.eads@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 12 Jul 2020 17:34:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2zr5JXr0K_vwJSkmH-YAbYbZtWFD8Pk-TOOdZhitw44A@mail.gmail.com>
Message-ID: <CAK8P3a2zr5JXr0K_vwJSkmH-YAbYbZtWFD8Pk-TOOdZhitw44A@mail.gmail.com>
Subject: Re: [PATCH 09/20] dlb2: add ioctl to configure ports, query poll mode
To:     Gage Eads <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>, magnus.karlsson@intel.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:keklkOrfaEAOxlROulpgtPUdOn7C5N8t8riNxalMweqJ/WvkKKp
 ZIVhayde/8FSOq/sN71WXpRtiCjjtwERVsJxhU9JKHVrGWq2Pb9nMelz6lcOLD9Qeg/xWYj
 AFTpgE58SJJM2iVa6mTu5L+YhXu0w5hC68CPlaX9iMjyEspQK+5gVjm5+IwNbSKucpnsbKB
 UKqPUROCB2y4mvylyJPPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OHlQqMuATPc=:yVFKi/pYaVeKV54IpVdhtE
 IyIIYbiZiC8W8M0VY8sf8qe1JES6yCw7tcOTpkd5JR+WyMN6CY18nsfS2CEXLRKNQVr7kgD9l
 07T291QoMzWceHORQhK0Bug14JQLkH5Razc6WHzPTorYpjWPAK3VSQprllTV7e7yGUMzszzIo
 tEhA2Mt2QvhmKCMu0QU9EULD6OIvgyRgHIT+1kQO0EVnXRLYKbWDx/XnkHVQK0f6k4QfTHa67
 LsWmz7W9i5fxYnHQtZV7FAET6qODYVDG7i73AfUW5FXRND6c06fALAaVZxw+rlP0xwqYGNU0Q
 0ZF6VyzdHjkPRiJ5wlAPpPOJJUq9sOLTMsCTzgOH3VHxeZ2V9+NKk58ysCh++Zix3a74MFG6W
 bNpEsdMxS/sdleY2pnBMXG6kQqFXhH1Csj9Jjsr5QBo5sPkoHL3eP7ud+J74awMbN4icwdGnL
 zO8vvgYicVlGP8kaxQG1yDi6Z8RwFMl1uqqJQLyKBqXThWWgNOC72bt9LpOlSCOcGrEJwwGmc
 SaSYlonvO8JcNOdd6aWSr8/lVyJxdzWePjf6rbRz+XMcSkSaaPAZB2PqQaqDOeW8LcQ8sq8y7
 HOeSHJPDhy2Yqn38DvXuHGK5UVXqzHFIRqJVj0TznYDeyJIH13wzn5ACYI9iEbxFlyKvxVJSI
 kZsLDrsc0mYPeN6LB0q8iQeQ3FN65ASNzE1cBUSAZ4w2xC1oc5S9MiZJ3iOQX5FrlM7z70Op5
 pvWoJ5VCmNdwBEpbNElt1fZGSa8L95i/0THHNVGYJw5auXo8b8fXyW1OSiTPnorMjoLh5NyD5
 xNOAxuEcP0d2sNLefT2FoxhEyjKKOyPPViozcHXMFfgSTgvzSCG/Kq/EhfU/1QygdtwVahz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 3:46 PM Gage Eads <gage.eads@intel.com> wrote:
>  enum dlb2_user_interface_commands {
>         DLB2_CMD_GET_DEVICE_VERSION,
>         DLB2_CMD_CREATE_SCHED_DOMAIN,
>         DLB2_CMD_GET_SCHED_DOMAIN_FD,
>         DLB2_CMD_GET_NUM_RESOURCES,
>         DLB2_CMD_GET_DRIVER_VERSION,
> +       DLB2_CMD_QUERY_CQ_POLL_MODE,
>
>         /* NUM_DLB2_CMD must be last */
>         NUM_DLB2_CMD,

> @@ -427,6 +513,8 @@ struct dlb2_get_dir_queue_depth_args {
>  enum dlb2_domain_user_interface_commands {
>         DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,
>         DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
> +       DLB2_DOMAIN_CMD_CREATE_LDB_PORT,
> +       DLB2_DOMAIN_CMD_CREATE_DIR_PORT,
>         DLB2_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,
>         DLB2_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,


You cannot add new commands in the middle without changing the ABI.

Maybe use individual #define lines in place of the enum to make sure these
remain constants, or add a numeric value for each one when they are
originally introduced.

(yes, I realize this is the initial contribution of the new driver, but it still
seems wrong to have it change in the middle of the series).

      Arnd
