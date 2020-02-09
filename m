Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CCBC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1082320726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581283480;
	bh=V77QzsU4CTzt/cC7lTfrZD7lT1lnKSkpTjieuRbZwzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o3wlusUT0Q1laPYDJGKaOko06i9UM4RM9wEVpKUAmlJLNN9V7SFENyGGUsxQcOpD/
	 oa++27/1DGID5Zh4B8jMW36j4rRDJDuZWrdc2v3jpOrCriPjUoizZvX2+9LBdeJUTI
	 /knYTMN6/3gUVTVIYHf317+HPePpnQmSyGJOsOWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBIVYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 16:24:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34321 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgBIVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 16:24:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so2769919lfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 13:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSee5NK6rMwjcOB2vYpOQ3otLhrgERKcdaUqTAoj0vc=;
        b=Vq7OLj9qWUS+0Xf+qXZzIh79iP+ijjjlhTE3Myev+SZmQM0Vq7vODPSmjZMmWykhPi
         Qs7D+CQVo4yUs+Mh4IcTBeqpksFHFMA+3l9GsiSq7q4YIjm+scKGht1wY1Vb6Tu8b9CA
         1m0snQXIHcauCaYxJQgfR9difYFbGhRpxRxIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSee5NK6rMwjcOB2vYpOQ3otLhrgERKcdaUqTAoj0vc=;
        b=EQY7ONnWrSapjtgp+054Kpr+2ft+llyQn5gWxcKlkNyu7jkIIaTOFg+q6ME+yYWRI2
         pULb/tjxVGKMYrg1q1MYQmOArz/svXBb7tkHrkcFTyu4DbN3JOKpPOpAuVTj3cMUpVF2
         oOomYs4uqwL0hk9Jve6TM/t7Z8H/a3stomBFY+kFs7N0ueX+QzGxP5y552nUe7RrsinJ
         vesC8ufRgXa1Z8UYcBy4MjmWYyQyhtN8ZpneevmKGpF6iccTxUM9pGYy/rkPfruTafth
         Qv+AQ9IrYAbTStConFK+mXag1jEzYBfRx0GGsgF7xdWQlDYaKlo4hIuYb73gTc2nJ44/
         mhPw==
X-Gm-Message-State: APjAAAWLAi3EvMODXxp8l6ccXhckNb2Vgmd/H811PBn2MR9OwOoVrhY8
        PUEEyRyTJzkGvAUOcgdWTkgcahAEsJM=
X-Google-Smtp-Source: APXvYqykjjp7839pf2RxHDlsGAoFjWIt4lnhLOA33uW6XPNa1B/4jYkg7AwFRrR5kmUECtFGx3cPMg==
X-Received: by 2002:ac2:597b:: with SMTP id h27mr4451840lfp.12.1581283475673;
        Sun, 09 Feb 2020 13:24:35 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i4sm6254990lji.0.2020.02.09.13.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 13:24:34 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id t23so2747461lfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 13:24:34 -0800 (PST)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr4397561lft.192.1581283473980;
 Sun, 09 Feb 2020 13:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20200210080821.691261a8@canb.auug.org.au>
In-Reply-To: <20200210080821.691261a8@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Feb 2020 13:24:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiM9gSf=EifmenHZOccd16xvFgQyV=V=9jEHR7_h3b0JA@mail.gmail.com>
Message-ID: <CAHk-=wiM9gSf=EifmenHZOccd16xvFgQyV=V=9jEHR7_h3b0JA@mail.gmail.com>
Subject: Re: linux-next: build failure in Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 1:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Just building Linus' tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> arm-linux-gnueabi-ld: drivers/irqchip/irq-gic-v3-its.o: in function `its_vpe_irq_domain_alloc':
> irq-gic-v3-its.c:(.text+0x3d50): undefined reference to `__aeabi_uldivmod'
>
> Caused by commit
>
>   4e6437f12d6e ("irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level")

Ahh. 64-bit divides without using do_div() and friends.

Is GICv4 even relevant for 32-bit ARM?

            Linus
