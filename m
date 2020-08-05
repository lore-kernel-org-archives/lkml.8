Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0746E22CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ESNQC+z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgHETyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHEQtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:49:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9EAC061A29
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 04:27:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i26so28913513edv.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PziUKsmF372rDIV3S+ngIfNzzFjadVBOy4PT2Nbdg9M=;
        b=ESNQC+z/Z1LEOCf9ToNZZagALOrvVY3U7nd5sdzRXPULMbM6xqR4+e9C/gBHdlhIK9
         32emkrytIlYO22Vqrx5sMWa/8mJm96fGLmkbTQlIXqJuDV0q+qoQmFjtgdryN+NXUGAE
         MLgsqwyTs/PUyDehIURdGhYrpGdnku/6azmIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PziUKsmF372rDIV3S+ngIfNzzFjadVBOy4PT2Nbdg9M=;
        b=GNJzudIhUYu+EIhrV6eUXThkMiqommEE/3EqoLVUcEdHgUNH8SZ5XEoJ5rv4h6OrVb
         1wQiXr+SvSiCpYgqZV++5aVzuOG4vIn6W/ybWsh3k/r6SgSMCWmYlg7q3jp0U+2DxPKp
         wjuZhO1PsOYfS91tSq0TETLaZcPFHLDK66Z1p7YYb9C85Z6y39VTc51dsYk75B19QVBD
         7c2JmLi570d/US+cM5PEWo+kgB5YFHvnOVfpmi1ZvDPnfpm0vzzHTzx2gTg8Q8i0WQLv
         g4oVWbUy035xRD8cUZ4r/gJD7DvMz0KRqflQ4yjbXBo4/AKbzOfId4JAozSMJK3nqjrj
         hU+w==
X-Gm-Message-State: AOAM533s1pZiWYibXSlZ8D9Uudx3OaV9EmDdQmSOwCbicSgTN/33KTVk
        iMfGX4N2zdQzcZfxmIsgfE0G8yATej3Rix4w+ex4Hg==
X-Google-Smtp-Source: ABdhPJwSzAqAkDNRGBwPe3v9vu2XVDG8K6eixn5B+jSbX3QhBOxtZVeQ7GZvk7UuTYsR/liT1yvsvfZHUm//pGefN8E=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr2258430eds.212.1596626862700;
 Wed, 05 Aug 2020 04:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
 <20200804135641.GE32719@miu.piliscsaba.redhat.com> <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
 <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
 <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com> <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
In-Reply-To: <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 13:27:31 +0200
Message-ID: <CAJfpeguvTspY7pi52n1aznebCF2jYki40hy5idkgu1D2y6C6mg@mail.gmail.com>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 1:23 PM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2020-08-05 at 09:45 +0200, Miklos Szeredi wrote:

> > Hmm, what's the other possibility for lost notifications?
>
> In user space that is:
>
> Multi-threaded application races, single threaded applications and
> signal processing races, other bugs ...

Okay, let's fix the bugs then.

Thanks,
Miklos
