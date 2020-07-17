Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6BCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CD820759
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wvZZuBKx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNkLjK3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGQVqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgGQVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:46:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4620C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 14:46:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595022412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWveIph5h7e6cozVWaFqIR73Md1np3NT/tbXFuQjfvE=;
        b=wvZZuBKxsyntLi9dvohYK7W5JLCHU6Jjh61wISFmO4GUDzcuPLnsJ5IAt4xsDNBl3ddPPk
        5z0f6H6OFgAtoXHNZa2MSpmLZmpDpdfuDl3c+DHCmYnp31J7+fHEhyloR9dhl2VF8eKNbj
        PUNbyrB2q7sqMC4vKSL8GDEw3e1N3bHgtlDE2NokzN7Nsf3QuxmwIeZMPxl++EmY22CgmI
        7jr0KN6j/kj+0HKIY1zuJCOcoRdPeWn7qgnU6YsoDAyRyovsd2fWHBNTsJADNj8AQ1iEGD
        dr0zU6eZB3jaZDHQlSrumdxsRX+1VZ9++V9xATLO2FGhI8r15kqyqNPvix5i5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595022412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWveIph5h7e6cozVWaFqIR73Md1np3NT/tbXFuQjfvE=;
        b=uNkLjK3Qw9GohkazRC0eH1ZSL380pAOjNgUdhgRN9ruP53vnB/B+YtouZEAfRumcxtBGij
        W/YpkBLt8plmIpBg==
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [RESEND PATCH 3/4] futex: Remove unused or redundant includes
In-Reply-To: <20200702202843.520764-4-andrealmeid@collabora.com>
References: <20200702202843.520764-1-andrealmeid@collabora.com> <20200702202843.520764-4-andrealmeid@collabora.com>
Date:   Fri, 17 Jul 2020 23:46:52 +0200
Message-ID: <875zalrf03.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andr=C3=A9 Almeida <andrealmeid@collabora.com> writes:

> Since 82af7aca ("Removal of FUTEX_FD"), some includes related to file
> operations aren't needed anymore. More investigation around the includes
> showed that a lot of includes aren't required for compilation, possible
> due to redundant includes. Simplify the code by removing unused
> includes.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> ---
> To test this code, I compiled with different configurations (x86_64,
> i386, with x32 ABI supported enabled/disabled), and ran futex
> selftests.

I agree fully with the FD related ones, but are you sure that all of the
others are included on all architectures magically? x86 is just one
piece of the puzzle. We'll see ...
