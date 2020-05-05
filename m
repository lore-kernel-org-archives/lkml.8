Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C352C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE77920675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gYytFFqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgEEOPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:42 -0400
Received: from mout.web.de ([212.227.17.11]:38787 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgEEOPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588688106;
        bh=mf+yc1THoV4pyv4ey9hGDxLNZka1B4z5xCXHHlp3NBo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gYytFFqrgxEhnMiNctQEWfaB2tmp5SoA75+VAEI1gESiBHcL41LSde8uzuEynFf9L
         OL0Z2xNHKaHd5AegX8Lgg1+mBtux9PDZco5ONf8AVWF1O8+v++DU2nv+/Rxjsrpn+5
         BGM9fR/Wbu3vkg57DMj4+c0aQB1cW/d9ABk3XMNE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.132.123]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPpIE-1jS6jg1OmQ-005080; Tue, 05
 May 2020 16:15:06 +0200
Subject: Re: [PATCH v2] fs: jfs: fix a possible data race in
 metapage_writepage()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     Dave Kleikamp <shaggy@kernel.org>, linux-kernel@vger.kernel.org
References: <20200505135313.28793-1-baijiaju1990@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d3e126df-e7f6-00bd-aa3c-ea39fcd1582e@web.de>
Date:   Tue, 5 May 2020 16:15:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505135313.28793-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QP5sqwEUOajYPTCypdV+V2cQv0nAqBqPw6LwvVHLNPF/+loAea0
 8FZWYinEvl3JjjgzrmORj9yCT05CZfs+6F/RoRHwkUnxPUh+7Bo1tq2TJsQz9U8Yy1o6kVK
 E0KfvFVPNXswaiDWXEQLBfIkqnBRBbq3gCs2FV50toH5/O2dJMUTJ9S98YrKT95lEH+wLoL
 ghLtjHiL0dBbRmqKBD+oA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0BZCCghejvA=:m1frBApvFnEwLFSglBajkJ
 fU2RRFOrB2kZm1BcP1JeACybbvyW3ch5C2Pa2bXswzciSo8yXexAaYsekjcnmcggV8lcfm127
 HbinQBEGT/A+vNh1NDL8nCUv2TbtZfCiE/l1qBE4IFKyB4JppFuFJf+3Bphbw8rkqkM3Kpl5b
 wPmutVvYbkxZJXp13shKAVYU/eRUluIcr5o1hoApM8FkQVgAKph60ABtc2qQ9J/rAKKHJL9Ul
 kkyrtMlGiX/RqrEaD24T8/7D+JI9hqhdJ2pbfiHEEI4rg/muUsXoGstCoINj/53LbGlTmxQCi
 gCpkECSvOJ+6MoeYUbLVLHhb+3mQrFcw5bI+tKaLI/eBOsG5XvAh/DRTL3oIOHgvglM9Gxu5g
 unFlzin50f6kdk2JlSnWJyueEVfgxEBkTVlMfl/wEWf0Limk1wkWkxLtsGwd3/a4cX1hXuYHq
 8zU7uuRtwGiJqJ1bXa0ja9PovvLuZUItPcTcQuf3LnD4hiUm8IzXDkxS2lpPubLBiNATGIVSv
 Z2yVkgfWCLkJYMjHBKif2j+MF7zuwf+uYqLTrrYEaZUVW67C0FmUY1+0EVIJ1waFrpYOrsgWN
 xi+Sk0l8jlQ2dnt+5dFtoTSAgkav/eIEjU9JWNojbsNV8cY/kYF/9/MBPpSPIwDrwfPk0E1w6
 +EmoO6Ndc1jmrbVdlc0wsNHqBNKfJOxtZRIZrM5MVEPyUJwJuMYNMQKtmykgRlPZu/sG5KWNE
 hIxPbioz5IYJALhFTq7rvugO2SShigLpoNZx8Are/JbU7eBQUw4csxe3dAkIne3+1PLf3kSUo
 4WYU9BC2JhTT9yRSRgTH+TBgxXaotmIZOEXDkq8PBllsLL7nvhlenQBpaREw2FbDNUg/9H+mD
 USw+7oTPk3KmE//V/k0PokpajqaxHzYgddFLv/A0BR7/rFGLw2xaknDGQSzlhN/Np78++THV/
 EdAQI3m4Qr03ciRn1kP7O2TpzwYYufYguR9YRPVzu+Vd357xmnppqg0IhRGNgP1+DCJr1U00e
 ifcV0gtEWw8+eWp2uzneSMk02sLpJoS/JuulBfAoUHzqa68Qi9FnLQQLjeMtrHybsmHKqS5Y0
 fcQtoCyRcDh7fHDcH4MtNyf5tvNBXetRZN18GpPM0ctm5hD22PCWQT6WY3foRwjuNy7VcemEm
 3EK/gsREJ76UCrLn59PXLeXHmBKpmvI9mNb50oz7jGsqQaJz9tgtCpWBG8jz1r2EzDWX4Ipsz
 wRWUJoyxOaAoSKQUh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This data race is found by our concurrency fuzzer.

* How do you think about to replace the word =E2=80=9Cis=E2=80=9D by =E2=
=80=9Cwas=E2=80=9D?

* Is this analysis tool publicly available?


=E2=80=A6
> ---
>  fs/jfs/jfs_metapage.c | 11 +++++++++--

I suggest to omit the triple dashes before this information.

Regards,
Markus
