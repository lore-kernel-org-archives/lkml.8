Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3D8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6B52073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pSeRxcIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGRMPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 08:15:34 -0400
Received: from mout.web.de ([212.227.17.11]:34373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgGRMPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 08:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595074468;
        bh=U65LMVBBoufD+55SxpSXNUDIDOZN957aglckxFtMk7M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pSeRxcIYUW6U1C1hF51L23RJN3Fz1nRdEDoQCT94kgtP4FNL/qEiAOlj7S+1Dqs76
         8UFXNoRWyN/i7ld/W07Nb6o/Z2K90XEjKq2MKM4Guzbi/zPADwZOOMpPRkDngYG7Is
         K+qJbkzuoyOttHdj/aHSQkPgoIVg5G3OhFqrNFw8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.120.168]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVtxM-1kKtG0021o-00X2EL; Sat, 18
 Jul 2020 14:14:28 +0200
Subject: Re: [v2 1/4] coccinelle: api: extend memdup_user transformation with
 GFP_USER
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de>
 <alpine.DEB.2.22.394.2007180841520.2538@hadrien>
 <fa0ec546-9aee-5c95-428c-a225a3521f6f@web.de>
 <alpine.DEB.2.22.394.2007181034530.2538@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0a961d1e-6bd2-45fd-113e-9258fe00a16a@web.de>
Date:   Sat, 18 Jul 2020 14:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007181034530.2538@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xRL2D+hWXFUp6yx33y+vyQ1zbck9m34U56qu9vxGBg4dbDNQTh5
 T4shAnnxdLykE39XxSayFgaNXsYwpihRRNly/eWM9S32je5qMD0bw5ZETuKOSm/ucjqYMNk
 I5Y/F1FX0hoLeEOQKA0IxCK6RtExjAQ9qiiogHzntt7JCKpt00ZHi6Wo3GL8Y4E0LZ8s2v0
 7hCoBAJXBKrOIdocKkQfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:se6+j1wCtLM=:GeJacnAQ8PPSdFrECjC7Pf
 nDj34N9QqNU/+zU72XoRwVvZ61S/jabptyrFNj9GcoPgTGOj0jx1hMgdiE420QHX+zkzD39jj
 0sbO3f3zR+R4DH3TubMrIYucH6t6MPb3CAWXbRxgiJsUctKiEka0WBckzPAmXPr0tgHaIFtqx
 FF2Q01ZcOM7zlbZeKWOEu9vlr8AH0aN4L24RrD8lwgTIIKBuEAuW7ElGUqvoVcem54EvlQs2e
 Y8w7KEbuT96gniZPMBRtrOit0mSnH6QPQrwq68y2VYSrzOdbZkDP74r4KfZSxC7hZhNsaMeDm
 r40SSzP8f0nMUP2MD0W8F35loGSQwrp33DxMjEJwrJhrcW/2edZ7Yi2GreBVuQzJxTEl633Vr
 AW/OHss7ZyqYVs4ZuhIEzXAAVIqTTDl6iHfOv84ZZLhKFx04jui7aUunNCFO4wAZgS1I/0TpO
 EAei0iUaVDqRF/F51+2DWNaCuDubqLdwMa71sPcLKKP3geFNq+sV9zRzyBvQPQ8BPphPJ4OJQ
 qjTHTHcUXyH35xSVEWSj7i3VYZU7iYZmy5Zh9D7gFX3w/OcRgMF61bAneGc7oB3d0nempDqzz
 +N+cEmxMoP6ke4ypof3MX8uCG7DkgJnpVjdGlvl60o4MMf7JbcXhCdoXbwwMYCuVFcw6HQqA5
 T/CUXIjATulPC8QaNB5Dto8jH1o99uAhYyWGlqCoUwhtwQaktI0p6a6NO+vl1GBlaAyU/7NmT
 D6PBYJHpPJotn0lqSMQEU+BBqMOnlTTquHI39oPpUuHLn0FgQWGPNRyP51XsZqgzq16TUzG9r
 lNvTvS8Gx9mOrZMo0uNKsR9z84/2kgN85MwFIgjvZSVgCGXDDX+dIM70sWlCu0rHQNamydwBY
 dbKF1h51s5KIdH0jRkS86XPVzgTTlm0RTDv66hdGz/PJpkQLOhu3p0JHImJ3D+vgPOYNJCZbG
 zUq2Y9MyvsqJZ/gntzikt34q8hsLNUZuBKCpOUQSPSx8cAJpWC+SwmjW92VC8uSckIAglXmg3
 m5xx1LMCZiyxNr/0PmWDr4U0B1UTfRLJDjAfovwPfDhQ3+ULAKioo3tud8d6K7ZclShGS5GF0
 MNgeFdT8Mr3madUMDJmZthp7AQlRs9M4GnULnQPhkJotYhgl0VyGgsUAovdncaDkAu5s2r20y
 FGScgTOrESEL9TbEDW5Ce5V6iFPqlwWGkhnUmUW68LKSco46URA/t0g4M63xHPLh/Y4ZPptwO
 5ly3dGM4Z3cKRTOjFdNpdoCnxsYl6zFzVsci76g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You proposed essentially  \( A \| B \) \( | C \| \)

Will the software development attention grow for a topic
like =E2=80=9CExtend support for handling of optional source code parts=E2=
=80=9D?
https://github.com/coccinelle/coccinelle/issues/53

How do you think about another tiny example script for the semantic patch =
language?

@display@
constant A, B;
@@
*A
?| B


elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --parse-cocci optional_d=
isjunction_test3-20200718.cocci
=E2=80=A6
warning: incompatible arity found on line 4
incompatible minus and plus code starting on lines 4 and 4


Regards,
Markus
