Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C5D206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594234681;
	bh=/HmNAv3VtI6tKUilo3NoJrZomug1fbzlcPoHAeFduEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GPyMh80Eb92iiYO/sST1JVX9g2uCsgX8k9kr69oHPVSO8mANk56V41mh/nPwZEtu8
	 nkiz8GwNx68JGWE4O7Tm5H5aAZtPTjQR2I/wWogVImPUGBJ3kj7srONpF5F5VlUItG
	 9VmbdAS8YxtbmUzdgPOlZ79Ka7TTm6hm81iPDz+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgGHS6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgGHS6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:58:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A6C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:57:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so55490346ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWYjYIBe3hb4/4vbCyVaoP887WP+Gp1mlQlCb62YSBA=;
        b=Vq73d8l+3BMp4JujE6UfEHRqIJvLNGYq5e4nYrdL5IbPLmU/htT7PVHjoWIxLiJoZ5
         9NrEe5AQIr1t1eXW35yLRMm3OaOnksZ8seDUtp4XFiPXnCQV+/dIDHaZkmRJsOCJnp5w
         Ptw96Qv96pkFd9dG9w2cOCCXbJZNZvWnlr9ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWYjYIBe3hb4/4vbCyVaoP887WP+Gp1mlQlCb62YSBA=;
        b=GkeGbjuVAZ1g51LAdeAF+fZka+WV0Xu4PohGwsZR4TJSl5kTizdq7T3ow2wd0WkBy0
         h6J9lFyrsbUPWCOkFbRKqrG0a5k956jk0awzemxHCyv/onV3gYplm6fP+J2ARIf09j21
         x+slAn0CHzjaAuPVLIjV4MO5FFHPe8QE6GuAXixSm7bhJ5ZJu/hJZ7XUoEQL04OMfWTL
         3gPOUK0wyrLM8hqmf+zXCSwvUMNS3r1gd5Sr7a2ZY5QsFWO1V3EBFKZ9vWwswuE9Gtjg
         GjYWssyLvxKbSTGnYx2USytUUa7BSSXsteWQwJtYVK3MRc+s5KbHV5+X32IjDzfCy47z
         tkTg==
X-Gm-Message-State: AOAM533nxEM8hqwI2vYfwz4KUvmVdZTozwt0vAvVMnTdJ9F0GJ6Fyl+F
        j8eCeQdhjb5GlKSi1iy4HhuL/OB5sSs=
X-Google-Smtp-Source: ABdhPJxRWD3x4auseQ9befdeLVRI75hflchgmIlM+T5p6LzgJBAvkcPlqDWkQ/NKo1ezBdP8yi8nZg==
X-Received: by 2002:a2e:3602:: with SMTP id d2mr35975831lja.152.1594234677625;
        Wed, 08 Jul 2020 11:57:57 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z23sm156111ljz.3.2020.07.08.11.57.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 11:57:56 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id s16so22032912lfp.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:57:56 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr37282593lfd.31.1594234676431;
 Wed, 08 Jul 2020 11:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <a98e9c26-5405-3894-6197-3f5e388a5698@infradead.org>
In-Reply-To: <a98e9c26-5405-3894-6197-3f5e388a5698@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jul 2020 11:57:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkuOeHvA_ws=usQt=rYq_M2vh448mDxY7kYhUmp_Lomw@mail.gmail.com>
Message-ID: <CAHk-=whkuOeHvA_ws=usQt=rYq_M2vh448mDxY7kYhUmp_Lomw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: update for gcc 4.9 requirement
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 11:45 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> - - Make sure you have at least gcc 4.6 available.
> + - Make sure you have at least gcc 4.9 available.
> -GNU C                  4.8              gcc --version
> +GNU C                  4.9              gcc --version

Heh. The docs clearly weren't in sync before either.

Maybe we should add a

  Fixes: 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for
kernel builds to 4.8")

to your patch too.

I only grepped for the obvious GCC_VERSION string. Which is presumably
what everybody else who has ever done this have also grepped for,
although in all fairness Will at least caught the one in
Documentation/process/changes.rst when he updated it last time.

                 Linus
