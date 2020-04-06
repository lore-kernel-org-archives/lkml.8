Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B58DC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D955249CA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586193120;
	bh=TOK8qNbKv5hDmcEqj9P8KMgPzHR3tvpyewZf9KmyAXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bxz/uJqGlKrRcevif57BUPYJUi2Zbw5V1BYDKB49y6nLEJODGpWxeJSpvdz+EkhfF
	 RCILaRig39y6kD8XwNYEwUxnZ1c5tSVM1KbQPz82Ilcm547bzw/eH+jLktWEENCTuB
	 bsDvCmq83Wncl5V0W9F6xiJqVry8RVZD4eHSw3Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgDFRL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:11:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45298 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgDFRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:11:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id f8so66538lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIHqbWEotAan/sewwDfvuRd/CvbCudC1wXEoK4uYwQI=;
        b=cCyfHsvSJIbBmPiEgqdHYbrCRkeZCLL0r8+OYWYvaP6ePmiCcvWmHGdWpIvR9wS7yH
         Qjaf2hfg8nqF8dZM3j9qgEUyAGV1loDukhbMsue6luVn6M6E5QsAdDS6GXk0FyXFT8ke
         MbrqoJpcYh6U+txeraXaFeVX/Z8k1Vrbk1lPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIHqbWEotAan/sewwDfvuRd/CvbCudC1wXEoK4uYwQI=;
        b=n+hJT6Et5fKVPlAPkch9jAdAR9+YuGV/UAshJpY6nqoQKf/c607iuEjN75WbudmwF1
         WZIz0jX04LFzKJ12Te5HrAwfy7NQSX08vIuUhnb5+vGfFGBhjGTya3Y2Dupn1fivq8Q7
         xalTEvXp4TroNbewKFAAKPZ3nZn52coLAp96X5cgy41F84rlQ3Kk6CLtdaODeyJaYWKe
         2iIl9GtclZA6jOh+gfTrhbgDz7OEwdPSHZ+FWxwQIN3ZG7Nmz09jPBf6HGmD71hJN01Y
         3asTtU84JsAYtCfihRMsNfiNqXLlul/06+vsaFAt7VkvjaU1+mPYjh6eG3wGqMz3BCKH
         mRow==
X-Gm-Message-State: AGi0PuZwhEtDE/yYBzFD3WQzCrpvvIxnXJhvETP82iY6Qsw1HJgPkm8E
        OFHY1DHDXBU07tPQi1YuM/+mWO5mO/U=
X-Google-Smtp-Source: APiQypL0cj0yy0nlzUuPd1x5QPO4+b7HZv0I4OTzp8Bag8H2/MFh+HR6iGnM3sTQXyyKou/c+6jiKA==
X-Received: by 2002:a05:6512:1046:: with SMTP id c6mr2807682lfb.115.1586193115872;
        Mon, 06 Apr 2020 10:11:55 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 133sm10288958ljj.91.2020.04.06.10.11.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:11:54 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 19so492484ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:11:54 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr166510ljp.204.1586193114144;
 Mon, 06 Apr 2020 10:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
 <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com> <adc76d7c441e8f10697b61ceaff66207fb219886.camel@perches.com>
In-Reply-To: <adc76d7c441e8f10697b61ceaff66207fb219886.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:11:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com>
Message-ID: <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 9:44 AM Joe Perches <joe@perches.com> wrote:
>
> Dubious assertion.  Both end up with zeroed memory.

You don't understand the function.

You ignored the part where the zeroed memory isn't even the _point_.

Yes, for kzalloc() it is.  There the zero is inherent and important.
People very much depend on it, and it's the whole point of that
function. The 'z' is not silent.

But for kzfree() it really really isn't.  There the zeroing is never
going to be seen by anybody wjho does the right thing, and is not
important at all - it's purely a "let's make sure old contents don't
leak".

The "zero" part is completely immaterial, it could just as well have
been a "memset(0xaa)" instead.

And you didn't seem to understand that kzfree() shouldn't use memset()
in the first place, so it's not even using the same operation.

You really don't seem to get the whole "kzfree() has absolutely
_nothing_ to do with kzalloc() apart from a dubious implementation
details".

Should you name all global variables with a 'z' in their name
somewhere? They start out zeroed too - so pretty much according to
your logic, they are exactly the same as 'kzalloc()'.

                Linus
