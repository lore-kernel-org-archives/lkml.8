Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5987CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2763020656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKoYPKcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGNVjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgGNVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:39:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A735C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:39:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so7611926pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NY7ubhSAZuzpqQ+2qyQyd7pDfm+pG2OQJkPE6ilqOj0=;
        b=LKoYPKcYrbfDweTU+AzZW7zfjfsM0mu1LqfWRtx3ASc294iZbbKOAIzKDDMBD1csTi
         IL4+mIDlsAJtJ/yRcAWXuGs3u1YlKdIQ7WW5Za9ixU9N+OsmY47m53tL+3hwjyhFweTk
         nEyKJkXQJa/uFgdvxKADhyq6n3rCSHUYFjmcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NY7ubhSAZuzpqQ+2qyQyd7pDfm+pG2OQJkPE6ilqOj0=;
        b=DMMuNS0qFpDarkuPEabiQ4QWQ8MTwQpy3Uhuv8VECBInU8+j0zfFgCNuWfKNKykhVz
         f6jhi1FsuecSKQbj/IIni2yN2pLvEKIf42kqYVYqt1ZOto1c7Gtgtiw80Lc4NUPdQ0O/
         KWr8IqgrK70UoiuyIvgeaQ8ZqLz/D3S1YAnqj1LqgF44e2Tqzt7utO6nctqp+XTyIWPU
         0+exSiEtZ/XpdVBjTKBNCg53C3fIi0rN04HU6PkwcR4FMpx85R5bsCJdRWvyHI+n00+P
         7UsV/33VRg/LibeEvR+xhhlMRaL1O9d3Q8hAXr9mu0usfRu1nXpTIrsm9zOsmHV9kFPW
         cerw==
X-Gm-Message-State: AOAM531Qv4VCEr2Blx8Cc4hcXXVySGd2nCByxInOSI90F3/z+G6bhGch
        a6Fu3WXaSGAJ/hUp22UXyf/EW8gi3Lw=
X-Google-Smtp-Source: ABdhPJzNfrb6Gg5W/Gp0ksXtcISMkz9T8Gsyf5DJycttrGSxe6+GiFSaP9nOpS9fc0QLbR/Uf/eNmQ==
X-Received: by 2002:a17:90a:1d06:: with SMTP id c6mr6981492pjd.194.1594762739535;
        Tue, 14 Jul 2020 14:38:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v28sm82181pgc.44.2020.07.14.14.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:38:58 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:38:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/7] exec: Move initialization of bprm->filename into
 alloc_bprm
Message-ID: <202007141438.607772B@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87k0z66x8f.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0z66x8f.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:29:36AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code
> that launches init to use set_fs so that pages coming from the kernel
> look like they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument
> copying from userspace needs to happen earlier.  Move the computation
> of bprm->filename and possible allocation of a name in the case
> of execveat into alloc_bprm to make that possible.
> 
> The exectuable name, the arguments, and the environment are
> copied into the new usermode stack which is stored in bprm
> until exec passes the point of no return.
> 
> As the executable name is copied first onto the usermode stack
> it needs to be known.  As there are no dependencies to computing
> the executable name, compute it early in alloc_bprm.
> 
> As an implementation detail if the filename needs to be generated
> because it embeds a file descriptor store that filename in a new field
> bprm->fdpath, and free it in free_bprm.  Previously this was done in
> an independent variable pathbuf.  I have renamed pathbuf fdpath
> because fdpath is more suggestive of what kind of path is in the
> variable.  I moved fdpath into struct linux_binprm because it is
> tightly tied to the other variables in struct linux_binprm, and as
> such is needed to allow the call alloc_binprm to move.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
