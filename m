Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51ABC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D2D206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIpxYzwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbgDCHdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:33:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45325 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388873AbgDCHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:33:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id o26so3099838pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=6eTQPyddv5f9SRxTrCu1HpU/mZFl02NaYZhT7ltXJvM=;
        b=DIpxYzwc7IBK/NsPfM0wzUov+Iv1OcKRReEWjT2bmDGtKez3CWY5TXWaIQMzsoUgtU
         NIClVMRucU+ZGL4X3rND3J/Sv5+cPTJGKLNhRuL3g/1jq+O1PnA/AbdgkxCOxux7Z3Ee
         05BisU9HXpM13G6inAt73sB+MxkGslDj0WX6KeoUU+IK+CfqfE6CThK5m87JlMCwcMR9
         2n+z65y9hXathwW164UwoutNkcR83FebyA7fsHe1SZDx9fleqlPOOR4/YEvT+FHHHNF1
         NUMWfJ0JwslkFzifHLGMtNoO2YqvXlAohajKqffSl0TVy4OxM3oldUugnckD5X2nPYHW
         qMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=6eTQPyddv5f9SRxTrCu1HpU/mZFl02NaYZhT7ltXJvM=;
        b=L22tumUNdz0J3b3MsBee6PQRzpDgnD947idKiUfw0zGT2YRV1y9ciLOsuGyAYzVV5k
         HX8cwdtTUwLaDE9urnhVdnq16rutMOYVA8cHejz4Ns7S2aiDHT2dAHmCHYy9DUxJgRsy
         sWg21Sz5KeokLUpqgzlRCa6T9wK3DtiLn3zFPm10eQ3+jiTMoFSLS+SHb/Cn7zLy9kLj
         ilBqZevCBQTWV1Wn1QTUHHMYKdIoYKrVOsicEPjshNTLC1wRYhR+le/h+GvMtJ/pmDlk
         OTdrbRgm6/BVtgOAlY6eWnmsRVMRVX4vtzkBFK0uXSnHTgWkYvCvJYsDpAKnO4uNzhwe
         EOdA==
X-Gm-Message-State: AGi0PuYSCSpnrkmu/9cQKjkOsskUhkzcccNEEMVGuVbeBEmkPR95yXcX
        Hj5jTE8Dgg5mtBuB1SQXIww=
X-Google-Smtp-Source: APiQypI0pCTSglQqiqf6qQwJ44I91xTYmtj4PFApCZx7Y0Y3z+lHknCzOY64l1KScrStsuRgDAWPZg==
X-Received: by 2002:aa7:9f42:: with SMTP id h2mr6792832pfr.22.1585899225368;
        Fri, 03 Apr 2020 00:33:45 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id h4sm4750410pgg.67.2020.04.03.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:33:44 -0700 (PDT)
Date:   Fri, 03 Apr 2020 17:33:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC WIP PATCH] powerpc/32: system call implement entry/exit
 logic in C
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <bbc0a09cfaf523bc00893253a7101362c98b31eb.1585667934.git.christophe.leroy@c-s.fr>
        <059c1abd-6be2-25ea-83e0-dcd411b7951b@c-s.fr>
In-Reply-To: <059c1abd-6be2-25ea-83e0-dcd411b7951b@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585898897.1jwur86s6a.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 1, 2020 9:48 pm:
>=20
>=20
> Le 31/03/2020 =C3=A0 17:22, Christophe Leroy a =C3=A9crit=C2=A0:
>> That's first try to port PPC64 syscall entry/exit logic in C to PPC32.
>> I've do the minimum to get it work. I have not reworked calls
>> to sys_fork() and friends for instance.
>>=20
>> For the time being, it seems to work more or less but:
>> - ping reports EINVAL on recvfrom
>> - strace shows NULL instead of strings in call like open() for instance.
>=20
> For the two above problems, that's because system_call_exception()=20
> doesn't set orig_gpr3 whereas DoSycall() does in entry_32.S . Is that=20
> only done on PPC32 ?
>=20
> With the following line at the begining of system_call_exception(), it=20
> works perfectly:
>=20
> 	regs->orig_gpr3 =3D r3;

Oh great, nice work. We should be able to make some simple helpers or
move some things a bit to reduce the amount of ifdefs in the C code.
It doesn't look too bad though.

> I will now focus on performance to see if we can do something about it.

What's the performance difference between current asm code just with
always saving NVGPRS vs C?

Thanks,
Nick

=
