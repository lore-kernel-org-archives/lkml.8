Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F14D20767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594318050;
	bh=cIbGdnO1e+K2HlFT+xNczbx3DeDi+F1gQnDljE0aD4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gwWHHHFL729BW6P9D+4coT+H1nsmhKxtZOYRjgw73SwD7FslA6mSMFA7jrAIAKNmT
	 TenJjaQwu8FMmDpGS7YbZnqKMBx+bddmgG0LNx5QC8NEuUx/7+Hs3sXqV4zC6KpFZy
	 l5Toz8XQ290CGPxV+6NLUz6d7iGpLLi8JTIenij8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGISH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGISH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:07:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134B6C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:07:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s9so3426676ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGB1Ppz9iVx4FA/xnoM13tjpRPi/F5lN29F79qSyClI=;
        b=XlUxRvTGYZccRYMrKRoB6EWa71eHhhv7TO7Vq+BYwEosgfG77FRVMUrnAizkb/+sIJ
         rFcH3zyCOVKPaTjKMFymNQmA2ANoiIU33O3g7HgDp0mdHKMUF/14/BxYkEd+THUBakSJ
         LuCHx3jBsBS0QnYep3fFl0iBrz4LUkE9/SE2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGB1Ppz9iVx4FA/xnoM13tjpRPi/F5lN29F79qSyClI=;
        b=h9WQwsilVqyZOtf1WznHrpLK/O9FkaVv1/rdY8X+bHO4qBeZKYkdnzjETet8J6ZGCm
         rwx+m7QX7aUuH5EzdW6w5Ebql3OfWMJeldGznLsYKNFMhaOYa1ceh5AhPJ5fnV6U3FlM
         5JQIy4T7OyOnll/kmORnYh8Dy2aaZmvhKboZJnCd64bOrAcF6vGe9Fp7ju3kMdswpnHQ
         la2anMARw6EGzAyq+oRU0ry1sRyLY/5Vtgf4L0tbQl2gehxn+bjaQyhZdker03dY2ncM
         ZsaxTR6KTSdce0u9i1YdAca4x2SvyWGoPGxQU9oBNYtdN5C0Aan6j1pEb/SYIRoC9Bst
         RsOA==
X-Gm-Message-State: AOAM530i02oRLHAXjhHh7A023An3MHtLFaIj7pktZvLPLivd1cfm1PwN
        lKff/DwPqCsjmxuZGjEiQlaj4ysTOjE=
X-Google-Smtp-Source: ABdhPJxdLu1PDilepBn+tIQ0LfnfoV0y0rf8BTXTgc8yqFECXkTQLF8bQtxw89tWLQxxSviEE+TgUw==
X-Received: by 2002:a2e:3602:: with SMTP id d2mr39116735lja.152.1594318045913;
        Thu, 09 Jul 2020 11:07:25 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i197sm1185153lfi.58.2020.07.09.11.07.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:07:24 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e8so3474974ljb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:07:24 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr36559372ljj.102.1594318044230;
 Thu, 09 Jul 2020 11:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de> <20200709151814.110422-16-hch@lst.de>
In-Reply-To: <20200709151814.110422-16-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:07:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXq_149rcDv9ENkKeKpcEQ93MAvcmAOAbU8=bWG55X2A@mail.gmail.com>
Message-ID: <CAHk-=whXq_149rcDv9ENkKeKpcEQ93MAvcmAOAbU8=bWG55X2A@mail.gmail.com>
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

On Thu, Jul 9, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to mess with file descriptors from in-kernel
> code, switch the initramfs unpacking to struct file based write
> instead.  As we don't have nice helper for chmod or chown on a struct
> file or struct path use the pathname based ones instead there.  This
> causes additional (cached) lookups, but keeps the code much simpler.

This is the only one I'm not a huge fan of.

I agree about moving to 'struct file'. But then you could just do the
chown/chmod using chown/chmod_common() on file->f_path.

That would keep the same semantics, and it feels like a more
straightforward patch.

It would still remove the nasty ksys_fchmod/fchmod, it would just
require our - already existing - *_common() functions to be non-static
(and maybe renamed to "vfs_chown/chmod()" instead, that "*_common()"
naming looks a bit odd compared to all our other "vfs_operation()"
helpers).

               Linus
