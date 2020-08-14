Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6914C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14EC206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597424734;
	bh=AfbstP+k4FgET/zQNAlAR/09TPUNHExZjGv0x7+VM0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gzQVd2/72Zs+b6JG9LErMhIDePWPDsH6nDdelFl8Tk0+ASCY+DFtqdT8s0s8jiExw
	 0lksInuj6Zym5OCe81CsGetYsY0i4rshlEzsWwJZfNHnQS7rQ1akN3s/kILLr6KMLM
	 Qm/tvkWnnahPSeRiG3yg/5P03QBt0VBIyyBB9M9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHNRFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:05:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C3C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:05:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so10643915ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYuJ9NHHO+qnoSaHW0PlHI0fiXCW7zDlZFu/ah5uFho=;
        b=QZC+eNnnLcPaczh2E7Iym7nx2PQpiiDURT50bzxJZUsdtO86YlDCUBTiiWPJAXsWnA
         U49+U2ao8O1Ymle/LvRAFOmnKYrXWnRy0koTc1q4uPH3YiU1H0Bu0Wp5Fx58rMDOEorn
         lZP3mAReqkIBPzLDybNfptRtvd5sif7WdrmnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYuJ9NHHO+qnoSaHW0PlHI0fiXCW7zDlZFu/ah5uFho=;
        b=SuiH43T1E7DHvuStNyCypHb3TZpdbXwcjW+QUOXEoP77/clQnQv1hdJwxr61fyBJP8
         xZdc6ndo/VA28IRF7frBUBeS7VyFS9SUP2i32B64317N+Kpb2/GfCICHLFqXgQO+dc2U
         LrZYeRj47JRl3tQEsiNHTemk1xPMimnr7Snx/w8k4O4zvSYQutZRdMYsspp7ymTWu0eR
         gcgyENZSNrDEfsu8a90p12hvT7azd2PeyLQ4WZ+6iDVzrY7+IkxMsUlKAAabbE0YkVK3
         0LfUJnjgz1INmucC/MmNE4VzKFnNDYUKCQZ+aW2EMp1AWcbhMa10qC0xBx7MsSpCAOfb
         1J8g==
X-Gm-Message-State: AOAM531MsoFbpN5Ecx0QIQwnkwc0QJe3fW8pRhZS+yvaBu+cGaio+bBh
        wFWUojUZkdV5IG4oUHeME4f26a3gkCHCwg==
X-Google-Smtp-Source: ABdhPJx4ZKTKxDpMQ8t2nnLlncjAp0js791prscQe+o9R8h8Yet+AqowyfCunkdihoDnq19YP/mlIg==
X-Received: by 2002:a2e:5c5:: with SMTP id 188mr1639387ljf.466.1597424727926;
        Fri, 14 Aug 2020 10:05:27 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t20sm1869189ljd.12.2020.08.14.10.05.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 10:05:26 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v9so10684180ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:05:26 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr1629608lji.314.1597424726058;
 Fri, 14 Aug 2020 10:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <679456f1-5867-4017-b1d6-95197d2fa81b@auristor.com>
In-Reply-To: <679456f1-5867-4017-b1d6-95197d2fa81b@auristor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 10:05:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLhwum2E+qperD=TypGHXxoBtXOu-HHDd9L9_XFFyiaA@mail.gmail.com>
Message-ID: <CAHk-=whLhwum2E+qperD=TypGHXxoBtXOu-HHDd9L9_XFFyiaA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Jeffrey E Altman <jaltman@auristor.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
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

On Wed, Aug 12, 2020 at 8:53 PM Jeffrey E Altman <jaltman@auristor.com> wrote:
>
> For the AFS community, fsinfo offers a method of exposing some server
> and volume properties that are obtained via "path ioctls" in OpenAFS and
> AuriStorFS.  Some example of properties that might be exposed include
> answers to questions such as:

Note that several of the questions you ask aren't necessarily
mount-related at all.

Doing it by mount ends up being completely the wrong thing.

For example, at a minimum, these guys may well be per-directory (or
even possibly per-file):

>  * where is a mounted volume hosted? which fileservers, named by uuid
>  * what is the block size? 1K, 4K, ...
>  * are directories just-send-8, case-sensitive, case-preserving, or
>    case-insensitive?
>  * if not just-send-8, what character set is used?
>  * if Unicode, what normalization rules? etc.
>  * what volume security policy (authn, integ, priv) is assigned, if any?
>  * what is the replication policy, if any?
>  * what is the volume encryption policy, if any?

and trying to solve this with some kind of "mount info" is pure garbage.

Honestly, I really think you may want an extended [f]statfs(), not
some mount tracking.

                 Linus
