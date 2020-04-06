Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72429C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548402072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDFSdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:33:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43936 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgDFSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:33:22 -0400
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jLWYh-0005jN-Tn
        for linux-kernel@vger.kernel.org; Mon, 06 Apr 2020 18:33:20 +0000
Received: by mail-lf1-f71.google.com with SMTP id f2so1120376lfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90HV19v61/oJlZKRSYQx/Q+sNGoHReecpevkIbBQOKA=;
        b=HkRURNsEhrB0t7GHTMTitvlO/WjQ1evighH6sXJLUxKXk7I7psL7mu4zoBBuobjT8i
         Cxey3kykbd1ktUx2E+l0sXRWEjwGc3JHUzIaIIzsPN6WTE5HwDKta5fvTzkmAVdWTZ84
         XsHVkjh5Pp4HSU9AXlYteQsFZsd0rpaD7TOU4Zg/Jtb9z1HuGW+G0+B0GrPaPvuqoV4V
         9pK+xNvKFbE+i/EfV68PjBWsivXUVZKJWY5UcwnwNMPQWJTCcBz4d2ZHsyioT9/rKk+4
         uatr9BsB/8rxIcm8AE8xl0tDjUBw6N7SEi+Rl14LVhDqq9bWYKnypj+UyaJcLaiAud49
         ZV0Q==
X-Gm-Message-State: AGi0PuaBtdaQdjsY1l+FZKqUKfOjvTXy4p300ekf4fUGQ7SEGHnrxx5H
        qFxK2bOxbozf4djw7OF5Kh4dimJ7TD7mh5WM1ICBlg6EgrE75+XbACUg4kKay0jkc/w45GcXacj
        4B3Jh8eI0nIoSGiYn5W5Tl1vzZ2/WhAaX1XDuuPqrd1oen7nIpwAl0tqn7Q==
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr12759338lfo.69.1586197999021;
        Mon, 06 Apr 2020 11:33:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypITp3xnqIy0LanaMOSTQptCQgmvJbvvW4mayLi3SKGRQ/k7zk5c43j4cUifOZGvLhKkDHOjqHFB4PoDD+QQXoU=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr12759324lfo.69.1586197998800;
 Mon, 06 Apr 2020 11:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com> <202004060854.22F15BDBF1@keescook>
In-Reply-To: <202004060854.22F15BDBF1@keescook>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 6 Apr 2020 15:32:42 -0300
Message-ID: <CAHD1Q_xwR4OqsF8n3VJXknZ5QgpLWPQ3YTuztTgn0GTMR0vgKA@mail.gmail.com>
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kees! I was expecting this could be merged in the current
window, but there's really no problem in waiting for the next!

Cheers,


Guilherme
