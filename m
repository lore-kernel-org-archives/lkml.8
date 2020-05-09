Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F937C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1886D20731
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589055194;
	bh=W3kKEQC5AvPwppXgmxUR2Clai0tTi9MD1gPnWVJvzGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qwRws7yf1KSJrjpR/8DvrrD6xKanWbYcgu/MI35763ycqKLuCc+b5f0Cs1rw4ngox
	 4Lk9e5GeSIX7XRExL6wRVXFBoy5D5Qg9CeVIdfLsZdcJ3c/GX0+Oyb4mKrzqG3clXv
	 9BbfyNr3Ii7PZG6nxrpZJdXt0L3mSQq6r0Jij8tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgEIUNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgEIUNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 16:13:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 13:13:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q8so4351201eja.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDsZUXjsiQvBTwD4B5aSZNNtEwOJDWf1jYmy0/zS14Y=;
        b=WPsXnPQBGyK2C++rccv5Or4C/vXPwP21oG2KRmQ8V6fcspuR8XbQ+5r89R8PKmZfOF
         OUxu8eXSqHgIWypV16sewX14zsAgL4jY7RoV06dLY1M4OWHITNrYQ0wZpSJbXKu2f1cz
         vVVczp9RsCnFy9vDPFYs0H9UUc+JYWG7BNq9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDsZUXjsiQvBTwD4B5aSZNNtEwOJDWf1jYmy0/zS14Y=;
        b=hjQG7Xqxg7sP5sU22ROVxEr+/weaOzpnoif4wL0oos74bnv8vPoto9w20TwzhPKLFT
         aryYCrf9Ep/qrPZVj7KUnCFeeZeBNXh8ZGq+sRJknfzuFYo1tXZYXq/DzsBB02PkuX45
         vod2Qd0KV5uFr71jMT5pT/J0SzlcAOOtcnyHpg0J+m/zXgz9pb8QCG5L27S2+jfi/w6E
         D8+sAPLGn4TU2XVI6uCydkxbSMD8izU4fh3SU6hxDFim3UYzvdyllvQ/VvRhV8+Ru7lx
         yP+laZyjv6ANJbJqvumRDralLdrLWkzjzijYX6QltkAMSOWLyhp9eSn484bs/BrQb0ZN
         6qew==
X-Gm-Message-State: AGi0PubXH74ysXCANIADZ7l2jyz1wphPnI8CrOHaf/zr4aSOX3v2KpzY
        BVzywa79owfIluM6UIX6rhRk9Wzh/nA=
X-Google-Smtp-Source: APiQypLVugrjBrrg5Hu+wae1bwoCpxkNfjuj7YwbovpTGG11Ncw6QYNdRf5cOF2z9kAIbDD+/Yw9BQ==
X-Received: by 2002:a17:906:c113:: with SMTP id do19mr7520109ejc.286.1589055190623;
        Sat, 09 May 2020 13:13:10 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id l5sm595303ejr.45.2020.05.09.13.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:13:10 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id k1so5993698wrx.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 13:13:10 -0700 (PDT)
X-Received: by 2002:ac2:418b:: with SMTP id z11mr5945437lfh.30.1589054883772;
 Sat, 09 May 2020 13:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:07:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
Message-ID: <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 12:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Now that security_bprm_set_creds is no longer responsible for calling
> cap_bprm_set_creds, security_bprm_set_creds only does something for
> the primary file that is being executed (not any interpreters it may
> have).  Therefore call security_bprm_set_creds from __do_execve_file,
> instead of from prepare_binprm so that it is only called once, and
> remove the now unnecessary called_set_creds field of struct binprm.

Ahh, good, this patch removes the 'called_set_creds' logic from the
security subsystems.

So it does half of what I asked for: please also just rename that
"security_bprm_set_creds()" to be "security_primary_bprm_set_creds()"
so that the change of semantics also shows up that way.

And so that there is no confusion about the fact that
"cap_bprm_set_creds()" has absolutely nothing to do with
"security_bprm_set_creds()" any more.

             Linus
