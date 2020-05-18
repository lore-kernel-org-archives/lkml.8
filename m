Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECD0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AA52070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HQzjzokg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgERLNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgERLM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:12:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612AC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:12:59 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s19so8075153edt.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCv2ZdCkY0qCMhbqU1FXB8Pdv4mOdNVdXKMY2xRHask=;
        b=HQzjzokgi4lY9NYMTDDWBnXLzsdgSdzg0fwgxvoGbCjB/wGQGnntdVBl/4A7CgVANm
         t3RUM/EjHKkPSlqHctqbr2W5sp+MBsczfHXSRCjcs6P89C6emJ0hte/tS14gz7/RIsxZ
         YycgIpnRwaXsSRc2T3Kp4LrhTaaSiLX11dq5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCv2ZdCkY0qCMhbqU1FXB8Pdv4mOdNVdXKMY2xRHask=;
        b=NV78nv+raaDvTWb4q0keVquwAGKyg9fxMF/FZ0IRBlLg/On87ua0nBzaFWiCUxvW/M
         cVQBhsU+DJdathVN6qOBPQ6A22X7IDZ/b3Cuf6rsFL4BonJ94NjoMBdyxmrzGa0S8Ljf
         daGKdZ/g+DZelQm6QOjAZU/z3ahKeN/iaimD6nYoWwOG/5RcrslATVAzj2LKIgq1Iijt
         ZZ3h5VWycXNL9VpwWJeF137B1ceo62Pw6b5ma+uoUgzP4Of2MPNOSRf60RucGpjugxUd
         AMw6vblNO3yA23aUVEt1ecetskK8DDze2PWHczsZ2m77AGVE9rMinjrgRq2alldAo0r2
         MdDA==
X-Gm-Message-State: AOAM533aXvu6lCR+duMJBeaahySzWoulbRf0oi0nOU2bV+kaNyN3qX9i
        iXGZbF69dGXaPMX8juN5pfMK81XlJdRCedzquB7gkQ==
X-Google-Smtp-Source: ABdhPJxZ4VLvkgQkfYrdQPEgUccy2Gxq4UWk/GGJdjdM3rE6rYi+Thc9+WMOfS0GZAYv4rW6bvgBCMU2bphOkyRNkG4=
X-Received: by 2002:a50:d785:: with SMTP id w5mr12551406edi.212.1589800378320;
 Mon, 18 May 2020 04:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b4684e05a2968ca6@google.com> <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <d32b8579-04a3-2a9b-cd54-1d581c63332e@oracle.com> <86c504b3-52c9-55f6-13db-ab55b2f6980e@oracle.com>
In-Reply-To: <86c504b3-52c9-55f6-13db-ab55b2f6980e@oracle.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 13:12:47 +0200
Message-ID: <CAJfpegsy5vzO5e3DJGTrpXoGRTzjegoLaDdzheDeQhw+uokYnQ@mail.gmail.com>
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 12:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:

> I started going down the path of creating a get_unmapped_area f_op for
> overlayfs.  That is pretty straight forward and works well.  But that
> did not take care of the is_file_hugepages() routine.  Recall that
> is_file_hugepages simply does if (file->f_op == &hugetlbfs_file_operations).
>
> I suppose I could add a specific overlayfs check like real_file here.  But,
> that does not seem like a clean solution.
>
> I also discovered other routines doing comparisons like
> if (file->f_op == <expected_fops>), they are:
> is_dma_buf_file()
> is_file_shm_hugepages()
> get_pipe_info()
> is_file_epoll()
>
> So, it seems that these routines are also impacted if operating on files
> in an overlayfs?

Those are non-filesystems, with the exception of
is_file_shm_hugepages(), the only caller of which is
is_file_hugepages().

> Any suggestions on how to move forward?  It seems like there may be the
> need for a real_file() routine?  I see a d_real dentry_op was added to
> deal with this issue for dentries.  Might we need something similiar for
> files (f_real)?
>
> Looking for suggestions as I do not normally work with this code.

And I'm not so familiar with hugepages code.  I'd suggest moving
length alignment into f_op->get_unmapped_area() and cleaning up other
special casing of hugetlb mappings, but it's probably far from
trivial...

So yeah, that leaves a real_file() helper or something similar.
Unlike the example I gave first it actually needs to be recursive:

static inline struct file *real_file(struct file *file)
{
    whole (unlikely(file->f_op == ovl_file_operations))
        file = file->private_data;
    return file;
}

Thanks,
Miklos
