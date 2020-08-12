Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B308DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9767E20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597256330;
	bh=Xob0b9wfX/1/4X19lJ4MoqCGbw4npN7y22G8fVD+GbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WyLKegvHKmUfRWhKnU9+G9DU0vsBezbpuVbbGpM+khSK1iH35A3qdww5kdQmywtv/
	 +xvpqs9l4U+hqW0tWePx+GFo9+eV2vEp1ukkz6/oNWU0GItYPIsolgn03YFo97lkVh
	 xhjrFCOXi1QDbI5iIZ67AKk/FnqT9smgqTLy7dY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLSSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgHLSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:18:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453ECC061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:18:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so3343698ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=US2q3MwnTSjWfqpie9O3CRcizx9uSCz4S3vkL7p/ooj414+R066sTYC3Q4A4VD1OD6
         WbBdeRdiPaC//fSZsRo3WOoZpu8gTtAt7k7tMZ8hwJVqEhGHjLO4oOIslMbvG22T1LrR
         FvpBZZmDKWHcNGLeiM+6hKFDuuH8IvkNuF9T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=ueFbTcW9omRsKdcd75cmf+KdnwuJDzy17bxma5pbJErB2doVeFs64oci5DNIYTWqAH
         2Lb1o2vmADf10/W0ujwNdlbKDskgTlF3lOWRGpql29tk/jo9JptLxHsMrhqwOff34+Yl
         Hyl952ERh78ehdGpT8k05SQpMVa2NzwEPIj5J65BMPFAYh4plnOBa4qjH04FXU5fpZoj
         xsj4iTT6H5p/xavVYtIunQJQ3odVx9Hhs1iZHhumMjFhDjZBBkrKKHR7jqdCQYNwgYS8
         jbC6bNsaEEjpWlrujztHACRGSLU/880+aFcbpErQvuwp0nUGVws5w7+6jq5rFT6Cg9TB
         E24g==
X-Gm-Message-State: AOAM533TsQ92gy4oxZX0LOpwK7mVasql2cITQvwvxBKYzrdtptypLoi1
        q0Sn4OdPkFGLnqjhiDVx2xOJhNDLK3M=
X-Google-Smtp-Source: ABdhPJw0MPz5BwxSvNzM3LItmCT85q3yUW+ehiSWGXaEYfx3tAbjcpvSSAcwhAzsOxFsGTI9kn+6mg==
X-Received: by 2002:a05:651c:1396:: with SMTP id k22mr241312ljb.62.1597256324147;
        Wed, 12 Aug 2020 11:18:44 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z20sm584964ljk.97.2020.08.12.11.18.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 11:18:41 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j22so1678659lfm.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr315813lfa.192.1597256320205;
 Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
In-Reply-To: <52483.1597190733@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 11:18:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 5:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Well, the start of it was my proposal of an fsinfo() system call.

Ugh. Ok, it's that thing.

This all seems *WAY* over-designed - both your fsinfo and Miklos' version.

What's wrong with fstatfs()? All the extra magic metadata seems to not
really be anything people really care about.

What people are actually asking for seems to be some unique mount ID,
and we have 16 bytes of spare information in 'struct statfs64'.

All the other fancy fsinfo stuff seems to be "just because", and like
complete overdesign.

Let's not add system calls just because we can.

             Linus
