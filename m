Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2602FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A3720848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liMR+ja4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBKXcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:32:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42957 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgBKXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:32:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so160860edv.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSs7UqmD5JkZZbHb6Da5Z4JrHfZRP5ftJHQt9uAAdrI=;
        b=liMR+ja4NzU1aOeqaKl4lbrBoRPtK+iwhpCD3ABdyNXC3IV0OkN3hWEOnv+stwyz0p
         dLvQVDNXNtPDaA4s61UCJ/3rotRJB/rTr5S8Cf9nj7ULYw81Aw4eW6jcW8FSnkpmkvFd
         S6jaIPrwapXw4jFnQN3EKyucf6zFOyc2+AAVH3ZF+KkhnTYbaAZHf9l69KVrBBOME6gy
         /mUhEwIhyx2yeczYKS/Ts9DFICgi9MWfVd6V5YiEbXZNoeczIP9qwGVwnFrqIrj7UhGM
         TlJlsGQhF7vrtBEFZYIULny/TaQZIx8x7GxfyVcNWvMGsS/sfcOBKF4lPCrnZ6HS/y0D
         dGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSs7UqmD5JkZZbHb6Da5Z4JrHfZRP5ftJHQt9uAAdrI=;
        b=qemQevKL3jCIaPV+TfXvbo5FOJ84O+E5TQ4l9nv28de6rxnymk85DcdCnT0z+qYTPh
         X6MDUp/WitbKJ3v/O19DcEtCVBTS7Hgzanw+qPy0z/cXwjQbG1Gm1DXXEmb1J7DU/0b6
         HReRpqG961EYDfYqgLD4r3tHqQi48C0tHomtFyMHPl24ZcdY+t157CIqEJhRujQByr6a
         I50jYAPyNhpTCM/1Ac4w/oUjqfe2bU/LUgxAxy8wriMTeo25W7ANHUkMsM3rcNKXgqho
         mojBxGBMaLLqAlF8oML3j2ficcHPrMQ/X089kISHW8XGXhLEdWGjNywTcz/y3HKP0DwX
         4+Uw==
X-Gm-Message-State: APjAAAXnhUJxN5+DEyxgHJxtuU5hTQD4y2T8DaTr2T9c6zjcZ9zUc0/v
        HN9JHGeyX9MBEtpkvW8Hp8BqD9zGEuI8OU2EO1Bb4w==
X-Google-Smtp-Source: APXvYqwMMZEHyNax/K9vt49l37WE+90gfgIcM9+R+CCDjwgdS1qYkAJjiKABPD4lZFkil4hu37IJKAM0KZWO/WJI9NU=
X-Received: by 2002:a05:6402:6c7:: with SMTP id n7mr7881480edy.177.1581463973027;
 Tue, 11 Feb 2020 15:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <CAKOZuevHH1pamEKy5n5RLWDP=tHk6_9bR+g3G+HKnqm_srHvrw@mail.gmail.com>
In-Reply-To: <CAKOZuevHH1pamEKy5n5RLWDP=tHk6_9bR+g3G+HKnqm_srHvrw@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 11 Feb 2020 15:32:26 -0800
Message-ID: <CADyq12ySxau=SyyNp6VSbwmvRm6Kq1=Y62wTbQZoEAQ1XaXcuw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Daniel Colascione <dancol@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> What about making the
> left-behind mapping PROT_NONE? This way, we'll still solve the
> address-space race in Lokesh's use case (because even a PROT_NONE
> mapping reserves address space) but won't incur any additional commit
> until someone calls mprotect(PROT_WRITE) on the left-behind mapping.

This limits the usefulness of the feature IMO and really is too
specific to that one use case, suppose you want to snapshot a memory
region to disk without having to stop a thread you can
mremap(MREMAP_DONTUNMAP) it to another location and safely write it to
disk knowing the faulting thread will be stopped and you can handle it
later if it was registered with userfaultfd, if we were to also change
it to PROT_NONE that thread would see a SEGV. There are other examples
where you can possibly use this flag instead of VM_UFFD_WP, but
changing the protections of the mapping prevents you from being able
to do this without a funny signal handler dance.

Brian
