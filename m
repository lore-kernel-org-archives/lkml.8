Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF96C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518692070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOzJWw1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHJUeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHJUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:34:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D557C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:34:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so674294pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi6y7Sa5SbnYmUqQlnDkyIhg+d6nJKBI1tgep4DAWjo=;
        b=JOzJWw1gvAKYKaKRPYFB7PDEtf/ROnu9QV3IBnv1TSojh8rA4SQDXu2BYcVoFy3OG3
         /1S7ceSeUOZRQj5/KJ883IHIaMTeO3M9J24kHva8cgaCR5Xo6aJNutKKgpikvs/JeoOS
         qD4csJ4Y75B50acWG/yL6J9pEBmybt7v8yqj1t99J8SeLMPb5fVjmpF3NEweDhwEol7+
         7doyqvmCBVIE/HEX/VvDC3/Fj8js2/F7BA9vATzSbiESOZLA5bGVxPf8otGpMHEeZ2cY
         2Bvb4XNIcXVzWcv8UNp9R4bSO+yVHTbiq+zBUFC9KU2RWuyNhgX+FzYF2XEQnZDoadwL
         4/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi6y7Sa5SbnYmUqQlnDkyIhg+d6nJKBI1tgep4DAWjo=;
        b=PjgldbCJ4mN7w0UUN6sd89NH6mXD5RxwJpNLMfN6gpeF7HlkbJmuT/l82J+615iKDY
         nlIosOCpQnsjPIX16IfzOpEMBP73J+iZUBmIEe9cblBoFINYOZJJsyPPMFWAw5s/j2Kk
         +GAfAhA1GKbzvg2pw9eu5FFDD1nVPaHCEmCCf8smWoN5UoEE+TWe6ppptVNV4+onYLc8
         6s45orPHCmzXJJDK+dao1q/39rv8cnTH33h5OxN0+0dwYn7yV5dFxoVD6LCGmgg5YRD1
         rb/1bII/RLkzQw8Y/NDGYmiGLuy9anumplUVik8EIXZlIQr5V5DIJT8NiUTnr9BEQEAh
         n25Q==
X-Gm-Message-State: AOAM532aP7IW40Tfo8nr0HCn2MwhRTZ8sREnnVlhuTAGTbTd1YHqP4OQ
        FKDnXpPE4U6RvR3zW6j/XO3kcOExl9B/kaF1sjmGmg==
X-Google-Smtp-Source: ABdhPJxBJws4QeAEFAf6sjIxEUPYhDGg0Xsa/WaYRrMREL2SAgkAMZcfy0aDWa02LoCK6HH8PIBVWT2GeZ8IUdp92VY=
X-Received: by 2002:a17:902:10f:: with SMTP id 15mr26409586plb.232.1597091656550;
 Mon, 10 Aug 2020 13:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200806203737.3636830-1-urielguajardojr@gmail.com>
In-Reply-To: <20200806203737.3636830-1-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Aug 2020 13:34:05 -0700
Message-ID: <CAFd5g44FgjeziOGbS=RphovQ=UYoPBRNjE7EuhWAdYFgCqsaQg@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 1:37 PM Uriel Guajardo <urielguajardojr@gmail.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> KUnit tests will now fail if lockdep detects an error during a test
> case.
>
> The idea comes from how lib/locking-selftest [1] checks for lock errors: we
> first if lock debugging is turned on. If not, an error must have
> occurred, so we fail the test and restart lockdep for the next test case.
>
> Like the locking selftests, we also fix possible preemption count
> corruption from lock bugs.
>
> Depends on kunit: support failure from dynamic analysis tools [2]
>
> [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
>
> [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
