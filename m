Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7601120737
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588109826;
	bh=sgoAjx/rxH+09D6zfwRTyHoQLg8b1bAYPPMkwTsPWK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S9BgNDCiBLCNfn4W5pbDkAelEfw7HY8Sl3390wGx+GQN9YMcP/7ywxPhpSROhR60a
	 YO/oaWfF0pCPPVfKoaVPm54IpTktwXh6WBtNc93u++6LMjES6Chg1X3jg8SoOS9a3X
	 vhYupkpG9beYh22i5SZpJRolvB001Kf0Xv/LQXFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgD1VhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgD1VhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:37:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A292C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:37:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so411294ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byKFbf6/4dlMbIbNFz7mzcw9H9m+Hnm7ILov1GMUf20=;
        b=c5V540DX5qA6TExpwN82zDgCG62wkqprBQKUL+iKPh4WlRl/iYQMUxVRhV6k+zsiT3
         LdHMx69qD/cpw5w0oGC5Q0372ifsczILIVK5UMTuNG1Z2+H4Chzy4fZoyZE2yARv/Qes
         lhUI/+ul3xggWnP/fqFH3tT8S0RA9vGMxghbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byKFbf6/4dlMbIbNFz7mzcw9H9m+Hnm7ILov1GMUf20=;
        b=h7VcGVp6sMHBovZThSDYbD/cxpPD4W3kWYc0thFf5ItVJmdepTS2r7TOMxj5HYCoRq
         llsrMsELzLvMLICt7NMsVQtdtsSsAHxPs4Dyv9bwXLNYn6JIslA2bAYx38jB4rhKd0Td
         c7wRm8iHcV9PbL8pFUVbj/UiAs4/eD3OBXMT67dI9yKeJpxZHJp5jNYgweHT6ysbqKKz
         s9EKEANH4m7JfEMgsGGXFuV9WaiWzylQ2YgphTbZtYbaByRXCdQh/VMTy9tmMQ1a1ij4
         aidA+RJBHJTuxg7Nbww9a9CAVgR12GDUGHYK+OB/Jiq1CiQrwWjhXU/v7w6wX8YZH1s1
         mG1w==
X-Gm-Message-State: AGi0PuYPRG4p2fLSjNEUEmMvm2x1HVpjd0Wjd626IIxIPVTU5B1G9RlN
        unSVH8iOMIFYCIQny3mtEMg0gQp1pKQ=
X-Google-Smtp-Source: APiQypKpfFeMG1F24osbGOCCoXeB2xPLxsvcKTjjLs6TvN/HdQKYhi7fJWiOFWZtbr0F75eX9YHFrw==
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr17858806ljr.182.1588109822370;
        Tue, 28 Apr 2020 14:37:02 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k18sm516708lfg.81.2020.04.28.14.37.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 14:37:00 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u15so423050ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:37:00 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr17622095ljj.265.1588109820160;
 Tue, 28 Apr 2020 14:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
In-Reply-To: <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 14:36:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
Message-ID: <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 2:06 PM Jann Horn <jannh@google.com> wrote:
>
> In execve:
>
>  - After the point of no return, but before we start waiting for the
>    other threads to go away, finish calculating our post-execve creds
>    and stash them somewhere in the task_struct or so.
>  - Drop the cred_guard_mutex.
>  - Wait for the other threads to die.
>  - Take the cred_guard_mutex again.
>  - Clear out the pointer in the task_struct.
>  - Finish execve and install the new creds.
>  - Drop the cred_guard_mutex again.
>
> Then in ptrace_may_access, after taking the cred_guard_mutex, we'd
> know that the target task is either outside execve or in the middle of
> execve, with old and new credentials known; and then we could say "you
> only get to access that task if you're capable relative to *both* its
> old and new credentials, since the task currently has both state from
> the old executable and from the new one".

That doesn't solve the problem with "check_unsafe_exec()" - you might
miss setting LSM_UNSAFE_PTRACE.

Although maybe that whole function could be moved down (to after you
get the cred_guard_mutex the second time).

               Linus
