Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3523FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C74421582
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/rT7owE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgBEDFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:05:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43970 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgBEDFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:05:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so350063lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 19:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WF1go+DuJvbwgdXeUhoD65NaX1JQ7zRHimo51GmC8M=;
        b=a/rT7owEo3U/lPRFn35JOyHmNdZNKq3CUN5eC0vmSOAlGMUJJc7ELCvSX1Mh8APfaa
         lAlLVERWXR5pYN81ddhMclRnb/OmN5Fx2KddB7KuZLDfFPyFM3c5qNNCCjwGgxr+r3s1
         DNCcaZvM6VYKACKmTz/OjiTlKJVFN9VL8YzEYvQS2U83lFvZUm1XWKOklUIkQxQvXozG
         vNU7Zo1syf0hTTILG3oFQfUcj+JQqVr59fj+c5MCVuSCuEvLrPxTFeYRhYsiMU1wniYS
         k/ew5rFlhFL2LzMHulEuIV3u33upCBPfLhXENQXAIsbZYUZT2I99yQmfa/FkquxeDAIP
         aNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WF1go+DuJvbwgdXeUhoD65NaX1JQ7zRHimo51GmC8M=;
        b=tOAj5a7nkDHcUMGvREqtcXoNNjGPOQMsUCJ/2yy4UPCXJ+IW66YZMLckzJsUyJ+k+n
         cnsVzrH77IgnHUYdW9I4uB50dh4jb0Iu10GGPrumdpdvfzjJMXMzutPqIQeTam8GXkGs
         js8LirqXqVqnmF/Piw3PRh4yYyEyeX3/xB30VLCJyIngqgNRhd+Xn0MtRd+5g5TFcal/
         IGvmS0JoRYiQm/1BwanzgM+WVmg3fpTC0MYFMdbmcMvvenY5UXUJnHYAwtO/gOd29+K3
         MY4yhSnnBzAoCUnl5mwhVmcH8S27nAf+/gqiD34B4w+UgN9bv5TeD3k6sauRRh87YGFk
         wxvA==
X-Gm-Message-State: APjAAAURN9yXo567m7SM+mqJY5k5dV2c+ANrxNld+VxAHKukAt6FVNT7
        r+gfQPZNsvZ46WjMUMeck3vk+FUrQk4wOWIe8q2C4Q==
X-Google-Smtp-Source: APXvYqzeG4caRRvcRllow4EA73MGmU6WFhFNYJbaTAD8sJamhzsXSFSCQuZUYpZgWEJovRgzDpyi7R9sxFKJltzNJtg=
X-Received: by 2002:a19:4a92:: with SMTP id x140mr17094713lfa.29.1580871913677;
 Tue, 04 Feb 2020 19:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20200128230328.183524-1-drosen@google.com> <20200128230328.183524-2-drosen@google.com>
 <85sgjsxx2g.fsf@collabora.com>
In-Reply-To: <85sgjsxx2g.fsf@collabora.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 4 Feb 2020 19:05:02 -0800
Message-ID: <CA+PiJmS3kbK8220QaccP5jJ7dSf4xv3UrStQvLskAtCN+=vG_A@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] unicode: Add standard casefolded d_ops
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 5:46 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
>
> I don't think fs/unicode is the right place for these very specific
> filesystem functions, just because they happen to use unicode.  It is an
> encoding library, it doesn't care about dentries, nor should know how to
> handle them.  It exposes a simple api to manipulate and convert utf8 strings.
>
> I saw change was after the desire to not have these functions polluting
> the VFS hot path, but that has nothing to do with placing them here.
>
> Would libfs be better?  or a casefolding library in fs/casefold.c?
>
>
> --
> Gabriel Krisman Bertazi

The hash function needs access to utf8ncursor, but apart from that,
libfs would make sense. utf8ncursor is the only reason I have them
here. How do you feel about exposing utf8cursor or something similar?
