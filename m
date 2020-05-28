Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C310C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720A12068D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8nA3Uvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406105AbgE1TFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405981AbgE1TFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:05:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65052C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:05:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so940941pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0J8Ym+kzod0znonchBb67O6GEq+arSkfzWAx+2kx7IA=;
        b=a8nA3Uvc1XNWqllXPWq50YCm6GC9JIOys9XsXoIOt75s4dnRClATn64VHORczX9nz6
         36TiE/XIWNy4AlmxWJnXDOjgvsdfvmvpVnaO2spx11lRLFhR2wUwUrM6twTgijFZSMqE
         wlhBeYKIjt+aSvFkHgat+EnhmlS08Lj8cQdcmDa8DdOVCnGQfzYhxtphaTNntW39TuoY
         NXWldrR4iHGI2FL0D3sITI0vFDewIHKpEGHL2qvhCcHfj0ZL8ZpDSHixbKyv8jWakGKz
         hMtXp+VhiNXwFMwKe+la2CyE3Cj0X/v83o5EewZSH0f1rn80z/ge1nhoKL5BqoZMw6XH
         lzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0J8Ym+kzod0znonchBb67O6GEq+arSkfzWAx+2kx7IA=;
        b=DWXBQSDxFUeIdT3IPwtHhkHO0YZtRFk1vFkIMiiQxkjw/HnDwD7bNgsRRoAjAL4YBZ
         MPswhZparn0I165r7kJ6n8ALK1z5REdnk95JS7Me2cVO6Z+r85jnkJ7bjuYDn/v4Ucsa
         92vM2yHXkUTA8R6tJLp4nA8sxX3jWzdGCjm85FWBP1Fw86996DfbfLnTTUa9tLr8EnNf
         bGMJNGH8uuSbZP+fnJoWdGhN4P1vZA7exyit31uTgIHGLNtAZ9986tBECZoplvW9SP4Q
         hr/OWQVHCzgHkKCMCbH/9Q0phzuSp+1dsK2KD+t0oovKFnaJQhJko6EUMy6MKB2Mi0Sb
         lo/A==
X-Gm-Message-State: AOAM532TGA2tSrZwvfaSuRunZE+S882UBa6jtt5E6QdvCAuzQA70Y2UM
        aSiZ+rVOoexTFADGIX1St5+KBk1gEkTkVE6mNiJVNw==
X-Google-Smtp-Source: ABdhPJyGks+NLInlB7CGn8AvdNxpH+2UCTLT9jhDTHdhJNdwc1bWKpa0P/I3v5HG+9H3eFYcbh9Z67/5AufG661dnwA=
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr4941782pja.80.1590692707555;
 Thu, 28 May 2020 12:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131420.29758-1-anders.roxell@linaro.org>
In-Reply-To: <20200511131420.29758-1-anders.roxell@linaro.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:04:57 -0700
Message-ID: <CAFd5g458j=VXttzbJUtD-HQR4k5T7us44oQOB6EPL09rgVr4LA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca, Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 6:14 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Make it easier to enable all KUnit fragments.  This is useful for kernel
> devs or testers, so its easy to get all KUnit tests enabled and if new
> gets added they will be enabled as well.  Fragments that has to be
> builtin will be missed if CONFIG_KUNIT_ALL_TESTS is set as a module.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
