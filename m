Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E17C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7420757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Tw+Y4T/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgEBTke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 15:40:34 -0400
Received: from mout.web.de ([212.227.15.3]:60677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgEBTkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 15:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588448425;
        bh=YOcanYR+jElNG6VYugS28YtSJKtjxXpS93yz0Becd20=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=Tw+Y4T/sZ/m57svUJ6z7g/VpeZ5nTImIJYFkt+G2KQKCiCYujYdHcgQtSI/tJ5sku
         gJCOkldXbCfbbvKwIPvM/hmr8H/34n9ti1DywHjGMZuHvGxKsIoIFOA/vcMCjIQGoo
         kVOwD3wqd6bFDcZdFTSgSvvB9ow8iVlNiJyJWza0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.93.244]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzVMw-1j9Mhn2O6k-014oXm; Sat, 02
 May 2020 21:40:25 +0200
Subject: Re: [PATCH v4] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200502185421.GB9082@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
Date:   Sat, 2 May 2020 21:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502185421.GB9082@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H8BepbZKMKuqgCv2jEt7g1B/6SnQs6Ai/yPdqYK94+zwQROz/3W
 /zeqLP82rZ8bhSdXpxN7cgyCXkK820KrLlkAXnZOPIqvkze0sXU8BJXPEEG61BcHYkOvXhk
 kXAa1TMrK0lA6ZutOSxNh477GStcI33820rRBL2LrVdHftbJqprgDKKI26KK9eubVSc9/LZ
 AL/Os5EX0HnL96arRiyUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UMwvEC3FWhM=:KKr2Wg7MiCmKS/D4eBSrze
 ZBiA4EE1xW204QH62PK0zQg3E3Jw4naHUaM0rrDD5l96UgzUaGgc3dOUVZgmWKt1okjJeW8Z7
 OiEAEEuFW/KArUoOk+iA9bYAr4jZZZcrPOYCI+Fbue0maVnrBFupGs9DmKxp0SU977EmbqztX
 o/8Lq1Ood9+7q50tLyiAMNkrSu+1Qau5+cJXKkipFrKFS/YlezMcGhduIawalhQSpvLyi3caj
 8Ux5Jwbctl8t5SsOlG1j6WO8s6RIfezBS3X80P7WVeFmX7mIvWGZ3MJARBfkgBb7nXo6vkWme
 sh0LatYVjyjtJWMcctS4rDjRRbljazGYApcDypC8KwRvidVhSsLJmv9jbQEFB4XEK0UA+wPuh
 WZ7Su+6AU8BZGqDMvwNKp3FF2Eq60hn4oSqBK58CzIDTw/PXwiVGCg3omomxYe2kv1vFPbKba
 QL+sNbj2xox/mSWxAyC7Uyk7j7s9wIpYKJMu9f2mCunW+Ia0s2v7YgjSqQOeI02KyWH19dR4z
 tJz8/FG5cGEjKhrUkPLBdddefhQcIi8tnArABz9PO7FE8U0HaLmBZvok1LtotK3IZ6TO8IVO5
 23tg67RIYeiUbLTip+ya1ss+xQsZIf+FQjd5ELL8bRpPqdPfWKuGJJZBLS8pJFUKwZ6xVIzRQ
 d4k3dzWSc7tF80ABC6CxFzTVOr8ghxAVCtKZqTNvdt5eC96kLVd6FfKsX2Ljn9kgLLwKY/ZKI
 7G5B1JkoMbl4IH1UVc3lOZnxwS/GcyFMZEhcF82e7Uwnxi+xMCQhsHSlbrTiRpaBkZ6ekU22a
 kCa19ijgbvgozXbtX3hgZzFrGJyJMf/5yW6suwOrehRCDqCPL+QYbhyjD4Z3IiHAOy8lFc/CZ
 le1nID8Do8/ZWawXgy7bgqATM4G6IQOLb3LQ48hSWwz7GcnrwdSFiW9VUl4NZoSbRdZBFoBi4
 g1qT/0t4uyIAGBOOUFW0E33g9qBKGYCF4MRCDyDn9kHEF/S2v0whuv22FukkpeTEj7Ge/h5qR
 zdJgTOK4If1nS3hSq7cluKhJ02x3Xf69Rv1MeoaZWUdR7b0lGu1yYOSXlb6sUsOIAkFToaRy7
 /3lnG+HIXy+AuPGZeda4jmHaRq+syw8pHMi9b7WNzB2Sw5utz9zGbE6SYSWHeHPFKMxJQcfZ4
 1PQnnUmD8POvP1URc65Fj7rwRdvZ73YDEYUmrwvrpO4HIEqY7wUmH8SJWPWY4fGBa10KBYXUM
 SauE68y15kBQXMs5C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The check doesn't support below formats and it will emit diagnostics inf=
o for them:
=E2=80=A6
> Fixes: ba35f8588f47 (=E2=80=9Cipvlan: Defer multicast / broadcast proces=
sing to a work-queue=E2=80=9D)
=E2=80=A6
> Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')

Will the tolerance (and support) grow for such quotation character alterna=
tives?


> Note: this patch also fixes double quotation mark issue for normal git
>       commit description, and now it supports double quotation mark in
>       title line, for example:
>       Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by defa=
ult
>       when checking usable channels"")

Do you care to achieve a safe data format description also for this use ca=
se?


> Note: this patch also adds diagnostics info support for normal git commi=
t
>       description format check.

Does this information indicate a need to split possible changes into
separate update steps?


> +				$diagnostics .=3D "Missing a pair of parentheses '()' or a pair of =
double quotation marks (\"\").\n";

Can such a message trigger any more thoughts and development ideas?


> +					$diagnostics .=3D "The title is too abbreviated, at least half of =
orignial commit title is necessary.\n";

* Please avoid a typo in this message.

* Which formula do you propose for the length calculation?

Regards,
Markus
