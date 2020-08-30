Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFF420714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGNjjXB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgH3ScN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3ScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:32:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CB3C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:32:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so4238125ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8uwjU5oHiF47ZrSXJ4yl5s3nLvBtRFzRy7WTBSBm60=;
        b=MGNjjXB+sKk0AO3lukEHRKMns6YteBnRQd8m5Bll9lSZ/Eml2CBmh4gTdwtWTxIP6r
         UK4oJoC2yzNckRturFI5L/egulnjeVsLW8C/ZIDjidPe5svsGSCX/aKWPhqTL1rngZPk
         33U5kKOxFG2i3PxPGx1/ADEnRCXW0Cj+rOMksm0Lacqaikw2OTBk/4E7Y0PIz9oC4ca9
         UsYadqznNUBk3Gcz+E+3QnAjKIquDMO2giLssBhNoP1Ge6wGJQ5D26ySn0fukexoSOWM
         43N9w551soMF9GansBYEpVOQ7aIBV5/1N2P1ZIDJjZ7nofUQwS+TWo8wAOSR5LTglIYp
         uciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8uwjU5oHiF47ZrSXJ4yl5s3nLvBtRFzRy7WTBSBm60=;
        b=K+sgZSa/IjE9kwe9ESQGSSrdbkgdptgSWHcd1isj9SU67oUcH2Sy6q/dYrP/S2yXfi
         vf+JWE926xIKo0qmjBUwlVfzy0D6BJpshG/YkYR4fxtA+PHHhFI4EcpejRFgQIEBJXwm
         SGCzD8Yy9fUAFl8kUavWSQOISD8MSMTjL2hDSuQ3Wj6gEhA99qvMwrLSY+gTsoRu13YC
         mtksp9WKkPIA6EHiR7O/uu50GK+jpnxnQA9a6SqHtA3XEuH22TjipNIVl+N1xa1EpZIK
         9vNx6F5oSmMm1d74QIMbsWVN9uDuz9dS3AiN5K5d7ziIyLnBBgH5/8b4/psfgcCXn3Zd
         CkBA==
X-Gm-Message-State: AOAM533kv3yepoNSZaGxZastBV5HyFhRnTy7AXpc0GbyEz9DKQEfX+BD
        guu5MaCGaiAM8x5ZtRAG43V1YLTcKsgMWwudJ3DvIg==
X-Google-Smtp-Source: ABdhPJyX6iKtCQdnK9B5zVHdLV6bTjpC02NKqEpb6xHUI18AnWkDRbQnBVUWMYHPEuxPsY8nyKrUyh0dRzSackS4pY0=
X-Received: by 2002:a2e:9990:: with SMTP id w16mr3391033lji.156.1598812323032;
 Sun, 30 Aug 2020 11:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200829020002.GC3265@brightrain.aerifal.cx> <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
 <20200830163657.GD3265@brightrain.aerifal.cx>
In-Reply-To: <20200830163657.GD3265@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 30 Aug 2020 20:31:36 +0200
Message-ID: <CAG48ez00caDqMomv+PF4dntJkWx7rNYf3E+8gufswis6UFSszw@mail.gmail.com>
Subject: Re: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
To:     Rich Felker <dalias@libc.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 6:36 PM Rich Felker <dalias@libc.org> wrote:
> On Sun, Aug 30, 2020 at 05:05:45PM +0200, Jann Horn wrote:
> > On Sat, Aug 29, 2020 at 4:00 AM Rich Felker <dalias@libc.org> wrote:
> > > The pwrite function, originally defined by POSIX (thus the "p"), is
> > > defined to ignore O_APPEND and write at the offset passed as its
> > > argument. However, historically Linux honored O_APPEND if set and
> > > ignored the offset. This cannot be changed due to stability policy,
> > > but is documented in the man page as a bug.
> > >
> > > Now that there's a pwritev2 syscall providing a superset of the pwrite
> > > functionality that has a flags argument, the conforming behavior can
> > > be offered to userspace via a new flag.
[...]
> > Linux enforces the S_APPEND flag (set by "chattr +a") only at open()
> > time, not at write() time:
[...]
> > It seems to me like your patch will permit bypassing S_APPEND by
> > opening an append-only file with O_WRONLY|O_APPEND, then calling
> > pwritev2() with RWF_NOAPPEND? I think you'll have to add an extra
> > check for IS_APPEND() somewhere.
> >
> >
> > One could also argue that if an O_APPEND file descriptor is handed
> > across privilege boundaries, a programmer might reasonably expect that
> > the recipient will not be able to use the file descriptor for
> > non-append writes; if that is not actually true, that should probably
> > be noted in the open.2 manpage, at the end of the description of
> > O_APPEND.
>
> fcntl F_SETFL can remove O_APPEND, so it is not a security boundary.
> I'm not sure how this interacts with S_APPEND; presumably fcntl
> rechecks it.

Ah, good point, you're right. In fs/fcntl.c:

  35 static int setfl(int fd, struct file * filp, unsigned long arg)
  36 {
  37    struct inode * inode = file_inode(filp);
  38    int error = 0;
  39
  40    /*
  41     * O_APPEND cannot be cleared if the file is marked as append-only
  42     * and the file is open for write.
  43     */
  44    if (((arg ^ filp->f_flags) & O_APPEND) && IS_APPEND(inode))
  45            return -EPERM;

> So just checking IS_APPEND in the code paths used by
> pwritev2 (and erroring out rather than silently writing output at the
> wrong place) should suffice to preserve all existing security
> invariants.

Makes sense.
