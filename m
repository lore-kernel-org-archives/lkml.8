Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C836520782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="chfynWAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHKU2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgHKU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:28:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D039C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:28:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so14517906ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve5Yd3mwVy0R7O+69rb0Z3/pkYDrUBPYv3Y7SDQCiIs=;
        b=chfynWAB8HsSXn0Nq9kuiBHfOY/TZ4j75nPnyD8edBXlVosZV/a4sfirrV1K1EKGZQ
         CcdKgi6EAOOB4iCCl58grDpy8pwBziFonZaMthHTr/jQhkDC3TEiBlQCO6xUpVbJ1fwt
         zcQQlAsevZ8biY9RI4Sz9V1uGTfE6bGeW0b0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve5Yd3mwVy0R7O+69rb0Z3/pkYDrUBPYv3Y7SDQCiIs=;
        b=a9NAkPZZ2IX2OsGn3q3VRE6dOZL+5Rv19/VHDEQa8CoqdykYxOeVGzyc8Z7LLRLfl+
         5jxeWL4ylVLkHTCNrJsyt8jqCA+KyEG29+yjuwJX+iCNHbdiGj8YtWhmFkHiA8Fl2J1t
         7HpBbpB5K5/gRBA3BSXOfHLS/FziT1beVtJsf62Q4FPodTtuP9fXOiVUg6docYSvedUH
         Kiwxv49Zj/qIcJOvCmu9gzawJVA5WMwd4DAeMbkqm3UQer8qcCHhzxFLKusYgsVIslN5
         CBz4HEAXAtqYZjIBRgOaF0ws0axsZLGNg56fHnmv2W7wED4LURHo1Iu7z+vbvfEP/HqH
         IdxA==
X-Gm-Message-State: AOAM532ZdZknTVbkEYgQuJwnP54pfF0jsGsftFv4gv4WAXBpkM6NC7CT
        hoa7m59dyy8yijCLwUwSh2F7btGcE2IZJcyJvoJhXA==
X-Google-Smtp-Source: ABdhPJynkGonNWW27v5lD0Dm9oTs5g6XNor54WFwVnAIKXdGR+PnhZVN78P+1gHxIPBKFMpGTOgrYXWyHLqEyGqEuwc=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr27554943ejb.113.1597177722443;
 Tue, 11 Aug 2020 13:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
In-Reply-To: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 22:28:31 +0200
Message-ID: <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Aug 11, 2020 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:

> Since a////////b has known meaning, and lots of applications
> play loose with '/', its really dangerous to treat the string as
> special. We only get away with '.' and '..' because their behavior
> was defined before many of y'all were born.

So the founding fathers have set things in stone and now we can't
change it.   Right?

Well that's how it looks... but let's think a little; we have '/' and
'\0' that can't be used in filenames.  Also '.' and '..' are
prohibited names. It's not a trivial limitation, so applications are
probably not used to dumping binary data into file names.  And that
means it's probably possible to find a fairly short combination that
is never used in practice (probably containing the "/." sequence).
Why couldn't we reserve such a combination now?

I have no idea how to find such it, but other than that, I see no
theoretical problem with extending the list of reserved filenames.

Thanks,
Miklos
