Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE05C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8984207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ht9tZv4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbgALIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 03:31:14 -0500
Received: from mout.web.de ([212.227.17.11]:40859 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbgALIbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 03:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578817851;
        bh=XmYXmgE/0UGkoCmUdSVF30WSv71FXReEApKSGy3waTg=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=Ht9tZv4fCyKVwZsYGIyVJij3X6MIOe/61SnYjtDwQCglsP3e28aiY3xbW+kO7o4hS
         SJbRO00vkwhU8TqKlN8j3036sbTN5CYSNhe6smQcw1LwhN/QyOgc4xp6ngzgT4RSnB
         U8ahEE7NeJMnjeLTOjvXdqdOwuW/qouMbmJK4s4w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.29.244]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTQo-1izwpY41sk-00ASS5; Sun, 12
 Jan 2020 09:30:51 +0100
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
Subject: Re: [PATCH v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6cc0c851-7a32-d82a-1c0c-51a08538b445@web.de>
Date:   Sun, 12 Jan 2020 09:30:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200110131526.60180-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GHQVDGieJCrTt6MDZI402S6zv+Cvii0gnTYIadvSOTqv55T/iLU
 wThY5GEfGuDTSq1o90NkyHRap9KcgRTmgrGp5tWYvHXjWz7XLlayDHRQZ+btLq1lpGqW9Ca
 +5etucZrZ7Npqu6ZCAH8wylGX25TI9pn+W13o6uExO0T5iijoa8fOjcI2WA+w8qSDMXryOE
 hvshk+FZzKYYuH1WHsTjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6uU+K6cz4Ig=:Z1Yhj0ukCcDMr+NmBUByE3
 jn8LQH2HMv7rqJRsaD9NqVnuVCSm2SneROro/itBAMpEnI9I5FdZkmYGZXnVKPMyZbwSsUI17
 gzjd+QU8UFm6bLN/mitiSKLHxLGTG/WGjGsQBvu+0wgqkRXZ+HJEb6nTfNP9lcy4vxrnDPPVu
 9LuJFM8GZiMVveabA4mcGFBYBWzEbUhRBJxKlctfbHPW9KN1TtNSabmqtjfC7o24JlH9ieEjA
 KXeqCtOh+drrQ6nWVb1mDtXffury2m/PgIOhkCgApBF5fuhVOjR+BrdU8C0IfSMQI+ZJHzZ0V
 sHWnFmnZdd3YBFfBKS+trDSO0FovU9TlYacnA+gM/L2FUYMbV6+Sn3xQrbeVEmv2meoqOYVvD
 F/9f7Ue/H1bcE3onSJe/nlmT7MJ+IptSFhrBmrKegrp/Jp7y9f/YseUHtqArdee2rQv/dG1SD
 4KnzU+EkSWt/ibnLx1k1rrZUZ4ROxLTviW0OsNuyVprmfPbT6Rxnw0z5wi0YwFyzZdOcsiNqe
 gLMgwijLEwtKolFpuCHZUDfD3Xoh5hW841CiUNbtW/CfPgddq5SWVIODV5BCQI/qluhWEDKTn
 p5yDyZYnMti2/QmE5DkW9PFLv4Uqa0g0wXHP1ba78eDwEYc9sHE8Sw1GsX2/e95gAyvpKNl2I
 Vcy4HrGOu236EP3sN+/thzLj8482HQOageb6YtkfXyHJ5JBY16t6MPrbIG0G/IbsWAygS1Ur0
 5Q1MN7SFDk7i8y/UL6yzuNyMjn5z0hXShAlrwFAaJDDT5hyYZ2Z+fSI0kS3ertrNTJwhZUd6s
 4uV1k/eAh8qt2WSwhcrRbK0Rsy0UInZzXOABFRI0zEQTIzbq5Hgt2jKxzkjVG+FLx62gk2okr
 4DFqx8FptiHO50HXE2B2w/+7OATJ7hW9nND7PhqOKAZWLuh8kz/SAO/gezpaNOJ9MmjSz+uWY
 4axxtfhdhGANKw+w0aY/UFb2eGT0R5dsmGkBMCEImdfeP33iG138OXg/M9cNorq2khO75ZpPi
 g8eU3V5n9bCD/cWpSq33tE3kAsDd+xc4IdVBGB8FOEMihnVcffzP0fvWrsyBg7COPG6W0QMZq
 Wz9Tm7sGgNnG3HGdcTOrRhVJw/vo7ingxTvJ0Ur3AzD1ulLmxA2/Af63k+XWZrm+3/ow57AEF
 GEqYLbsnBTdwiBUuscRJy0nkAOmgbOCU3fvUuiqegS0s4OXiNadBAocVLcaPmVQnIDXJ/LcpL
 Z8eD2O/GQB6/zDn5vsGviZZDzZG41gzktG0jiB9Z4Os86Widv/JJK0dvxSuU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This semantic patch is inspired by Mateusz Guzik's patch:

Does such a wording mean also that you would like to support the operation=
 mode =E2=80=9Cpatch=E2=80=9D
by this SmPL script?

Regards,
Markus
