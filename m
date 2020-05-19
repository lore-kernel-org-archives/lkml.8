Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9051AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705C820756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1QETDhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgESQ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbgESQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:26:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CF9C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:26:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so1614800pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kDaF8zyZTb3Ta49NCK5A63qXcN8gydwJuZQlr41/Oy8=;
        b=O1QETDhpWINpx9qXOpoLNVjfTGd96i8BxobEwfwNRfKkNpVmJLVykZTQUhodidSGmJ
         WSliMm3RbgtYth7tcFgdCKpxcpqCdnATzK1fJjMflEOY0r+m11P1uzV6DJVkUmwtV1hb
         tjnNid9N19+QMXPTuHpDakBiFJmHE/XUVu68g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDaF8zyZTb3Ta49NCK5A63qXcN8gydwJuZQlr41/Oy8=;
        b=jZWIAzPLwO5GUqtlslgKW8j1bl+a0eA9ieoGo3O5iPpjk0wOvINDrUDdTfehckhS+E
         kHOrERfa1BqnSFczI7Cxj/oBvdOZ4S48O2GX0LuOs7MsLBsVzP09YWMBdYn3Ji7x74Wc
         QAj0Mw2LZ9m/u3wOXCQDrwFPGGz4A77RhBsXv4r23iwAfEcfgGFb4A9e742tVMxRn/9r
         557kUdPAlnXBVplugWHoRfs3VGpenmBMaQkntlmjnXTX1noC9s5pnaBhiqwJ8CnWlAfk
         pfc9Vhz20amMeYTxgkqv0m+SqL9ilbmQXDHDiwhEIm6aY+uA7zpu/0Zz7JWq4lCVOyvO
         +DHw==
X-Gm-Message-State: AOAM530TpjfGi93TsGvNVzklGRArNrSaUXN1xAcLYspq+aS/soN0bM58
        V13vvWWHI2qBZKsWC/rP76ScSQ==
X-Google-Smtp-Source: ABdhPJyAcwedXrNHFCHkCzGmbuwb9krutiZpm8RExHOjZKVhXgmGqDW4Wg6fBQWPhl4x2ofwxKKvoA==
X-Received: by 2002:a17:90a:dc10:: with SMTP id i16mr333818pjv.137.1589905567075;
        Tue, 19 May 2020 09:26:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f136sm12823pfa.59.2020.05.19.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 09:26:05 -0700 (PDT)
Date:   Tue, 19 May 2020 09:26:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Relocate execve() sanity checks
Message-ID: <202005190918.D2BD83F7C@keescook>
References: <20200518055457.12302-1-keescook@chromium.org>
 <87a724t153.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a724t153.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:06:32AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > Hi,
> >
> > While looking at the code paths for the proposed O_MAYEXEC flag, I saw
> > some things that looked like they should be fixed up.
> >
> >   exec: Change uselib(2) IS_SREG() failure to EACCES
> > 	This just regularizes the return code on uselib(2).
> >
> >   exec: Relocate S_ISREG() check
> > 	This moves the S_ISREG() check even earlier than it was already.
> >
> >   exec: Relocate path_noexec() check
> > 	This adds the path_noexec() check to the same place as the
> > 	S_ISREG() check.
> >
> >   fs: Include FMODE_EXEC when converting flags to f_mode
> > 	This seemed like an oversight, but I suspect there is some
> > 	reason I couldn't find for why FMODE_EXEC doesn't get set in
> > 	f_mode and just stays in f_flags.
> 
> So I took a look at this series.
> 
> I think the belt and suspenders approach of adding code in open and then
> keeping it in exec and uselib is probably wrong.  My sense of the
> situation is a belt and suspenders approach is more likely to be
> confusing and result in people making mistakes when maintaining the code
> than to actually be helpful.

This is why I added the comments in fs/exec.c's redundant checks. When I
was originally testing this series, I had entirely removed the checks in
fs/exec.c, but then had nightmares about some kind of future VFS paths
that would somehow bypass do_open() and result in execve() working on
noexec mounts, there by allowing for the introduction of a really nasty
security bug.

The S_ISREG test is demonstrably too late (as referenced in the series),
and given the LSM hooks, I think the noexec check is too late as well.
(This is especially true for the coming O_MAYEXEC series, which will
absolutely need those tests earlier as well[1] -- the permission checking
is then in the correct place: during open, not exec.) I think the only
question is about leaving the redundant checks in fs/exec.c, which I
think are a cheap way to retain a sense of robustness.

-Kees

[1] https://lore.kernel.org/lkml/202005142343.D580850@keescook/

-- 
Kees Cook
