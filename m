Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78617C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDCF20728
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588044967;
	bh=WUekqtlW2qxmY+i/sIRQCBkqdsCrUdGR3PZOPeiwciA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W/VUvsELbGnArbI6I3E/FIqZJ5LW21nEfTRmaRbZ1NL2D53gxptaaO2ycgGb69Lv4
	 TTmNOFiVduNmX+2fu8Zt3k7RXV94r5JO2E01Tr89IEJQJ9wO2PF2Scp9NoLhK1HovM
	 OiYZSrl/Uma2Z6IWvcYk8DDc7rK2OX1PphE0sZgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD1DgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1DgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:36:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3FC03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:36:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m2so15639325lfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1Hl4EoAQeecS6RJeMB353EzxseO3r7Hp2yIzNObp3I=;
        b=SplrAUntYpA62B1N75YvHPdEO4shjtitO6O7fp81NGqZCL/liBkn4YGhS2ufiW89mA
         6QRtLc38lw6xNb2vgvLJDvqC9mE3aqUJAqwD+PeOfBSBP94LeZ1hMSN6COmTdIaxaQpS
         UpK5WWl4Kpc44DM72q0SRTuLkDG5Cy7pTFjlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1Hl4EoAQeecS6RJeMB353EzxseO3r7Hp2yIzNObp3I=;
        b=mTsxgPPCXvW1Zi/fcqKUP3AnF7y8cxraihjGe1moKqEK8HKPB1mLubFexqGpsZJrxh
         I/kXz3hgI+4ZsNxJ5NVzDqzoG8rxrTy5tMrNMHqzA5QMLviDqmIibGygAFNQpWI1fC+F
         WZD5LNvl7BxztUwOGV8VEvN3PtLuHzjAkfM+RdkAuoaHp/nlSFm47H9kVmX59IXzwAFk
         9DtP0MhsXpEBusGfJspwnAsvksNOzTPnzfXnc2wBVB7P/fG0RKmuY/wEcNeuor/Em83i
         ENp4X6yYclMMMSDijBp7WKwlQNUPvkY4Yikde0etMjM4skv3Rrq9z/PldirCiOqGDCMQ
         1m1A==
X-Gm-Message-State: AGi0Pubxl+WVbUCNLZM1xY0+78F3p8fvj8Afjgqw++1C0TvaapJwXDhb
        hfy4+3DqlE5zyM5187P6P+c1boQIgdw=
X-Google-Smtp-Source: APiQypJ4zb5UkqWpJUwGQ00ezKOxY4UIAZRncm3SFC+0rQdmo8swN41GyRdN5yfJUoDiilbK9DUuqQ==
X-Received: by 2002:a19:ae06:: with SMTP id f6mr17411962lfc.97.1588044963580;
        Mon, 27 Apr 2020 20:36:03 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j14sm13090863lfm.73.2020.04.27.20.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 20:36:02 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id k28so15651043lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:36:02 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr18095968lfd.10.1588044961861;
 Mon, 27 Apr 2020 20:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-3-jannh@google.com>
In-Reply-To: <20200428032745.133556-3-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 20:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
Message-ID: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
>
> After a partial write, we have to update the input buffer pointer.

Interesting. It seems this partial write case never triggers (except
for actually killing the core-dump).

Or did you find a case where it actually matters?

Your fix is obviously correct, but it also makes me go "that function
clearly never actually worked for partial writes, maybe we shouldn't
even bother?"

             Linus
