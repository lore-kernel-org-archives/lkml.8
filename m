Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88785204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NPneonDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgFRLf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:35:26 -0400
Received: from mout.web.de ([212.227.15.14]:34417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbgFRLfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592480100;
        bh=mrk9KN93Cq13swgTdZ56LeduK37rnJtF/Sv4c5hfqIU=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=NPneonDJGToeMbjxAT+qmM7xwfT3m0x4QxVEQiWFJh5gbUtBC4sgg7xjGPQ6rwOLv
         4x7vAxY/tRLpOXW9EiAz+G1QGiq93kHme2fJ/sKLTk+iWYbTUglOn4WiDf7EOe3tIj
         Caa7JIFzfLG0QSOaQDauhjldLtz4UQTidrPXio4E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.102.18]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0La1Sn-1j2hAM3OQP-00lkDk; Thu, 18
 Jun 2020 13:34:59 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <54ac89f1-5f38-8909-a652-c658a5a1f36b@web.de>
Date:   Thu, 18 Jun 2020 13:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Dsq4Mo4EkdKR8BRAGjdd8c2NdEx6G8+Kdjlot/fS/RILhfftby
 4gN8IziJBUTiEfT/vy+gIm8fCSqdH8qYJflL6nlW4L5s6CYIlSeoB1q4jlCnKE6o3Ds1UHL
 h/34v/EBKxS+gKXB2pIBnbnP06z83oqZzQfLwwUaGnjtEkxDI0b7HPSIQWQ7UFrP6EwucDr
 gMH9bKNLy9Cg4nchBbiog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z1xSrbl3LBo=:U0HD7SMPsYBVeB5MUzfN87
 GUiNxltBIimtTQLZunA3arKQWjQyC6OX1cTeh2+c117p5QK8S30KuOgCjCu4PkChlU7vggN7a
 kBiW03juwhAMF7mzqt2OQeRM//gJIWJgoswIM8ZAE3C+j7YoDWoxAeVzgBNFADt9PZMr+yWai
 GnZ4Jit3uByUapCg3skMeDT4EVjvyyTpvLwjxx+j1k7wYSQ+s4ciJ1OvEC6l3niILA0SzYw+G
 M38KifDtnumbiC1zYrvUQalzYQJZk6MFb7U868oZJY5gwH11IX2iyCvDMTKK36izkmIXM5ASs
 cQo3fyWZJXp6S+VbaryLW9LcDdG0+n/nIOfl4mOl97dH09viyFYoqVVVEFY05czehja7s2H/9
 sVMlbmdDpWv/m7DbixG7+x+p4RCwRjEmmQ40690Rn1GracsmGoPKz9sW5WHevbAzX4NdZkefj
 dwZvwQ2nITUdBY/cTYD2JSS0k45Ja/kOgy0DL55nqi/5G5z7EtPt93dFeVdHUjhKGNGfndV/k
 mRjsDSnoeuH/2F6n9nTu1xlNe/dQC9BePUmCTaEbPKz8u8ykgCTXV48h0c028vE/nZAtW/iLs
 dm/0QVo5LdPP5vDPWnAktBO0T2MVK0qNZaLVUrqQ1gF+xTPKHxY/4YOdcq6GIblwUWtK2EXJA
 3ot/qbICNMxDwDFT6FVtwoOXzIMaNppkKKyDWn7heoGGFsEy5mmDAFsdbvI+F7/sglw4oIrfA
 wllGqltgMRVDVzL3FMZA1jJ5CG0DaWsbbKtVgi0r0gaaGtTsly3wosWsHpjXcbjpJwvg+CfGo
 klRIAT51tOPlyM+29QVmuyjIviI+PniahLkrqzK4gMQ2C5WX4QZnOJ/rIEgC9GFZdcYVwOHfO
 BVZ/sYy0ucKM2Vf/DKDOz72D4NVGiKVCm69Nx7CsIGpzbQ1clBblUYIkn7ZP5F6QETUbr0vq5
 /shlRmSPwc66b65ZOEVb31fEcwtLM7wmjQ/XyRA7J0+OFFzGBgBL2a5b5tC3S+UDKTyHbDZsm
 eQ3A0rwuAiujij1a0E6J3kxr59JHxAdqMa9bG6HqD6K40HcDNsWYREqA+x7femliJmuX3Yb1P
 A/Mv4JqWdGDcUG1mHRKHE4kLyaD7yHVbiA2c26lnPrvYNdwMfAaiT6qPzyD+6yGgHeVw1q0C6
 zPrvXk91C0pR3apPzjli27cRcayXNgOmMzj/ZKUb749s3NZ2Gw//rt2/cghYnJbgUmZaMdPav
 98oXw2X6fPBSpC5BI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why did you repeat a typo from the previous patch subject?


> Changes in v2:
=E2=80=A6
> - assignment operator used

Did you add just a metavariable for this implementation detail?


=E2=80=A6
> +expression subE1 <=3D as.E1;
> +expression subE2 <=3D as.E2;
> +expression as.E1, as.E2, E3;

How do you think about to use the following SmPL code variant?

expression subE1 <=3D as.E1, subE2 <=3D as.E2, as.E1, as.E2, E3;


> +      when !=3D \(&E1\|&E2\|&subE1\|&subE2\)

I suggest to move the ampersand before the disjunction in such
SmPL code exclusion specifications.

+      when !=3D & \(E1 \| E2 \| subE1 \| subE2\)


> +coccilib.report.print_report(p2[0],
> +f"WARNING: array_size is already used (line {p1[0].line}) to compute \
> +the same size")

I would prefer an other code formatting at such places.

+coccilib.report.print_report(p2[0],
+                             f"WARNING: array_size is already used (line =
{p1[0].line}) to compute the same size.")


Regards,
Markus
