Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BCAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AA420702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NfXW8gw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGGF4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgGGF4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:56:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A01C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 22:56:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d194so16120874pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZbV4l21xdzW71xXZzlMAZD+NRBjos3envDGwppLzulM=;
        b=NfXW8gw1ujyflsQLwzIJUJl6yv/6tCYaWdIMXKgCTt4z3Ww0mFNBeIgOPWXnJj2bT6
         lv1hrqRXfKZADzlSMJTcecsBSJnaZ8lAlqmmL9nFCKuUyP2jIIRFMK2t3hUUbLKt6Xa3
         4z6GvTlG1zXHnw88+cl0MNX0328JZYODTKYZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZbV4l21xdzW71xXZzlMAZD+NRBjos3envDGwppLzulM=;
        b=ksfRTghjpB7MsHg6OExCSHM2sfu4CJ9jY8MGKawFiE1RxgpvhSCLShxadaPzLEohAm
         ZpYyGOuX+fxAuY7WcOmzaf8Tt4RHS+8kKiUttk4zo+o56PGbfRGxv6H49f1lFjMLtyDb
         khJLiJBn44Eo+n8Qd/erNThPrVDRekWiFsl1HnI9sWglf9kl8rVjbyO82qqGgslFQF9J
         QayKwSfy4meIUpjNO8YPm54XIda9HJL+ogyPIiTCfDIMOAgtjxv6xi7dmFHRtWGiWzKJ
         pljg4yXpSwRUKCesCRkoEBVTY+hycFpUF8vxWhualquvA1c9o8R9GDSH7oBN/Rd3bVQW
         9TJg==
X-Gm-Message-State: AOAM533u6cnOFUjJtHM/n+F4DryAO9B3hTkHm3ePeob+4ddL4nC41Yum
        DIN2/z2L2BDubTvxV2rzn8MRlJnD3kM=
X-Google-Smtp-Source: ABdhPJzsiNlWqzzBSxLtFN4h9Kxieuvtd0hdAy5D91AwU2e7ZloJSYe7rbLvC6DMYZd+jw9XnsRtkQ==
X-Received: by 2002:aa7:860f:: with SMTP id p15mr11390619pfn.59.1594101379542;
        Mon, 06 Jul 2020 22:56:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y27sm21531713pgc.56.2020.07.06.22.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:56:18 -0700 (PDT)
Date:   Mon, 6 Jul 2020 22:56:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <202007062234.A90F922DF@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:29:46AM -0700, Andy Lutomirski wrote:
> Is most contexts where 'whitelist' or 'blacklist' might be used, a
> descriptive phrase could be used instead.  For example, a seccomp
> filter could have a 'list of allowed syscalls' or a 'list of
> disallowed syscalls', and just lists could be the 'allowed' or
> 'accepted' lists and the 'disallowed', 'rejected', or 'blocked' lists.
> If a single word replacement for 'whitelist' or 'blacklist' is needed,
> 'allowlist', 'blocklist', or 'denylist' could be used.

Yup. See:
https://lore.kernel.org/lkml/202007041703.51F4059CA@keescook/
specifically the terminology for seccomp is already "allow-list" and
"deny-list":
https://github.com/mkerrisk/man-pages/commit/462ce23d491904a0b46252dc97c8cb42391c093e (last year)
https://github.com/seccomp/libseccomp/commit/0e762521d604612bb4dca8867d4a428a5e6cae54 (last month)

> Second, I realize that I grew up thinking that 'whitelist' and
> 'blacklist' are the common terms for lists of things to be accepted
> and rejected and that this biases my perception of what sounds good,
> but writing a seccomp "denylist" or "blocklist" doesn't seem to roll
> off the tongue.  Perhaps this language would be better:

I have struggled with this as well. The parts of speech change, and my
grammar senses go weird. whitelist = adjective noun. allow-list = verb
noun. verbing the adj/noun combo feels okay, but verbing a verb/noun is
weird.

And just using "allowed" and "denied" doesn't impart whether it refers
to a _single_ instance or a _list_ of instances.

But that's all fine. The change is easy to do and is more descriptive
even if I can't find terms that don't collide with my internal grammar
checker. ;)

-- 
Kees Cook
