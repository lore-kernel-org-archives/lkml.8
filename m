Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEB4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731472084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2gGyoUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDICA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:00:57 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:43977 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDICA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 22:00:57 -0400
Received: by mail-io1-f48.google.com with SMTP id u2so2266522iop.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BV0RwnCaNmgxzA1hCBYYOULfJvjeOLI/tY/1za+ygYI=;
        b=t2gGyoUdXHaLNExZO5uBjJ3GqFqREcWOs2ajNei0CD5Df4FhsRJ2O23n5o/wGUjfeJ
         kqM0zxoVnrMfd0BHGhlWpGJcLDDckTVGlTozrYkttIeo+KWkTeVe7DPTUjgMdGU2ASkk
         nWFpc4p7H7o7jLRSpHRT9ghzBur2lVE0cbYE1N6EuIXJEITFsiUt01fLrKEI9ig7WwUB
         ZgY7oAI3h+/HoePBJxusSGPLuwVuQYGR0+XeoBGGgNi+ShpZAGa6UPR6PJOBvB3SmDA3
         9k2AO8mPvzJ0PvvGxZIAfdfun6y3kOvpbvz0o1rlecqK+KG6xB55N1GKagDzDx/oAKtW
         UWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=BV0RwnCaNmgxzA1hCBYYOULfJvjeOLI/tY/1za+ygYI=;
        b=R1QZ8PGTlh4Np5hJrx6qW8xxuEikjpOoVz22fpiMYurqfyb6TiIrH8SNnniW+CV9Kc
         94hglqj8W6J/G0bZ+kAMbQ2hfS7NPzNpGC2xgxX8QruEHs6Pj0CtXbjGrHuD/fsx4xZk
         aZ/y/n2o5ThSWTPucVO7RBOMx7f1rv54T3qAlRhZ7a8KYAq/M4lp/Qq/dSbspAUfUv6j
         Qy8kpgLcT/qTxn8EZWjEAVpQ4EeExWXgAw7tEZZ4lJF28oTvBJ19x5CRE5QC9Ws2w5yp
         G1wcqrLWgf55a2mwYEoClZuLLmNaUhf1ICT/cnTGpdZL6z2NgEGDrDgYisUWIH8a0T6G
         CqDA==
X-Gm-Message-State: AGi0PubhEyYse7OS9J2ExmJ5GeiLV0g2LQaYkVZsL8ifRMLjsh9Q7uOu
        ZhF0Oom+fOlg7Fmd3938k5HPyOOxoriO11Vw7qLuCA==
X-Google-Smtp-Source: APiQypJ9Bc0IU4lcg4aqwdl+rul/Hs0jNJJgLeUvQWBd8guHRSrw+gVIxBewbUxNckpp0ptxbveMAjsOE41KqUNzaes=
X-Received: by 2002:a6b:cd4a:: with SMTP id d71mr9928757iog.5.1586397654498;
 Wed, 08 Apr 2020 19:00:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a58b:0:0:0:0:0 with HTTP; Wed, 8 Apr 2020 19:00:53 -0700 (PDT)
In-Reply-To: <CAOzgRdbWsKY7mXgiTx3um_gdJvgPN1O2p1vxmWv9eApQAy9UzQ@mail.gmail.com>
References: <CAOzgRdbWsKY7mXgiTx3um_gdJvgPN1O2p1vxmWv9eApQAy9UzQ@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 9 Apr 2020 10:00:53 +0800
Message-ID: <CAOzgRdYkJMiQM9M-UHv5Z-6CLzaV0P8YTK5Ft-CmT5-JqCnYSA@mail.gmail.com>
Subject: Re: Merge branch 'core-objtool-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     viro@zeniv.linux.org.uk, peterz@infradead.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d937a6dfc9428f470c3ce4d459c390944ddef538 caused 64bit kernel build
failed on 32bit userspace.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd937a6dfc9428f470c3ce4d459c390944ddef538

2020-04-08 16:13 GMT+08:00, youling 257 <youling257@gmail.com>:
> after this merge branch, build 64bit kernel failed on 32bit userspace.
>
>
>   CC       tools/objtool/builtin-check.o
>   CC       tools/objtool/builtin-orc.o
> In file included from check.h:10,
>                  from builtin-check.c:18:
> elf.h: In function =E2=80=98sec_offset_hash=E2=80=99:
> elf.h:102:14: error: right shift count >=3D width of type
> [-Werror=3Dshift-count-overflow]
>   102 |  oh =3D offset >> 32;
>       |              ^~
> cc1: all warnings being treated as errors
> mv: =E6=97=A0=E6=B3=95=E8=8E=B7=E5=8F=96'tools/objtool/.builtin-check.o.t=
mp' =E7=9A=84=E6=96=87=E4=BB=B6=E7=8A=B6=E6=80=81(stat): =E6=B2=A1=E6=9C=89=
=E9=82=A3=E4=B8=AA=E6=96=87=E4=BB=B6=E6=88=96=E7=9B=AE=E5=BD=95
> make[6]: *** [/tools/build/Makefile.build:97=EF=BC=9Atools/objtool/builti=
n-check.o]
> =E9=94=99=E8=AF=AF 1
> make[6]: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=88=
=90=E7=9A=84=E4=BB=BB=E5=8A=A1....
>   HOSTCC  scripts/kallsyms
> In file included from check.h:10,
>                  from builtin-orc.c:17:
> elf.h: In function =E2=80=98sec_offset_hash=E2=80=99:
> elf.h:102:14: error: right shift count >=3D width of type
> [-Werror=3Dshift-count-overflow]
>   102 |  oh =3D offset >> 32;
>       |              ^~
> In file included from arch/x86/decode.c:14:
> arch/x86/../../elf.h: In function =E2=80=98sec_offset_hash=E2=80=99:
> arch/x86/../../elf.h:102:14: error: right shift count >=3D width of type
> [-Werror=3Dshift-count-overflow]
>   102 |  oh =3D offset >> 32;
>       |              ^~
> cc1: all warnings being treated as errors
> mv: =E6=97=A0=E6=B3=95=E8=8E=B7=E5=8F=96'tools/objtool/.builtin-orc.o.tmp=
' =E7=9A=84=E6=96=87=E4=BB=B6=E7=8A=B6=E6=80=81(stat)  CC
> tools/objtool/help.o
> : =E6=B2=A1=E6=9C=89=E9=82=A3=E4=B8=AA=E6=96=87=E4=BB=B6=E6=88=96=E7=9B=
=AE=E5=BD=95
> make[6]: *** [/tools/build/Makefile.build:97=EF=BC=9Atools/objtool/builti=
n-orc.o] =E9=94=99=E8=AF=AF
> 1
>   CC       tools/objtool/pager.o
>   CC       tools/objtool/parse-options.o
>   CC       tools/objtool/run-command.o
>   CC       tools/objtool/sigchain.o
>   HOSTCC  scripts/recordmcount
>   CC       tools/objtool/subcmd-config.o
>   HOSTCC  scripts/sorttable
>   HOSTCC  scripts/asn1_compiler
>   HOSTCC  scripts/extract-cert
>   HOSTLD  scripts/genksyms/genksyms
> cc1: all warnings being treated as errors
> mv: =E6=97=A0=E6=B3=95=E8=8E=B7=E5=8F=96'tools/objtool/arch/x86/.decode.o=
.tmp' =E7=9A=84=E6=96=87=E4=BB=B6=E7=8A=B6=E6=80=81(stat): =E6=B2=A1=E6=9C=
=89=E9=82=A3=E4=B8=AA=E6=96=87=E4=BB=B6=E6=88=96=E7=9B=AE=E5=BD=95
> make[7]: ***
> [/tools/build/Makefile.build:97=EF=BC=9Atools/objtool/arch/x86/decode.o]
> =E9=94=99=E8=AF=AF 1
> make[6]: *** [/tools/build/Makefile.build:139=EF=BC=9Aarch/x86] =E9=94=99=
=E8=AF=AF 2
> make[5]: *** [Makefile:46=EF=BC=9Atools/objtool/objtool-in.o] =E9=94=99=
=E8=AF=AF 2
> make[5]: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=88=
=90=E7=9A=84=E4=BB=BB=E5=8A=A1....
>
