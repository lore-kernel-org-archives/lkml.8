Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758FF2145D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="xlH2+MLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgGDVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 17:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgGDVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:14:28 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8EBC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 14:14:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so14780145ilk.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PlPhdPEZXE1GD8L44azYzT0TFumqmAZNNi4Yg9UzMI=;
        b=xlH2+MLPbpFQoQW6QM3rv6isTJwA1UeMN+daOddsvlfmf+UxY9Q3IWkDp6O1S9Xjf2
         xcYe+B4CqfYATsootFWAeKgAvkkKAcuH0GYSKrr3FBlWGkI1UvWh5XYZrtoLLzeJ/Crs
         t9yFz9ZGFGzTU8+ZXWooSP2KwDVgf2PUjVhff4og80Q3AlWaI/zEWUtX2jMsZ+b+VPqA
         HZEf9lBoLDIpPpq2X4YtnoWnB9uJJP+BJmzCNxZ4kZS0KUYnD1UzGRuibNTFRoXgGMBp
         ltef48pyK+l7DAdHLIjW2RKie1SL74I1a/9Gej3+wCr4oRdnoqp5tJusIThbwBwraoHu
         sZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PlPhdPEZXE1GD8L44azYzT0TFumqmAZNNi4Yg9UzMI=;
        b=gsDbpgUzKsP4PJDgWIdkUBZe4MzV0a/RAJiHdVSkHXofMSoqhWylG08zaKM79eqBqd
         Wt70BoS3Co8hOB3EwURfdsuJgPh21MepGcABJcpTQwrWX/PALr2czsTcBgX1FGuqGpUk
         ag8+fDKWvt2dC952jcqaZuiI6UjfYfU34mZmUlE1BJjqauD+BWNvZCM+fWxBXh50VOMK
         PfIrMJy4vP4Yq5+uktvFfvXmzJvPnPmEL5I1AilFjW/Dg7PRPKUOxRiNuk9XBm+EoMJk
         v6kri42sovhbnkCKUCrJXPEfQxB1scVJXvvv3+5XN7cMb94q8yQGqZVUE/Xd/HaDpJn4
         YI1Q==
X-Gm-Message-State: AOAM530TxCxn3IljhpHfV9rN0IehhmPEzDpVvosSB0txekxZ1Tv+yt8J
        8RneaPd2phLAJDWxptW0d3o/L+ll7V7DPejAtuzeQ2BPcI4=
X-Google-Smtp-Source: ABdhPJyigj0IhJ7b+Xv7cD3r6+A0IFgDsdmhNzSaAZnQpgz56QW9lkBxb8HgrhHNqtJSG45sc5Tfkq/IIsO5kAcgo/I=
X-Received: by 2002:a92:4184:: with SMTP id o126mr21892061ila.278.1593897267501;
 Sat, 04 Jul 2020 14:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 4 Jul 2020 14:14:16 -0700
Message-ID: <CAOesGMi6JoYvi87jrhXuaF6THmoJVzwbOxzGR8VV8JYeKdVOZg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

I'm happy to support this, I agree with the general approach as well
as the motivations thereof.

At your discretion, feel free to add:

Signed-off-by: Olof Johansson <olof@lixom.net>

Or Acked-by, or whatever other label you prefer to use to show
agreement and support.


-Olof
