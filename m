Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3108C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998BA2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d2/Gu/Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGNVlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgGNVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:41:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05B5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so30244pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVz0yoqE7nbKLxEfE0Ni6YZf8hVnVv/lZnqHDwHd9EI=;
        b=d2/Gu/BmUNB5aqve7jAShkkdGjL9w8kucpLcU7onUISWOA1mEYKDfwakrLbMq+FLcv
         m0luqWY1m/cPBVHnz3QKPRILQXGtjXZfWHubOLuYJtO3zgaijkhqOiEDpIpkqipJixUJ
         aKgOIaNB2Nd6SJXbuWDUosoe/bMhO5LT++RmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVz0yoqE7nbKLxEfE0Ni6YZf8hVnVv/lZnqHDwHd9EI=;
        b=bmUEjlKFwQz+mLU5vzksrQtYw5Y1sWC9Fp915d62j0xsoRlTYf1XjQi2wNbV8mew7Z
         yToM1G/1tWQ4oNVnovmhciEkRZYm6TLTdEitWvU2kR2LAOlgSJhlC/N8ym9zKvBQF4wm
         2gjZ9fvMRMEH0lcbg1O3XTi8cn+k2q/B1RjKXfzJQ5ZMsaA6HkgJZAfhAg/TD7qITpAu
         UWcahTNUJfOl61eXW0Mm+MDp/G1Y0+DLCU82f/t/yH0SLl+qGYydAxG83VgQzP6shWau
         iD2wZtu1GSIrqKDK81bRuVzmPbeFsIF7NOdb3mtW/gVjjJeVkuxu6NmuSNvQP0nog0tq
         4XgA==
X-Gm-Message-State: AOAM532h0nBQOPLMD+LE+UrE3bD2rw+t2YjbvH8StZ6Zv1Tct97KvQvF
        Naw5ZfCxjSUAJo69eG7cYhP9dA==
X-Google-Smtp-Source: ABdhPJxhN/Y39BnxM0uRcYuZZMzDRRwoDiA3Y/6MHYVyzHW1tffbpD9XK/UIV8xeYgDAxt4YVSdZhw==
X-Received: by 2002:a17:90b:3010:: with SMTP id hg16mr6773703pjb.69.1594762867408;
        Tue, 14 Jul 2020 14:41:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm113755pfq.197.2020.07.14.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:41:06 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:41:05 -0700
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
Subject: Re: [PATCH 6/7] exec: Factor bprm_stack_limits out of
 prepare_arg_pages
Message-ID: <202007141441.C612C34E7@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87365u6x60.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87365u6x60.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:31:03AM -0500, Eric W. Biederman wrote:
> 
> In preparation for implementiong kernel_execve (which will take kernel
> pointers not userspace pointers) factor out bprm_stack_limits out of
> prepare_arg_pages.  This separates the counting which depends upon the
> getting data from userspace from the calculations of the stack limits
> which is usable in kernel_execve.
> 
> The remove prepare_args_pages and compute bprm->argc and bprm->envc
> directly in do_execveat_common, before bprm_stack_limits is called.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
