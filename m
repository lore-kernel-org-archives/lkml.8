Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C642075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586293285;
	bh=SeaEaHFnXbhpQrCCYQ6v8rsvEnzeKDxOkkNQ7B9VOJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FAXrTx/cYp08vE22p9RpK0CPvUoNL7cs3BDQh/JRnpdyQTe4BQ8Zq0s7Ek1XuHdSR
	 W1bajVDL2l79q1QJu0lM2WrzqgGDe9AamCp3pRua5OyCrPoC3lNOSVGvNkdifktisu
	 3BoDTHyfY98MqLZrHBwQVeES2CKv2wSAqUXWjMZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDGVBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:01:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34362 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgDGVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:01:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id x23so3505109lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epjd3hRndDDxUzNxhGw+kNUEWswsyoCP1k+ltMRz2F0=;
        b=Rea+dN4Po4ublGuumqEu1Z9YdmnTeD34HLjcUPAn4kHYHWLUNPIQ/VZCsT6xyf8JiS
         bmcrncrGMpFp3ozkp1oN3IxqZ435NGWt/x7uln8afuzN0jgjeD5EbAAwriXLYujNsWDj
         hGtKlgxlKKZWInJKxtH5YVmPqsKEobcBPvotE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epjd3hRndDDxUzNxhGw+kNUEWswsyoCP1k+ltMRz2F0=;
        b=cPdaQWXj08G39/LHQAYJBAu4mFgoZNIEel1r7WVQtZ4gBVWT0GXSqONkBNVztxs0Eq
         xyXv9Iw7+BDtGfRE0VqzGUzp/3QFSVbx0DQbegbe/U2Y/oIZ6NVZ+6P9Cmj6yUiB3N2e
         uNzQn63zCuh6LojVa5Id552/NLNNoHkjIvxwyPSo9UCB0D/odWGWSnfHT/wt2rpvD3ei
         v2Fya6VKqD1xVL4IobzuIEJmrWL+mvquoSZjZ5BV0FP7pY2vDpRcShIfj6I+L86iEuXf
         NXu76ksi4C/PrlUuFBoaLeEv0OJNrAM+W4R+G1Aom8hLeRtvPecpbU3xddf9QKqTVgUH
         S5kw==
X-Gm-Message-State: AGi0PuZvTYYe1RlwlL/nVR67IbnXgX/ZUlkw9MztpLCnEYEVdrkAYbwV
        4m4aRupF2N6o/e/9gGoZr1zFVrZ+GNI=
X-Google-Smtp-Source: APiQypIdYEsEGhl4RnzTophC58IU+xs4IQ44GLK4EXwsv+rW/Ug22tevKD8+3IH4zrA39pELAM5/1A==
X-Received: by 2002:a19:494f:: with SMTP id l15mr2518612lfj.33.1586293279685;
        Tue, 07 Apr 2020 14:01:19 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o2sm12314195ljm.2.2020.04.07.14.01.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 14:01:17 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id z26so1203288ljz.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:01:17 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr2769380ljp.241.1586293277007;
 Tue, 07 Apr 2020 14:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200407200318.11711-1-longman@redhat.com> <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
 <67c51b03-192c-3006-5071-452f351aee67@redhat.com>
In-Reply-To: <67c51b03-192c-3006-5071-452f351aee67@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 14:01:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whV5Z4XioUOW0UM-PBrW7iqb0HwWKQU5Vn8b5pmsDm=Ww@mail.gmail.com>
Message-ID: <CAHk-=whV5Z4XioUOW0UM-PBrW7iqb0HwWKQU5Vn8b5pmsDm=Ww@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Waiman Long <longman@redhat.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:45 PM Waiman Long <longman@redhat.com> wrote:
>
> If the memory is really virtually mapped, the only way to find out the
> size of the object is to use find_vm_area() which can be relatively high
> cost and no simple helper function is available.

We _could_ just push it down to a "vfree_sensitive()", and do it
inside the vfree logic. That ends up obviously figuring out the size
of the area eventually.

But since the vmalloc data structures fundamentally aren't irq-safe,
vfree() actually has magical things like "if called in an interrupt,
we'll delay it to work context".

So that "eventually" can be quite a bit later, and it would delay the
overwriting of the sensitive data if we did that.

So this patch does end up simpler, but for vfree data it is actually
technically the better approach too (since overwriting the sensitive
data asap is what you want).

            Linus
