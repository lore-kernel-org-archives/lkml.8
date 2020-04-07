Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20E3C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28F820719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyygrqVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGBMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:12:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45577 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:12:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id r14so3315pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=3cdUhQp/zpzkOyVvmj6qlGqEL1FKTqwSK/cEYACNo1Q=;
        b=LyygrqVLrfCaDS6whDZy427nStCSkQikCPbl7Ge2Pwyxch3zVwHf2FLJsU0hlZPvcR
         OlhmxukFFK1fwQEGP0DWimeobp9vfksZYCn3p+4nh4c5mmrfQT0OnbJOaiea8CjdodHP
         8DDp0N5GzuQ1pv1wRQhpVy0GD8CGmahwTjpdxdoAU0YnVIPgyFkPJOTGyvardKU1ZK6q
         tTRA6d3rdQ/kpdwh3snHMWlADgHvUGQ0s7nGjA9DL8pkynK2v1UnoKxR84ijbzYHCS9x
         Yx5Sb3hpNCYxDZHF25i7BUUeplUBSOiy+ZaZEHw5/ddzek4O54H6grPHdSnZEdZzYbqh
         bP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=3cdUhQp/zpzkOyVvmj6qlGqEL1FKTqwSK/cEYACNo1Q=;
        b=fBZSpjziBLVAIkLsnYzWJ2S2oKZZNK1XDtMN7EnWsHbLfpccpN4EAcxZpwAYaPuJ8E
         qWfP/kKnCaKkAonHxmvDgYcjeRYhWlmJdO+4ALDe6VR6rTLJPJMdkXn5Zb9kRYL+/XLL
         fn7nCIMKAkVx8WzljS+9fKt0xpUXjxQAoFMLurM0nRMUID6oExaJr+PMQbv6MwcM7LYd
         Who3V2eJBQ4jpqD4bMj5IQ+w5Kqb9jxnAbmylWBTwjWiJnrml4V/c9CCCEHz46JalHc7
         quEWeFejrkijOUYVv0NxOLQ4GvXkIMsv/Jnehgr1P4KRQBeITm8YNd5jOesRphdGBD9F
         5cQQ==
X-Gm-Message-State: AGi0PuYvH021jNhX6ZyRa6zbm2SwQCAGXQUsh4UGnFzZaUyXc/pg/ymB
        zQwteBTe4jgPXRxX/j+11vw=
X-Google-Smtp-Source: APiQypLuPGhY0OgC1uV5M40YzrGcLzB+SkCB5iv8ooQ+KJkJlEXTFlZzy8EKLaasRmrLXxN+Ghqf+w==
X-Received: by 2002:a62:1c4a:: with SMTP id c71mr172644pfc.58.1586221939248;
        Mon, 06 Apr 2020 18:12:19 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id i18sm12785222pfr.62.2020.04.06.18.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:12:18 -0700 (PDT)
Date:   Tue, 07 Apr 2020 11:10:54 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v3 15/15] powerpc/kernel: Do not inconditionally save
 non volatile registers on system call
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
        <1299b6b50facf78458e7db265fb9936595ea009a.1586196948.git.christophe.leroy@c-s.fr>
In-Reply-To: <1299b6b50facf78458e7db265fb9936595ea009a.1586196948.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586221719.pt68ef9jgc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 7, 2020 4:16 am:
> +	ret =3D syscall_exit_prepare_end(ret, regs, ti_flags);
> +	if (unlikely(ret & 0x80000000)) {
> +		ret &=3D ~0x80000000;

We could just add our own set of defines for these, there's no real
reason to use _TIF_RESTOREALL as I had.

Thanks,
Nick
=
