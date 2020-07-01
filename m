Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22590C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB16C20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vqKoS74T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGAUg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAUg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:36:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAFAC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 13:36:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m22so1907515pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ml7h1RVx99WBpFKay7KhhYcDTfjcQtiJ3hL/JQFsxaw=;
        b=vqKoS74TQnzmoAPXc661uI/GMGxdpNdaBZTZQxL1pSs4vIipZ2me8BZvCXyL13ghqf
         MVMjyCat4XWCs/AfCxZQ1ZxDnnsY1CFSa2cWYUwDJ8RcUpS82qBYGyz7WH3N88QJe0km
         S/WWPs78A/S12EzMphJGD3rjtuhoSIv0F+Un8H0tweuWLlqM9Mb8qFKjOOcZZZAGmR0w
         3p/mE1XJEELSg8qArLrrz6/fkUGIZRWfteySCJYr6eY+OKOGYJJikHLLCWXSn8BklLFt
         Lg0+IhvSPEgXxhOvG43Y88golPITpMAZu35/zVKkl5/cmUZAapILcpCCyb9T3onGDrZD
         kzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ml7h1RVx99WBpFKay7KhhYcDTfjcQtiJ3hL/JQFsxaw=;
        b=MR0SWD4c0WQdeH98VNz806ABSta0317vIcUc7VP//c3dAR3upX2x+hjU7Gs1XqeX3M
         FvnoszZol4mVEspk9PTwnmFEpv5Q3p50Qc0KYZISMkQcpzgPbbKwVg7Qnhp+nLNjnf9a
         Po6VT9M2qY06h/RWU3ogmLbXF4hyZfpPcguZYDiVv6aiDTBIcSKjmuBkMJ/lUshizZBo
         7kI4FATdixTp46xuMjlfFlWVecDETZONfw/rym9gFLc1i6jbZi5J/mIJ+7ZKuZRO4aW1
         MQH5GD3qM/uv3wye7xMaz4D/RArSvySOgBLAN/pIYK1lTlw7PLOF6cmC2zrJJXvc0U07
         sYbg==
X-Gm-Message-State: AOAM5300Mjry3wPYgqjaTgxObaogOlJrjAOC8NSS3Te/PsimxYT1BKrx
        O/dHYUJGoDLo4el/LASc+/Inww==
X-Google-Smtp-Source: ABdhPJx3Dfe+b8yBPt4IJWfAbi5YqL8m4kbq22oOyKhe1Ay3txvxSdOzlcoAnPFT0m/oEsjXe3LUwQ==
X-Received: by 2002:aa7:871a:: with SMTP id b26mr19365029pfo.294.1593635785869;
        Wed, 01 Jul 2020 13:36:25 -0700 (PDT)
Received: from ?IPv6:2600:1010:b04f:a97a:115b:a679:8f4f:946b? ([2600:1010:b04f:a97a:115b:a679:8f4f:946b])
        by smtp.gmail.com with ESMTPSA id t126sm6565239pfd.214.2020.07.01.13.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 13:36:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: objtool clac/stac handling change..
Date:   Wed, 1 Jul 2020 13:36:22 -0700
Message-Id: <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net>
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 1, 2020, at 12:35 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Wed, Jul 1, 2020 at 11:29 AM Andy Lutomirski <luto@kernel.org>=
 wrote:
>>=20
>> Do we really want the exception handling to do the CLAC?  Having
>> unsafe_get_user() do CLAC seems surprising to me, and it will break
>> use cases like:
>>=20
>> if (!user_access_begin(...)
>>  goto out;
>>=20
>> ret =3D unsafe_get_user(...);
>>=20
>> user_access_end();
>>=20
>> check ret;
>=20
> That's not how unsafe_get_user() works.
>=20
> unsafe_get_user() always jumps to the error label, it never returns a
> value. So the code is actually now what you claim above, but
>=20
>    if (!user_access_begin(...)
>       goto out;
>=20
>    unsafe_get_user(..., out_fault);
>    user_access_end();
>   .. this is good, use the value we got..
>=20
> out_fault:
>    user_access_end();
> out:
>    return -EFAULT;

Ugh, right. But maybe, with the asm goto magic, we can=E2=80=99t get rid of t=
his. I=E2=80=99ve always disliked the pattern where we enable user access, d=
o a bunch of accesses that branch on error, and finish up. We ought to be ab=
le to do it the way I described and get decent code generation too.

If we do this extable change, we end up with a different mess: some exceptio=
n handlers will clear AC and some won=E2=80=99t.  I=E2=80=99m sure objtool c=
an deal with this with some effort, but I=E2=80=99m not convinced it=E2=80=99=
s worth it.=
