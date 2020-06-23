Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F88C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1149C20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUBnFpb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgFWGb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgFWGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:31:29 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:31:28 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g7so15432325oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qmek8AIjwhUpjq4ifIiYp8uzWRuQrceKBuTssA8WgU4=;
        b=wUBnFpb1XedTOZz49F9n4D4PIuVtPX5VkJUtaqtxGg7UGknVrrLk60Zx9naVjTQYpL
         BDk1zi2t7tZIMJb82rFEjfZajaMsFAfhbh9FZYYZ8BPu11D1WPwD9JSuUJ53USXF3eJ3
         BDU3eMbwMLCMH35owR629KtTdFBa8up4bL/K/aTED/GVZ2rNWXzFwMf14rzHMKdQ2C3r
         umREKoXA6uXgJsA82lEpOsHQmCxGoWNtM7q/swcZNx7OoszdTF5+N14EIm40e92Pf/JV
         wzWzcuqAgcF7UZnbQzN/BW9eedX0VYOZJfbh77b/t64+lrEITy0RMQKRGi5EmJSyHFl3
         k/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qmek8AIjwhUpjq4ifIiYp8uzWRuQrceKBuTssA8WgU4=;
        b=qtDQ2tSvZfupUFPiFvsnL89UsWMaaToyeZPxLRUMu8c3NicoVXVmSLKyZzJxe+iUpR
         0LG5ULM2p44jaeiso3PMcXGYd1LLAETejhxoi4DVCsgB2Oo4gRZ3hLfZjWV9VN+N1waR
         Bm0GlVS6/HaCrhU+atNJO+2sklVAFuq2to6MW5lUAKyWchRugZgwYpp9iP/MJIPXIYr3
         59rqsuBWOa0v0goVXvTitE5Ee0p01EuH+uQ2+CVhPagWMCr/EfxUiqEWM8RNmP9Ypz7o
         70NEZ+ng5h0hhgkCvj67PM0/WCmSiVySVO3t0B4nNi7AzqliIrT+hDxc8Bv208JLPrRb
         Vdkw==
X-Gm-Message-State: AOAM5319G9dMgPfILDjikpzVqpsaMiXec2KZiGItXZmnCoK43LdANBsz
        nNXPprmJH8Mr6bewQxT/8tPB5/gt0OdHlENTk/WrNg==
X-Google-Smtp-Source: ABdhPJyIrpltllyO77WrCyCR79bPdhL1fhSudnjvKpS3olL4BruEarN+UIc2fZLLpjqe+SOyDu+d76xm40Uv44HIab4=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr18209710oth.233.1592893887231;
 Mon, 22 Jun 2020 23:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200623004310.GA26995@paulmck-ThinkPad-P72>
In-Reply-To: <20200623004310.GA26995@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Jun 2020 08:31:15 +0200
Message-ID: <CANpmjNOV=rGaDmvU+neSe8Pyz-Jezm6c45LS0-DJHADNU9H_QA@mail.gmail.com>
Subject: Re: [PATCH kcsan 0/10] KCSAN updates for v5.9
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 02:43, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello!
>
> This series provides KCSAN updates:
>
> 1.      Annotate a data race in vm_area_dup(), courtesy of Qian Cai.
>
> 2.      x86/mm/pat: Mark an intentional data race, courtesy of Qian Cai.
>
> 3.      Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu().
>
> 4.      Add test suite, courtesy of Marco Elver.
>
> 5.      locking/osq_lock: Annotate a data race in osq_lock.
>
> 6.      Prefer '__no_kcsan inline' in test, courtesy of Marco Elver.
>
> 7.      Silence -Wmissing-prototypes warning with W=1, courtesy of Qian Cai.
>
> 8.      Rename test.c to selftest.c, courtesy of Marco Elver.
>
> 9.      Remove existing special atomic rules, courtesy of Marco Elver.
>
> 10.     Add jiffies test to test suite, courtesy of Marco Elver.

Do we want GCC support back for 5.9?

   https://lkml.kernel.org/r/20200618093118.247375-1-elver@google.com

I was hoping it could go into 5.9, because it makes a big difference
in terms of usability as it provides more compiler choice. The only
significant change for GCC support is the addition of the checking of
(CC_IS_GCC && (....)).

Thanks,
-- Marco
