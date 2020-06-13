Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536B4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A402078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592067854;
	bh=MErJ7SUa38uYAQ9W43lpmBKDl9WtECEIMMWZ1piC9RY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AF91rL6Og3L7jLpra+ywzPtf6hOMSkjWVygkTjATfZ4HzLGeUKK3aMGhdc/qXbFKC
	 Y9U9hB/OWONL/KIcr7cXF3CRBTzEVqk9+wHL9fjGcddRjFWCe2rwTr43Vpt1HhADC+
	 IxDpe2PDPa5XSguP5/oorrcToNG4JqRg/VkW1Fq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFMREK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 13:04:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B36C08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:04:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y11so14523665ljm.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uOcP8wvI0VVU/9vs++U3KixSM8L7MBiXf+DxWGkO0I=;
        b=Yy3d5KdRDw1hzH1PEQuf/w+pL5E0KZICHKYeEpDF6h4E1JkwxsLxvUOA82j8ffi9wm
         G69M2LrhlOjYJ+LDuDQRsqubitClqczfsBDSYVR2HIzjv6ucIalMybe9rZVai3H50Ykg
         LtyaL1R6OHx6sisGgCxHaVvhg8CvecRUuLcqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uOcP8wvI0VVU/9vs++U3KixSM8L7MBiXf+DxWGkO0I=;
        b=iX07/kgxdGLRkx72l1eQNdAwA7GlJf1DIK1bRe541rgbvvGYIw9sXBLx5kF+rFt+Ng
         qId6aNXJ5iwb5PxpKKKuNm3p/VlcXqfZ4gxnv1je5r24DYtRkk4cdcdlGek4KAVm/eBR
         QLYx9T0jyE9jZbijnqh3ktrrxpnN2+OWeKEVx15xD1xx4WaTee/tz+kjvAS/sCF00kFN
         FgJnIXbiYtHZQFAJF1MtUqJwRZ6M9Fz6mlvM0z/iijVu2cP46X1uIYIoZcfoXHRRfOue
         7e69iIMR3o8XflM91yZPunxEYjAML6bPiarbB1LEjZmMueb3l87Md1ovXk6iNHSnk0aR
         N6Ow==
X-Gm-Message-State: AOAM5313tVmOkhpJPyhxHLLM5/jX4O7+SDm6zo1cN35bbcLFSVgMCjmf
        bhEbqUacAL/nEelBl6aN5q7l32u25z0=
X-Google-Smtp-Source: ABdhPJxLw5NV5PDVF9+TLC4PilUlaXpsLJfHeagb0Wz9GMQpgFg7LJPrRah9PZ+QNMD0UtYOQFEXVA==
X-Received: by 2002:a2e:918e:: with SMTP id f14mr9580170ljg.229.1592067848089;
        Sat, 13 Jun 2020 10:04:08 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id i22sm2720838ljb.21.2020.06.13.10.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 10:04:07 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id s1so14528942ljo.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:04:07 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr9126775ljk.314.1592067847109;
 Sat, 13 Jun 2020 10:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
 <3984625.1592053492@warthog.procyon.org.uk> <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jun 2020 10:03:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX1WM-ST+imRUUKabBo8GodUkYLGSAZ9NsGyqjA-q1Ng@mail.gmail.com>
Message-ID: <CAHk-=wgX1WM-ST+imRUUKabBo8GodUkYLGSAZ9NsGyqjA-q1Ng@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 9:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If we have multiple uses, and one of them notices some problem that
> requires any ABI changes, but the other one has already started using
> it, we'll have more problems.

Ok, it's merged in my tree, although I was somewhat unhappy about the
incomprehensible calling conventions of "get_pipe_info()". The random
second argument just makes no sense when you read the code, it would
have probably been better as a helper function or #define to clarify
the whole "for_splice" thing.

But let's see how it works and what actually happens.

               Linus
