Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C791C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1D6206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sAX0Tjve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgF2TJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:09:00 -0400
Received: from mout.web.de ([212.227.15.3]:47885 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730792AbgF2TIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593457715;
        bh=SjJwO36+LEo11f5tdUs0qxg9Z/7UILyq0Cmave4hjxI=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=sAX0TjvexmpTFVpFy6VBjLnw8nlKORkgskomJdZ08zCLT4HMutzUh5oABw07yv+lS
         MH3QcHMZxoZ6p+F5mRqeOj4D1WV4HG2IdqG9p7gQZTJMkaC5o7N5v6NO+Z6Z9Lk6KV
         wA0Sde8U5Y9U0/JQaMJxdNX9EHQAimgiGGr71oI8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.123.16]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhUQ6-1jTUTR33YY-00Mdnj; Mon, 29
 Jun 2020 21:08:35 +0200
To:     Randy Dunlap <rdunlap@infradead.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Coccinelle: fix typos and command example
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fd3abd02-81ae-8c2a-14d6-2d7b650facff@web.de>
Date:   Mon, 29 Jun 2020 21:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p6BZuzQuN1w/ZRW/eOFYrkoAEFQLsFV5V06tI5esYcBnj0RsPGz
 dk6gN/VRlU4FMCJH6+vu/Rj3upFGCF9CFAki0AsJ36ZDQh1AauMfH5tKtdY1DnPqxrO7SZ5
 7Lokryf4M2QDV4pEwCYVFmGROiu0y2IiLIbPmW8seyAa3SEe3z4OHmHxXHNjJ3X0RnSqnnS
 sDrne/9UwMPCEY5OrinEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MIMWciczPuI=:RF6sLzyKF17JDHmOm8cJ6a
 sEztfH2H8AMrlyzRJZaPq4uABbFyOXZEbJXjEyDMXHV/jJbtAzBaEu6MQOWWSuDomtxZdqNsK
 rOUsL7L1K0f8mItezv5Ke4fRHHoZJk9jWDr8Awc7xw+8wgeM42KJQSmMuX+eAFe3cYxSEi445
 MWy4UnWCtLVEJNNRfDe7HMMTv522w3L0q+wY07DfxYXXhLXVXAggoFLwnfxv1mqPe1KEUj3vH
 Q0cbTMpx68orGH1J6EN+M+OhknFrogDATEm+yqwrzub1XHF76YqFlgvQ5a866UNq85DZvwqwr
 bb9I9bckQq200qW23HmMFLg+0Xkt2tQzZ1n4ijIZdOV/AGlWm8OOr/bSllosZzF1xLzLq4BtQ
 WYOARto5o0cy+sQUlTUSPuhz8bAOMIb2BQkFIAeSCeWky0cTZnEOWiLUTZjUVocCA7CnybxXQ
 Luu9J0j4bpFVFvRP/m8KUasjqt1jgSTxkPo6ZILzOcNKjkPb/nqwgbK+o26IhGVJ7GiGkKcBD
 Vp5/CcfyeW+okmdN1mayGwQMCLbAW+Q3KBVn7kD8GUuT1aaqC6FcMepchTaiE4y8wECuT3soX
 0zvwHJAVp3kPwc2VwMvaiA+rPLixFMKPeH75oTxM/yJqusviu2Wx2xXPM+OESzk8zmKyNFeL0
 OmRzEisq8NGMACNX/nEfT+PTxjv3avrtpLU1LLPinAlQWLEd93GkoVm5F7k41FzyDbjgvtVsw
 Zyrogz6zMrOFw5mBdvP7Vb+DzCWLPiDNqPgIgxJvF6SCRM4z86V/9j21QMFembC5Ki1JNgwFL
 zjtRXhFqtEYGO603xJODLygXwtZw3xP2AFLm0XRLbtpTpJGeczPvkHr83EKYrJ4UEYxcCprQG
 B1RIBW0I6PBQvNHm5fZeWdjPx1Q93+IoHqaenmW0o3ueqMbfX8VmpmWnZ5oFHEEDXAPfHrihq
 6tqjttDIbfpRkCiZoFH2UcNjBdFPxfd1luWxRe7iLFmerL6ibvkHKH3s5rut/OH7pj3AQP1FB
 5RCwikyyknJGHFYIa3rB7t+vEOpWCXYwLS875aR13rEYVcBMXrg3nJh7GGlLh82f5OEaXVNlY
 0J5TN/rhUr8BMl+utjkoeDQRWWoWnIpRAji+6ZMcrkWDSwx0mBE/s29+EkaJ5G8PqSudSnf9q
 Us33a89K4JqaKDrxmoTHwPhJaqKaR+0L/CNmSRAKfpFRnxptVRKvUf23TRU8Gc8BoxcBdPp9e
 W9FU1aXZnVkwUxUgk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> @@ -327,7 +327,7 @@ SmPL patch Coccinelle requirements
>
>  As Coccinelle features get added some more advanced SmPL patches
>  may require newer versions of Coccinelle. If an SmPL patch requires
> -at least a version of Coccinelle, this can be specified as follows,
> +at minimum version of Coccinelle, this can be specified as follows,

Perhaps another wording alternative?

+a minimum =E2=80=A6

Regards,
Markus
