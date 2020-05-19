Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3388C207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XRXtSm6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgESSDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:03:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADA9C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:03:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f4so184800pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dYNe5imColFPPD5d+DKRKhaBy7kn7zETJG2kSJ0FeeI=;
        b=XRXtSm6WmkRg/hhVT0J6wTCFjJS/VRQIn80o5YtK2d3KtQLGKmgb0nch7IKPjMy/nM
         Tlqo0pCvjSB/6fKqFOkf378IkgEghz7FVCm83CToijVKNG2fAhbGr6S+VT2HK1iHWi76
         2qMe1lXe2OzbTWFltdgnXhA5eMud8jKZFPEvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dYNe5imColFPPD5d+DKRKhaBy7kn7zETJG2kSJ0FeeI=;
        b=hd39AyFJIsRgiSqJhleHXbhIV/v3w2ealEerb7JHyyKLXniZe7z39xs7GkzhKQRerL
         Ud9OX4eoUb9CyRvmo1DOAFwNz0l4IjMKiOe6tpL2k10W5DLLF17M8a/Q9+qbHHo6lLq2
         RjVnkWT9sXNXaKYYiOZwF1mmm+aDKLois1DJHpwLbPGTwzSLowTbtEeayGWSAypLlyiT
         VETXr0kz0Z5igomDliQXu3h1iZyH3Fz32LfJIksMPY9ytbZXynCYvSC+KD1aXBNWBq5R
         14RqKNjv6gGFLIhzmju0Riu9Omb+zHgbjvNM89sJn7RVjcrc/ccmNYSucOh2MK5LLFJk
         0zEQ==
X-Gm-Message-State: AOAM533DoC7ooSJ/qxB7+8Sh8jpzhiKWIFSi/CqR/WeIvuC3mDzFJwKi
        GH5CheJPiLfNAtcHT0jUjO/orQ==
X-Google-Smtp-Source: ABdhPJzOfQ6CtgRtZicGc3qjy7cHgD2IjZ7KftYoJMUgTLXdeh2g3w/o0z6fA08RKk7eq1D3X8DdPg==
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr377808pgn.391.1589911434306;
        Tue, 19 May 2020 11:03:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u1sm128576pgf.28.2020.05.19.11.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:03:53 -0700 (PDT)
Date:   Tue, 19 May 2020 11:03:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 1/8] exec: Teach prepare_exec_creds how exec treats
 uids & gids
Message-ID: <202005191101.1D420E03@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <871rng22dm.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rng22dm.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:29:41PM -0500, Eric W. Biederman wrote:
> 
> It is almost possible to use the result of prepare_exec_creds with no
> modifications during exec.  Update prepare_exec_creds to initialize
> the suid and the fsuid to the euid, and the sgid and the fsgid to the
> egid.  This is all that is needed to handle the common case of exec
> when nothing special like a setuid exec is happening.
> 
> That this preserves the existing behavior of exec can be verified
> by examing bprm_fill_uid and cap_bprm_set_creds.

Yup, agreed.

> This change makes it clear that the later parts of exec that
> update bprm->cred are just need to handle special cases such
> as setuid exec and change of domains.

One question, though: why add this, since the repeat calling of the caps
LSM hook will do this? Is there a call ordering change here, or is this
just to make the new LSM hook more robust?

Regardless, this looks correct, if perhaps redundant. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
