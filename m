Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1403C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6C720872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="P8xRdqxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFAFsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:48:18 -0400
Received: from mout.web.de ([212.227.15.3]:59209 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgFAFsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590990482;
        bh=3NfdEOcEuVpzHL9fLwQi+w0me4LqMXjJFSJdC/uf5L8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=P8xRdqxh7FvbjIqH42zo0uh9RUAyxSKyEWdW+qB9YcXiVLayEkeXX6lYeAJUxo3Ix
         IHwWu9A9H7+iUO28kcQlqC9e2a3jtV486zB4QElI/R+t7lejocYzB+NzQaDcW1Ehbv
         XcpdBVWUfTtqi6leL94kDoNDdE3OgNJjlTFXEfwU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYw31-1jTLNp0J8t-00VgDQ; Mon, 01
 Jun 2020 07:48:02 +0200
Subject: Re: [2/2] Coccinelle: memdup_user: Extending data processing for
 special tokens
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <02c75f13-ec79-f4c0-f28a-8a354ea1f6f0@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6cd81cb9-7fb6-bddc-65df-c3d50677ae7d@web.de>
Date:   Mon, 1 Jun 2020 07:47:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <02c75f13-ec79-f4c0-f28a-8a354ea1f6f0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IqoQ5dImrO129UCFy2lJjRF+bn2zNZpg52mE0au73MyJnd+8WNb
 nQYKpxbfZXHbE9NMzWf6G5xZ3YM5cpZvwL8USfURxSHvMOk1OYeYPPdY2nMKI8mrxRRMurX
 7n7ALMbGcm2oA5jfoaMJ6tXT4AAbD4NgNFpbeahbEml5dXcdiEFxffz+xJpUDDBwm0coEve
 9bWrcjobqSA2hzRw5Xp9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MEQ4ZoR97/E=:89/TNEFVVwGZjvN9ZHHTDG
 7pl2dFFVfDgQhkZWyGwCYghDyGUd7iF6bv8AIjUlnu2WXXZ8AC4/XJZR2iFhB3FW/YJo8Xzj3
 mwoNNL3/ZDo1GuavFEhtVRBwIfsocDxDXZrAsUobfoJXDygL7lPYMcqWZk09J4opKPzboz3oD
 /sJ3pkYiCm8WVhL8xamOwbyOcV/JIvlyj8orLL0elAMTHhFTGzIttQbjA5WtzX9/+LDX4JZ3z
 xUpxjNMdQ4siLPqyW8my4Ig6kxaHESS6/y0GpezzF++W4oN/+ODXGiRnHceZuze5NXmBRx3K4
 yDI5Qcd0PXdOJVKrQsZpHnyHc9Nvr9DWhw9Q9aPIU9mcUbGa3Y5jSDvYx+cE+o849CLku0eyU
 Vrxd9jtSlIrcopofICaq2uPnogO5yzBlhwoiKcYD2Ys8M9t9/PON6YWpU/bq3a7EEREr30QZy
 ETwrsbNQRulhOsTtjkuOf+EgC5nsHwsq9DyicT3Y9h4ibGKbUng9ypJEVHZbdoDKCvj1tMH/X
 +zoQrJB84oeR6pnnDeHt2/mj7tmj2NB7Ku8BwJf9eLS1631djYnVgJsSgPfoCxfk+rgKkMiY1
 7r14y4ekWJdQuY2yN7B3CE8aIKvyDF0jmtAy/wc7cDet6E3HOC5/AbiRBKO+L2EjYiJG8TvwA
 Y5XeNEJ62PEpD5nG0TnyG1q6zmOU+xPwKeV3ngTDsVyTNG/TyVPo5/09GxRgvkWXBCdNS+MmA
 zh30G+r6gWTbY/6ikE2f4n9MV+SDDotkG9pupf3o7/O6EtF5W3FVNsU9oEoUiuPtg/+Tl4DLJ
 BUIIMm1JjZZvKLXYAiRt8HIeLy+XJTjb1QXE0uKPWmfAqDeva3tcmoqGIWBmgKP5rGa5E21pw
 zys9GOeSTKVD6jcEUznxSeo8dDnKkxyhK/pGwfccgshE/olUWHf3vMy30leur8n6lPHvZZ/DQ
 3ebN8Xu1uBn5M3r+X08vATTUICmPLrCGoLe7DCWmYd6j2nK8HCbtlaDTNRac6rk7kw58eH8qL
 U7osNA3MHLEsdPw/yhyh8bo99RrLF/bB7YrayctLlDunag0m9INfj+BHUUcBpah2Q7Dp4yd/S
 QjtXshxVp3xl/jj5TYlNKk3JrdxrjBkP1BEy6Bb6R58Y4ux7rlULgbX/a0Zz/shvZ4ut6Vy7g
 jXb4x0qv2Y6BRV4jJ4halGA5pH7UMh/Q+rbS3Zub9mJt9tbtkRhfWN40m5dV39D3t8abtcHDa
 AEwK6VRcfFGjlJiuf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, the Coccinelle software does not like the following
> SmPL code variant so far.
>
>  to =3D
> (
> -     \( kmalloc \| kzalloc \)
> +     memdup_user
> |
> -     \( kvmalloc \| kvzalloc \)
> +     vmemdup_user
> )
>                  (
> -                 size, \( GFP_KERNEL \| GFP_USER \)
> +                 from, size
>                  );
>
>
> Message:
> 25: no available token to attach to

I have adjusted a bit of OCaml source code.
Thus I could see where such information was provided.
https://github.com/coccinelle/coccinelle/blob/7cf2c23e64066d5249a64a316cc5=
347831f7a63f/parsing_cocci/insert_plus.ml#L1041

=E2=80=A6
  | (((infop,count,pcode) as p) :: ps) as all ->
      (* =E2=80=A6
	 modifications.  for the moment, we thus give an error, asking the
	 user to rewrite the semantic patch. *)
      if greater_than_end infop infom1 || is_minus m1 || !empty_isos
=E2=80=A6


Will the referenced comment get any more software development attention?

Regards,
Markus
