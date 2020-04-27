Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A278C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5EF206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bxOzjLv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgD0JR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:17:59 -0400
Received: from mout.web.de ([212.227.17.12]:32833 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgD0JR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587979059;
        bh=tJKIP5/mdsP/vNzNEGPQkFtlyQQVMN8djw+HAazwd7s=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=bxOzjLv9wCyTxtrCkWsoiIUaQY0sXSLE8QdUGsYDG2ztSgNZlytYiSG85Yp2hg2lC
         hQNzBLt8rgULSQ9E2mTotLauoHMCr8bT3d/RineqxpUmMjEj/ZPLhla27GsgeBtSTo
         ghez2ib7HN3KtzJ4hFXCaCRXRd7ORP5bKC4Hbgtg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.190.48]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudP2-1j2UqZ1OAS-00zkRC; Mon, 27
 Apr 2020 11:17:39 +0200
Cc:     linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] drm/mediatek: cleanup coding style in mediatek a bit
To:     Bernard Zhao <bernard@vivo.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a637d892-de2c-b31d-bcfc-b3fd5b1d38d0@web.de>
Date:   Mon, 27 Apr 2020 11:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:7j4GHmZW2bMANUC8DguSnJsY8cIhQHIdrTwtIV9F63WBSjbJtLz
 q5JnZIsbpUJCR7fmCSxMWjHC9TkOY3CuXh3nznN5jkOvaGInSCz8caVtH5ENyz2omKisOAn
 4nytp5SEYc0l7gQlBdOxcD+Mtg4Nzei1Q45pZ8BBE/oSDnRlKiSIQhFJIcCWkcJufQNPqPh
 XvvRGR8gCJXhGBPQuQJsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bbP7I+VHFPo=:h/eOyi0b4FAVcjvznZTeEX
 CmZ40gnemPLuct6RgEb4t1sxGh1yoxgnQr4sIlG4SnJzSZF+tjb/v8mSdIvbxwrfemz+wvWZt
 /1KsgxL40U83TBJPKeY1jEGN5I9V6lncoFaHyxWtqmuV2lA/fqHCfq7xD5e0NDKzgL/0O/TSO
 /ZBuAtLY7UQGLs2stde1GfpHGiuDDJYLik21fHfyCPToAj4CL70VRW9FC/9PPSfVzN70SSMMD
 +BLNU4WCx2eTTANsPTUdCo4oCLwy6MVmT3lEYvxyMwnPg3ct2w+fCcaWEdiJ5iIvgE4meiNhK
 szxRVpkEa6dYH6MCgy+AUsAnhIPO6QdOSFfAr4bWlU/VvHEa7Tfp08PQIe7jdskrWW7X7yRAf
 +I8BoHwdmSElom4svp3Cq4APLlq72bt3gbJeLwp+kGewhrBX9/6xP2OAjPksWj48ZLNyUkIHY
 /CdDaYNp3PbS3ovE8rsem8aI0XFAtSZud3U11obN1YHZ4TBQR2yw9F3N7E0sDqNxIss1Ch/b6
 Zdo2m5oJ0QiStih22xHNN1NdtbF16X4Z0ojtdL8bZhh3VIoHiQMCftRLjSsC0hyN504jY/gL5
 Z902b+RDrUkquzMZXQA2jlB+GdDb4mz6NFjZQw2YI01yH2UBYi7lrTC/2cSbMh+/AgeJwu6/5
 MRWvQRaga6/rWBMApqPsIjKcKTO28curdwp7v23spmzHP2IrOgtM960kyEL23oDYLM32mjI3D
 FP9twbBWKhwVJ4Hzrctqmhove4PwJW74Rqnv9AImtifdFw/Z4sQIwKtc2+Pqj4WTE9qZgs5+i
 VJdiGD8yt003eXqSmrNkFAY0An5PGgSpGZ7VKwPgHJ0ikwliSlhwskxH52P7k9Py9T2WxdN7k
 PaCMeEyVRAZMMfzkBUyec1oFlyKYXmHbQtmflskt03OsFwgjNEIWa2zkBjebtEq+uCz0IZ1ef
 SLwEeRuK5Y0um4FgvQBsIbIh8kB+4Z4MAHgsN5wJ7v0rvqKqm9Nmxi6/W4FlGXi6s2j3mZ4B3
 OnMrZgOjC1dLryhdPTRxGCQDtxA22j3HKlt5WJwJhGQEjFvxTkbJZmL5e92E1jmFvfDQwulF6
 SFf1gerGQ0Se+Dcx6Eh1a19EtNcG8N2tsSODVOmspHCdC+zxA2IT2jTXDZQnklG/ZixfNbeXq
 Wh2KitXyEdjDaSvABd0/XbAlc/A3YWHVpgzWXPFWmTkSLX9XDIM0ABBEuIZlYGCK6DGfd3yS5
 /tZNVpuyGjDfB7psr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This code change is to make code bit more readable.
> Optimise array size align to HDMI macro define.
> Add check if len is overange.

I find it safer to handle also such source code adjustments
by a small patch series together with improved commit messages.

Regards,
Markus
