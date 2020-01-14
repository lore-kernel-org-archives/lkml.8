Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BDC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFC124656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579037593;
	bh=m64N75Iyjh7MpsWP3+t/yuBBM0u3fhgot60yIPDuIqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jOcxVMX0FHCiCkyYOsGtoncSTqDu3YQzxvhmgpNtCFHMXLgGbR0h1zo2Z26uAJQ9g
	 FA00NoDWXFfqiv7Elq5cRSsjovrj5NIjzmiJtpnrCP5L+RE+cz7xbqXmOwtr5iwfWn
	 Png2Nzr1kyL2ygSbAjnJ4TC+wPR923zzDvambF9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgANVdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:33:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36519 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:33:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so16098653ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5uoKw2YKLElJKDx+jK5wl0K2xjBXMt47XAsAkyAM+o=;
        b=gVkyh4tPO8RK11oXNRTkFnFw5qS02VpB8fRn7yuyjXBrIM8r/+uUtu3n5AJSu/v+0r
         3KVUAw32daILdFTdwNmZ41g6fmO4U+5YEKf3aZPOaD0BxhRqx8Hhmkwlmzo36zFaxnqP
         lOdeXPMNVWW1hl8kB5QPM3J99EYMRT9fPNA7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5uoKw2YKLElJKDx+jK5wl0K2xjBXMt47XAsAkyAM+o=;
        b=UbdQYoF5QXZbRuCqwr9MXqagLzVe7EqAvVcAIXsiKSDp3WDmd3iwQyZFHc/swuEbD4
         mQbOXdmDeNRzZvCrfbhKF4n7Sy/77YAhQR+BRBCQXuzzuUq2QWS3kMC72S9G3rztBCoh
         i0RucJ0ZH7hYdUYlQaymBiRg8hbdnUi3nUXvHLPjhyZb5Sm8TrSI4ho71P1G7lRtM+mA
         vZ2R9TRzZGw92AOJ/vfwfHWdPqFZMsld1M/jZNGB0AQHNhecjOW8XYtIv2Nv0tRa7QHS
         6+t2516r6lipatO3Pc+kOiR28LbZAS79pwGQ1xxqTLmP/wNUCP7vXXv8zd+ESeS20qD8
         ZzXg==
X-Gm-Message-State: APjAAAXfNx9IffbHaqk4Gl8pdPQrtHqjA2if2/3vO9Jrb+d41CGUAtjP
        aAya6puOFJOVwEAIBWpmLgpsAteuYoc=
X-Google-Smtp-Source: APXvYqw3vNiKonQgg5fJsiJXI2ETM5Eor8R4ldgLLbggpp9KQyczAMOKF9JbVbj6nswBv4xRPEIOpA==
X-Received: by 2002:a2e:8646:: with SMTP id i6mr15893316ljj.122.1579037588024;
        Tue, 14 Jan 2020 13:33:08 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2sm8127647ljq.38.2020.01.14.13.33.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:33:07 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id w1so16104446ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:33:06 -0800 (PST)
X-Received: by 2002:a2e:9510:: with SMTP id f16mr15481129ljh.249.1579037586642;
 Tue, 14 Jan 2020 13:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-2-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jan 2020 13:32:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
Message-ID: <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:09 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> There are 2 generic varaints of strncpy_from_user() / strnlen_user()
>  (1). inline version in asm-generic/uaccess.h

I think we should get rid of this entirely. It's just a buggy garbage
implementation that nobody should ever actually use.

It does just about everything wrong that you *can* do, wrong,
including doing the NUL-filling termination of standard strncpy() that
"strncpy_from_user()" doesn't actually do.

So:

 - the asm-generic/uaccess.h __strncpy_from_user() function is just
horribly wrong

 - the generic/uaccess.h version of strncpy_from_user() shouldn't be
an inline function either, since the only thing it can do inline is
the bogus one-byte access check that _barely_ makes security work (you
also need to have a guard page to _actually_ make it work, and I'm not
atr all convinced that people do).

the whole thing is just broken and should be removed from a header file.

>  (2). optimized word-at-a-time version in lib/*

That is - outside of the original x86 strncpy_from_user() - the only
copy of this function that historically gets all the corner cases
right. And even those we've gotten wrong occasionally.

I would suggest that anybody who uses asm-generic/uaccess.h needs to
simply use the generic library version.

             Linus
