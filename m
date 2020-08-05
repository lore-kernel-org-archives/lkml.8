Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F52EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737E922B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UYk0LJ7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgHEIY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgHEIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:24:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B4C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:24:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o23so18000663ejr.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRkoVvZyMZKrXPZJsbTSg0eFnj2VcDca+RKzJ60eyTc=;
        b=UYk0LJ7zSStHb1U495GvSSdmH6LUhiPYmcg6PAq1rMqY11Eyd7mimZZrA3M0EtvJUe
         vvHGhC/9MvozJfhIiIgBsFE7xq5Hm++FVNDlJ2kUw02Jto10O7BN/4nzlscTmBPJj7xg
         U2829Bced+hHMLcR8pAqx46/TL8W7/1KfFh6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRkoVvZyMZKrXPZJsbTSg0eFnj2VcDca+RKzJ60eyTc=;
        b=B3/jGfx2duMhj/OToVI1EQ/UFrX9vgI4+nDO1zsLCxLUJK1fGWnBtDRJE/WycQHex9
         Ow9RtoPLoT7Z5i9VsYBCTeIp8XXrkhwi4mhdy9K0jh7LBF8iFhbyI7teFGBgimxOGYfE
         c4mFGah+mhVSlNJq8LEykItfL2lIfzzuLoIYE/lNADJDHW/h+69BRF5fDR9lDFduKYxU
         +lkYm8G9PY5pGseME9b89jEsx3VpPDIk9YUmQx0F61rquw0wQ036fXcbVCIikrKv0GVe
         ji4O1hXBOcNIVf+s3ika5b23rswdenFJ31tXIUjBvBwbZ1z8r7+0nrdCPH8I5DoMwY1b
         2IHA==
X-Gm-Message-State: AOAM532Dt9I00IxRt/mfuuPB+PIoHnpTlVOubyHo88uw5TCY4qnyLbyt
        CWvFEV1XM2bE437+gmY7a7bDWp7hzLmFFioE80wKiQ==
X-Google-Smtp-Source: ABdhPJxrLumgFgqYyoKDBG2k5IrM0kpKGeRUM6PbmX2nVN5dA62HAF0gWDOE78RgoqsR4O8I2bJbm1frFluN5es5kOU=
X-Received: by 2002:a17:906:22c1:: with SMTP id q1mr2028127eja.443.1596615874689;
 Wed, 05 Aug 2020 01:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
In-Reply-To: <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 10:24:23 +0200
Message-ID: <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
Subject: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> I think we already lost that with the xattr API, that should have been
> done in a way that fits this philosophy.  But given that we  have "/"
> as the only special purpose char in filenames, and even repetitions
> are allowed, it's hard to think of a good way to do that.  Pity.

One way this could be solved is to allow opting into an alternative
path resolution mode.

E.g.
  openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);

Yes, the implementation might be somewhat tricky, but that's another
question.  Also I'm pretty sure that we should be reducing the
POSIX-ness of anything below "//" to the bare minimum.  No seeking,
etc....

I think this would open up some nice possibilities beyond the fsinfo thing.

Thanks,
Miklos
