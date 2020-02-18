Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3200C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F320659
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPqV6iz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRJTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:19:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34534 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgBRJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:19:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so10656582pgi.1;
        Tue, 18 Feb 2020 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8w6bEyoNMZ8GDT13mdRKLob+Xn1ecdp0CQY3QFDsyDs=;
        b=BPqV6iz2bS9MAhgLxm7OeM/o/qlK5Wua9oMkKpxtEeaRf9utiyPHZ72av5ngMciQRR
         +SrWtaC2oqYl3tfcI0fgn8LvStvsFpniZ1QbogwBwTEWr3SkbtQ80kaJ9HiYNWdQcX+q
         uXSG+MbNYWg4MnTnmlWhSeiUxswt+DiewfYl1td2lHl4l2g6C90p9Uudg+0pyL5Vmh5T
         Objq17zvOMXBa8+AMIpYTzOhiGIJErA+n1sMozF+dNGg0GRIBWpAQ6UhY55PMdxiLo2N
         4k2l9kGDjnsWYctqRbRb6Hbylo2QBNbc9FNMfsWexU5IXz8RBsxWKWXiHYZCxsP996uj
         9JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=8w6bEyoNMZ8GDT13mdRKLob+Xn1ecdp0CQY3QFDsyDs=;
        b=i5BubamruWAn7US755OVP/lT2XJ7TGuTFuKEjALjn5u54t7LDTs2DWuI6CaQQCj+S6
         6wHezDBmX89/h1J9LBbdePkvNNbibHDLEBeSQKO+QAmp5K80oESaFMcQpwEWU9UIXFnV
         R1cah68dvDkCKtxWhlMkS/4da6P3jyhb+jltTGF2SuiQ2gg8jUFmwxfjdexkKmRGaALx
         6mYv4fjc7txfL+dBAijJjgAW9Olxj+a/OkY5IHjPM4y1+nHhVNb4QBwXomW1f2yH+J6c
         8+lLnJhISMporKzeFDodeXiKiFqrBXVIDCxc5c4UgpHdhIwxmUoofFTMnmCX8BzFubBT
         JMGQ==
X-Gm-Message-State: APjAAAWptT554NKI8hTL/3cWuV0xthETKTLjHHX+Nrp5VARpcrwz8Fpm
        F9HvDDKVS3u9f+sf/fL7Tsc=
X-Google-Smtp-Source: APXvYqzdMEe4GnabLeoK5c8UQ1m4S5xb2zFZjwAIugQwIwcwSD4dwTkunADz5CRAPkU8cVCnzXChCg==
X-Received: by 2002:a62:7c96:: with SMTP id x144mr21295021pfc.7.1582017560307;
        Tue, 18 Feb 2020 01:19:20 -0800 (PST)
Received: from Gentoo ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id t11sm2322514pjo.21.2020.02.18.01.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:19:19 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:49:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace stale url with active one for Mutt
Message-ID: <20200218091904.GA3828@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>, corbet@lwn.net,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218065854.13152-1-unixbhaskar@gmail.com>
 <26370462.jMSB3ls19i@pcbe13614>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <26370462.jMSB3ls19i@pcbe13614>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09:17 Tue 18 Feb 2020, Federico Vaga wrote:
>On Tuesday, February 18, 2020 7:58:54 AM CET Bhaskar Chowdhury wrote:
>> This patch will replace  dead/stale url with the active urls.
>>=20
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Documentation/process/email-clients.rst | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/process/email-clients.rst
>> b/Documentation/process/email-clients.rst index 5273d06c8ff6..bf8b4c9a4e=
fe
>> 100644
>> --- a/Documentation/process/email-clients.rst
>> +++ b/Documentation/process/email-clients.rst
>> @@ -237,9 +237,9 @@ using Mutt to send patches through Gmail::
>>=20
>>  The Mutt docs have lots more information:
>>=20
>> -    http://dev.mutt.org/trac/wiki/UseCases/Gmail
>> +    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail
>>=20
>> -    http://dev.mutt.org/doc/manual.html
>> +    http://www.mutt.org/#doc
>
>http://www.mutt.org/doc/manual/
>
>I think this link is better
Sure.Let me correct that.

~Bhaskar
>
>>=20
>>  Pine (TUI)
>>  **********
>> --
>> 2.24.1
>
>
>--=20
>Federico Vaga
>http://www.federicovaga.it/
>
>

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl5LrAQACgkQsjqdtxFL
KRWujQgAlZ5ZEVIRfqnvG09XSPDty9RYeQ46yCAIVry3YCiqna7cnMR87fMP4Sck
aYMGFol+angmsXin7dzgR8o32qANzVxyF/zziqcyI81vL22vvByjuFGUzVz9DYpT
fAmzwtcgiJ/wXV1A+O421+oFLFRfg2nI7vc2i1effy7mEbzFzFgczuJWADWArWwQ
MaU4YhbuzhFwvxmFKcKjmSLyPtDd0cdtgZVk9wDn2qnh6kDcVlxJv8NJMIxwMykz
zupNPIB4xd7DBvJCHcPE3fPZHdMJErFwYuFcMyPrQ6SmgZ7wqk0i9ARzars35QqC
vhyi2mQ88zKgvVMqvHmiEYDqXL9o6A==
=fYJL
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
