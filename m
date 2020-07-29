Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBB920656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjswJK9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgG2WRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG2WRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:17:54 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D1C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:17:54 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z6so26275409iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBUbpHMrOzLkTRO1VgnWvJTXTiC0psLpW17xVwkMvZk=;
        b=HjswJK9z3OCMr3E84OQrrTlnUI+in5Bf7kAqFPkDWECbZpo+b5Rw9dDWCE6DvaQg3W
         3TNRWRWu/422ORMp15P/yzlWaMc3d4wSEZdSwasGlVZDvOpLJ6Y5/jSJUaNgm9/DAQMw
         lQ8Tp/y64LPWZsXwn8Lf54v3lJ/ck5BU4ojJ3IH377iKtEeBZc+WOT70LAfpaHgdm5yY
         2RioRkZqcdrQrtz2AcIOAwO21XLC1vO05P/GiW/vc3ERcNjBfZVRiqIYfqQvydD8gmdt
         SCHY8tVID4+C9rVoEETryRqeKlSYZKMbWMyHPkmxddJLtpDu+GeEStffJUWFmDIra9l6
         C9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBUbpHMrOzLkTRO1VgnWvJTXTiC0psLpW17xVwkMvZk=;
        b=cKyKN6i2Q3qeEINFpSXwvUGj8vDx8Mp4JpA13NCyC4B4BMjlvOr63JJUJHg4IYgkXc
         +rQHA2qoEpUR9300BtmjThhAv88lxAatLgoHCwiK1Hp/I1xtc2KmTnTs7M5bktthNSoM
         XUQOU84eMsQ80aUBK5Aa6xo6mTs0i9T4esHzSlUFJzKd2FqPGhC1ueN6RRjrQ++LJtQG
         HRQplSOB+ev7UPvzseZRf9szqUzlkkfp8ffb7NUzY994jVg3zWKFbaxUjEKhceU7ojE4
         yLITox6QUWfbDxuSGqRmz7EV5L+KUu0RNuwCST0rc8KbdGmCQUoiiV4IecvpDbol1Mxn
         34XQ==
X-Gm-Message-State: AOAM5338w+n7m19yQM0qyXJkD1C1+F5+p4jjJHP4h6R5c8dXhdHKFl5V
        cG7Nu1FThLt7aytZsOvyXmjl2KbU7QHHdQSf/NUwyg==
X-Google-Smtp-Source: ABdhPJxe6ROlG1A5mJ7AYQwm7PIFzAKasC8m2xiJlm4UqwYsToWY9DPIQf9/kQ6A+YxE02236Ql5MvlXPzwBucSkncY=
X-Received: by 2002:a6b:b4d1:: with SMTP id d200mr33823109iof.70.1596061073142;
 Wed, 29 Jul 2020 15:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597952647.12744.15718760666138643079.stgit@bmoger-ubuntu>
In-Reply-To: <159597952647.12744.15718760666138643079.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 15:17:41 -0700
Message-ID: <CALMp9eQtvodpmE07DkQBu+zqE8yvrigw4N6dMQQoiEetRPFA_Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] KVM: SVM: Remove set_exception_intercept and clr_exception_intercept
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Remove set_exception_intercept and clr_exception_intercept.
> Replace with generic set_intercept and clr_intercept for these calls.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
