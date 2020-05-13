Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F62C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797922065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589398656;
	bh=VWs4NpfAEV+Wf9gSeX0e5o0koUyBavjyGOUsk1rJZSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FMbaVkP0yFsYhEwoequMIAHAC3hqS4E8wv55qUFo7dzZbsbcw8vMDdRnKtvH16WbV
	 uo2iBm5/5/3mMHFVeDUnmwRhTxtwyDcw0BdxhavBnB3hYmHP9/FOf6LEcmRrVktgBx
	 u3XZ6cOaUZTriDHA8+Qt5R5h4dev8jp6jWRTPSW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbgEMThf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390708AbgEMThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:37:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2514CC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:37:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a4so495411lfh.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FRYECFHiQr3Nfb1uzqLNFih4Bcng0OOjZJ5V5m4DAs=;
        b=ZjLEDdjhfQ+ZsfStprzo3boptGtjEB8xMJMPV9hfgVHHrrYSleH8mLbHC8Rk2rWQqc
         NnCj3BIzoVOHPTIgSoBKM0vWlfW3SuT0UoYyIfcumKGQE/4wsqoLb39sPYuJ5/AuOelG
         tGQKJ8l9ywdlX+FMm4CTzGEq2pztEwBhTbMlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FRYECFHiQr3Nfb1uzqLNFih4Bcng0OOjZJ5V5m4DAs=;
        b=pLQaigKa9QPMADdkPBDYbMu2xdaTmcwxYO3mZtRhGdb/Mf5cJtL+8V2bfIfrzlqBWO
         sxMiuHnIB8u93CZUlhLpOqXqAnq7zg3GD2Eyrt0Qx6sl++QEiQZBXPrvuQT4buTGnhkp
         qb4F/679i1tPpyMRF3uPMkgNyKxkytJqhJA6EvgZ1e9HUFNE7yfwmQ/E+OUmf9xAwObB
         cVpwY4wsJhQgo5BQ7Y5rZVM/VbaTjRQkC8EvIbla28vM+UMyBhaKhhs9f48VLR6Yt0an
         QyMZ4J/xlvDKIgmr48VgnoyXRKc841ldJpnW7h/KCQoFD9bZWUdHihgPYfkaQeeTWkaz
         1Tsw==
X-Gm-Message-State: AOAM530r3+q+Tf2BTI4JUaHRhrf9sdM7bT4BHYeOt/9hXFwvr5MtZpRl
        z99mk4os5te62Ri7JDQn3VL9WG1oA4k=
X-Google-Smtp-Source: ABdhPJzZR1bjDikyYlmpQ7rGoeQ4rp4GJAtNGlV7tNr9gKMqQZvYgWvfM/WUfwportk/ITDi99wxxg==
X-Received: by 2002:a19:d:: with SMTP id 13mr681662lfa.167.1589398650335;
        Wed, 13 May 2020 12:37:30 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q7sm231433ljp.20.2020.05.13.12.37.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:37:29 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id s9so560913lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:37:28 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr686949lfe.152.1589398648496;
 Wed, 13 May 2020 12:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
In-Reply-To: <20200513160038.2482415-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:37:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghd2efrE_DoJaC7nTkpCC1gPGp+xbNY7KWOE-7sa4h0Q@mail.gmail.com>
Message-ID: <CAHk-=wghd2efrE_DoJaC7nTkpCC1gPGp+xbNY7KWOE-7sa4h0Q@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series start cleaning up the safe kernel and user memory probing
> helpers in mm/maccess.c, and then allows architectures to implement
> the kernel probing without overriding the address space limit and
> temporarily allowing access to user memory.  It then switches x86
> over to this new mechanism by reusing the unsafe_* uaccess logic.

Ok, I think I found a bug, and I had one more suggestion, but other
than the two emails I sent this all looks like an improvement to me.

                 Linus
