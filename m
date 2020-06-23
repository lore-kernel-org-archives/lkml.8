Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345A32073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HgkSIv6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgFWHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:49:23 -0400
Received: from mout.web.de ([212.227.15.3]:44685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731371AbgFWHtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592898536;
        bh=0Id89Q8KMAQDXyesOVHf4HPskkYmahuHWvjdnRF1kDA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HgkSIv6t8x9dbU9L4QHxRReqpTT5qI6u5SQuiWLTH6A/SE7IsarJ9ZtrJuKKRrDUZ
         x/2/0CrVHbs0p5S0MXulLILf1frxl7ZMbLPUYcYFZF6/CTXWyZt4MI4hatBvg/+w0p
         fmra/w1i5p3GKj4g7WGfLmAtOoCRoUrvQ0uo5MAk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.105.198]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1joBdd3rYA-000fLv; Tue, 23
 Jun 2020 09:48:56 +0200
Subject: Re: ARM: imx6: add missing put_device() call in imx6q_suspend_init()
To:     Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Cc:     Yu Kuai <yukuai3@huawei.com>, Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yi Zhang <yi.zhang@huawei.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
 <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
 <1542979d-f7f6-bcf1-53c3-22b7c076ddc7@web.de> <20200623073220.GV30139@dragon>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5300cb30-2243-9bfe-125c-96e720cd1f29@web.de>
Date:   Tue, 23 Jun 2020 09:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623073220.GV30139@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bxPnG0KD82IuweOlPCG2u8tbRnGbLQ3MNsqQmnyyuQFyBvfmE0Q
 NB2EyNTluasOFF+NZNf16rN9TpiNNd3GGf3Pet/wKb7itvMStTzVaYUHi9yyuHG/v8FgSUS
 f0uqpgInybuOpvM1WTISDrIs5d4LTpy1cFB4i10NuvtTyxxwJhYxxj05vYn6rDGPeMUFeUg
 OLkXzuGUKWik+cJOh8W2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FU+tt021O+g=:9zf2srTC9H133Hss4LoPLF
 j6rmhvUm+3ybh652Vo5k/Y6+hJVz9S70NzKNR2kHqFq/gkjyHNYZ7+sHHtmFy7Ez+X7YeNoup
 ruphG8EW69sJ7RzmYhNgZy/R4U5SjeF72/wOuXaHpqcbMsL49PoNqobJiVuWwbRKN3r+/Go8P
 p3ilNgTVbDzhUN2SO5qbLM16z8p5MV2ukN7yFwLrDvaTAT39HDVVlqgEJC9+x9Ju/alGv/PSW
 7NFxGe2InMbTEjGJ5XkKYRuiAz55hfkptSqMni07v8DEDmeYnInSkdVBWXCr88OgssbixhEEA
 Oygt/5meho6ecqTtVIOMfQDktT+ovJa5d49zs0dzsKTy1chhmkwe5OKtxIJ3wZFSqKmxRVdkw
 kpdhqzOVYWYBtLc8336aUPAztX7b4EK8aNUZOTDCzDbfD5HG02SntgFepcOwzvG1TgUqNXhBk
 1jms0LD/nzgWrjSulfqxBSUbxfo9UQiCQL8p/V3tGszTe6ZY0Ef3FDX4M6/0sObXe5kOyRy/5
 H2OGV5omIdYvI3ETEae9Y6DQzFJJqhdpcyEuEGUo0II6xmXYRCYIdFnWkz1yWbwFkUPeQKXqH
 BZtU7LUH2BuEnjvwfZX1r2xjgzl9n5FoP2HxuRd3rsZD6ExH7UJhhKLQA7FZwNvXagX3a7t1a
 j65PK9UIjbgrgxGvYo7EyiTYR4HHJ/8Ig9SwxkHbQHU3VBaaku+cuDyP/nHqb0ULjy/02GBfo
 i/cmzr/lROy5VVnW6PO/EFJ3PEBIaq40AaplFFt6tXUQlYFpn4j9nwpEo++Wqw4HfKkX9a28b
 0AUb3fSZW12qkKnnDGd8Z6/oa0N+GjHrFAmu1pGD2Q5gVyzWry+V+4l53Cd30v7PY98gPkEym
 jrntBZnuWdA93yNRTkl4i0iQQoWCD3hCeEQz1BnE9v9k8GPRfHEdYMMpokOTP8jAwlvMyN4n6
 sOeWNY7V6ojAvV6nUng2X4MGJGQlzSIchbFzQ3cK9uAB/ostMGi/eLu0InpVhGACd535i0uJK
 PMd/h94xzEBxqo66N3tVpSQazeEkLRGGq98eFhVSM+10AeYObbycnuL1wsPtVVmd/LzwHoFLg
 H7UjqHPElq83Vsq1Hq4cbM4o19r889yfUVsfDU7VQI9V62ciSg/v3LUfLIUfHNM+eYhje1tzb
 8rgsH7Hlne7Alyf5cyKfItTkCXBa2nUq4E1n3K2Wyep9Lh9+9pRaUTgeb5sef5ddNdQd5/Xhs
 ui9vwzSf4cSrLLEhV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Do you find a previous update suggestion useful?
>>>>
>>>> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
>>>> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-bb2e=
5fdca1be@web.de/
>>>> https://lore.kernel.org/patchwork/patch/1151158/
>>>> https://lkml.org/lkml/2019/11/9/125
>> =E2=80=A6
>>> It is useful indeed.
=E2=80=A6
>>> Any idea why these pathes didn't get applied ?
>>
>> I can make assumptions about the reasons for the possibly questionable =
handling
>> of such patches.
>
> Markus,
>
> Could you resend it to my kernel.org address?

You can get relevant information from the referenced message archive inter=
faces,
can't you?

Regards,
Markus
