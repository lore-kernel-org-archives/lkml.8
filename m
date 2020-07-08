Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6263C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8175B20672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="RKAUZLS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGHHxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGHHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:52:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1621C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:52:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so49330850ejg.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzQgfQwlB8mQ8qOfmtknJOwa2W5D3WSjFsl4EQ7bldY=;
        b=RKAUZLS8ppSGqqaHG7ZpIgrwQ4r8B+G/T5SL3RJnDgnzyaiBa8W86kf3od5xL40Utl
         i6sfNp+Psui78KrXHyEyLcLwJ+StdXe8zue+WBNTrxBYzK1bKDKbZfx+17BRQ8BLtjUq
         JU8kOyCeajyj/z+qqxVy47uUr8k0brlZ65dZ5xtbF76ueZQQkVYMLML9zplT9hlRvJce
         DEf0lTcMjSp0fypSqF2K5dT7rHDKxo5JGwDTRfsEdMF+tTII4hs3WZUByfIgcQJadGIr
         sTGOKA8G9whVLWqyP3Zu6HIObSR6j+7lKmOUSgvh8Ez4x3aOtICftIqhwrwqBQZQzTkc
         mDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzQgfQwlB8mQ8qOfmtknJOwa2W5D3WSjFsl4EQ7bldY=;
        b=fUxA6S6YuNHf5l0vpe+3+qv5d+2EUFCfOmLGu/dv9Dk4y9f68ntk+aDQKCE6lHYwqD
         J8DZ2tKIbiX/wdYpRa3PeLkuo6yPMoOXO1hG6BYyKPBVlNcLNpHd9+3Y7xukd/8Bp37K
         F/Q1JQevdcEBv/qoubYs61r9IV86c+JlzoQmuZhH5Rqa1MK1WmQomzSaKA4dLGzz3GKD
         xwfDsmuWapu59mWstyUSXsO7YyZLKYK+SAB5xA+hY0gd3zPIQwK7MXnD8vIS7oabgM2M
         5Sh3/g/Sc3DnG+QaL2jY4OOqBjzFNbYoZpAolwGZYIp7Ktxrq3iUq4GxQwPBqpEnitoy
         +S1A==
X-Gm-Message-State: AOAM533GF/gbcdaNskMG/CDcPZvPaSPG/1DoMGe1KpaDRkV53pXiB9Gn
        vE3yIXRVaVqKQjTUEWtGjvcTsUaVLhHQ61rc1xAe/g==
X-Google-Smtp-Source: ABdhPJw7442gcjNFjZSE2uTN+bNfa8n0XgtMlWOFnhVCtn09GNsf3QDa21dGRGPOv8CCO6HI2q650npcLAIGzKIcY5g=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr50141392ejb.124.1594194777397;
 Wed, 08 Jul 2020 00:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 00:52:46 -0700
Message-ID: <CAPcyv4h8J2qx92YmEfYDoSwKZYjqPaw8w2dcmeDuVbApCbS7aA@mail.gmail.com>
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:40 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
>
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Chris Mason <clm@fb.clm>

Copy - paste error of Chris's address, should be .com of course.

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1 [1]
> - Drop inclusive-terminology.rst, it is in the lore archives if the
>   arguments are needed for future debates, but otherwise no pressing
>   need to carry it in the tree (Linus, James)
>
> - Update the recommended terms to include replacement for 'master' and
>   'whitelist' (Kees, Andy)
>
> - Add 'target' as a replacement (Andy)
>
> - Add 'device' as a replacement (Mark)
>
> - Collect acks and signed-off-bys. Yes, the sign-offs are not reflective
>   of a submission chain, but I kept "Signed-off-by" if people offered
>   it.
>
> - Non-change: I did not add explicit language as to what to do with
>   existing usages. My personal inclination is to prioritize this
>   coding-style cleanup higher than others, but the coding-style document
>   has typically not indicated policy on how cleanups are handled by
>   subsystems. It will be a case by case effort and consideration.
>
> [1]: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
>
>  Documentation/process/coding-style.rst |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..a5b61e9005ac 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,19 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>
> +For symbol names, avoid introducing new usage of 'master/slave' (or
> +'slave' independent of 'master') and 'blacklist/whitelist'. Recommended
> +replacements for 'master/slave' are: 'main/{secondary,subordinate}',
> +'primary/replica', '{initiator,requester}/{target,responder}',
> +'host/{device,proxy}', or 'leader/{performer,follower}'. Recommended
> +replacements for 'blacklist/whitelist' are: 'denylist/allowlist' or
> +'blocklist/passlist'.
> +
> +Exceptions for introducing new usage is to maintain a userspace ABI/API,
> +or when updating code for an existing (as of 2020) hardware or protocol
> +specification that mandates those terms. For new specifications
> +translate specification usage of the terminology to the kernel coding
> +standard where possible.
>
>  5) Typedefs
>  -----------
>
