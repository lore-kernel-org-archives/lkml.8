Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D08CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F5420838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoLAnZaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJHP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:15:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39926 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgBJHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:15:29 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so6408774ioh.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vKC4fIel0yFXG0LI2mvsasatAX4LSDIV07mHX56r+wY=;
        b=qoLAnZaOtLT4OL5VW2Ih0rbfd6L2kvosqZssjICIUO/wevNJJBJDgXSO1dM5J6DXb2
         /hr10k1GaP8efEbGviFC48dMDtnOwyAp0zMbVP7CQEBctbc+CZwARD/NJFIFsjWbL9FC
         /X3MVSCmeeRRb9YfkAUp00j2R73EKemjKIGe+P6uWbxKPXX9zA0BKM0M3yXgV3TjgaaF
         S1GwI8Mz/IYdszv0ELXXAuM/SJ25wpJstihswaSPvGXRIqKYOBqmeJMVksqydvILm0zI
         l/vZNoT+znc6rT8zKEvy1Y2iWtZzWR5tMEYlPNYDCjeaX4GmDktSZi8BJEdz2S0z1yGs
         k64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vKC4fIel0yFXG0LI2mvsasatAX4LSDIV07mHX56r+wY=;
        b=C+LbGhV+iuALa/+e5uM3dytUkyJpZp75/SasLfJQL2+HBvruyaIbyuILWw315HL/Pz
         jT3fgif3D5K+YMwOonNFRunlMchS3DH5+q9qY/H0qe9zVqHa4UhG3VYTkTnAxTQpaUsr
         n6MomIA9cXhwmFfTiTSasfR22BDlduLdrqnppnTeSoZqsWH4+JqaYOA8RpbUeuFFQW3t
         Nz2xUkuUzOPkP/MWQx4n1C56ZzFFg4EF8XgjjUnQeH3WxuknpgJ71et6sEscmSsJ3EJ/
         5UI+cBPaCq6xJsJcnUQsfM9mLvuT/kz3wYeCAJ/e60yvvbFmlCAUuwaT/oQIwwbHi4C4
         dU0w==
X-Gm-Message-State: APjAAAU2aMMJj+ioQu3Si85yF0AazhdasgGihd8b1O8MhsMDLBSXPfFb
        m1yA8gYn1VQ7YpWpCWQ7RJxU3zlpZhRPOHae4F8uOBZ9uII=
X-Google-Smtp-Source: APXvYqwq+yT/7ZlGpMbwc5iDWFkJj5baKN0YZtK8yPAiMTrUMrT4ip5GIyLXOPnIBH04UUTLRNNcltQHQflY4QcKrB8=
X-Received: by 2002:a02:a48e:: with SMTP id d14mr8870760jam.30.1581318928556;
 Sun, 09 Feb 2020 23:15:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5442:0:0:0:0:0 with HTTP; Sun, 9 Feb 2020 23:15:27 -0800 (PST)
In-Reply-To: <20200210070130.1029-1-youling257@gmail.com>
References: <CAK7LNAQs-KVCM7xXqJchQrMG+nnajPFRMB2Z+RJ9VTsg7XGRAQ@mail.gmail.com>
 <20200210070130.1029-1-youling257@gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Mon, 10 Feb 2020 15:15:27 +0800
Message-ID: <CAOzgRdYxL0RLq4Jqz1B_XXrUaQK5hMcWaazdvZzsNBUFy4CBFw@mail.gmail.com>
Subject: Re: [GIT PULL] more Kbuild updates for v5.6-rc1
To:     masahiroy@kernel.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        youling257 <youling257@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

revert 8d60526999aace135de37220ec94ba40bc792234 scripts/kallsyms:
change table to store (strcut sym_entry *), can build success.

2020-02-10 15:01 GMT+08:00, youling257 <youling257@gmail.com>:
> this branch cause 64bit kernel build failed on 32bit userspace.
>
> kallsyms: malloc.c:2379: sysmalloc: Assertion `(old_top == initial_top (av)
> && old_size == 0) || ((unsigned long) (old_size) >= MINSIZE && prev_inuse
> (old_top) && ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
>
>
