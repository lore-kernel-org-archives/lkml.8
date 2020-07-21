Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514A0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283B62068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595365149;
	bh=3HVzTOC2YNqklJwj+XhK5bSZxZEErQbi5kqSUgWt8ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sdC435j6MSWFGbHromvS6MBgfqYCkXQrXU2yFP6Psq17z/5liSmploMsEDgjxW1S+
	 2eH6kbGxZHmyM/gYING2VRoW3cJq0wzVrd11hX7e3kP5pg85tpx7uZlj8tFfeucNf9
	 rmtC6QOpeCC7bZfhxyAuQ/QGbF9MmZa7OP++XBAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgGUU7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:59:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A88C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:59:06 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k17so97109lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oK0U7CK9re3KwY6+YWsTmFuqjWG2zA/cc2/NJqjaC58=;
        b=MJZCaND5bM+eLX/atXXRAs6foyLZdDHGe4xkDKocFoD0uopxVHUhAJF2FHiEr07g0i
         laWzz+ZjhXspCUxo4v10aCUKL49bwik1j0t1yx8BhtkyTkMGbYDaV4cQvfR9eOd8QLBe
         Q7fIBTaBylq5TNJhwwHDi6jMkh55DZb7AgFtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oK0U7CK9re3KwY6+YWsTmFuqjWG2zA/cc2/NJqjaC58=;
        b=Iu8Q4Q3gVIBSBXQGd1P/iRCKDB4VU3ZtzHUSgyCqiKCSB+ZtIP2kGbp2qnX/Z4VpaZ
         zBwk7w7VEdy+U03/IaGbVF1N6qz1dPAQ2wfmUwmZkfWqZzLLBU2vRyyZ2Zovxktax0Ov
         Lk1Q421Pa9i7md69WD0ccnlk241t6nXW9YgrOLWaqpN+3VnMGS1e1jBpWjwKavwDbXhC
         76NYi4MTzIP+NoNWSSQA18ciVngvaZ3La5Fw4+cbA8m242SkFvSK3jg7zF4Y6+A6M6MQ
         r2pkJLxx2kZAcZ3B0adK1AIQoXtAC3cCbZ0xkNNQ3wAp6WaYqii8Ba0spUDnVlssgbQQ
         9sVg==
X-Gm-Message-State: AOAM531SHWgSzutc3sI7JRU7s3Ds6s9tzHx5b5bF0+tieS1AU1N8f3/L
        bznLErOD+hUAmtHnxh6/x6FRugxWALc=
X-Google-Smtp-Source: ABdhPJzXI2rC8V7wL9J9FsC9KF4yTwaG8iEXaFSQAM0LzNwsnvOFSWH0HKMIqWzFQpnxWYcwnlr+9g==
X-Received: by 2002:a19:ac03:: with SMTP id g3mr14139693lfc.164.1595365145051;
        Tue, 21 Jul 2020 13:59:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w19sm5038073ljm.120.2020.07.21.13.59.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:59:04 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id j11so167491ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:59:04 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr13034796ljj.314.1595365143886;
 Tue, 21 Jul 2020 13:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk> <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
In-Reply-To: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 13:58:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
Message-ID: <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This seems dangerous to me.
>
> Maybe some implementation depends on the fact that they actually do
> the csum 16 bits at a time, and never see an overflow in "int",
> because they keep folding things.
>
> You now break that assumption, and give it an initial value that the
> csum code itself would never generate, and wouldn't handle right.
>
> But I didn't check. Maybe we don't have anything that stupid in the kernel.

I take it back. The very first place I looked seemed to do exactly that.

See "do_csum()" in the kernel. It doesn't handle carry for any of the
usual cases, exactly because it knows it doesn't need to.

Ok, so do_csum() doesn't take that initial value, but it's very much
an example of the kind of algorithm I was thinking of: it does do
things 32 bits at a time and handles the carry bit in that inner loop,
but internally it knows that the val;ues are limited in other places,
and doesn't need to handle carry everywhere.

                Linus
