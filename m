Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DEC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3565420730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcxYe74/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgBDNuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:50:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43263 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgBDNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:50:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so12210282lfq.10;
        Tue, 04 Feb 2020 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jLVAcyplvqzHsaCloEAHREkwig8WcGxJ3DAaOOUD3A=;
        b=GcxYe74/idVHZGr0GaeypVm2u2HL/+wZaUIBarQqgv78UGehNvGeO9nQsXManCpMBX
         fDgvAm1QoMCK47vmAtNf/UTARl1eJ2UL81UfRwIbWLlXtqgiMv0dErvjN7o1SzakSwpe
         3KWtUQlhn5zGJeJHw8AR0Xl1CIn4cEQQUBE9Iioma2649hekeOGtjErpydl/S8cYJXvY
         UFUEQmvqssk17dR97GYN8fGIz8YELs4Z9KPsv6uAQ5SzmH8iaB9x4vPdnOsuetI7tcHx
         6myRkTjT/QNtm/ilSvhRfD9KUSEgEOLcc3PThcc9uaWEhPTEJiL5e6pdwGZ3Izm4hgsP
         C+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jLVAcyplvqzHsaCloEAHREkwig8WcGxJ3DAaOOUD3A=;
        b=DcTrQ52fWlCn9Lc+sJ+11aFxsXRAOS+Y1EEnaIgUHNpCshBLX7onvwwb8hfZzeU1R5
         2Ne7uuYeSW8lR4tDWJ4kIBSxt2jIq+VkJDsPm41Mq9Z1BxhotKlz6OdUwHlQ/Yytia8a
         V/aeBKZY3e+4Hb6G4q+IQBbCBp8O6wwBxM0Sfu+3bZF4G+UhUUFr8AvPpwcWXrbEjm6j
         YekL1INzH/6bumKGhSh+C/O4qaeRvQqEBUsZxyh98Bwwtyca5rZmZhc2RnWEaKY8N3jS
         D1IG15fQs3a+30B2tMNI6kR6kTLi5fKxVa3idjQSDO1LbXE1JGvUMKbzOcgb57zD7mIn
         uYUw==
X-Gm-Message-State: APjAAAU0QKbmLcIXpFfm3aacEyQ24TXubfkAmOf7kz/Rz/sY8nZPBaM/
        olGUhbPV3MblY+iInewDTa2RDkg6eAsTv+SXkPY=
X-Google-Smtp-Source: APXvYqyEjCRWCWA1erMGYdAPp7MEajrTswSid3c3EY+/9BGpIiG48e4yLchZKAedme8ceod4i+wIKWKZ+sqsGiUvpk0=
X-Received: by 2002:a19:5212:: with SMTP id m18mr15375040lfb.7.1580824248848;
 Tue, 04 Feb 2020 05:50:48 -0800 (PST)
MIME-Version: 1.0
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com> <1580823277-13644-7-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580823277-13644-7-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Feb 2020 10:50:41 -0300
Message-ID: <CAOMZO5BnfGdbDuobV=qi4zbzKriM0kNmAyd8zFCSdv2krVj=Og@mail.gmail.com>
Subject: Re: [PATCH 6/7] ARM: imx: imx7ulp: support HSRUN mode
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ping Bai <ping.bai@nxp.com>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, Feb 4, 2020 at 10:41 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Configure pmprot to let ARM core could run into HSRUN mode.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

> +       writel_relaxed(BM_PMPROT_AHSRUN, smc1_base + SMC_PMPROT);

HSRUN cannot be configured unconditionally because if i.MX7ULP runs
with LDO-enabled it cannot run in HSRUN mode.
