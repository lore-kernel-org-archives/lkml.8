Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64118206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UiJYyiPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgFDP5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbgFDP5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:57:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:57:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so2294611pju.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z02HjpdIyC/f+FSei9jV/KYu36NFQ5uAYMvx88TokgE=;
        b=UiJYyiPHhL+5GtrxMVXWjvcLL6Qb6ycW1HR0pNl6xx96Ji5PVF2xsK4yG7NhyB73sH
         JfdV1+OVGIkRnNEt/Ilns2vglxHs5OARDplc1i8yf5PN/5MSVwspv90DlARICMpyJ3Ja
         NHisdCZ2Ihcjm/GmIb4s+HKitVRc9IbkqL5mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z02HjpdIyC/f+FSei9jV/KYu36NFQ5uAYMvx88TokgE=;
        b=TbXE5yrqfqWsyzfzcg3fwOIw31r5ycpc3CTap46yYqPbeY/WA4Oa9BB7I6TYUas6u1
         SRYXY5lLpj/W2a/smhtcNdXXPx+9ChmUTNw7416uDae1cT73CFYu8MhVroqrjWORToM6
         g7pXsBCNVwJsf9Pao5pXc6KirSq5ucpu9qFgUxf+z1IhBwe9L3LoVErClsHqIfdLaDCt
         cpB6xZ9okiInbH0C37rTW3xgoDDn3yeB5HbWVCKBFcIglNeGqBgw4aqn568gOh3fDuYt
         H9C7pU1iIT6ENbig+cypL/5ier5yw6SQiPxWsMqyyFheKZR1Yjama2iGg6QeEp925cmX
         LwrA==
X-Gm-Message-State: AOAM533dW/oHYHP9KZ1th5SUpZUQUTiinQjjZO0Z7IweCMYH5UNttAGM
        mpitcd4LfKd0hrUKcXBXmPy1YTJCmV9/zA==
X-Google-Smtp-Source: ABdhPJzAbcerGsniFWkInonNtK9waPikGTV4wg1tDPqm0XOFXk03xxeKyPpoHNFsKBzYlQyzuic08w==
X-Received: by 2002:a17:90b:252:: with SMTP id fz18mr6292145pjb.96.1591286257215;
        Thu, 04 Jun 2020 08:57:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm5106491pfd.21.2020.06.04.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 08:57:36 -0700 (PDT)
Date:   Thu, 4 Jun 2020 08:57:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     glider@google.com
Cc:     miklos@szeredi.hu, vgoyal@redhat.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        royyang@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] ovl: explicitly initialize error in ovl_copy_xattr()
Message-ID: <202006040844.C50B47699@keescook>
References: <20200604084245.161480-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604084245.161480-1-glider@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:42:45AM +0200, glider@google.com wrote:
> Under certain circumstances (we found this out running Docker on a
> Clang-built kernel with CONFIG_INIT_STACK_ALL) ovl_copy_xattr() may
> return uninitialized value of |error| from ovl_copy_xattr().
> It is then returned by ovl_create() to lookup_open(), which casts it to
> an invalid dentry pointer, that can be further read or written by the
> lookup_open() callers.
> 
> The uninitialized value is returned when all the xattr on the file
> are ovl_is_private_xattr(), which is actually a successful case,
> therefore we initialize |error| with 0.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Roy Yang <royyang@google.com>
> Cc: <stable@vger.kernel.org> # 4.1

Please include a Fixes (more below) and Link tags for details to help
guide backporting, then you don't need to bother with with "# 4.1",
the -stable tools will figure it out with a "Fixes" tag.

Thanks for the v2!

Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1050405
Reviewed-by: Kees Cook <keescook@chromium.org>

> The bug seem to date back to at least v4.1 where the annotation has been
> introduced (i.e. the compilers started noticing error could be used
> before being initialized). I hovever didn't try to prove that the
> problem is actually reproducible on such ancient kernels. We've seen it
> on a real machine running v4.4 as well.

It seems like it came from this, but that's v4.5:

Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")

What did you find in v4.1? It looks like error isn't uninitialized in
v4.1:

int ovl_copy_xattr(struct dentry *old, struct dentry *new)
{
        ssize_t list_size, size;
        char *buf, *name, *value;
        int error;

        if (!old->d_inode->i_op->getxattr ||
            !new->d_inode->i_op->getxattr)
                return 0;

        list_size = vfs_listxattr(old, NULL, 0);
        if (list_size <= 0) {
                if (list_size == -EOPNOTSUPP)
                        return 0;
                return list_size;
        }

        buf = kzalloc(list_size, GFP_KERNEL);
        if (!buf)
                return -ENOMEM;

        error = -ENOMEM;
...

But v4.1.52 backported the above patch (e4ad29fa0d22), which is why I
don't try to figure these things out manually. Once we find the commit,
the tools will figure it out. I think you just need:

Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org

and things like v4.1.52 will get fixed (if anyone is actually doing
updates for v4.1.z any more...)

-- 
Kees Cook
