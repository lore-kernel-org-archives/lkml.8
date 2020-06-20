Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1307C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 08:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8928D23A31
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 08:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ShisUiao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFTIcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 04:32:11 -0400
Received: from mout.web.de ([212.227.15.14]:39511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgFTIcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 04:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592641856;
        bh=Do/9FX4afsLmrfLMqB0ZguGLjPD+r9XVnMDpe6e4Elo=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=ShisUiao1BzQVNERMtlqEPl0uXM0dxx6I+YXdSVHEA6fmq9t9OJRIAxJCss+psUG/
         0lfCXZ2ax1QC+D+dFw8RorjnhPAozmtLwpBZna2DZm1vmV/omUjYBRO59tRc8jiDf1
         TB/BHdkQZroqMq9iqQjQBdZN61jhPXHPgqM/uD5s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.139.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1jcQQn1FjB-00AHsV; Sat, 20
 Jun 2020 10:30:56 +0200
To:     Wei Li <liwei391@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf list: Fix memory leak in print_sdt_events()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <83ebb281-ffb5-483e-fba7-7278fc621af1@web.de>
Date:   Sat, 20 Jun 2020 10:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IgM61iDZjtqNNHsKY8CB8GeUoC+E59LZzYp3HIEpxIUL9R8/Hqt
 0k4Lu5J50L3FFmvdpJ6mml/INys7fR60mpb4IJKOg8yerWAaq3dLoSiZKVJBy3osLlBvT2m
 IyGlUT5rBcqMcsHiEi8gXOjeKtsMGaYJIVHs8rQz4KkZlL6Z4V/tVKfkFZoB4E9NU5Zgj/i
 QYVy3XNNaWb4nM4KlrQlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3S7wSoACepg=:GdrLLnJ5kfN0LUSsnfxVvE
 H6XVixkMZKVv148Jn9IWGOSv+Rp0g67spFV6CZwyYcD66/J8DQw9aTumONc9v+B2flC4PsMms
 NaGA1JoElQ8Ez/bMRKzMDkjYYi1qYWtLOzqAb1+NhsA69ycyT9xBtasOdKzPOAU8SZSam6E16
 wAP1sz4wY3OEm6SvPYf66nhERxMeIYq/wnaXAq7hCK8vtVdaZ9zczqWw0422bx9rob9Qvb3UZ
 HYlaxaWZm3ZcLp9PRWV/efS9VPAFdCx1qd3cwLdy3VzuvrV2rtIP6GztMflNIDWYbu9hy9K5l
 nPwToJsQa9oarDAb0b0alE3PNDIGnT4RMPsSP1b4FQ6LfJc+A15gl7LDyodOohAqS0Saup+sQ
 MujzTR3QQaxlQoD4LIHiXM7rmFG+keOiRy9Tdux7Pt5N3kaDzINuwuzCdHI2TFebgFAdGox9W
 WZ3MMJobmf984zs/DbTWfZtpLcmaK13mM2VUhf2V5umiuJNhIx28DfR8gJg7fSrRtjZWU5MA9
 ghxxIlx25JZlotyXNy8EfS95ENlzdkOpbbFn5JnqIZ2fSiTB+yvQ5HVvqBc00cbRzyKSu/xtA
 zcbDW/pgzHwSSxlQt5MT2en+gVyhDph9i+5194PafFl/SLtcJpHjg5GxS1gomAz/z7MKpG6iN
 9Nor5rnHR7J4RipkwaWHJgHIhJwK6fbOBOS8+DJ1FdbdBmPSJnCnJC/CP5dHgwScLNzjXzILx
 Mb6itsuo/B4Wdi3tXFb+TnIYBax/pNekICCtpbcO2ykN1H772drfT8H1WYCR/IYIobfRyq/Di
 5df4/ldGOM0A6DVf1GgeJsBobQnzDwwSc4gqbwCfQu8KpXIYR1rG/9W7T9oE4/3Z3kh9P2ZUR
 1Hxs/8X2Mp22eZmS0QN598Le8XkwMyxKeuy3wki8bVmmo4PpDCElwq54Ysq4CzflwlFlLsEtv
 3Jc+dKqEoRXuZEas3cqqzL82sBdLsdla5VkSU6btIZLwrPDuN/km7FkdyvZm2G4vGf6RIVwQy
 e/OqJq4LWBvD1l8fDCk47Pk2D1H2E3odTi01jJKmr/PuP+qIC2lqJtdiwLtA7E9mXP/215Fw5
 HUqLdp3WL54rr1vjcUy0HEahl+UY4Zs/JTM5FIuo/+waQ2kcQn8wil3n2LP9M58x0eGsC2vq0
 XjgSi3t0EschFoOFkvgTbdQtvSKFtQGBo4U9tMQOoeXmT1qh4h6UJJcTvvGBjqKQjsSxNGWna
 TQn4daB6TP3IYJUTk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Valgrind check info:

I suggest to improve this change description a bit.

* Would an additional imperative wording be nice
  (despite of the presented =E2=80=9Cleak summary=E2=80=9D)?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D4333a9b0b67bb4e8bcd91bdd=
80da80b0ec151162#n151

* Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit messa=
ge?

Regards,
Markus
