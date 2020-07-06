Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB1DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B320702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WZP86zFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgGFQaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgGFQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:30:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2BC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 09:29:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so40012459wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXAuiOj+J7ih7guaxWlWZz3Hon8m2pdL85sec3nqONA=;
        b=WZP86zFB0F2LWpOr41M/TYwTLKw2Rf/hcqX2mxebHFq24vAAoO+FTeenU8Ls1o6pTs
         yYBzhl90q3qkTa/QzsDhv+Uy0/tfCAYb8XWTfXbLRZ7USGsvBjT94ywcpgsVL7K0If1B
         AKCZFAcx7If8HMYf4ZstxuUj1xYAdTLl5hbU6nbSgCzlbDlN6AV3+KAAPdCrnzPOtBHq
         PdLqz0ETSM/pLsREZC2ko67Fm68JQ/a1Lk9vQq8NoxMU25i2HD4YmBJGeSMYxRMrfoTU
         N7CaPWR6RV/h7+9AmNt6JDx76ntlwaa9uuVvfGbolhLJQ+4JsSpqxOxi7bJH4uHDYR8C
         SsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXAuiOj+J7ih7guaxWlWZz3Hon8m2pdL85sec3nqONA=;
        b=V1ugqVWgCZvAUA8P1kQ5pNpyIrOsuMTjOf8jHOQOpjaj/8Z2s2eEOSoRv1VDSiJcm6
         rT6lIVP5zI/znwZ5UQjOn29JYax0MkcDb9m4Dk7myEaB4wT/CXAQbWvP5G6DXqGlWuBT
         9vqT6YigLYjJW09kV2FRB6SM96TPUdG3v2ZIvHW8EpBRhIursc3XblxQu6T85z5edR+4
         nx2yMc83FGvx/+rRpKjEDDxIeAGE7o76HY6/UKQAW7y7dXBUmVyfpBC02xcAeGkSy39m
         yIPFWSmeya5GHjl1wMjr6AU8qRcv/YZqnNYwkkWsu0lOegMer7yEeivCt/dsSnbXnqDC
         K4DQ==
X-Gm-Message-State: AOAM532j/fdurB3zDJe36mJ5g+u5yW5VD1iNBIn+WlcRW6FXVMDmByFg
        dAAy+GUWHOiwH9Wns8jjOb8HCOkC9XDKU8nIf3OCTA==
X-Google-Smtp-Source: ABdhPJzk8k9ooYv1kWukndt8CMnG1n+NKLbCfqNP+yN4xkeFEb5Podrt5l48C6eWdZitlQgeIkLNwJfZgg3L6agz0ok=
X-Received: by 2002:a1c:2402:: with SMTP id k2mr11313wmk.138.1594052998297;
 Mon, 06 Jul 2020 09:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 6 Jul 2020 09:29:46 -0700
Message-ID: <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 1:19 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Recent events have prompted a Linux position statement on inclusive
> terminology. Given that Linux maintains a coding-style and its own
> idiomatic set of terminology here is a proposal to answer the call to
> replace non-inclusive terminology.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/process/coding-style.rst          |   12 ++++
>  Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
>  Documentation/process/index.rst                 |    1
>  3 files changed, 77 insertions(+)
>  create mode 100644 Documentation/process/inclusive-terminology.rst
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..4b15ab671089 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>
> +For symbol names, avoid introducing new usage of the words 'slave' and
> +'blacklist'

Can you put whitelist in the list, too?

>. Recommended replacements for 'slave' are: 'secondary',
> +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> +'performer'.

Should 'target' be in this list?

Should there be some mention of "master" to go along with "slave"?
This could be complicated -- as has been noted in this thread, the
word "master" has quite a few meanings, several of which are not
related to slavery or to any form of control, and that the meanings
associated with "master" and its cognates in other languages vary.

>  Recommended replacements for blacklist are: 'blocklist' or
> +'denylist'.

As someone who has written seccomp code and described the result as a
"whitelist" or "blacklist" in the past, I have a couple of comments.

First, shouldn't whitelist be in the list?  I find it surprising to
put 'blacklist' in the blocklist but to omit whitelist.

Second, I realize that I grew up thinking that 'whitelist' and
'blacklist' are the common terms for lists of things to be accepted
and rejected and that this biases my perception of what sounds good,
but writing a seccomp "denylist" or "blocklist" doesn't seem to roll
off the tongue.  Perhaps this language would be better:

Is most contexts where 'whitelist' or 'blacklist' might be used, a
descriptive phrase could be used instead.  For example, a seccomp
filter could have a 'list of allowed syscalls' or a 'list of
disallowed syscalls', and just lists could be the 'allowed' or
'accepted' lists and the 'disallowed', 'rejected', or 'blocked' lists.
If a single word replacement for 'whitelist' or 'blacklist' is needed,
'allowlist', 'blocklist', or 'denylist' could be used.


> @@ -0,0 +1,64 @@
> +.. _inclusiveterminology:
> +
> +Linux kernel inclusive terminology
> +==================================
> +
> +The Linux kernel is a global software project, and in 2020 there was a
> +global reckoning on race relations that caused many organizations to
> +re-evaluate their policies and practices relative to the inclusion of
> +people of African descent. This document describes why the 'Naming'
> +section in :ref:`process/coding-style.rst <codingstyle>` recommends
> +avoiding usage of 'slave' and 'blacklist' in new additions to the Linux
> +kernel.
> +
> +On the triviality of replacing words
> +====================================
> +
> +The African slave trade was a brutal system of human misery deployed at
> +global scale. Some word choice decisions in a modern software project
> +does next to nothing to compensate for that legacy. So why put any
> +effort into something so trivial in comparison? Because the goal is not
> +to repair, or erase the past. The goal is to maximize availability and
> +efficiency of the global developer community to participate in the Linux
> +kernel development process.

Should this type of historical note be in the document or in the changelog?

Suppose that we put it in this document and then, in two years,
someone notices that the very first bit of text in your changelog that
diff helpfully quoted for you is also mildly offensive to certain
groups  Now we could end up with:

... in 2020 there was a global reckoning ...

... in 2022, people noticed that comparing peoples' opinions on
variable names to medical conditions could be seen as inappropriate
...

etc.  And now this document ends up with a lot of history and also a
lot of content, and the history part starts to resemble the
now-frowned-upon lists of copyrights and changes that clutter the tops
of various kernel C files.  I suppose that changing this could be
deferred until such time as it might be an actual problem, but perhaps
this should go in the changelog instead.
