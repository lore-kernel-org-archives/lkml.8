Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E0C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B81205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HAHNRWzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAJQft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:35:49 -0500
Received: from mout.web.de ([212.227.15.3]:41705 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbgAJQft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578674126;
        bh=ywOghj+GkZbJuOdq0nGQ9EvAYoVtkRGJ+VGaMoVlej4=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=HAHNRWzvc4zS198eWuiBvvF3PtISbe4r+hbdfqIIkGVWT2JGyHIPunK+BoPMRGA1+
         h30HonLUiPFTVf5+G+OsybFL3WTLtOnZ74JAz9riJqc4ZTeMqO+v1OzYpC3dSq5EWl
         Spl3FBdGmM4dAHpMUzggMLYc2Jr0IojXMX9U/BoA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.170.191]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgOQQ-1j4soK1nVO-00NkH6; Fri, 10
 Jan 2020 17:35:26 +0100
Cc:     linux-kernel@vger.kernel.org,
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
To:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <91abb141-57b8-7659-25ec-8080e290d846@web.de>
Date:   Fri, 10 Jan 2020 17:35:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110131526.60180-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wv5p/O28eOczAM2rFvszRt4ZYLkNQgAJ/LCwgooooQwNTDjyZ9z
 dcoqh8iKryZtqqf0teCTzVeNnB5KDa4SlE93uYBrxQ3IdCwc14YyThZ+tpeWYQhpceIFhfV
 EAc04GOyGjyZRIK4PsSNP6M3k+45dv9/BfTFyejsvUoF+XRvRzDAY2+KDYxzdfyFE1e9B2w
 A/47hroxfovyMFF7YI8LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ohfRlFmojI=:f5AjPCCTMu/rkIYl4q9X35
 wJhFX853TXf+jM1zZwWHstfcHf07voAYPQNcdfOjFPFgQ1T3kI3dTKPcTlfF3/Jsw+OaJr2Xt
 XagwVMQuf9XjoG+O6W6QPJAr3ozg5JpN095n9wkkIOHTxOmh5ukWC9vmsEqru2e8JiQyzsIkN
 rIq2aPFb5jRAefo2aUbN8Atj65ImXNU4Ba6OdFQFCjlGHQ1BMTjpf0CtDhOhMbxHuYdst//eL
 Naek2kCMjBroxJxe/Q1qA85dJfJXS20Lgdqka/y7MHw2bXpeg5Krn1rYRC6PwqCg/+plzzYbG
 FltZoCyoV99YNoQR25XfKrzLhLjIM+32mmjd/4ytpne9j3A6UnSBAx8ZZAlsmXyJpm/phxFOI
 /cyAGHvqoSql9xiBK8p/t+MS8AmWJw+9Qht3/8zTrCLcw7CrgJq6EsxEW2WXwbW+kikHsM0tw
 Sd6PENE3QoR583hlGqWY/FZkH9dLlfFtXtfBQticH6erJpHa4Bg2zlPD1xQJ5gx6X/Rj7hFqw
 VEjfNArPLyjvcyH69cES7z2WFjGCgforhmkZO7iR4QtFCFx/wH+kzv08rjHQqlyH+HOnFgL9A
 BVZT39AYBO1csmmBMj1tm0Mbkb6z6K1bi+0dtFRE53+76Q/h+fTtG26FKTAOx32h3aMfpO0HJ
 pqNvPTvfui281JSr6QVo2oyXvqyp20qwqPt6xyGvBUolKBhoiBoHeaiSeAMd5jUOa83GNwGLh
 wzEUKvvWadk16WM+/lcc6ijQa01p8awqazNP3Zyhyy5KnKz5jgmMv9igulXWSBBP7fV8tNrJt
 rkmnUJnA2b54W49rt7M0jIL9t40OM/TsDMLCK3bcBI7AKOC/lAXF8LMvhRczc80H7HXiekSjd
 lCXof4k0m2dpXK+sKwHr4whS/L6rOs/EhYclEheMOMGhdMJOCCQ6JLxdrPBoIyqlYeV9NlrUs
 g9ul5tJ6BoaBfNPzPwvJ2ofaEzdcQjXQSOi2SKUCEdG830RuZh6IWzXLpL9ELzQsoYgTUEENX
 5HWOjnVRhqW5hpye50pYaw/YvP2zv1J8pGKMl/UV7cvycyYuvvZcmkeWJ41o1/E3iD9f6SlwL
 RatJIRw1V0Ef5+ytsGwpTDUK03VR+dWz0lGwh5g/bXQHg2k5Cw7KXen/mPpyw9kITsw1UZ2Sa
 KeUqhJgYyNYjCwAmXNxSJi/t+bgCOp0mtQGkOR0cDT+6Gjw7r5dtSXMvbT4Y3x9/5lodVM3Xh
 UYZf8NFdVj9ZuF8y6D51I+u7H1NjvXjI8PrnaFj9jOHfPo6fR9o8c/fc9kN0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@initialize:python@
=E2=80=A6
> +def filter_out_safe_constants(str):
=E2=80=A6
> +def construct_warnings(str, suggested_fun):

* I suggest once more to adjust the dependency specifications for the usag=
e
  of these functions by SmPL rules.

* Can the local variable =E2=80=9Cmsg=E2=80=9D be omitted?


> +coccilib.org.print_todo(p[0], construct_warnings("div64_ul"))

I suggest again to move the prefix =E2=80=9Cdiv64_=E2=80=9D into the strin=
g literal
of the function implementation.


The SmPL code for two disjunctions could become shorter.

Regards,
Markus
