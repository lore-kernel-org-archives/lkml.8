Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F4C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F297120771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586455633;
	bh=QULdvA/Sx7XJffozT5xBSNPgMYS/3DHKQe3XK/EIo/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NBV9ED/nqYsNtJZhmHHO5xtH42jYrarq3Egmy2YBQzHFtgFb7Lx6kKX8tlo+I+eet
	 YZArElOiREcag3+LftAH6FOS+3YEKp3AC7eaB6boukVwr1M1A7E0R4tZyi2QoK/zh+
	 a6IfRZTOTgurb5PIYb5CVImso+1TPyFfLyUlOSyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDISHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:07:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42664 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:07:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id s13so329870lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBrUWLbZwr5SPpF8gJ16K43we21bAOTnDyWHWq5miJs=;
        b=aaY6eRayHYXc5ivMpYlFmsawWScyEu3k6ckAQ+QjIy+NIuWi+LeSCgizJqFpMmToai
         Jhmf9IO/IwprrefYTpdiUzczZOcCXrHY59ukIhp81/uB02G7RHhQsGjm+qudSTlTCvOB
         v98ctkuStOhNsPewVW9H2toALB5uGk3CWVnZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBrUWLbZwr5SPpF8gJ16K43we21bAOTnDyWHWq5miJs=;
        b=Bi9vI5XmbqietDiofEFLDxt+jLwyLsLGs2Vr+BxXfBQe86gbB9+W0ZfDj2DHMgCwOm
         MSACApdomUnEAVwMmWyg4dte8VJX6fgyKDmm0ZCczGXjNfZw59aBSKxJi8UGn7bKqV1V
         GLmPNTd1CWe5jhHZi6YZy4A+K7EHoKvmzOwZKSnvyIBfkJjmnsn+fXQ34UwjXkaAeyOJ
         9D09VBNEMPSy3YOfP7/HtYqNAbI9a2d5rb+dZzoL1QOVSauOfoVBO09IwMFz58bmY5K6
         5PtbTI1+Aa2SI/S0BG7kUzlzfKV4NWPsa00Zn6HHzzFuydN+3cJ6H13w5JpBO1QbbZM1
         X7sg==
X-Gm-Message-State: AGi0PuZL6QaziV88TAE8ArVTNEerIf4qGy9Z73PM0XXre5Uumc3EpjbV
        XS6ngzsWmr5gzfTmTBysLvcss86SLI4=
X-Google-Smtp-Source: APiQypIugMgvVxdhw1Swna/YyfzjIo7M/0T8Ryro/IDYNgZ1RdkS1XLXkuIYHXlUD4w0KakKBljMqQ==
X-Received: by 2002:a19:4843:: with SMTP id v64mr293793lfa.155.1586455628996;
        Thu, 09 Apr 2020 11:07:08 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id o17sm4885182lff.70.2020.04.09.11.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 11:07:07 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id m8so688030lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:07:07 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr581750ljc.209.1586455627334;
 Thu, 09 Apr 2020 11:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
 <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
In-Reply-To: <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 11:06:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
Message-ID: <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Qian Cai <cai@lca.pw>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:58 AM Qian Cai <cai@lca.pw> wrote:
>
> Agree to make a big deal part. My point is that when kicking trees of linux-next, it also could reduce the exposure of many patches (which could be bad) to linux-next and miss valuable early testing either from robots or human.

Sure. But I'd want to be notified when something gets kicked out, so
that I then know not to pull it.

So it would reduce the exposure of patches, but it would also make
sure those patches then don't make it upstream.

Untested patches is fine - as long as nobody else has to suffer through them.

               Linus
