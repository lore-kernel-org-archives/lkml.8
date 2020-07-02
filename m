Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598E6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EFB207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HJNGE/iV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGBDIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgGBDIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:08:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4DCC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 20:08:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q17so11876592pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=nX4jifuVUD4wv3dvKuEbLJYR6Iy5QHbia6zFZRrUfLQ=;
        b=HJNGE/iVrjl41L5e3nwu2leRVLp42WbAHGKCOLTJAGMERTEKWvoWlDbYd/4qLu1Kn3
         48+pcDPNyOPN6QsHJUv8RglMc8NMmNr+JGmMfpy37riOe4M5EwihMAq7gV9IqTnUcUjD
         i2wW6wT7Wb1zipA65eOzxw1YiVPX55yhPtuP696VjAQtUuqZLlyb04CtaxTQC2nPJOEB
         jwU/YMwB9qWDY6reG9BnbEDMC3NN6TM1sKyOuP38yy6NfnDl3dNwu4os2d9lLxUcLEZ9
         5EZbUbonPixPnHPCQDn8rEV44OVmwZAla3RDqE1r2UrS/3e1F9OuDWT0G2rN+PP1u2H0
         O4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nX4jifuVUD4wv3dvKuEbLJYR6Iy5QHbia6zFZRrUfLQ=;
        b=FF7GENmWWyRnjg9xiRFCNc9fD69vohO7CClTyYydmIs0V7R2H9iHC3bjkDdnYXblbP
         vgZ4lx83TKLvvZUk9pVTdM6sunW6zZS3XPegWPrxbEZK+NjW3hzteXFOwgeGB0GJLYZq
         OtCcnY177B9fO3aET4I/dsTFuRPeSdYj6Itwo36xXVYsyz0EOXFUcWbtsCyO96xNC+el
         Gy92W9Uedq3RZaPd5QxS0pJeuBSzMkQqGVQDJmhZ5b5gRCOWtk/TB8MOmmjIxqo8Tmlv
         O9sehqcUDLEVazt9IKB3KA2mkvLVS44b9oCXbLkb9BBZWHNQDwVJ5jBDJ70gL5TG7TyJ
         0g7g==
X-Gm-Message-State: AOAM533rYHZhmlqPEqbEGqKVyCHimKsCmRgzzcemG/O3JqAuvr/QoL2K
        vsS8VrMlzCyAPCCtD7wKZe1vmg==
X-Google-Smtp-Source: ABdhPJzGryBl1zzI9Sjl18IeYrLO+6//97HpZ6bzh7J6TtqubS+bIb1s9tn4ZXWr5IovpoA6bHRoiQ==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr23100362pgv.252.1593659318743;
        Wed, 01 Jul 2020 20:08:38 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:acd6:6304:8edb:f3fc? ([2601:646:c200:1ef2:acd6:6304:8edb:f3fc])
        by smtp.gmail.com with ESMTPSA id 73sm7333278pfy.24.2020.07.01.20.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 20:08:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: objtool clac/stac handling change..
Date:   Wed, 1 Jul 2020 20:08:36 -0700
Message-Id: <B9CF61D4-50F7-4A82-8327-86CA18450669@amacapital.net>
References: <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 1, 2020, at 7:30 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
> =EF=BB=BFOn Wed, Jul 1, 2020 at 5:48 PM Andy Lutomirski <luto@kernel.org> w=
rote:
>>=20
>> You inspired me to mock it up.
>=20
> Ahh, you want to just use the jump folding of gcc to avoid the problem.
>=20
> I guess we could do that. Are there cases where this actually helps?
>=20

I was thinking it would help avoid brain melt. For better or for worse, the k=
ernel is written in C, and readers don=E2=80=99t really expect call_some_fun=
ction(arg, other arg) to actually teleport elsewhere in the function.  I=E2=80=
=99m all for goto err; but at least that=E2=80=99s spelled =E2=80=9Cgoto=E2=80=
=9D and it=E2=80=99s really obvious what it does.=
