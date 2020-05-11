Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D9DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5374D206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="zGg51pqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgEKWCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgEKWCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:02:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EBC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:02:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so4493491pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QcqAv7P8UvANEMfeZSVs1Z4C8izH07RPJiqXxjw9hi4=;
        b=zGg51pqrgFWI4OxU/iBR6WpE4sKCxEHd98DVJAj06WnuF8itLlYSDkEXZHNlI1oJwo
         0F3EmlaYIOvLA9q4llDdhbRV5qpvz9ykQM9YaWkc3Bem2PK+yFOC0jYYaw07WD6z1KbQ
         N4EMyQ0PnZiTLMG1GrhpN54g+PjvA2JT05NfXNEYMZ7CiI6VFr7vJhkcUfJRagIlnnzt
         kjUIggrjl+kqrhLgJp/VSrWr7UXg/dCDTf+Cvnk557yZTibYwa1j4i6Iold0jx+iN3P5
         zUsqPy8qEFSXISNg/to6m62QxJJT61C2/1vRcfufsllpzjwb9Zu3gF8gtqTIkR4+OqVH
         vLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QcqAv7P8UvANEMfeZSVs1Z4C8izH07RPJiqXxjw9hi4=;
        b=jYe61jJvihZtzOm9pfAks5xCzM+5GSK6pIQIdZ9aRkxjHbc6V1bestoAxO8WUrcvFN
         QpiZBiRxMcS7S/hRuWru2t2cUXDDA33fkZhXB1ZXKyddAeh5bAa8x8mhSOjP7DI7dVlb
         iaCP47OdNlMGLBaTIw/PQQKmQOeUa08nrOwLsZjiQLfZpm1oIMA5FFtgPd2sUSDyQ1Vg
         j2btL9tZipphP4BO4tVEyboYRmI6mF6jE2uN7Bh9LA6b1VkoIFqfuu2/fLK7N7Nju+TJ
         HoSz9dI0k7lhhxL4c92sRUGrwqpozSuufhoqaCtCIHAYqAX3vf5DBTKtYSHKVqqtkVBQ
         CNEQ==
X-Gm-Message-State: AGi0PuZppNCugDdbMcx9YA3Vm7/bLegrOZo992pqNOhzJLkvvJxXzNoq
        fr13fCCsHmj6fBK0ghipp+IUrA==
X-Google-Smtp-Source: APiQypKbWv7BEQtYlKsnaRgx2nOihXjdEb2WmNkWEXAul0dPafNnIP8I4CYyNEVkRCkfmcHQMhn0Gg==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr16808107plo.306.1589234563112;
        Mon, 11 May 2020 15:02:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a13sm50193pjm.38.2020.05.11.15.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:02:42 -0700 (PDT)
Date:   Mon, 11 May 2020 15:02:42 -0700 (PDT)
X-Google-Original-Date: Mon, 11 May 2020 15:01:02 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Fixes for 5.7-rc5
In-Reply-To: <CAHk-=wj8Cks7L2H9ToNWEMmqECYEfX0uyCXpW1OsZ+NAooi2Cw@mail.gmail.com>
CC:     schwab@suse.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-a0b97369-68df-4c33-ab10-28a5d3950b5e@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 12:04:09 PDT (-0700), Linus Torvalds wrote:
> On Mon, May 11, 2020 at 1:13 AM Andreas Schwab <schwab@suse.de> wrote:
>>
>> On Mai 09 2020, Linus Torvalds wrote:
>>
>> > glibc depending on kernel version is WRONG. It's bogus. You can't do
>> > feature detection based on kernel version, it's fundamentally broken.
>> >
>> > So I really would prefer to see glibc fixed not to do that stupid
>> > thing, instead of adding pointless vdso notes to the kernel.
>>
>> I'm not aware of any discussion or bug report on this issue.  Any
>> pointer?
>
> We've discussed it informally several times, but that really is just
> "I remember mentioning this before" than anything else.
>
> Basically, testing kernel versions is pretty much always a bug. You
> _will_ get it wrong, sometimes spectacularly (we've had programs
> literally break when the major number changed, because they only
> checked the minor number).
>
> Other times you'll get it wrong in subtler ways - testing for features
> by version number is wrong, if that feature is then disabled by a
> config option (a lot of new kernel features work that way).
>
> Or, the already mentioned "distros often port back features to their
> older kernels". The latest example of that is Wireguard being ported
> back to Ubuntu 20.04 - using kernel version 5.4, even though WG was
> actually upstreamed in 5.6.
>
> So the whole "look at kernel version to determine if it does X" is
> simply fundamentally wrong.
>
> Why is glibc doing it in the first place? Is it some historical thing
> that is simply irrelevant on RISC-V simply because RISC-V doesn't have
> that kind of history, perhaps?

I don't know if Andreas had something else in mind, but there's actually a
RISC-V specific reason we _do_ need this: the 64-bit time_t conversion.
Essentially what happened is that I screwed up by merging the rv32 Linux port
before the rv32 glibc port.  As part of the rv32 upstreaming process we
realized that it would be better in the long term to just drop the 32-bit
time_t support from the kernel, but at that point we already had the Linux UABI
defined.

We ended up changing the user ABI on 32-bit systems as of d4c08b9776b3 ("riscv:
Use latest system call ABI").  We didn't have any rv32 userspace at that time
(and we still don't have glibc or any Linux capable hardware), so we figured it
would be OK to break the rules and change the ABI.  The obvious result is that
32-bit userspace won't work with old kernels, so I'd assumed this was being
used to quickly sanity check the kernel.

Andreas would know better than I do, though, as  I don't really do much glibc
stuff any more.

>
>                  Linus
