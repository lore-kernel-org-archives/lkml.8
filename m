Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 04:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF0320772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 04:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK/qKUpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgDAEYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:24:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44882 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDAEYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 00:24:06 -0400
Received: by mail-io1-f65.google.com with SMTP id r25so12405713ioc.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 21:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6FYICBSJfbwirVW1y0OAiy0C1pnsi4snfn4QjE3qwQ=;
        b=EK/qKUpHpUV+9QRlxccDiPEo+A05wpcpLa1gCS40owpEa70V18ost5JI6y/H946fwF
         n+DhhjoadnmCQjQquWk5+vIUllbXLnCYwqXI3UD/FUiGUllXjCMrbhF275oq8EZbmusX
         56R84bHQz28k+b10p/iK4tQRhx3bp19dveinb+n3Rp2IA1EZsm2O3GQLi3jYSGiEiCDa
         LcQf0glmeHhKxNUqAxLJt+iavl0mjeZOxBoT2fICLFT8NJ3NGxeXsx+yIZZ5GiJh5ARR
         ekl2KWVqC1oXLwOPmbs5wONZ41LbfbT5barXjoMc5OFJ3DPZccF4lilyAthao4R0aUew
         WPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6FYICBSJfbwirVW1y0OAiy0C1pnsi4snfn4QjE3qwQ=;
        b=BJqwy9uZ4hO3MPZqzhtMTeuiFmoG/A8OMUy9jp389rwGZUYkktEpWZ5ziGjxkP+rBH
         ZvcL4/RRpN2dbz4Dvic9fdR8L/13SfYpG4XUT974xbbQbGqqG+GIbu5IgMw3HaZ8AUwe
         UeiIYGNIvgUl5Td3o+iM8gncxM2XbviwXmu60j+65SkrekPU3SRwSBvbkTlT+PRttEsf
         WMhWtuw61u9Ex1dUhPcVMMaiixybH4O6BOO6bcW6EMeYdbFmXt5ts79Ujngd8bO2mDe6
         7ILSf8OsK5CftAy6vxihYVX3vP1KAohk4EbQRKJngq3WDvdMCJt1OhObF5MChNYFvF9n
         vLCQ==
X-Gm-Message-State: ANhLgQ14SqBgTrr+4Y9B4PtMBdxYdapFK1F/Ni6+YfPW//JBPy5OWR8J
        Q29JBrfxKIs5dnfhVigXIgAR351egYdmr3qQs7M=
X-Google-Smtp-Source: ADFU+vsYqeN9OOoJESGw3IyB1X1G3OR/ZmLnj03QuzJ2E1Qrh28p5g5s1RTH+AU2J1NlvLAGPM+ML9dmdPRT6e3Bkxk=
X-Received: by 2002:a6b:b78d:: with SMTP id h135mr17926718iof.84.1585715045618;
 Tue, 31 Mar 2020 21:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584604193-2945-1-git-send-email-peng.fan@nxp.com> <AM0PR04MB44812577EF272CA1D457A1F788C80@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44812577EF272CA1D457A1F788C80@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 31 Mar 2020 23:23:54 -0500
Message-ID: <CABb+yY3jqhQpDf3eBMrGRfYeS2-Gj7o3YfZJVkb7Tp+4i-QZ4g@mail.gmail.com>
Subject: Re: [PATCH V7 0/4] mailbox/firmware: imx: support SCU channel type
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 8:34 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Jassi,
>
> > Subject: [PATCH V7 0/4] mailbox/firmware: imx: support SCU channel type
>
> Are you ok with the mailbox part?
>
Is there anything you think I might have overlooked?
I already queued the three patches...
  dt-bindings: mailbox: imx-mu: add SCU MU support
  mailbox: imx: restructure code to make easy for new MU
  mailbox: imx: add SCU MU support

Cheers!
