Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B11C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9150207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595442581;
	bh=FN2BDFM3ReiaeCoIqSwNZ5wlKI4QZO0yobe2XcOPwn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zfl2NYiUJkDj8td0kYhtx6eCSrGkCVVE32cnfbAjgOSCb0M2XzSa/gc0QkPnyWiAh
	 mNpO0HcBr59JadHMxZOwIQc9D9OIqfudMwCxSJwkBE+AwCwpuLaDHtGCxJc+MCTNYq
	 kBy7eX4ardZhixmkNtOkAm8ltvXjk5Ys0psdhXmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgGVS3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:29:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F9C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:29:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m15so1205164lfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfwVArCwT7ZvorIJCn6XJE1kGXlXCCBt7JStKiemrDc=;
        b=Y9Grku/LEnGv2LHPufhT1fzjPgYUvb0x+f63akNlgbkoKFxp4b3ixHQ05s2Yig5vKy
         1Y1eRLuHzf8zeKZcLkDNgasiT05atEtXVZnl04tHaqbUP5o1Am8KOoLRm08IYOGMEFHM
         FBc21ltlpIXX8MggmcTkSzNb7oTZcMifypARw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfwVArCwT7ZvorIJCn6XJE1kGXlXCCBt7JStKiemrDc=;
        b=R0VNZQM3q6p2Hv3SqZalfRFgbM7RbNk0203sN8oXJ1uWNvfoF34v+OJDjiVTmLIDW7
         InQXh6trpLrLlsV+EfzHJ/mbYz4BxI1aqvtJOcbJnrTAyArvlfJnQaqjC5vIcgVaWNkZ
         IsgjCbGHtVTrAJo/7gvtWUyyOkzjIq4oEibZ4E1q6Pj8enPW7t6unW64eBd2N1ECrpXp
         iogaAMKGaDcNbc0jHwnQ/UmPBpUoEvjD6vVFul27ItZlCvaSENyoIdqre+WvwKibu4sV
         VlY950yhbee30Y+tCzfJyt9eKY48Sn+lIdOcJoR0V7ex4uwe4eUt80Vcvj3AGZEo23kZ
         cV3Q==
X-Gm-Message-State: AOAM531nTvBOtY2nc4b3YdupLSHi0p7lwC6ESzp40O/kCAyTswrGZxmm
        ANBMNlql4jOLKOWIAv92Wu0u6cb0334=
X-Google-Smtp-Source: ABdhPJy9uwClMiu38AGiGakbWztz9YEye2oqp//MokFnRIdBRY+j8OXSAcvQ/vMMFWG8q8eFkoLrnA==
X-Received: by 2002:ac2:5338:: with SMTP id f24mr317474lfh.5.1595442577995;
        Wed, 22 Jul 2020 11:29:37 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l13sm432250lfk.18.2020.07.22.11.29.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 11:29:37 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h19so3517204ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:29:36 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr244946ljj.312.1595442576423;
 Wed, 22 Jul 2020 11:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
In-Reply-To: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jul 2020 11:29:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
Message-ID: <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 8:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> More likely, it's actually *caused* by that commit 11a19c7b099f, and
> what might be happening is that other CPU's are just adding new
> waiters to the list *while* we're waking things up, because somebody
> else already got the page lock again.
>
> Humor me.. Does something like this work instead?

I went back and looked at this, because it bothered me.

And I'm no longer convinced it can possibly make a difference.

Why?

Because __wake_up_locked_key_bookmark() just calls __wake_up_common(),
and that one checks the return value of the wakeup function:

                ret = curr->func(curr, mode, wake_flags, key);
                if (ret < 0)
                        break;

and will not add the bookmark back to the list if this triggers.

And the wakeup function does that same "stop walking" thing:

        if (test_bit(key->bit_nr, &key->page->flags))
                return -1;

So if somebody else took the page lock, I think we should already have
stopped walking the list.

Of course, the page table lock hash table is very small. It's only 256
entries. So maybe the list is basically all aliases for another page
entirely that is being hammered by that load, and we're just unlucky.

Because the wakeup function only does that "stop walking" if the page
key matched. So wait queue entries for another page that just hashes
to the same bucket (or even the same page, but a different bit in the
page) will confuse that logic.

Hmm.

I still can't see how you'd get so many entries (without re-adding
them) that you'd hit the softlockup timer.

So I wonder if maybe we really do hit the "aliasing with a really hot
page that gets re-added in the page wait table" case, but it seems a
bit contrived.

So I think that patch is still worth testing, but I'm not quite as
hopeful about it as I was originally.

I do wonder if we should make that PAGE_WAIT_TABLE_SIZE be larger. 256
entries seems potentially ridiculously small, and aliasing not only
increases the waitqueue length, it also potentially causes more
contention on the waitqueue spinlock (which is already likely seeing
some false sharing on a cacheline basis due to the fairly dense array
of waitqueue entries: wait_queue_head is intentionally fairly small
and dense unless you have lots of spinlock debugging options enabled).

That hashed wait-queue size is an independent issue, though. But it
might be part of "some loads can get into some really nasty behavior
in corner cases"

               Linus
