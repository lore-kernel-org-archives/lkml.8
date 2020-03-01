Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6EDC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380E6246A1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ASBynYC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCAW4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 17:56:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37802 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 17:56:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so4605661pfn.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=se0IyZ7gHAr6eXWZqvCMUC+l5nOCWe5ipTBvljrrVTM=;
        b=ASBynYC7447q00ZpeHqf2PKC8Nx2UdrkTwe0RQoPQwc2FGK20J4XhFfNTks5DS10lO
         vnURyOuqYSmzCj85qCBYJVjYWqM4OixHSHzEFQIb1McW86yT5HgyWTmUt0nPjwDiF6xZ
         NJGPec54E/F+jOz1aK2izc5qHceggkUAEf/kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=se0IyZ7gHAr6eXWZqvCMUC+l5nOCWe5ipTBvljrrVTM=;
        b=ukot0clNrQ7LiGudoxQKgfUdOT9umBCgK7aUfjK5Wz2mO6jzmUQ6hka8lJ6RkD4EYK
         bxlEprBM4KUJ/SPOJwv/hSa+8fOF7UtwXBPeIB7blxp1UWky43ApUVasCFT3icoKVxxh
         WY0uftuWFPU2XAP4ezZGfWr8KrtJGouNkRSJLcdfTOnHNOynKNXKdnTJqcFFaDwbwu7H
         zyGnwBV7unWA4QvKgZZ+v/qSEwkux+eBmnk0rc4nUQsuohflzDYHPUEXU0G/8Tf+ihlO
         /DLLMY5/wZcGt0mCoNbj4sbN36+sVeOLBiUcKMBWc8IJWv8dlQa0DvJqOyG0ZWvzBAyw
         KL4w==
X-Gm-Message-State: APjAAAWIIU31cdNSvaphi18StkogitdfIu2pPva4l93bjMNGo8yfp4mN
        Acc91sL+5WOlEfNTo55PzFl62A==
X-Google-Smtp-Source: APXvYqxmGuJMAlljhCbvCHsl4IAdZQSDpFGJgzYvIy9a//apUKwSSQZyYDPoDXfkSqr3LbplqokxrA==
X-Received: by 2002:a62:5bc7:: with SMTP id p190mr14926424pfb.16.1583103389485;
        Sun, 01 Mar 2020 14:56:29 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-591b-db3f-06cb-776f.static.ipv6.internode.on.net. [2001:44b8:1113:6700:591b:db3f:6cb:776f])
        by smtp.gmail.com with ESMTPSA id h2sm17797020pgv.40.2020.03.01.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 14:56:28 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     syzbot <syzbot+be6ccf3081ce8afd1b56@syzkaller.appspotmail.com>,
        arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, dvyukov@google.com,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        kasan-dev@googlegroups.com, labbott@redhat.com,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        maco@android.com, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: BUG: unable to handle kernel paging request in ion_heap_clear_pages
In-Reply-To: <0000000000003eeb63059f9e41d2@google.com>
References: <0000000000003eeb63059f9e41d2@google.com>
Date:   Mon, 02 Mar 2020 09:56:25 +1100
Message-ID: <87blpfr8fa.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+be6ccf3081ce8afd1b56@syzkaller.appspotmail.com> writes:

#syz fix: kasan: fix crashes on access to memory mapped by vm_map_ram()

> This bug is marked as fixed by commit:
> kasan: support vmalloc backing of vm_map_ram()
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.
