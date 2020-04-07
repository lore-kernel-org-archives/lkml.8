Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34436C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCBD20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586291240;
	bh=moGCNv47ZxvdGIc/GLXskdRzKlVipLS5hfxu3QO3Dk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SnaIZSGLqpB4wv1j+waE1+0Uzpr9D2dxhqqGJrC8N/GhF5q85dJwathbb1TxRS4Sh
	 8r+6Quf7sPxagf/N2sUg3S8P7QW/M0Dbt5e0MEYwlM2dIBPQw8l63tTfOjSToArGw/
	 4hnPCiwzvoV6OLnyDPMlCQyptnMGd7S7DAOrYLqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGU1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:27:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42229 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:27:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so5194609ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vULJyP67JBNxuLxHNrQncN4uZpPg3T+lQ2vheCSCnts=;
        b=Co/TSBn32SZzvluykyMIO4sU64Cf1AfgWv4n1Ae9afPaloY7VXr8XtXadW7RVEAJTs
         vKV3XqBLwUf5Lgvpk3GujRZVBG8OK5QgWjcN+ys77+yQtLlPkGtl5ki0fbBk2eZ4dECK
         i/T/hdMlpAbmHPRqD3BIA2AO4cpGwlth3++mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vULJyP67JBNxuLxHNrQncN4uZpPg3T+lQ2vheCSCnts=;
        b=VTn3DPCfDzP6roQTIjoW30gKbkyMMfuvDWNuF8Xq8AMRE9JHKTbhFpU0bfT8ggCZrO
         p9qksBXDCakYKuqy4bZWpCtk5BEy5XqwQMnPIeeKtjstVBOeVZsYuV/4Nz4+E4Y+hbdN
         +Rk/NVVML3907vIqxIZVaHNvOuegTJbtP+jbMoMKC9+6sW7aO02McDIZ9lvWjRWMXRny
         UwZdI5ngk3Bmh9jzKoX6lnuk4MRYDmfNGMAfcWye2Q1eekpkfK7XbBZzqxKy8EvJ/6Gu
         0IHKNf44d/a/OgOcBwfy1HJfNkELjyixNE3aWo0beYCTDyFZbSXjslf5XjOve8yL6NQj
         qpeQ==
X-Gm-Message-State: AGi0PuaOaX3Wq0esKuCjO4m7NP3AEDYmBe85Ct7AsV9xgyYbeXeC1pjI
        CEdibkVg5Y7rX5d+qec9O2zyryMDcNQ=
X-Google-Smtp-Source: APiQypIcVmKI52DHjS7PhPqwhtxF6CFbgQcjeSlI7bg+L+VOTcL2/F04Pbq1lfiWKZa1LBaYDH/j4Q==
X-Received: by 2002:a2e:9f43:: with SMTP id v3mr407294ljk.129.1586291235210;
        Tue, 07 Apr 2020 13:27:15 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f26sm13806243lfc.76.2020.04.07.13.27.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:27:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r17so3438503lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:27:13 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr2501400lfl.125.1586291232936;
 Tue, 07 Apr 2020 13:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
 <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
In-Reply-To: <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 13:26:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com>
Message-ID: <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Joe Perches <joe@perches.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Think of it this way: free() doesn't really change the data, it kills
> the lifetime of it. You can't access it afterwards - you can neither
> read it nor write it validly. That is a completely different - and
> independent - operation from writing to it.

Side note: I'd really love to be able to describe that operation, but
there's sadly no such extension.

So the _real_ prototype for 'free()'-like operations should be something like

    void free(const volatile killed void *ptr);

where that "killed" also tells the compiler that the pointer lifetime
is dead, so that using it afterwards is invalid. So that the compiler
could warn us about some of the most trivial use-after-free cases.

Because we've had even those trivially stupid ones

Yes, obviously various analysis systems do exactly that kind of
analysis (and usually go much further), but then it's external things
like coverity etc.

The point being that the lifetime of an object is independent from
being able to write to an object, and the "const" in the "free()" is
not "I promise to not write to it", but "I can accept a constant
pointer".

We've had a number of places in the kernel where we do that kind of
"lifetime" marking explicitly by assigning a NULL (or invalid value)
to the pointer when we free it.

I have this dim memory of us even (long long long ago) trying to use a
#define kfree() ... to do that, but it turns out to be basically
impossible to get the proper "use once" semantics, so it doesn't work
if the argument to kfree() has side effects.

               Linus
