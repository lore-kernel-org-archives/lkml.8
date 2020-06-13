Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180172078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592080719;
	bh=m0t7LcobDkydextSN2GpEwt/5wK0jq7pSmBZDT3WQco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G9s7PkzEsazdJszeea5Q/Xv4NclMte26cG9XgfN6bI3J0Gn8e9qij8h/8SumGqyf3
	 aQO482mCXxSdykhY5JUQ5hHV7k3XH96ylZbXe5FH6PkEZvSZr4jxz26sOfC4TNS9ot
	 Z1Vi1bI7ej0YNIAKDHqUqkOLynWMn/HjN3Uahi4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgFMUia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:38:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A9C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:38:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a9so14855690ljn.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3cBwjqJkGkfKqMm3ALvsjk5I4escCnWAZ0zicK8gMc=;
        b=REy0fsRB1I92oFOzAs6uNVkEMih0EWWHqWIiZRYm2TqUvRGu7oewfk9YR5IC8ORapf
         +5rDonQqpVIq80gRjCze/ukP1iYNmsvcfuR7vz5b68yn3s8XwY0C+ksC80PDTuKDqPVd
         EIUYhchyUPY3nU3GcX9EXusELiYvsX4vuAeb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3cBwjqJkGkfKqMm3ALvsjk5I4escCnWAZ0zicK8gMc=;
        b=dkFRpLIn+fhi4zJsIjWAT3kscButO+byZddGS+Nyv4CPp8ijE0C9x31juX32LsI9NP
         8/Bc8Frt3qdybwvZbnpGA07HwLITrdNxaX1ELL0cvJCPIJwPts1/Gqc+4RfJcoDne9ZM
         O5f4EqZB+0h6t2bn+l1CKjKg4zlP7Phv6Bwg5lymtywKjpelfBmQ3IrZrQaZkiUZLkJy
         HsP7oyxfaCadvg1OZ0soT4nDdroQ48AYHueY4/WF2W8JHq2IDU0yF2Qv9rMx/1pJ/WCj
         A2LLkC05XLweOm5evMd943T5epovd70KS3XztWS+I0hCXUHNiZeNbwv7d9QK5NOI96/b
         qkwA==
X-Gm-Message-State: AOAM533R1nTWXfG8FLTHKKJESrWbfaIiusHcPBgEkUt6fHrXWwGYQNkW
        Bti3Z0MeNtyWp8R2QeWrvtcgWSwkgnA=
X-Google-Smtp-Source: ABdhPJzic0G6LUNs1l+S+03ls6aO59MYdujuGcjbErMv+JzV5dcjoi1dbUWZ5lHW9kIHLMfOrnAY3g==
X-Received: by 2002:a2e:9c9:: with SMTP id 192mr9068452ljj.4.1592080705363;
        Sat, 13 Jun 2020 13:38:25 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t20sm3295204lfl.17.2020.06.13.13.38.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 13:38:24 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x27so7338641lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:38:24 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr1035337lfl.152.1592080704105;
 Sat, 13 Jun 2020 13:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
In-Reply-To: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jun 2020 13:38:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKftdT8wT1GNGpstQA=P7Y-4_LrnZZ2hWCqfuYRVoo+A@mail.gmail.com>
Message-ID: <CAHk-=wjKftdT8wT1GNGpstQA=P7Y-4_LrnZZ2hWCqfuYRVoo+A@mail.gmail.com>
Subject: Re: [GIT PULL] more Kbuild updates for v5.8-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 10:56 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This is touching a lot of files to finish the
> --help--- conversion. It was generated by a one-liner sed
> command, so it is easy to understand what is going on.

Well, a simple grep would have shown you there is a script in the
Documentation directory that actually generates those "---help---"
markers.

So if converting away from them, we should certainly not help people make more.

I did the obvious fixup in 3e1ad4054b8d ("doc: don't use deprecated
"---help---" markers in target docs") but didn't test that script.

            Linus
