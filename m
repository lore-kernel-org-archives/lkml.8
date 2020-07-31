Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7259C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A182820838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqWtzFYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbgGaKma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 06:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbgGaKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 06:42:29 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5051C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:42:29 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id k63so2959055oob.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Hd8wvT4b7y7GSWMKgqZCYWtrUwduUCyWW8ioRrqvkAs=;
        b=HqWtzFYGwUPfARVcYA6OBCcbEfaztunUaTVBVKIoLrihy+35o7tBvwT4Tdfif+yY8q
         vW5t9V3LkFj/SIRvoD+kuAQamH1KbCSCQWv2Bgh+/umfkYGsWW3vXC7X+ccqZHo0wnrm
         ajW+XqNq1eX1X/TkE0W28gQXRFbiTFvCG5nTVNz3UGfoO2OwxxBiBtOQzvr5D7XBv3qq
         GF8+ADRqMrFvFfDq6zndrfgPyCu9fWosXKZZ43cH9HoEo2ksNFPPjH25naKVYEwtqh7T
         sKsW4rSHB1xB92J9w2E3uIxFFCiYVJ5ykOR4EanfXtxZrRElW+ckF8htNI+7eXzhttgh
         HgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Hd8wvT4b7y7GSWMKgqZCYWtrUwduUCyWW8ioRrqvkAs=;
        b=SDfqjCm8YfKJm5iPbk5FYYXt6Yu5NldRbuhv7Kde+BYPL90t711IJ+lYBRam0ur3wx
         3wK0AqElVEvdlkfZgzGQP0/aUmGu6OBz+3KHgTM3Lq/YkYrz3CXW0hJiMgiFYmyRMMLS
         Fuepa1X/a+xUEIevxw8eG5d5MkkY6JrjTIsnM0XTJTNh4kBkA53EbsrNM+F5hx/+odf3
         1bcNDEWqqJFiIQ1D5IiB4nxtXZcCMdktPMA4BNsGHdrsMvO2teW4VdrBayjwWq9zSCzD
         VkeXkVcB4HNVHcgpwUcWwwwwtfaumOjS8BdOVL+Q7+OPIaJRLne+Ok04Lf0AdPFeptoU
         JTRA==
X-Gm-Message-State: AOAM531b4ZAQxIIcvKnkEkyUQuPqTRCHvZybxfg4fMRZ4jA7srzs3J3o
        eMETFn+kpJBI4fiYsXC92KOsIJYl6pdFBnKQ2Y0=
X-Google-Smtp-Source: ABdhPJw+i0I+P441LxXNKMNTb5p+5CyJsW6V81kwSQNJ9QHTo1LmWm7rSHCRzw9+04Ww8fiLhFlZW4lObYvaxFBV+Ok=
X-Received: by 2002:a4a:4594:: with SMTP id y142mr430529ooa.24.1596192149187;
 Fri, 31 Jul 2020 03:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUXiz52bk+8bbLTuYCDLqoF9zLiV6NEjzPRgodu3FzCFLg@mail.gmail.com>
 <20200730112022.GE424218@kernel.org>
In-Reply-To: <20200730112022.GE424218@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 31 Jul 2020 12:42:17 +0200
Message-ID: <CA+icZUV0NRkvbb5Nn86qN_KnXd3qAo9kCqrkPEvf9GHc0SAt3w@mail.gmail.com>
Subject: Re: [perf] Explicitly use python[3]-[config]
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please let me know if you need further help.
>
> - Arnaldo

Hi Arnaldo,

YES, I need further help.

I have published in [1] numbers for "perf stat make ..." with
GNU/gcc+binutils vs. LLVM toolchain for building Linux v5.8-rc7.

[ GNU/gcc+binutils toolchain ]

   10964.876434769 seconds time elapsed

   29666.464675000 seconds user
    2149.943729000 seconds sys

[ LLVM toolchain ]

   17149.393417675 seconds time elapsed

   47787.158036000 seconds user
    2289.196142000 seconds sys

How can I dig further to see why the time for user is higher when
building with LLVM toolchain?
Any suggestions?

Thanks.

Regards,
- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1086#issuecomment-667036028
