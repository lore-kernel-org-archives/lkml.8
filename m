Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51589C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F8424958
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cR5EI54e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEILP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:15:59 -0400
Received: from mout.web.de ([217.72.192.78]:45153 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgEILP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589022939;
        bh=WJWQjqQHs6wp1kU2LrLWAHw0PS0YkP9G37F7igi1a2M=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=cR5EI54epQMRE9vF7zG6ZdCoQqFivrN0+wpxD817UCmYT1c51NrU/dyV1HdvO2S8b
         6JCpCE0+7TmuqId2BzaCyQctPeYwZEQ+G3h5NSgW5ul3e4Z6pgpVF6Qd7POP8VMfRs
         bxgE4S56z9q1u7qTBrKFryAHTLYQVvhSYFRQxzVo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.147.78]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1jaUm42qmN-00Wxfx; Sat, 09
 May 2020 13:15:39 +0200
To:     Jiping Ma <jiping.ma2@windriver.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
        Yue Tao <yue.tao@windriver.com>, Zhe He <zhe.he@windriver.com>
Subject: Re: [PATCH v2] perf: perf can not parse the backtrace
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1769b8a4-fc93-c3d7-2dab-9406ea1eb491@web.de>
Date:   Sat, 9 May 2020 13:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7ADtn9W3m54GC9ZGBgEm7+ycBt038iVcc4bqqOUhT/jN5ShFjlT
 GGathQJdegHU5r+4zisVedPOJg4ty3CQCCQEKSaRHs/iPDyPEAIEKK/AQkpU/Mm3ygfBmkn
 cx2r42RvvZ9FnSyKYCJ4ek+W3sN59OHQ7yRS/TnMjs4hHiZb7nYbRdqKZD6pPNMnjaYFa3/
 BrekJn9DhsSW0nl0pLy8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gtm/SHwwAMw=:LGbrcdZ0tT4nwwuLVraPWo
 oNCUu9FfBjlTCViCT0XOQL/LETKlQ4hCrrSSQgDXpdBQeoUumuSZOEa3C0Cn+wvt94WFH8cDo
 pqN6ESvtnC7v1REQVloEqQ4i605ftzO25yXdru/1NBHrbxDYLBBIjYnG5r/BYjY7t0xt0fnBj
 vY9Vr8I5YfMURD244tc6wioV+jW+f5zDbjhyvjqfkJ5k3l9WPJDeK6R547hXMwsaIrnmxIAsu
 qSXFRYYr0+AmrnyzFseXe7bkoT6+Yhknj7AbVvom8BB/3Ks5e1VA+kdh4UNTSIFWw3r5Kmem4
 9U2odxgt4TMVbvFHPq8GwKntKnv+KmzAByTzDz+rCDfbtWjXHyEkQI+Uj3KvV88DxTEUsfV3k
 WYhFkZdpccQfHi8MzEOYceP+xuEUrBetRapwJAxVONpAPKM6PkVLPOrgdtNQhb1JfgFGdtfSk
 WNy6JqpOnrbCEK8mRX2oduu1KkDlsWGNZqhevfoubCoplGUsQ1JCigel0IJoWrXbyiDkLxkw9
 2Hk6j5PB2ztFfTDZjYO2Q4OntWgh1wza1l3ejNiXVj6SgTxHOTT6DW3/IRcq8ZW8pYI+Uh5C4
 +4PE66JecGhOlfmo7GfaW6JFVzKmqBlWlntfcR01+uv8GAxYbtk/wstZNQKUuZyIJdRCkiHio
 Tv6u/q2S39Ze+Nx64LOaowmNVnnsLKnvjbKsR9EE6DLeFOgaAlP2KNNdydb9G1PxWsPMa9CQE
 XFEOX8BlbsQ5sYG1/dt244KxZ8wTY16c/Y1eWS3/xCSlxWsGJ186OJ6IrG+/33Tz8t3b5dgdS
 OgM18dkF3qFzvSVewsqrfh8k1KV2Z8xhm1LFx1wIDgt7Fw0VvOSo1v0N7eCB0HnvrR+sudSqo
 vEiv0Nt2bzJ/t+buvfFVSy43X5dm+9q+dOOyqjlhr3qaSZRUykYyKruI6VX1zfT+u5Cjm8Ycl
 J4aYqxY6XOboxPo8DjT6zJ66J/pRlTgRsugCZJX2IiLQwvlK4plqhOB2QoEKcXsTAejkoa7tU
 KuaYRVRabsZZUiOhvTI4/OJDliM+h8h1grUBBMRhcl1NIncKv1E7S+Log08ZJ0U/hXWs6oarI
 8Sdr/Z+1/DosBs0tfhc5Bzt7PU9c7dVwJUVAlQDpXkODAsvNGPreNszwn8bGQeKzFlEmSkv0y
 exWqbRXHuije9NQobFHM9uWWUBPR1Hyl9ZmXOMfoGReTFyOH3JNRblV5Xk6Mk2wPy3M9EUB9p
 /Dag347WOm/CCXDty
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Record PC value from regs[15], it should be regs[32] in REGS_ABI_32 mode=
,
> which cause perf parser the backtrace failed.

I suggest to improve also this commit message.

* The patch subject was not succinct.
  Should any information be moved into the change description?

* Please avoid wording weaknesses.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
