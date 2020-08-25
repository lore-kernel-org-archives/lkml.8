Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210A120738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsh1gjof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHYUee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:34:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36335C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:34:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so10072508qtn.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/SGIV3hvSPVA0d/hRbfdIVi2Nsd+rgAjYCpmFW+IOY=;
        b=Hsh1gjofFAWID28hBOW4sf5pS2NVLyl+jl4PVM8uTW1JeRc1xjSgYd5Galxcb3DK+N
         wJVU6YJXchzeg6cyb3ehanEJMP9CiF0CBC/OHa7lwChU4f7PhPCYRfRy7d4fBKnrBOU9
         m5F8N4JZAlteeDSew3tqpflcjP98p9OEQoNGek0vifWS8yz1fciZK019+0O5VArWejsT
         +F6PCKhw3KJd24hgPMbjK0UqLORkKjb8BM1nc/CXGsuU0mSiq+RvvD6JYCgl69rS9PWD
         nB3O5mys0Mh0Dfm3WsBzW91c2PCrtxqPhtMYUTfzroKOFh7O3BBrqA9Cn3a2j1MXO2Rq
         utiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/SGIV3hvSPVA0d/hRbfdIVi2Nsd+rgAjYCpmFW+IOY=;
        b=HMayJ/j0S4k9A1BeMqZzNDk55O8ooLMO7R6nDu8BX2Od640ZRHEuFGWSNnnY4fqrD0
         CsOXn1xvRLIzAI23xcN0NSoQYutpFA22Eun+JqYwALsaf7aBlTRmR1vBCDI2sWi/mxBv
         nGNLZ7Xh70eTqSH9CiDfuDU7uHnKHc315Qn0AktPlbbcnwf3jaO67yCF6V4tg2srnwT8
         XsOSYkxhEiucf3fCNHJQci90epb9EVBVkO9Fajx3OkKJV+3BeL+D38RRJp292BHZgFc3
         OBv3JCQM7vwlelngjkQKZIsG3NEJ2GLJhmeHZqAXqXk8vly2NIchxJsHEx2iI1zlgziA
         p7eA==
X-Gm-Message-State: AOAM531OeU+4pvyekfajExjF9R5DTv25PX8If+j/XE8EH/Y7DZLQX5dO
        6QfCYgpp2wMzhHlE6G8VkSi2cKREBirHmSQJ0nA=
X-Google-Smtp-Source: ABdhPJxm4p9TVbNdn0pD5V1vRjNpr2X6gEN83jp721kzAr1c7zImfmnDUxsaqoKtPLDJFKkIlkt58iRxD2WVYJOp+Bw=
X-Received: by 2002:aed:3f71:: with SMTP id q46mr7541045qtf.353.1598387673307;
 Tue, 25 Aug 2020 13:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
 <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org>
In-Reply-To: <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 25 Aug 2020 15:34:22 -0500
Message-ID: <CALaQ_hr-xuLJ3ZYHuvCaY7jLm7od1bgGQvgT0c6N16xTtdAD0g@mail.gmail.com>
Subject: Re: localmodconfig - "intel_rapl_perf config not found!!"
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct. I'm building for 5.8.3 and I'm currently on 5.7.4 (1 month
doesn't seem particularly old).

On Tue, Aug 25, 2020 at 2:13 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> so intel_rapl_perf is listed in your lsmod.cfg file:
> intel_rapl_perf        16384  2
>
> You say Linux 5.8.3.  I'm guessing that your "make localmodconfig" tree
> is Linux 5.8.3 (?).  What kernel version are you running?
> I think that it's older, and some file/module names have changed since then.
