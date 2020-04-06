Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FDC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E00B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586192672;
	bh=PZagBnWcfzp+s6eKCPKdihXxtcMkJ5nUu5wMIfH9OiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EQMqA65W9rgzy/ozD3S0E3MJ/n1JhdrlzoPvbV7nD6BnXTB9zK3aUA1RW2blfSLcY
	 BJH/4A4tWAUwBYTVYuA1deI8e916ZYNd8DW5TJEo4sTbg/tIfQWqyGCXaVgu1mvDh9
	 zpjEUukSqUScMCXP+qd2PwpvZY1D47xXO4r08+Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgDFREb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:04:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43131 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgDFREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:04:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id k28so57145lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ar7jflrkNXaeWaLLNE+J/V0wCb3y07I41Vn1cDNa1H0=;
        b=iAyiGuOhg1NBw6xntWOjfjlwN9HPSP5nDSdo7Jp3I/fwBUQ0KJFRRQOcR/HKfmVC7o
         qnHtvHaPJgAGeNdQfEkNAtbjCg1eAhwAJJRKbDQ3v/rLuR8aMVuXHQIiAZrb4at4+sBj
         MTvWffSqk+SyA3JRUrj2Z2o42xS9DNGcGc5MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ar7jflrkNXaeWaLLNE+J/V0wCb3y07I41Vn1cDNa1H0=;
        b=ONWQfwgCH5eNzvqjrDgFEay+BmtwuUePJrQiZ4yyWsqEc7Z7XMLbMtdlfpmcGfraci
         mL94V0zSAGfW6zZ2K+CaXDn0VCgrcTstvS1sUIwrFCjgF8ppCmvD5vq8KhTwVn4Z1Kaa
         JnkN7hG4MUlxMBHxatrMR9jQucJUle8KVefcu17GlW0TflZL/mS6YmozeIt6dADrwrV9
         4Obt1oL5Wxh88JYSiiNq0/BKEtFblP+Wdcs3jC0bRHX3WOzEYhuiHIJtFDStM7kTreNP
         CflApSkON9C/SAnikomHF3+HXTE6yCnDupWDUYPOGHQKP4n23183B2u5C/hbNDQ3ebaB
         7L2A==
X-Gm-Message-State: AGi0PuYcS3tXPuT8MG9L4a4gFp72V+YQJgBP3vzmAShJQ9kAOG/2sRPE
        1qLAXeoDN/pgbCTJfOB+tt5RQK66nLY=
X-Google-Smtp-Source: APiQypKl9Mi/HozM2ku1OKLPcES8Ik6/x3zUfBdq1k8VEtbuhHCbYrdHbJO0LnUD969Y1xBNQ81ppA==
X-Received: by 2002:ac2:5dc6:: with SMTP id x6mr1613897lfq.108.1586192669006;
        Mon, 06 Apr 2020 10:04:29 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id z4sm9958243ljk.51.2020.04.06.10.04.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:04:28 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id j17so71878lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:04:28 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr9430308lfo.152.1586192667631;
 Mon, 06 Apr 2020 10:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica> <20200406164641.GF21484@bombadil.infradead.org>
In-Reply-To: <20200406164641.GF21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:04:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com>
Message-ID: <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 9:46 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> POSIX may well "allow" short reads, but userspace programmers basically
> never check the return value from read().  Short reads aren't actually
> allowed.  That's why signals are only allowed to interrupt syscalls if
> they're fatal (and the application will never see the returned value
> because it's already dead).

Well, that's true for some applications.

But look at anybody who ever worked more with NFS mounts, and they got
used to having the 'intr' mount flag set and incomplete reads and
-EAGAIN as a result.

So a lot of normal applications are actually used to partial reads
even from file reads.

Are there apps that react badly? I'm sure - but they also wouldn't
have O_NONBLOCK set on a regular file. The only reason to set
O_NONBLOCK is because you think the fd might be a pipe or something,
and you _are_ ready to get partial reads.

So the 9p behavior certainly isn't outrageously out of line for a
network filesystem. In fact, because of O_NONBLOCK rather than a mount
option, I think it's a lot safer than a fairly standard NFS option.

               Linus
