Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997FC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECACE2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KpIGE90p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgGTMIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:08:43 -0400
Received: from mout.web.de ([212.227.15.4]:51383 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgGTMIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595246871;
        bh=IOqgafXOwez7E5wsjZ+GcbCSvOBZDrawUyLZTHhgNss=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=KpIGE90pbXkR90K9vtHJtq3Xb2sDz8hNkyy0zF6zRGuHcludWe3oFY6o2/CdasNOn
         sjwa1AQ5X91NRK9Ot1P6tS6wMlA0vEBh/nswRKQC+Jf66H5lyoZmqWrUYyR1OnMxIL
         pymU81++G4+a0kHLyPOjd6l1pH8dKtIrBbkFw/EE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.85.87]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEVQ1-1k3rJO2vcn-00FkaY; Mon, 20
 Jul 2020 14:07:51 +0200
To:     Corey Minyard <cminyard@mvista.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        openipmi-developer@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ipmi: Remove duplicate code in __ipmi_bmc_register()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2084072d-e16c-d47c-6eed-f47e8f149c44@web.de>
Date:   Mon, 20 Jul 2020 14:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6GyjCIeKwuz6vMp3D5exOGwK29vo62dvK6acUWMG5UHCHvuJVdm
 Ha8/+slcrH/Nxoim43uNJOM1NCZhiCnEUR00H1TFA/tYFNcbvsjj5a2TqRn/ljgjrMhhAnA
 fpnyx4pnGlg9vNvmwBhR/oiClf99EZn46Bw78Vjjkve4Z7A+wGOgBjBdsRMCfoxkpnPLzgu
 ThbdghnuAyWZY8IDTt6RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+kOQjfIA9bE=:6xQ9w3iClb8g4AUVJU4SHV
 CeNW78thBSaMzYzD/RSvzKS44UFKbYltLYo/mrhudTyYeO6/Mvn6WJp1hXZzUp3UTIi5yCbM4
 kZjoehGcfpgBdCz3p/xEicAJhjqH5c5FjleNv3Q33DI+MXS3g5NvSgS26RmQuPcmNeYmtwWpG
 kU55yGRxPz0HePeXP6wEXoVVZzt2d9dV4ofh1Hl5emK+G1OQoWvSzr8/GQE/D6Vikt5JrCOlx
 /MMR9icbIbeQQ7CzzLWFIwkNU2CqLIrduYiw2Tj0nNkxaYQ121NMVYEoCMTsSAmxXzdaKBGXg
 gZWpPKwzjCLvDdzX0yn6PJmt064DG4eOYqSWbifAgJSpJBvbeHTzFTmkBgQfv8EaEfAHJ9VGG
 4gxEUx3BC0H+1VvfedweyNUl0hBuMaNVGNGF9adySUs5Z0L0BhkVLjwDrCi7pYORdgIEJSfmL
 gwPV3sdohCIfxOupOVYkdNc0EECM77I3N4Oqw5jhGu4hk1LOikYDCkjYFmG2GUVnp8ze4Y3bt
 cHmEzNPZNYyUl45pCR+USWo5qqOs4yC5eBKKAuAwHk1kAXvilsBdjafZgvtuEhOtsJIxevcsk
 7d598PNdWaHhwUtwqhQyyr5P7C//65w4fGTMCgRmYqLvXNKXdu1dNbuGrJJBiPa77Eo8G1wgC
 QXQfeky6TYcgGZBDjUUKYqqlQXY58P8mDBQXxxbWwTt6VkrmzdYupvpdwOngZgEHsz/H2iITu
 6YMT8ane4rnbkZIiKcyRBRcH249AB1DUCcR6r32JJL/kGxzzIrByi8yJPTuCFoLKV9Nyx2Zen
 No4zCmnOtmpuGCLYR4u5M9glWH6CuT2Bwa5BYGUXDC9tOOwyajQY1bBhKUd8BWDP5RxmAvOvq
 af5ZVTJbnS9hurelLvBES1IUR7qO5N8AN/B374kWjLcvwhaMeZnjFTkCCAQ2Bz2Xinn7peo5+
 bWHTu/4eUHux8X7ttqW+nkMmbAAnpt3YScuC3nTALNzXj9rUD8jn6ZnKvWF311Gnn71zPQQJJ
 h+4QpNCQrFPGdjiNMioEdqpAieS7eRAzA6Mlnv0GP5Aipa+C8kwYdRbeCB1lqsqPk1maKIHIx
 unmCNVqItw0gjBIJ/Uu1xVc+RjC5wuVcuCmufRULidhG9yYwzXgw+KxhChZydrA3wLwSUXb63
 SszPgQ9wZ9wveO0NZzVDkh+oA5x52ItOdgn9jnxNw7V6LkicazQGUV550YJwgqXAe7C6/ffSB
 toETR9N/qZx56wU8bwzFUrb6WNP8w4WguXFRESA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > __ipmi_bmc_register() jumps to the label 'out_free_my_dev_name' in an
> > error path. So we can remove duplicate code in the if (rv).
>
> Looks correct, queued for next release.

1. Can an imperative wording be preferred for the change description?

2. Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit mess=
age?

3. Did you avoid a typo in the patch subject?

Regards,
Markus
