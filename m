Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC77206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595622371;
	bh=MGH5EUfFft7693c26Z+gHhy71zVD137Eni3+iyD7VXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yp+6/r/p5xH1aZM4feXlyEVlD9DJWMsBWlLNvqDeY2JgsBfMjyLTkIdBJncokQ0Bb
	 gWX7tBKQ/sSHltHsJqp5B1p0wKs3AOEZKLi74NEzTx/rS1ws1jiiX6UHqfPDgGEThi
	 ovaVfQE0lrmd4Qf1n4OWzMCLUsSIeL3QH70l8sps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGXU0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:26:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7FDC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:26:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so11234190ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=KtKcrijfok2OM2Bs9fSARpIOCqZAORRhOEAWEspyefuuQiv0/hudjwYFxvdZYP8RIE
         x/etcayReiFZfOvZz4a+h99awZFUCnk+gEVf5LIz5qer03CSy6o0FgWPmB4n2oXPdXJB
         lJgwEQlLR1A9JtB7EMnPQ4yBFe/eY6IWqSZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=PNHIwmTq2MW+Kc1Ib10WC/UjDXRy5QwzkVeupbfnLoKJvJytaBeC5vg6s2QgPPRzXM
         d7yjm5ECv7cFokTAnL9HfF0yhbPWD04fsAso0TOT8B6Rfctq4nKCGLBM4lfdTQpxzfgE
         cH98t957ZjTkcu3doUs5yUjKRIxuZoofBZo0TQAfnCnee1Qq5xruwtBsJz96TMxwtl6O
         6gC39f6TDH4k1V8K+zKIL9fz8updUg7xE/jUg8+0yYhzi7taW1C19R1so9+BQU2rcl8K
         XhmOe/1hVXQbCYbfH1WiVb9VnPQa4QWUVsxOKf7pQ22faK5pVuWzQ+mjHqACnZdSdxn5
         jqCw==
X-Gm-Message-State: AOAM533lsx2QmDAfUw7vPXdd439mCKHrlEqv1Ssewq8xZFTIVPqyYI41
        Yx85ZGS0ydq0SxgLcfbEn+Nwl60DQsY=
X-Google-Smtp-Source: ABdhPJysO6p1efj2TTabCk1pSLbSYxWQhbf5K3aKjML3PquXgbMMWD9KmUopO8pmaH9foRIOYLtNFg==
X-Received: by 2002:a2e:8710:: with SMTP id m16mr4553007lji.401.1595622368052;
        Fri, 24 Jul 2020 13:26:08 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j144sm633210lfj.54.2020.07.24.13.26.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:26:07 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r19so11189301ljn.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr4879223ljj.102.1595622366366;
 Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
 <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
 <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com> <2189056.1595620785@warthog.procyon.org.uk>
In-Reply-To: <2189056.1595620785@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 13:25:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute
 change notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:59 PM David Howells <dhowells@redhat.com> wrote:
>
> That's a good point.  Any suggestions on how to do it?  An additional RLIMIT?
>
> Or should I do it like I did with keyrings and separately manage a quota for
> each user?

I'd count them per user, and maybe start out saying "you can have as
many watches as you can have files" and just re-use RLIMIT_NOFILE as
the limit for them.

And if that causes problems, let's re-visit. How does that sound?

                Linus
