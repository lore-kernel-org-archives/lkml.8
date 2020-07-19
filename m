Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFBAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD25D207EA
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZoRVr/Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgGSIgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 04:36:42 -0400
Received: from mout.web.de ([212.227.15.3]:57945 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSIgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 04:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595147793;
        bh=lp69MfIuLfyui//osOAwyy4cyzOx3HEtZdTlkyzoCvs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZoRVr/IzRtqwwRL4ccQFACg13i1pCrWP7mCncLGeqkCHoIMtpcvuWa6XxfHiwZMJm
         GGQhDZ7Yn5Ysy2wKLjQpvP1aukA5kOI7o4G8tJWnDGrMfYyO8UeW1lp+Ndqie7l2Hy
         hoyyP16KLeQ6Hi3wolKjteCKx5uPK9Nu2JtPLRQg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.156.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Letgd-1kcn9i1ySF-00qk2B; Sun, 19
 Jul 2020 10:36:33 +0200
Subject: Re: [v2 1/4] coccinelle: api: extend memdup_user transformation with
 GFP_USER
To:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de>
 <alpine.DEB.2.22.394.2007180841520.2538@hadrien>
 <cf2bd604-3094-f90a-52a8-ff5a44cf3850@linux.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f97743d2-4840-94a0-8133-b751adcd9e88@web.de>
Date:   Sun, 19 Jul 2020 10:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cf2bd604-3094-f90a-52a8-ff5a44cf3850@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wokGH0B3mPGfB7Zo4fP9Nk+pSTuAVt/L+WKjXYbf/gabAeV/5Gv
 hjeQU3ocrjEqKvLCfzeikDpMuwIM5mlYgFA1YG7NDY3s+q4i3KDkdkZZMJL51ovRmQUE2TU
 ARJ9w1eWbSUm+4xlCccnjnJZKC0/IKERdfiXQIjJhAWiRJ8N+e3Lf+IAjYFequsDy9VAudw
 ot5ZgiCpDpSJVkUWm43SA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSwW5bnBq0g=:LJWhPc6eBeEvyhf/c/WvKu
 gg4S9Mnx+i3m+GqQPvWyqBtopIlpyigbhLChhsIqrh3/1lm7zD0jbcwPPMlh1N9Q+uvQH40C/
 zr7qJOCcVQf0pcQwg/AwdpxAfzyPc4ZOpBlXxvq/6LlRNHGfgqP0tvhefnXIaN5yi/kL4gtBE
 TQGuS9i4ZKL+3tRtD8EbgEH69JL+IvKcWk+ap2iWGBTKHOB9PWaYoUV/ATLT/N+rCFp+6WOf5
 ilPxqf5phJmV9y/Ll2jG4xKom52reYVrHvjQF44P8kwDkXmc7KrfcFowbRQYI62ziEX1tD/Bj
 6oLr9dAAMtZjTlFYm/YX8cx1a4EEIK6jQJD1oof+T/nd8zR61mJSrZ3Njoc2NJBUH3JcQmPfU
 wvci7+fiu0jKtD0LOIRQUe4oY77VEwoN3Ck9pg7n086BLzep2AaqNE4Eb+EqOdIY9QYjBH/+M
 zjSCWMzlFE2xLahjk6iE8w5yOM9l2avFc8gfRydEl0mLpmqOfp9NS/e5h18lhhgrEr8ngWPBH
 2sMIwvjVBDU1FSbgGD6YuEOfleH9hfhCl9w7dX2m8gbTqkDFA9GfTRO+0XC+LB+YC2rtfrpcO
 rZmcmcgz2g5AUjrxhyiKzK0tIxfGEpr01h2v6ELYkUoX70u7ipKeJF6LS/YWIRPNIs7W47aok
 mXmWZuNazdMeuimz9Pk/3BAqSE88RgyAj0RHj8rgs85BKduEEffzqAstkWPJErDkypx7nyWXL
 sJT5yq7I/oTAZPaSGjJUmwHdrGiL8DA+VwJc983nAx8/6mfsKcli7/CXpk0c5w0FrHlgMpQdM
 bVIWieM89cRGk3lrOYCwb/oCFIjk6Vw4xZqjpnnh5wLYJa3TSKGKHIbQ4AUZDMFE0nbbkK6Iv
 Xc+8ohVVrDhZRR63QLpk/nb8JnLyWWQgwMTfAEACfim6YIMBN6IP/dFsME8L6K+dK4CY6FPFZ
 rzXrKD7qWNiHFWR6AyNvpdEpAQ57hOLjJAmdLs9OIo8t+v2G0R/Po1dWzloi9EWrQ1wk1xd0y
 iYwAJr4AX/go4CkDW9zXZl2yZb1IZTPhpoXguPApzeKtjWiAf4sQjMM1obaLyapJrM8Ph1fXx
 UlYK6vugRynpb1tAZhKf0nhrCGrwDa8a5hwEJ6YV4W8uAZCdsZDcp22inTYadfdHljFLGPOkm
 s1L8mLwW3o3lk1/oTXa8MriNZYrKcvokGBwpBUowFMlIVG0a9fuUH09iBS11ikbbmsp7J++Cw
 QEQsRg29tLlwlIEmVImBs3c5ycaBKg3tnhcp3BA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> you do indeed need to put - in front of the second and third lines as w=
ell.
>
> Thanks, Markus, Julia. I will send v3.

How do you think about to discuss any remaining open issues already
on the current software development version for your transformation approa=
ch?

Regards,
Markus
