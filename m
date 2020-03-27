Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2DC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096BF206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyhqEyhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC0RZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:25:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44998 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0RZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:25:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so10994476lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsrK46vQ35+v3vstANJDsKCt2RLh4j5JJHq78hw90Cg=;
        b=LyhqEyhFVhLvPgLfeQiZBbkqBhqcUmwfWUwFmqQgcqDHGkAjBjy69gsvWPnLyCLr9l
         ub4d8ljKaebWH1VCAQG9mlHReY258tSYmQga+itSeD5mXRcniQ338POLmK0YISYnSuVp
         6A6TdO7x5UmCDkQyHDrMuK3XxRNmY6CKiCSIeIpkbheqMMjeFHswA9zGplgIJzsoFEl3
         nptJn/Xp3Gk0nuh6rx/TQkkXmi8hJKKF/c6+hsJl1pHY3+H/uBn5PxuS6pm5DUozCr8y
         uPxJiyP8fMWzLjD9MTdQqnJtjTXXmAvivCDrMvUG8FaZ1C+dZkEBztWbqZXEc0NovQmD
         0tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsrK46vQ35+v3vstANJDsKCt2RLh4j5JJHq78hw90Cg=;
        b=m/lECylyduopOu1M6BNvyNtgsy6uYPu6m6JgHPCQ16l0uIM16/LGkvOXrr2XK/vJUr
         9S+ACxZM8cTaq9NdhQRAiCTd8ejVmKclQZqUH1tFuYiKUeo7IuBuop557EvGf8ax0fiM
         EV0QcTr6BmL2CIvNVlK82ORDzUq1e1maVbMK38Nwyi7FXFTv0dwKrplD0O6CDb1YaOXk
         GzXlDomlcxgUFM5h1UYgs5R+MS2Gu87Xb22oUYMtypAnYPsJ9qcpIe3EUZPZKRJUxLLb
         w+0siq5Oam/mWZjlmR0dcrq6Bl3YKaNy6VL8HXfh4ZqwHF9rvdeMIwrbvhnv7i089D8j
         XP2Q==
X-Gm-Message-State: AGi0Pubg6ifxXkSQ3U3rpdgNxdiM3ypWAFAHKJkFnV19OeMFZNPfXWQd
        WzspAZ7Z9BRlZmE8puwDfeAVffZMxzuu7Q0BBM0=
X-Google-Smtp-Source: APiQypIEaUrI2pBQKvvCxQSERCnysMEM8pkuoEB4sHJBVv54D/4RtLBF7AaYjn+CmEGlJvJE2jYmJvml3Gzr2pI8nQQ=
X-Received: by 2002:a2e:a0d3:: with SMTP id f19mr5866ljm.117.1585329898944;
 Fri, 27 Mar 2020 10:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200326174232.23365-1-andrew.smirnov@gmail.com>
In-Reply-To: <20200326174232.23365-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 27 Mar 2020 14:24:49 -0300
Message-ID: <CAOMZO5Bd1yhT95Tc3Y_sF2XpuDz4vjtxu3jw3U_KTjp5C9+XaA@mail.gmail.com>
Subject: Re: [PATCH] ARM: vf610: report soc info via soc device
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Mar 26, 2020 at 2:42 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> The patch adds plumbing to soc device info code necessary to support
> Vybrid devices. Use case in mind for this is CAAM driver, which
> utilizes said API.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
