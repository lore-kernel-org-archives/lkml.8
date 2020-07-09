Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB0EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8ED02078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594319007;
	bh=2epF66p6DDES1+2TRgFWyT7u9QjeZjL35rp9PiscIkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ciz8Hs3+aS28JiIGdXeseNfL1/Tf7d5FsbkE4kAmGOePmlBSmcecfF+DrHacWC/Oh
	 uDUAXiMy2tuQPHaInUTEbit01dv3uLLoovono1ZxP8rNozqruo8WX3Y8d8XOegR91X
	 xZEHN0dBY4wtZ3YKvXHZ4WB7WfyhtdcukAdL5dxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGISX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGISXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:23:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:23:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so3508246ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBK34QmOm7rGagdq+y/pFHeLmBKGPoe57/dqNXAHGsw=;
        b=E41Qu6K2EXG6IW9nxZNyd9nff5Sg9XWoTihHNGOyqwH57TnGAezxJygQRAw0a5fPFn
         E0iTIgSbCcZhaVhOSAlxzVIDJdXSvOJlGcYzwHlw+oMGcRa8VxVwijJnbsBL8MNol8Oi
         r7PZqhXkTu6KRUsNghrwQbZ/XTNJNQBklIUzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBK34QmOm7rGagdq+y/pFHeLmBKGPoe57/dqNXAHGsw=;
        b=csG1KbngvVdPMHmTcJBUz9Drc5PXyieQ01dVjd9f5dwqpsfYdawbOOtb7zg9kRfYsO
         tRD4Wq3L9zcmx7bLGe+xv5kX5Vz9gqHs8VRtpuk4pCKio6JLbR5OM9fYcveZyDzNG/Sy
         ii+o2QyCuoXtZxBn+kjWQBzyzH8PZdydyZYL3P9IsXROGM1BiCF3U+GiLm9v9+oUdMqx
         C1Z2/bIf4Pn6CzSyBsTmWakOU18tQ2q63VKoC84gSKC4tj8rOVIAhW6wml0YHdLGzraA
         2C88pJ2ITWXNuut+/PRiClp2p913GAdWobagVXmdVPB+4zFAQkUFt5tbd4Qc8ffb2zf4
         M+cg==
X-Gm-Message-State: AOAM532wr9jaCP47mPFFzd4kB2OrIPbQGMEC6bglMCPixXWk6FXzh3e/
        KGe39TlXmpGiChoArcr1fO+fHRcDPzs=
X-Google-Smtp-Source: ABdhPJxqAttJ/dteZU4FnAL5W2BFAljWVhF9ZghsAGGy+km7oslOK+sA1si8IO4A3xtuadldfprQyA==
X-Received: by 2002:a2e:910c:: with SMTP id m12mr15794245ljg.274.1594319001463;
        Thu, 09 Jul 2020 11:23:21 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id f13sm1201140lfs.29.2020.07.09.11.23.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:23:20 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r19so3474555ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:23:20 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr36586914ljj.102.1594319000060;
 Thu, 09 Jul 2020 11:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de> <20200709151814.110422-16-hch@lst.de>
 <CAHk-=whXq_149rcDv9ENkKeKpcEQ93MAvcmAOAbU8=bWG55X2A@mail.gmail.com> <20200709181227.GA20954@lst.de>
In-Reply-To: <20200709181227.GA20954@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:23:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXtjWb_sVfaSGTaCToHZmxRs4EHpQ1ck=6B=zGTLuQdQ@mail.gmail.com>
Message-ID: <CAHk-=wgXtjWb_sVfaSGTaCToHZmxRs4EHpQ1ck=6B=zGTLuQdQ@mail.gmail.com>
Subject: Re: [PATCH 15/17] initramfs: switch initramfs unpacking to struct
 file based APIs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 11:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 09, 2020 at 11:07:08AM -0700, Linus Torvalds wrote:
> > On Thu, Jul 9, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > There is no good reason to mess with file descriptors from in-kernel
> > > code, switch the initramfs unpacking to struct file based write
> > > instead.  As we don't have nice helper for chmod or chown on a struct
> > > file or struct path use the pathname based ones instead there.  This
> > > causes additional (cached) lookups, but keeps the code much simpler.
> >
> > This is the only one I'm not a huge fan of.
> >
> > I agree about moving to 'struct file'. But then you could just do the
> > chown/chmod using chown/chmod_common() on file->f_path.
> >
> > That would keep the same semantics, and it feels like a more
> > straightforward patch.
> >
> > It would still remove the nasty ksys_fchmod/fchmod, it would just
> > require our - already existing - *_common() functions to be non-static
> > (and maybe renamed to "vfs_chown/chmod()" instead, that "*_common()"
> > naming looks a bit odd compared to all our other "vfs_operation()"
> > helpers).
>
> Sure, we can do that.  It requires a little more boilerplate that I
> thought we could just skip.

Yeah, it makes the patch perhaps a bit larger (or rather, it adds one
new patch to do that "introduce new names for *_common() and add them
to the headers"), but just looking at your current patch:

+                       ksys_chown(collected, uid, gid);
+                       ksys_chmod(collected, mode);
+                       if (body_len)
+                               vfs_truncate(&wfile->f_path, body_len);

and I go "wouldn't that look a _lot_ more regular something like this":

+                       vfs_chown(&wfile->f_path, uid, gid);
+                       vfs_chmod(&wfile->f_path, mode);
+                       if (body_len)
+                               vfs_truncate(&wfile->f_path, body_len);

so I think that I'd prefer it simply because it makes all our
interfaces much more natural.

I note that we still need that ksys_chown() because of disgusting
issues with the legacy 16-bit uid support. Which is likely not used
any more now that a.out support is gone (well, alpha and m68k still
define HAVE_AOUT, so it's not "gone" gone, but it's gone).

I can't imagine that anybody would have ELF and 16-bit uid's.

Except users are crazy. So who knows. But it might definitely be time
to deprecate UID16.

That's a separate issue, though, it just came up because of that ksys_chown().

                Linus
