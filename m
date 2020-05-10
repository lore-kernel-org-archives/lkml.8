Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA6C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5D020731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAWBJMnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgEJNfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgEJNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 09:35:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3632DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 06:35:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a21so6528696ljb.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jngAZ+J8DfcOtIHmAf1mcvbnElRAHo3CrJfzQxbIjSQ=;
        b=tAWBJMnlveO7XgyetJ2Z0EL7I6ezBIDNhR9yyBaatXjqSZky4/PDirpAConDmBioFS
         QyMJY07TqxbIzBGV535gxqHE7VWuE9t7FHv5rWHA2xfDuIGGSPhfg95pjZyaLU2Ykm3w
         wRytboptwGLWktiNorvyy7YdnFj5PbVNfkEgdjwj9RShSDKDXsiHxggnNQ5ed2WSsvs3
         lD8kPRnc7D/LjjE6dPhj77us9FZ/LG/eTrYjlRDD2+4P8J4SXnYUNmpYA0eAmq3o063R
         jWaWmOOJ64GX1jf6Xg7wHutGBIc0wglplwoDvBH3iY+KhadsgXbl63quys3PeXAnK/RC
         NYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jngAZ+J8DfcOtIHmAf1mcvbnElRAHo3CrJfzQxbIjSQ=;
        b=rKzSXeX5pY/rklYmcrpWPD/Pn+HaqBjGJPmxg/6+2qlo8vHdrGMm75ePCpGm15E08Y
         FkII6XFeivmg0darpbc0oppR1p3nd/AAIw5h46d89YPlFoxqAG+4kZ3k7QLx4iiT70Mi
         /zAMBWQzTbDeqmELTvxA6FLrsOz1uiTYDcMjWUr4ZpI5yIgG6BH9Hxyd1lK9krthBGgf
         pahHUIPbyGRIlBIOJ9fdrC54Hff4DP4XRT+kfliP2t7mo2o1kv5LJdUT1VGhEgxVjWjr
         NIhDlcaDlcFrduRpGjDU5jAcj5hzO7E2PAEl6HMvAUZc8D8Cr3cS/rIIArcrBgC2+JFZ
         w5KQ==
X-Gm-Message-State: AOAM533e1vxU5+aEbFfLcj9CXWiw2762gXeDIhuvpHNOgP6bLo2Ys/Wr
        TPvioGGaxL8Y5Lei4kTb703vfFhqXw7/KEbpq9hHA+i1/TPe
X-Google-Smtp-Source: ABdhPJxGoLS5ZdeKRCXQ1NC06eKGbXfNnZX5+BfAD9YT23bcl0UYWPg9uqMOz3l1NN9hnAp47w8I3taB2st2fzSkGAA=
X-Received: by 2002:a2e:a549:: with SMTP id e9mr7458208ljn.283.1589117722336;
 Sun, 10 May 2020 06:35:22 -0700 (PDT)
MIME-Version: 1.0
From:   Mahmood Naderan <mahmood.nt@gmail.com>
Date:   Sun, 10 May 2020 18:05:11 +0430
Message-ID: <CADa2P2UP1AtEmQYtyqUFKVNz8Rxii+-Zut3ibc5pMYnQB90-zw@mail.gmail.com>
Subject: Using a custom LDFLAG for all objects and binaries
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I would like to modify the kernel makefile in a way to include
--emit-relocs for every file that is linked during the process of
kernel make.
I see

KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
LDFLAGS_MODULE  =
LDFLAGS_vmlinux =
...

But I don't know which one is the main. Should I put that option in
front of every LD* variable? Or it is possible to apply one variable
for every file that is linked?
Appreciate your help.


Regards,
Mahmood
