Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12684C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5221741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ez+9IuDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGWP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:15:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44959 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBGWP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:15:57 -0500
Received: by mail-io1-f66.google.com with SMTP id z16so1180131iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfZLiffjzS8p0VcpmAdgeBkNbj1uA9jdNca01ue7Jt4=;
        b=ez+9IuDImdaUY7iHSTgV+FCo7hQlp4h/2a0nUVizcOs3oBlJ/RRxgF6bIAU0ObYswc
         oPeSVvZy446HOPH5Xt1e3KZvlQaBBWMcZiFk9qP8FxLXOx4fwQB8AovK25jkxUNthXN6
         uvgJKuhuj2/gihncyDcwLrEcE9O+SOFWPZqbjw1nt1ItVNEdrNKjJSzGfuuFUh7uBF2U
         UC/nEm6Lk0iI+a6bdnS3j8T9OTsed2h9kln58cKRdK5nAVQ7QGfMZx3wd0qUBY/HOiQy
         g7GFtcCRdf/7vRrJO+xBX1lulK1l2RZfaYsAF4x3ROyhHYCIpik6GHJ73WrcnqiQKl5C
         qU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfZLiffjzS8p0VcpmAdgeBkNbj1uA9jdNca01ue7Jt4=;
        b=EdX3jlKwXR6xLNg6wv58v5og8sdvtD79qXybGeDEvCmVV+28LyAOpbehGePn/B5C2T
         Vr9NOr5T2pIMdyGoOeO4Po1Oza7sWEsZfk4FwNpxLl2cicjGxbmVEd6k7f2iwIYpgBEe
         xfCwMmftc9xJC/qKek4ipfbhmuMNiCgcT25QYKcAMkLUC4Ux6LwieBHAyGp+/6dqZ9fd
         jEhj9KzSNo8OrvOWcZLBs6bZZ3rVeElH/1cSnCgfzHEDUdxb7/p0EJSNWo6hixBTzx1o
         5q3t5M5TblIHDXyx7lbagdkzMcZZPgGm66lsrJQM5FZcsSko468lQYk3JyGiJNikMAGo
         4V1g==
X-Gm-Message-State: APjAAAX8keLdVp36FRl4I5XEYsZVFPQ8qC6N03siZ+fOMgUi+HNo9kyD
        7f54AuvVzP3hkv7z5QQZB/gETl6oBymIGuS3bJDokQ==
X-Google-Smtp-Source: APXvYqx6uhzoHSlOqVuZtnEdU6UHdi8JnHFJryKQ4FvVyStADif7DkR6ipcJ1CsZbjO5ly5yUz01y9XExH+ustLG4AU=
X-Received: by 2002:a6b:92d4:: with SMTP id u203mr606535iod.288.1581113755090;
 Fri, 07 Feb 2020 14:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20200127212256.194310-1-ehankland@google.com> <2a394c6d-c453-6559-bf33-f654af7922bd@redhat.com>
 <CAOyeoRVaV3Dh=M4ioiT3DU+p5ZnQGRcy9_PssJZ=a36MhL-xHQ@mail.gmail.com> <c1cec3c8-570f-d824-cb20-6641cf686981@redhat.com>
In-Reply-To: <c1cec3c8-570f-d824-cb20-6641cf686981@redhat.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Fri, 7 Feb 2020 14:15:43 -0800
Message-ID: <CAOyeoRWX1Xw+iPX52uCZef6Rqk44d-niUTikH1qL-fRoaYJeng@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Fix perfctr WRMSR for running counters
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, please send it!  Thanks,

I sent out the test a couple days ago and you queued it (commit
b9624f3f34bd "Test WRMSR on a running counter").
Are there any other changes that I should make?

Thanks,
Eric
