Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D47C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B74F20728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579288839;
	bh=1KiRU8JtKAnHsFqwSMovv1D+wZlaPEx1howCZbKYWl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=15g9T6wy6zJ2xfvc87jJYmJOHmdmIDrDfnypIYPPF3TEqX46QTqVDQHjHguAoTZ/m
	 5H7h4fbtIIlORk8bfp3dPATabB4p/IWDa5ho6CjPXKiwlcBqmlTS2qNtdcG27etR+X
	 m2G/buT9Cmy//FHxlXfGu7b3HYrfReuMqPck14wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgAQTUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:20:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41375 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQTUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:20:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so27570985ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 11:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjn/4JEsak9XgJfi8H/1wSFhagaL5qBcKMX83cbL8lM=;
        b=J6oAUgFSgqzQVKrljKHl0wA585Cu8h3LZrzViJ+RlD9Jt/9vla5+6+/UIQPgOQl7gS
         Sqo6g3ob4Mo41Mx8brh1v3MW0bYMAAA7LEOEXM69LJf7+iKCWNvVV55BAqfB3KEywnX0
         UAZ5Zj0s7Dfyx43GFe9KrRl9tX1FMBy8+oVzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjn/4JEsak9XgJfi8H/1wSFhagaL5qBcKMX83cbL8lM=;
        b=iRYx8w7Q67NwGDOa2283N/lMDN3Km+M7rhSszaiPvHhpbi5DekYhSIlhxxmwmQ524/
         8+7VEpIx02uSU4he2JTPYJFHUfOhloiHGqcHjU1ElikhJ3NjKZp0aytxAAzwcxqDQqEm
         K3laQ2v8HTqQ/8u6+Zp8h6A1zq4iYbTuuuKNkfkR4LRBOOlcLL9wavVyDN0F3i43qQ7V
         5fYdKV0mYUyMH1AnHvVt/QD5MzqxlZFfPPXvcrzwLxFrZzVpp0odAsGpH870abj67Kbl
         zjTjd8JnI/Qbuv485pieV4o4pYKEzvjvHPmUG21KxJQGmnRQxOnFjf3gXU9/rSZq4thO
         NFTg==
X-Gm-Message-State: APjAAAXNdkAwxAXsS92cc727mWDk5SAomPG4qDHy6r/dQXtl/ju7PAjt
        YrtIyEbmiZ3ulMG3LiJ3XqHzzO+G3Jw=
X-Google-Smtp-Source: APXvYqzmxtiT6qbAgsiO8SytHsLb3M/r9eSj1ydzPwSMHmwGSO4tnzWCVauAIJVBr+sIgD0//8UmTA==
X-Received: by 2002:a2e:3e03:: with SMTP id l3mr6524495lja.237.1579288835110;
        Fri, 17 Jan 2020 11:20:35 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id s2sm12711972lji.53.2020.01.17.11.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 11:20:34 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id j1so27552647lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 11:20:34 -0800 (PST)
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr6522426ljc.43.1579288833652;
 Fri, 17 Jan 2020 11:20:33 -0800 (PST)
MIME-Version: 1.0
References: <c6ed1ca0-3e39-714c-9590-54e13695b9b9@redhat.com>
 <CAHk-=wink2z6EtvhKfhSvfC2hKBseVU8UWsM+HLsQP9x3mD7Xw@mail.gmail.com>
 <5c184396-7cc8-ee72-2335-dce9a977c8d4@redhat.com> <b70a0334-63be-b3a5-6f8a-714fbe4637c7@redhat.com>
In-Reply-To: <b70a0334-63be-b3a5-6f8a-714fbe4637c7@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jan 2020 11:20:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOwghtCi8kpdefmLbyG0oSH23vYrMOU8v_XKEe7va-4g@mail.gmail.com>
Message-ID: <CAHk-=wiOwghtCi8kpdefmLbyG0oSH23vYrMOU8v_XKEe7va-4g@mail.gmail.com>
Subject: Re: Performance regression introduced by commit b667b8673443 ("pipe:
 Advance tail pointer inside of wait spinlock in pipe_read()")
To:     Waiman Long <longman@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:11 AM Waiman Long <longman@redhat.com> wrote:
>
> I built a make with the lastest make git tree and the problem was gone
> with the new make. So it was a bug in make not the kernel. Sorry for the
> noise.

I think I spent about three days trying to figure it out. At least it
felt that way. I looked at the pipe code a _lot_, also blaming the
kernel for obvious reasons.

             Linus
