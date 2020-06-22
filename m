Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE408C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847BB2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VZ+Sq4Ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgFVLSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:18:01 -0400
Received: from mout.web.de ([212.227.15.14]:38151 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgFVLRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592824664;
        bh=/5WLjwd8sz5iXYEWHrgMiI49OGUB+mk2Z1j2lPDY2Ac=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=VZ+Sq4YmeYHBNUwFww8q0f5H4yg/7iv7upqdTU19QrY02nT+0fpUwgid+x3b+VBV1
         fBgefrUjYf2TXbXDpD9b7iqlcJpVzmB7sZbwombiRKi7JBgsvyyM8c5onudsvqObup
         2FIdBIn2js/BqzjBRJUx4cN+vmzmacF2denFiba0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.81]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS17v-1jQ4151M0R-00TSp9; Mon, 22
 Jun 2020 13:17:44 +0200
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [v3] coccinelle: misc: add array_size_dup script to detect missed
 overflow checks
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>
Message-ID: <5f91ec99-5c21-78c2-f484-76a0b5bd3e71@web.de>
Date:   Mon, 22 Jun 2020 13:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:es1+goQmOENsqBhxvdebywUx/OyieJP5wb/Ee8pVOtvV9+K1QfJ
 /geXOz+u6/u1fho0wPPJFwnN4ZtbaaZXA6XvS8ZnXjvXafDeg1f2hShcmsq0ecaZiQM/neb
 WdvW4r+gdpF43Upizarr4aV6C89obGKBhO9Ds96VHfgSgzzswf7fiKrbpFFylIDuGbH7/Je
 PDhPZfM6OoU8kM/PbyJTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ojpzMAXksUg=:3o6/608ltrIquJhGJiTPv6
 d8A2NJ5P5gHixY7U6TFo62skaX2G3kkA3frATjvmejOtTPlTnwEgWOvtoBpBCNcPl9avHx7nl
 UbfGO/FjCg8+Fdb5BhJE8ZgfryZ+dp0cXcz55xNQS59cbiCZW+qoACM7ymtrrtCwnA4SPEqKy
 tTjyrVvwMMw7qVvEQaqqOhCkFpL7jtfgMSkP1DjA+TaL3EKXCFqMiaGC9I57lGCi8ZZfgs2G1
 vEexnWAN6tFle5WhTWJRf240DbksYOS9B4XhIF9mFrHQdtoNL4LIYDImfdAdsNUj1xgUFLIOo
 i6eEK3tSBsqy3PaZosvR17SXR4DvgZr95dmCBFh7LG+7QSq3f84EyMJWhdFGiMrPEXkFn9s8r
 BQ1NzuU7KU10iFZJNCJmkrg0HPTLC1nK8ldn7jO/PW8PuzZaPOkh+wgDjFFBLUgc18gRGO9fU
 COUJaBRdEWR+yL5LJeqxatRb3lPlUpx6I1u4OaG7G1xSV0JKAHYzkYehZqYvEjw6pOOR6KPGL
 mC54h4aeCAbvE0T83jxcDNVamP4gO49dK44PZCB9iiEVpYkbkGAShLgUjH2vJ4XuvDVpmeRVb
 RAkJJfEpBQ4abUe4+RGSIpFPrJRFcTwNQjLlJHV/8SyhLcjiclg2wG0K3dGOs13URp9uMaTDd
 ACvOol1DH3SMUVJz5Hkbz6I0zLuvL+UhpRMYl0Nd229BPvr/MXLmags66/SffiMLBmxKRqD7N
 U5E3CppfUEMk5Jsbi4rpPNIvLqIuyL1izExKo6RgH7KRk34oeYcXz+XTg9u07WIHrBN08uTNJ
 gM2Mx873sZKdo8msM7e6v+XPE4HLAhB9gp54cfaxcsC8y53rVPrfWNWdMLU81fMPCrglA9Pgk
 Er4liWNQcLGdhRtG5o8WN3THI5NUfW2AFF1p0V1XAq8zx4BJETqG4C4NpfF0kkUs3OH0v0+Oc
 5mrtk21sEQ5h5ZGkSPNhXeg8/kSonS+oqHk/wplQTjkyk8Uw5ninH6GjyX8Y88tkee2ZJ2s7l
 R8yNeCyDCc62ZY3Kl0rU9FduL1h8sKuIjRwtvFXdMWQwWfy8wFQ7WJNl4psVUFu3cEH8Vq15P
 08qRIRy67mbVD5zNY5VFNvdGThw+loy+I6tC2jxfC9lCfHQ+9koqGzjHIAXp9qKdrje1zWiFb
 eum+HdALXmCxbV1esikwNIWTN5+qIb8j1gYHHB6Kk1LFnKyydmUfZTXpK7ow4B6w7WdpgHjqY
 XopqEuBYJQLLqn9Ax
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +coccilib.report.print_report(p1[0],
> > +f"WARNING: array_size is used down the code (line {p2[0].line}) to co=
mpute the same size")
>
> I get python failures for all of these messages.

This is interesting, isn't it?


> I know nothing about python.

You probably know more also about this programming language
than you express here.


> How is this supposed to work?

I suggest to take another look at information from the section
=E2=80=9C2.4.3. Formatted string literals=E2=80=9D.
https://docs.python.org/3/reference/lexical_analysis.html#f-strings

This software documentation provides the information =E2=80=9CNew in versi=
on 3.6=E2=80=9D.
Will such a detail trigger any more software development consequences?

Regards,
Markus
