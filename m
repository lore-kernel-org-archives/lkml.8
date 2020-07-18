Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62557C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D23820768
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouF8Bare";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1eYzsC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGRACh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:02:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44232 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgGRACg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:02:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595030554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzDYaJ55+C3M7tuRWSTdZk/99YhA6YCcEIiY7JEij2I=;
        b=ouF8Barect5zlbS1B5+cSQaJcVLRsCDG4IVZdbMBfMpaGc04nfTK3crKEK9oqWGOlhxsom
        QvdHIGTt2IdTvQtd5DAVnFqMCsn1TvmYFGUdSZd/H6kBxc/TkXfUtRpsdnTNW46IZwqz+6
        7Z4V1HPKuDjcv/EF6flKf/j6Hl3m1AOFk7S6tAPA3L0/um2OdptaEiRzOPtUi0Cg2olniV
        1Ey1+zY3xZKpJyjsHN4J1jAIR9wOjhw/5aBExNtzaWY7nQuLyBGoy5Uyo7rbc8NxXQA5N2
        d76zGJrUUbETTouJKJ+9P34XWBfCYdAvzUHLkleLeb8k9oJ8558Yk07z1yVNxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595030554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzDYaJ55+C3M7tuRWSTdZk/99YhA6YCcEIiY7JEij2I=;
        b=U1eYzsC9Xb18Y7vSwk0vR2M7m70hY5gsgzqCpxxOPYIuw1umFsd31/j0DQSHyVtgPkksqt
        hW6cDCxiGP9I3KAg==
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com
Subject: Re: [RESEND PATCH 3/4] futex: Remove unused or redundant includes
In-Reply-To: <7b7270f6-636a-0b72-8fae-a181d1dfc3e2@collabora.com>
References: <20200702202843.520764-1-andrealmeid@collabora.com> <20200702202843.520764-4-andrealmeid@collabora.com> <875zalrf03.fsf@nanos.tec.linutronix.de> <7b7270f6-636a-0b72-8fae-a181d1dfc3e2@collabora.com>
Date:   Sat, 18 Jul 2020 02:02:34 +0200
Message-ID: <87pn8tpu5h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andr=C3=A9 Almeida <andrealmeid@collabora.com> writes:
> I just retested compiling tip/locking/core, and it seems something
> changed the last time I wrote the patch. Removing <linux/compat.h> will
> indeed break the compilation now, the patch bellow should fix it. Sorry
> for the noise.

I just folded it back manually and force pushed the result. Manually
because the below:

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/kernel/futex.c b/kernel/futex.c
> index f483bc52dbac..4616d4ad609d 100644
>
> --- a/kernel/futex.c
>
> +++ b/kernel/futex.c
>
> @@ -31,6 +31,7 @@
>
>  31 *  "The futexes are also cursed."
>  32 *  "But they come in a choice of three flavours!"
>  33 */
> +34#include <linux/compat.h>
>  35#include <linux/jhash.h>
>  36#include <linux/pagemap.h>
>  37#include <linux/syscalls.h>

does not really qualify as a valid patch.
