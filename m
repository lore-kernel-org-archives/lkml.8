Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90622082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcvEkCx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG2UQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2UQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:16:50 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1180C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:16:50 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q75so17761143iod.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qq+ysuvSU+V8JQG1DuA+Q8eHlgCH1eO+fRWf5OmQClQ=;
        b=YcvEkCx9qexk7f+HNawBWOgq3Ozk6TN2CCHAbw23oQ3VzwAf9Q+gVni2+YeXOSo80m
         wNwNPYLaR+D5PcrJyAE4lrbD2wdX27P0wNO/Y0GesGL7tfLXyFOKSNPWJ8UhME89F2SC
         WW3HOcWX4qfczElt0ALpYlZcC+WRjvve8dFU5bPSu+SbWSM14nknjDRcYRNi/vH8x6Dv
         bEX35VZtg4Q56GYYgrkWRr6bk6MAFZugFyJE60UCLZDE5s9p7DC3pgpzDT1vN2TxTAXz
         VRdn0EwJFjhmR7zFyq9o4uyPUYIjCgcyWccX8a5348RDxrepHllS7xCIzaTGR+DzibhZ
         D1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qq+ysuvSU+V8JQG1DuA+Q8eHlgCH1eO+fRWf5OmQClQ=;
        b=pJ4BZ5g+32DGnTAHaHrCEI+lhOLHnSYjXwNEYVdFtJNkFizxjMFdt10bYFhW4xZBp7
         MpLwaXFo8mogeEQONl+qeef5MhdmccAIGrL/G03QDE3deW6eDEYmv+GsBvI6LinJxR4T
         9uRl9Il4DO9VAzV1EnwifHEElMO/X125czZ0Y+M34LSmB8hxAVfLJwc+EnY2j8AUJcQt
         pqqXslgMh6BNLCkr9eb5T21dO8N5Xvp4fNXJ5jj0CQAMvyRlBKu2aDXwpJ6GEeFacDJf
         Ak40pzRGxx0L8EEmQe0mG85HtvSMtIvXnKhPFNO871QgtlOAu5WIit22zr0HNpm1Cjy3
         pVwA==
X-Gm-Message-State: AOAM533cLwCS19RobtJ4FSmzKEzunzwKBG5Qhsq/TlasGpQ6KbyFjeqr
        qBapvdcbtNwsNx83+k/MlPX4rvNRB4GavYox0naQfY2G
X-Google-Smtp-Source: ABdhPJy4w7jgd/UAwb5pPY2xqkZRN3ELOqqLs6AJUHt05VUljtTZQfKhOa5aVXvbhgUsVDCOuYt1rMmZ2zibhre8Xok=
X-Received: by 2002:a6b:b38a:: with SMTP id c132mr17932385iof.75.1596053809764;
 Wed, 29 Jul 2020 13:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <fdc7e57d-4fd6-4d49-22e6-b18003034ff5@gmail.com>
In-Reply-To: <fdc7e57d-4fd6-4d49-22e6-b18003034ff5@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 13:16:38 -0700
Message-ID: <CALMp9eRyyO3d36j6YbcvLEuPLZpByYS8SOCpVithpfqCeKhDUg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/svm: Convert 'perf kvm stat report' output
 lowercase to uppercase
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, acme@redhat.com,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 11:24 PM Haiwei Li <lihaiwei.kernel@gmail.com> wrote:
>
> From: Haiwei Li <lihaiwei@tencent.com>
>
> The reason output of 'perf kvm stat report --event=vmexit' is uppercase
> on VMX and lowercase on SVM.
>
> To be consistent with VMX, convert lowercase to uppercase.
>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>

Please don't do this. It breaks an existing ABI.
