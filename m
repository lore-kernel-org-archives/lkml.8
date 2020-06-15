Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C02820679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="izOVr15E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgFOP56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:57:58 -0400
Received: from mout.web.de ([217.72.192.78]:35009 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgFOP55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592236661;
        bh=j+PBmo/R8jKyWORcywbmsA0MKDmsl/lXrcLHqjImqyI=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=izOVr15EUjENRdSNZrLjArOQqBMhJynLEaUA1zWlkZa+Oq2YOOzQantO1Uf4wg+xv
         c8rPpuMwOP4ABEq6Nkzowf6hpQKHq53YrkB3kfv77EF9Z0kVxKZB0QuThpM9UmC8N3
         00bIkqMrRG9p5gwCVT+gf9YJzs8+90LxDzvz5UDA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.107.236]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPPs-1j4OvX30BO-00kyrY; Mon, 15
 Jun 2020 17:57:41 +0200
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux+etnaviv@armlinux.org.uk
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <mccamant@cs.umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] drm/etnaviv: fix ref count leak via
 pm_runtime_get_sync
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <77698453-95ba-5e99-bba5-2ca4a4918026@web.de>
Date:   Mon, 15 Jun 2020 17:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cnE7yTcEoKAz2gwfVrF5In4bRE8Sye/h13yy1qddljPU6McyGYq
 pbW0hjBcUJ0uHtFfUPeLF8PQ+ezgHGXIfueedFj2Or2n9B7VW6xH3d4/z+V4Z9JdLSdFEzE
 pd939kSAtUI689FPHlOMX0iWnU+2+644w1WJKBqp8wgC3sYTePjWgDPM4Lt9l2OAK1u8bnj
 KT7Tdogld7PUDyN1jZbJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:awtHdo3yDe0=:oRLD6eU3G1eHW3Xecm+dw4
 1X8UD8dL9lYh+K67JaqRR4ri8byecxZ6E3EcrH1/CPn5bHLun3hH34DtMf+zecBE6DvEC3wTZ
 D+vZeqKKjiazPKZc/V+DwI59CMzL57coWFiO8L3ZSy2C8o6n8U8aLpsvcyl8cYGPhej21Bjxu
 rSzrIs9b1330OfQmE4ivYV+1trpfgJWCoUpJSq9Tqag3sEZ7zMq0Z4pi9VdU0xv0aXoijQkwZ
 1wpeKEV5qWUBScanmO2wmnF04Ae199W30FvgUbagGaS7kfbFibWiCRy/r5k0DUXxe8bNSPgTI
 wSPjx7yu5BQm19qT3TA3pZSPeNfqSUZi5BLxZbPF2MrzwSG+vd6LEb26JqpyJvgRUatCDFDDz
 Wfx5F6VXx5r3ZBx9MsFTHjvm0MpSXxOQAy+ZR56RIFcmK97TJkNcmEcQR/OzsqXpjTrR6OPrI
 Fs5ikpXUGxjLb2rpQDNufUapFtqXZFO+XBtaeSdp3ZJWXwpkmO7zGBI0BIv6Z2aw62iwhpugP
 w6lrZ2rujevkCaSH8ApE6kJ3zxeXGxuYKys3f8nF338upeFh3Nq0gn5ig+Ag7xtp9H1v9LtLK
 vMTKG325mzOl1hVlHc/sBRC6xoRI/YgiXDFQd/uGHEYi+CeqZmjDZRy+JGj0PJohvtn0UtBqm
 JHuRPsa7G1o0nNtVJ0F++E9jmQG7nXfrdt2hFw3sBkpP6oVibXrYLrGbxw8N3ItsDqz+ss/p9
 kgt4tAFfyDEKPIHjLl8gwHCA37/JyenduIz5TJj+FHe8HNGEG5+tbC1iH9A1nfbPCVNB9rGx4
 0WI/3KgQlAio0llyo1fpp7tv/vUW0h4aTMfX+kR2BIpCdfb4LlcKjOy3psOOPxoF/h6VKEu+6
 ToftZ4GZ2QvhZTA+lcqVvVauThu1pvLHBeqRXefFUjr6LjFTb35cYHyYAboVr1By1aMVh0h+N
 3wXHeWYucm6MDNfdORQ3qvuG/a8bfj2vnOViF7E4COigcjBRFu6P2r2VduKwCSkSndBo0l9lC
 h/LaoGp+K5PF0/XV3Dz/E5Bnocl7KU38qSdqf2Z7LDo1JdR5dQMas4jN6NbvwqO9F/l1Gda84
 iUJRP4ia6mq6VlJAMBgoaa9RcyCUylhJVsWgIofpVA2LNvdlHeFbrMAbCsO7a0u5MSX4exIXx
 YCZuhywobJzQSroFtZJ7S7eABos84ba8MVpyDpo9Xj93aO1WySdknMuiuPjx6umfMXOx3vXn5
 88sE19pgIK8xROxMG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> In case of failure, decrement the ref count before returning.

Can it be nicer to use the term =E2=80=9Creference count=E2=80=9D here?

Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit message=
?


=E2=80=A6
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
=E2=80=A6
> @@ -1326,6 +1331,7 @@  struct dma_fence *etnaviv_gpu_submit(struct etnav=
iv_gem_submit *submit)
>  	ret =3D event_alloc(gpu, nr_events, event);
>  	if (ret) {
>  		DRM_ERROR("no free events\n");
> +		pm_runtime_put_noidle(gpu->dev);
>  		return NULL;
>  	}

I suggest to move a bit of exception handling code to the end of
this function implementation so that it can be better reused after
the addition of a jump target like =E2=80=9Cput_runtime=E2=80=9D.

Regards,
Markus
