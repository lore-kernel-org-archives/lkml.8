Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC7C3403B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4CE2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqrPJBs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBRNB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:01:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42464 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBRNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:01:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so22851895ljl.9;
        Tue, 18 Feb 2020 05:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NRJPj3OerMDUZIsLVIBTx3cxsVu/NqvIaRSfxkUDjk=;
        b=ZqrPJBs7Tlhw0pc/b3ZpLDIFuJb6Qd3kBwiTrq2plEc25WoAK8oWQcCVsRtoJtU51f
         nXmXCezpFtcTq2+1y3kYsVlLI83rQRghbYgi4BCQ2eZzWkqEkhxalddHLjikO+hLnVLz
         GAepQZyJncUccBWh7Y+UGXbnP1RncqzTsVMJqqTPhuhwqowo6buoGTBuYDsUwXDTe38r
         YfcnGICAcinunmW6C6oRaQEyWBeDSfqdxcxH4pwmDOw3zUacWW58rEMLMIWR0QSYPFIF
         Ft90RL807LNlaFnxRnN+2g2jkvUiTguwhPYzCJVe0Bsmt5HeI+t4cTiMydv4Su3O1fdu
         1c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NRJPj3OerMDUZIsLVIBTx3cxsVu/NqvIaRSfxkUDjk=;
        b=rdTvspuAVaSrHiwg9fQqJaKoiZ7uhP7oG9On47MKIa8cjzjg1dUu705XhZm3I9A5Nw
         u8HiRbfcadb76Qs9iZA0KgS7Dshz5Ly8SJNpO1IoOPBbBqrRvgoZurhGtOZMFoYdXNXW
         mZ5PezmkkxfRvSE1CeM+OqySpVj0BEy9cYIQNKG0ZCz77cka350KWdeLgVm5JxX8iq8p
         6xBN0hSuJZERmnCmc3Tu5roSGb5SI056D+sg6SkOkiUE9lsS37qxCvH7VqUsWIeLit5S
         I4Q4XGp5d6V9NPLRPKSC4AvKZEXfA9dn6k1xwjQ1FSd3l260OCzfcPBRk+jy6lm2wNLR
         eaxQ==
X-Gm-Message-State: APjAAAUvTG5DMHmywKYmSxK3pnbLr5CPuHIRwdyAoCXSWDHC9YopB1Lx
        livHdJbZPXwnx9r4F82ar2dUWVKa/XIUH6U6nGE=
X-Google-Smtp-Source: APXvYqxONNhL8ahuIYdrsoVgkIbRN6liLiU+pdYOPCPkpHuXvPwsraNW0EIhNjpyMTO4eyKbuO5eK8XAJqs/p6GOwCU=
X-Received: by 2002:a2e:9157:: with SMTP id q23mr12846980ljg.196.1582030915517;
 Tue, 18 Feb 2020 05:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20200214192750.20845-1-alifer.wsdm@gmail.com> <20200217082047.nzxxo7mpejq5yj65@pengutronix.de>
In-Reply-To: <20200217082047.nzxxo7mpejq5yj65@pengutronix.de>
From:   Alifer Moraes <alifer.wsdm@gmail.com>
Date:   Tue, 18 Feb 2020 10:02:31 -0300
Message-ID: <CA+W=15bD5Ek0S8_OAr3nTBrhNJCozF7yAB=BhX0c0HCAOVVVOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, peng.fan@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I forgot to select reply all in this question, so I answered only to Marco.

> Where is this gpio muxed?
>

The gpio is muxed in the subnode pinctrl_fec1.

Regards,

Alifer
