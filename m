Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E216BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1E2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLp/U4LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDGAYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:24:00 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34657 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDGAYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:24:00 -0400
Received: by mail-pj1-f68.google.com with SMTP id q16so564907pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=fkkoXTqICrhfI0O291OsPi1le2LLISiv9KvqGzJ1lRM=;
        b=cLp/U4LXlpw/S4H/fngDMWW48C/pnzAVPqAT/YjmmdcqLJitsCOl0bVKWyFJWzenSd
         DbjOae9WWegv+7Kn+jum0aM0VRbUl3pWv8OAg5kScEPatj34FXZfkDervrGJtN4cCaXE
         Zer8eZnpGSkFHcTqTLtufx8j+5kcYVQAwYKyCxxshH7ZRkMkdR0qbnl64cjLN9mBqG8I
         hmd6MGQmpvouNDAUNs4FM/9OgF1D7bia6OLeiyA2TjZhbH7/uO6UhFToGimfHSZYlzpm
         /UtWP2GEjyVWTRN++1wQ8Y4i3dxzdGbqSywEB3XL+GiSgUCDngAi6LGDo5ROQJFdwmJ3
         sGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=fkkoXTqICrhfI0O291OsPi1le2LLISiv9KvqGzJ1lRM=;
        b=XsKfvKOCmqKH0zn86GAYTeFdgQIWe48yhhA2bfYYeIbF2do8qE+rXxe3EeWpgNA7rp
         MfgVGSC2pSLiuLFx7hti9GH3Brj2nXeXX1P3Yl3j0vt5upfnr6y9piICFgFLCpmloeUn
         wif6TfP+JCfn/kFHs8xI15Vv7J8m3RK0WD+qlXgKLUyx4ROli9d6kqHIuqV7I8VQe175
         a4I2WZRK2j5DRq3kmaFPrSsmQ894ir7iIIjkA6bV/VaJbYOOQJfA897a7866SeLnDWXK
         HlLxdUM0lbzOpGfMc5DdTm+ISN86A9tpQZpeQYoXSUcV+8KgV1bujtqdxynN+jG3uewR
         QdoQ==
X-Gm-Message-State: AGi0PuY7ws2L2vHK0LVVypoEMqB0FhGfaFcSp3Bpz7HaOGMZ2sluMnSw
        zOlBa1h0p6GVLw7OQACz1wH5aOkg
X-Google-Smtp-Source: APiQypJ1PmMXocM19uNmFSCVzSeP+x8zrMcsmsc5rJUdQsYouh5WdLMWmtNz6sxP1KZ/8kCis2jf7Q==
X-Received: by 2002:a17:90b:2394:: with SMTP id mr20mr1998678pjb.79.1586219039523;
        Mon, 06 Apr 2020 17:23:59 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id r24sm3889293pgn.44.2020.04.06.17.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 17:23:58 -0700 (PDT)
Date:   Tue, 07 Apr 2020 10:22:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v2 05/13] powerpc/syscall: Rename syscall_64.c into
 syscall.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
        <cacbc62ded444e26e15ca67e0ec91b05b7de6459.1586108649.git.christophe.leroy@c-s.fr>
        <1586137301.c2ssus5vmb.astroid@bobo.none>
        <1a154868-6849-ebd7-9d38-673d0954c2d7@c-s.fr>
In-Reply-To: <1a154868-6849-ebd7-9d38-673d0954c2d7@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586216862.v31svyhizc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 7, 2020 4:20 am:
>=20
>=20
> Le 06/04/2020 =C3=A0 03:42, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Christophe Leroy's on April 6, 2020 3:44 am:
>>> syscall_64.c will be reused almost as is for PPC32.
>>>
>>> Rename it syscall.c
>>=20
>> Don't mind this, but I wonder if we can rename it to interrupt.c.
>=20
> Interrupt for me is irq.
>=20
> Maybe exception.c ?
>=20
> Exceptions, that's what interrupts and system calls are.

It's not the same. An interrupt is caused by an exception, but an=20
exception does not always cause an interrupt.

The code here is handling interrupts, it is not handling the exceptions
(those are handled by handlers that are called). We also handle
exceptions without taking an interrupt, for example if we set=20
decrementer or msgclr.

And we often (especially in 64-bit with soft masking) take interrupts
without handling the exception (we set EE=3D0 and return, leaving the
exception existing).

So I'm trying to fix terminology slowly. We are not "returning" from
an exception for example, that doesn't make sense. An exception is a
condition of processor state which is either satisfied or it is not.
What the software returns from is an interrupt.

I'd like irq to be ~=3D Linux irq, which in general means an asynchronous=20
interrupt that can be blocked by local_irq_disable or sometimes a device=20
irq specifically, as distinct from "interrupt" which is powerpc=20
architecture definition.

Thanks,
Nick
=
