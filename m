Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB66C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741842072F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MZnRQj1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgEILfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:35:51 -0400
Received: from mout.web.de ([217.72.192.78]:60697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgEILfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589024137;
        bh=+l59GLSaJJyYmgkGic3MxEnRzt1Zg9pMcqBsDoQtzDs=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=MZnRQj1Uvp1CDd93+QJSQQSf5oKTjf6SJ3vZQGh9eGX/YRR3u//G/dvAxCv/nax14
         Sp6WFa1Ytr5bH/nVXGlgRtuIlCTQ83fvZmzGYxTc52FrDGGbetvlbkvBXjK8xILw2e
         w1C8IddK7qDoizNGgZQxDs7pj47tvl8CIlkfx/Ow=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.147.78]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Tu-1jalRd1lJc-00W8Th; Sat, 09
 May 2020 13:35:37 +0200
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] seq_file: Introduce DEFINE_SEQ_ATTRIBUTE() helper
 macro
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <050ec4c0-1bf0-3880-e368-41d9dc7a3f7f@web.de>
Date:   Sat, 9 May 2020 13:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lomFFwZjljkJmAMmwe1bu4GNyQOwQy+toXhy9VAz6pudshYSYQL
 iX4M/Hzn1+Cq+niiOGZsCuuveGlpHL7sfCZROzvph/E8h9zrdnwze48y9jythYAw1stJGmi
 dR7ssviaLDEdrMnv615eE0d6MIqhEgoTguyNZhbFcwhSdYm6IXP0aLqGUntkl08re+Y0XIW
 vziAsk1J6x0amko7M/FCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NzkCWd9XxMw=:qZbH4alA3u8eIWe6YxKcWP
 eropUKwoDbLaodnNX4djTEza/vFAcQCKCqDqB0HjG+XwbIZBpvX2ZqEC0m+33inZUjAeqsb6+
 N4yo5joSD/ohXbWSuNDoyB17iLSBktzQ3DXPC++ZWPY8zoyslmO/zucm+QKyVQVzEc9wWgVM6
 BrKnJw4bbwdhccz/3gxCdzyI16NIu3YvTHRhFdOFuH6I0bYfJyvHneqQMRq7YhK7Svj6sa4By
 zGPY8sR6dWkW2TMIP/TDVun18m3f6Q1+xyk560KIbHMXn7UMlQJakiWQrkjl6sXXLRxFaU+3z
 CZFuMtB2j7z8IzJMAPNtqAyaaBCwRtBu+j++bprVzrJmm/QkxqV710eyrEGQDxoNJrCLhtEUN
 HRaMxwqNmxizmuCzb0sl8QmJR07qm1RGfwtmUxmWwBtsZtUqlmBeNhAI568XvYdfFT6FyS+/t
 weJnMT5J1NA8S4c8TGlNhT45sAZ9TdtioUziKuic0URvYH0mlLLmh6Ke2qN+Mjv7JwRWYyFIS
 4JmJrb7QBHxNjZjDJgedvk/PiHsEEcsdFg88tE1IzyBxybyqhby27O8QXINLrtMl1dJfCQpuv
 /Dlr3gctfnGVSuim9JplxdYttVcfG122J2B2NLdTUpjcOFy6TAh0EMbR5ZttBuus/G65AL6Ik
 Y0Aiz0ozjnH4VkS9Hb0QfVAh8MwZkvJdX7sNn0108rXxspHX/H3m01psZYEj8F/dhsDlR6Oqv
 yDth/GrpPCT7bLARHwuh5CgAYMx1W/6k/4IFikYgczVU5Nk3Rlo2DWSOS3PPBg7CbTEj1TJQB
 dyM0wOHCkDR7/Iwu583WstNZq4btAbdY5K+EMdvVQjua3pVH43wbwU/QhEp1iauzaPtK+THTN
 c6CuoOrC6/gmHLjP9cHZ5UFO4OcI51Jjl1SqbC8FIL0NC68wcgow7cR9gcB4TD3WpppbirKVX
 jTUEs7RUFS13+QEji++5Tj+arJk+g3gUcwEIlqsrXms6Im8/OpVfhK7VUWG97FDbKveUMSN7X
 U6LN+P+GyXRlAvdCoPp4tK5vYI0XOBK8Ug/4kVILYT4TBOBFALIkZHoo3Ftw12MUyPXb9tWiH
 phHPYeWR0ZGp97nWnnRc9a2YoQY7sEvrCpCinAh40EsjvjtMT4w0SUOuD5qJLQJOB9UjyKT5R
 WE9Qu6MZjDwJ2DxplGPy+AWsRtabTdyrF6HZYh3oY0QV3aa1/mJdsvf8atM1bEg6noMi5kQ1g
 xR5v5m63Bv4q/tqYF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/include/linux/seq_file.h
> @@ -145,6 +145,25 @@ void *__seq_open_private(struct file *, const struc=
t seq_operations *, int);
> int seq_open_private(struct file *, const struct seq_operations *, int);
> int seq_release_private(struct inode *, struct file *);
>
> +#define DEFINE_SEQ_ATTRIBUTE(__name)					\
> +static int __name ## _open(struct inode *inode, struct file *file)	\
=E2=80=A6

Can such a macro work also with an identifier which does not contain
double underscores?

Regards,
Markus
