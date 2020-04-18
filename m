Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33052C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4822250
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ABlpc9cJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgDRUAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:00:41 -0400
Received: from mout.web.de ([212.227.15.3]:55851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgDRUAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587240021;
        bh=b34gshVCmUqeLuteDgg5/sGl8QG/KrAMIesadNvuyHU=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=ABlpc9cJXnjEU3N95aUkacrTfrYqybMhFFK6KcHduAIgXxEQ6oo9Y67P8BSuo83Ib
         JITyRP88768zPmTe9Z9TjXgA4tffufSE4yNt+kw0XD5+UMFhqNlDilwsyCUPVGx3ZA
         ATjWPSOHoBQPgomVpcHV/QOz+rsKMS0VFIJkKRBM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.116.87]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwI74-1jB7gB2Kqc-0180XM; Sat, 18
 Apr 2020 22:00:21 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] m68k/PCI: Fix a memory leak in an error handling path
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-m68k@lists.linux-m68k.org
Message-ID: <2e00c1f1-8faa-5045-ddf5-2bf943f714f2@web.de>
Date:   Sat, 18 Apr 2020 22:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OelrizYe1o89n6DadaCsfn0GjAa9KxJ2BXPw7OZwI4VwwtjHU2w
 aJFRVDxxDEyk/RswOVyBcemjcE0Y86+Ks8iO2ydqCA7xe4GjfS2riM/3r5wQBPasXRsy4hr
 gSUm+aRBDvUCsV2QAaYnnPWNiHBgGDjEIqirrQR5ozbIOKoaiYSfHjBVeBegPyEi1WTw46y
 mOvncCgfhpFVRmG+SuH7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCXTgqrRPO0=:3W5MzRrMOgJSwYmpyrI0uF
 fj5vh8DZc+smnDzVDS78j654UvfH9VuaQIE0SWW5q+8Rm0ewHVeITg7a8H4EIHcOXElpZDGAC
 WQaC9qNNm4n7fqcscmgM+KGXTA+sKFko08dCH+Al+tEGycwIoa5zYsjyJYWe0UfQfYWvCzF6C
 ArOpE+wvBIiQ+M32HII6e28B9nijsUkMSwbLrIQjgFfxw+rLQI41868vy8i5OZsM1f1dsbyIY
 KYfzW4Rb4Bb/pZrraQ0GiJtrh4cCKqn2ktBDuvS8oRU97uM0OZdCXqIVGjawTKv8371UZu6Kz
 IIdCkTApZIot85tLtT6S8aExphMw2F/moSTGAIsJu/Gt2H4UTiZjUDvBh/bkZE8qNZQn3Ja3p
 B7EzJi86ZypJhPca8bYEDC/vaSLQmVeSRsltogJO+n9gDZ0fGbA7FZj8AlDs2bxPKDlJi5NE7
 Unnq2RjvI7F2OZeFL0+MEoK19y0gKQ3MxNuS1uxNt6rrXgugwTlkPjosLnljUvfQHdHR1F+jy
 8b7W116LsUkKTvu4cxKUZyRfObOcxCCGlm4z/XpyGC+rsHtzClJ590NMMzIfHqJdaJc845r0K
 z3wAreVa+KQzyGAr261FOGbBQvFXDjB4xH14M6Bid1OQ0ssd8QVA2uBGrkiQnHm9Vsng5p2Mx
 oP8Py9bUHE4pJGQb4i1yGPfTLLEgxo7cYsM3iLJE3lf8haDBvYI0rFLZlSYyGj8ItN6r5RqDJ
 fp30O4/Y1kUuqXXjwi1eHsUS6pP01HE6hYUhhCNzx2EitUzLXcbcbhjNrNolnmAjxz1Wp+jQh
 izs5VHh0FfOFlaAEBYQ6sS+JZH7qSUsg9Yq8JblT3uv5NDWi/1NRA4MMDkDZ2jGWjSAyxeHfJ
 0+dI4eaJRNZdHLNKTNtayvDLKWPjgRxssw8nPfoR6OGbHc4P9Awq5w8GqGTIw2DuqgxF0wfzJ
 vkUGoH7klliv0+8BBY7WOG//SVM7tktnzkhJMVPsrHhopqq5AAF1hSMHjPsuJ7fwrpzqTkZym
 uyOApagEJ8I7epYltitICbZ0p2wM8KYtWaaV0JeaooEBw0AwnkumhMleSDbsxrE3lrVNAd7ZF
 fD/H0mET+/HJT14cSTC1g9dxe6ePTaHFcCZasZgL0BTRlaFz83U1mslzyA40qTc0Iuwy7abzW
 CkzspEZyQwxPbDTAizt+RAHRltoOT27GOD9KuUcB8AkyBOD45hKi7Y7KQ/7cO/cQdHgR+rbqL
 FHHay2LFqu4UO6BkA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If 'ioremap' fails, we must free 'bridge', as done in other error handli=
ng
> path bellow.

I suggest to improve this change description.

* Please avoid a typo.

* Is an imperative wording preferred?


=E2=80=A6
> +++ b/arch/m68k/coldfire/pci.c
> @@ -216,8 +216,10 @@ static int __init mcf_pci_init(void)
=E2=80=A6

I propose to move the pci_free_host_bridge() call for the desired
exception handling to the end of this function implementation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3Dc0d73a868d9b411bd2d0c8e5ff9d98bf=
a8563cb1#n450

Regards,
Markus
