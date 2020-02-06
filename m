Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E63C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05ABE21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BucAo8q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgBFQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:11:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53852 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:11:32 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so165368pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ShO/ZVHIlXWBbnOBWlcqX5lFDNR31/CcbxL+NYy3uCs=;
        b=BucAo8q5H6l+y/zkiWSHU/uS3/MdTExtLLSryAR0sLTOa7NCQHvC9SE1vOd3mwa7JD
         Px/W1lQbZ/Ws2zsPbiWu4W3HImbTvt/8c4IFM+YBwXT9xiRc4cTIw1Y45AvvpsWWvpN/
         oppgu5KccXuPdjobS3Imy34ND3dZn4Z+HeOq7BR2GmdgKx4NK4rxF7HJvQkTLEh/I3NS
         U1kvnFjXkuDZIomK5HGX9p/C8wG1KVlPk50ZxgjoN8/6+h9u3Q7wcXyX+x9N+liA8I9Z
         UWGNs50N/8tjc3VbemXUFHTAIow6n3alPnETR/ZPn+KfhgZNY7IHvFiG3ZNalnG0tb2L
         waQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ShO/ZVHIlXWBbnOBWlcqX5lFDNR31/CcbxL+NYy3uCs=;
        b=L8kIahOvWUJmZoJkXb9aytfdGntnXYpf57qVU252lGLdohvnW5+1tvZXxDJOlwKNeq
         H8rvyeJaM+mkisEZ/7PzFUrcSpZDnTaP/dQKpvy7GCa6skKScqxMAjnz2Co+Bwt+YKOL
         Q1A32BU5Za+ihVeOKySCinVp4O4OZdueJJDBB9Wz1DM4J9k21nMhKBiZmV4V86FhncW/
         /wsb7B+Q/pij4WjZMW6DFXrZ0VJXHnglVIutHhKk/EWVcCpsATxRmgmeicV3QzRuVt1b
         c1zJtYQyE7cTvNdf+QvVeKIswGxWeLpb2UOWj7v/nM9+dcsipHi4K3U2vA/ozgnWdiPr
         2OYw==
X-Gm-Message-State: APjAAAWrtkTzOwnnkTwtH19JbQ04RKd2DhHaIRdtqMpKRq0wvfPZT+Mr
        NsiwHtOB+bhgkINm9UGmpA+caw==
X-Google-Smtp-Source: APXvYqzY/1V149Xc6NfSBQ5Gb8li0Zj7tK81ZlOtSgNffKALUeuhuKRkE0TSHk329flS3FxkOy5VyA==
X-Received: by 2002:a17:90a:e981:: with SMTP id v1mr5371620pjy.131.1581005492066;
        Thu, 06 Feb 2020 08:11:32 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3448:2e42:e55:6113? ([2601:646:c200:1ef2:3448:2e42:e55:6113])
        by smtp.gmail.com with ESMTPSA id i11sm4090079pjg.0.2020.02.06.08.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:11:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function sections
Date:   Thu, 6 Feb 2020 08:11:30 -0800
Message-Id: <B1282A43-1246-4956-917C-72135D9F0328@amacapital.net>
References: <20200206152949.GA3055637@rani.riverdale.lan>
Cc:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
In-Reply-To: <20200206152949.GA3055637@rani.riverdale.lan>
To:     Arvind Sankar <nivedita@alum.mit.edu>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 6, 2020, at 7:29 AM, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>=20
> =EF=BB=BFOn Thu, Feb 06, 2020 at 09:39:43AM -0500, Arvind Sankar wrote:
>>> On Thu, Feb 06, 2020 at 04:26:23AM -0800, Kees Cook wrote:
>>> I know x86_64 stack alignment is 16 bytes. I cannot find evidence for
>>> what function start alignment should be. It seems the linker is 16 byte
>>> aligning these functions, when I think no alignment is needed for
>>> function starts, so we're wasting some memory (average 8 bytes per
>>> function, at say 50,000 functions, so approaching 512KB) between
>>> functions. If we can specify a 1 byte alignment for these orphan
>>> sections, that would be nice, as mentioned in the cover letter: we lose
>>> a 4 bits of entropy to this alignment, since all randomized function
>>> addresses will have their low bits set to zero.
>>>=20
>>=20
>> The default function alignment is 16-bytes for x64 at least with gcc.
>> You can use -falign-functions to specify a different alignment.
>>=20
>> There was some old discussion on reducing it [1] but it doesn't seem to
>> have been merged.
>>=20
>> [1] https://lore.kernel.org/lkml/tip-4874fe1eeb40b403a8c9d0ddeb4d166cab3f=
37ba@git.kernel.org/
>=20
> Though I don't think the entropy loss is real. With 50k functions, you
> can use at most log(50k!) =3D ~35 KiB worth of entropy in permuting them,
> no matter what the alignment is. The only way you can get more is if you
> have more than 50k slots to put them in.

There is a security consideration here that has nothing to do with entropy p=
er se. If an attacker locates two functions, they learn the distance between=
 them. This constrains what can fit in the gap. Padding reduces the strength=
 of this type of attack, as would some degree of random padding.=
