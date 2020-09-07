Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12FCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6690920757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bitllW57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgIGQkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbgIGQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:38:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF85FC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:38:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c10so12665332otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22rG+o0x5E8fn3lCo9EgmgeQWY6DcyVeCCT/ulJfvbo=;
        b=bitllW57EJOYHuZ5CUKD/Lb1sFDAtPUOem3ecI2UP5Q0jVAjzxdw9cvG8bOu1yi6S2
         bvOWP86o1ZNwx9Fkmfi7+tvAVV+vGPobCKiG9y/53o2pVIkHQDx0ZsFka6V4SD3czEE3
         x+Tl+fP+CGIy2viSi3K8rmPDboV3CnVBOn/Kfri5r96cPfRSz4zqlHRNBSAr3lAOaYqf
         i9ZVZlwxyHvG/GF2NDA+lzp1mfQI+qImZwMyK9aISDMX7zgmLcCO02j6vi8tyMXcMY++
         ObuajIiQvYTIYZHSkaTPgwyUzMEl92mdfXHfPW0TV337JP+dOU765tvAW6aj/lyM8YfE
         1OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22rG+o0x5E8fn3lCo9EgmgeQWY6DcyVeCCT/ulJfvbo=;
        b=GRRUidjbCovrPlXf+4MaJ+hg+bXCpJp4/Destd5ABS7kFZf5rqMKvR2VRpjL9p+D4T
         f3KjkgyRQ0M8lKEXi5C++PQNOdwi+atEo0wVvCzzxpxdZS3UuvWYdTXCkePaXUqSrOF3
         F5YwAL94KEw9zajtjRRpQPqiay++KdMS8Xb0hq86TU9P8pn9UFlGgoo1pAwL8Ks+b2D8
         KT8JjTg8eVkE0MQaJudEFwjB69E+rCw+jFgZEAr/5VsVj/CWccvr3UlK8Tj4cQM9Ra2g
         oWSXf/YfDVBtUbqwfxFJqTgQ55V+Rphqbz7QYAGnGhCoJqvfAWMcrvZUPgkLTJ90GAn8
         K7Zg==
X-Gm-Message-State: AOAM530yC0b7+HQUDM5g9DumLUOl+hg18eUbqQrhznLyZDBYlWfsbpVF
        wAOMUC+FDhtIelHoVyfLPx+cvWFsm2B7oUyAOs2/mw==
X-Google-Smtp-Source: ABdhPJzsrwPGCQDoeOK2piqQ7QiJFzBZJjpEU9sPz0Ed1c6gEk6sIyv2+pbiSAvi7iaELl3C5S0YJJO8OglifQ0pITQ=
X-Received: by 2002:a9d:3da1:: with SMTP id l30mr15600016otc.233.1599496695929;
 Mon, 07 Sep 2020 09:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-2-elver@google.com>
 <20200907164148.00007899@Huawei.com>
In-Reply-To: <20200907164148.00007899@Huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Sep 2020 18:38:04 +0200
Message-ID: <CANpmjNNL_hqmKfZAGF5mF-HwVx78tp+j0JNKhK=xPwJLvdWnZg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 at 17:43, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
...
> Interesting bit of work. A few trivial things inline I spotted whilst having
> a first read through.
>
> Thanks,
>
> Jonathan

Thank you for having a look! We'll address these for v2.

Thanks,
-- Marco
