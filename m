Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7FDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744FB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597773117;
	bh=XiKzO6jqr/WzermZvX+VVH7YjrYKOXAffYhCx3w5b7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b6T160Sy5344mcsoyioXoJw+5OCoJGzsHhnJUTO8ETXvcRJOxHjhyeKo1vUBxLdjg
	 zb+PAlDlxvxTvFxXf7Uo1+HO5XbDJa4zgir6zIVgtvsyujsRJJRmmEG4F1a/+eVfSS
	 Imbp5qoJ03r6V/smO1WkL85ye2iBHCKmk1/1qQ40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHRRv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRRvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:51:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4AC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:51:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so22427670ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhYhvABHV2jddQfXOeFsKwuWkPnm9/K7ODsabnkqxyE=;
        b=BFxNfqqTyERz8S3NIUgvZJCdbPrOEFBU1ekAkojzkd94vT++SS7yPoapxO2J4Ep9Hx
         7/9N9PGSXkogaZXbMUoaSa3n4dXLXXnvFdDlfLdXjOSdzZaXcze/Uo+L7FgvmcmQ2/tx
         kPWXT4EGNHd6mHTASbUu6qgRp1kqjS6UfPNDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhYhvABHV2jddQfXOeFsKwuWkPnm9/K7ODsabnkqxyE=;
        b=O5p4yJBEzHlYqM/u+qR+fvLa/taYhUx1aXPhQUjlNI0PcLOKsGL3qMoZrjfWpEChKp
         1p+UkcHClXlJcSN4WNvPIQ699rp/MCdxyIp5BuSeAoX8Pxoj9hVW0CwKq8fZVrU4yy4a
         LP7gLD94AVbdulzECzxVEB9Z6M6iRoLSUcZos64xLGnh9h3ZzRZpDX9/pZXow21yvS35
         pm/+f5cAEeUiXOio7Pcj2tqTuw9zlLJ415m2fC3FxTJjHdUANwGkFTtiWla7DGgUXVnj
         8Tx6xlUThqK9WVtAvx4pQ1dL85HCBUoCM4S45ba2MJfPMnL73eEmodMe8OzlOf1mJSmq
         3FCg==
X-Gm-Message-State: AOAM533V2uoszuyvol0nIsD/FpgAOJKEViWAC3UcuCMHFfbl1Gm/QpYb
        Cw45LWaKZ9w4DHuW6w3ZCj0DLAsPf7aiFg==
X-Google-Smtp-Source: ABdhPJxH94TFgNU36lKvN96n7GphS8oPmszS6fc1u8y0aVxkXSTEBua92IWsZb/pahmnw4aFaypUOw==
X-Received: by 2002:a2e:a28b:: with SMTP id k11mr10362682lja.405.1597773110786;
        Tue, 18 Aug 2020 10:51:50 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a2sm6105810ljj.40.2020.08.18.10.51.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 10:51:49 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v9so22427581ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:51:49 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr9571203ljh.70.1597773109282;
 Tue, 18 Aug 2020 10:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <875z9h9jkr.fsf@x220.int.ebiederm.org>
In-Reply-To: <875z9h9jkr.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 10:51:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcRsoQsPjOqwzH9ycmhp_SGpA9gZpOErHEk9Y076uefw@mail.gmail.com>
Message-ID: <CAHk-=wgcRsoQsPjOqwzH9ycmhp_SGpA9gZpOErHEk9Y076uefw@mail.gmail.com>
Subject: Re: [RFC][PATCH] seccomp: Fail immediately if any thread is
 performing an exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:11 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> +static void set_in_execve(bool in_execve)
> +{
> +       struct task_struct *me = current;
> +       spinlock_t *lock = &me->sighand->siglock;
> +
> +       spin_lock_irq(lock);
> +       me->in_execve = in_execve;
> +       spin_unlock_irq(lock);
> +}

No. This is complete voodoo programming. Code like this makes
absolutely zero sense.

Using a lock to serialize a single write is completely bogus. Yes, it
can be required if the field is a bitfield and you want to protect the
other bits in the word, but then you shouldn't be using a bitfield.

It adds zero serialization that a WRITE_ONCE/READ_ONCE pair doesn't
add. The other side will get either the old or the new value
regardless of the locking, so the locking is completely worthless
garbage.

At best it's just wasted CPU time. At worst, it confuses people about
what the locking means and results in bugs down the line. Don't do
things like this.

Locking for reading or writing a single value makes no sense. Locking
is only useful when there is a coherency issue and you have a
*sequence* of writes.

If you have a single value that acts as a flag, use
READ_ONCE/WRITE_ONCE to show that there's no relevant locking. In
fact, better yet, use "smp_store_release()" to set the flag and
"smp_load_acquire()" to read it, and then you get the read/write once
semantics _and_ an ordering between the "I have started doing X,
everything I've done up until this point is now guaranteed to be
visible to whoever reads this value".

           Linus

PS. Yes, there are situations where you want to lock around a single
write because of the serialization it guarantees for things around the
locked code. So you can have valid "lock-write-unlock" sequences. But
then you'd better have a BIG HONKING COMMENT about what the hell
you're really serializing, because it's not the single write, it's
something bigger.
