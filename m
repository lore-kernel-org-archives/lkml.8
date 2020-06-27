Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA15C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391B0206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593296122;
	bh=LPMYAPRRxguRn61pkhZt5cTXc7rHCyiq+/Zp7N8Zh5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N+mRXtjd9s/td3yaAT0UWxqtrv8y4CMNr/53ozdsEtnlwvf5zGiRPdb9G4x8NxNSo
	 b0znr04qno9FdsDPS0Bantkq3O2fYo0TzWHm7bsQK81L0u93D2/PKXw7TCokQOU6nR
	 SVhHacTPB8UHRScYN/bEQ4ManywYSGiz5EjeqJeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgF0WPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgF0WPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 18:15:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8C4C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:15:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s9so13904595ljm.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4JEHR7Il2IGp8f5V95s+cFH08ZEfipxHhJKa+vtSQXc=;
        b=L5az16Wx0Vb9F9owDOvTovtU9UfiHOeqrhQTmmBE4a4nothf30qTjIzyM7cu7SLlCV
         YKOvifljh4XN6M2evYVQVyyN8JAU84f2cZB3eUoAUJ7NLDuZx7HIHXCdIn+SygeHmNx+
         97SUthWIKvp2epNCe7/LpggsYcP6nm+vsFS9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4JEHR7Il2IGp8f5V95s+cFH08ZEfipxHhJKa+vtSQXc=;
        b=iEYVHdvoXnjy35sLgOgq26c9yO8lArKV0DGDyYDscYlgfjF3VfcKrTCeC0B+TbtZ0l
         EEAK40ZIZpObbjXg5n4imDneHLfB7eVMObP7+h5KinIXmKermav9FRqAX4hCg5N+FAzZ
         7U1GTK92sqt6JTSsM9FXJGPUQvmNUJhbsCOEQoIksoosawc9m+iowzSbFx1eQPNrGC43
         X63cPRLRlTDkqq7U82ElhbzB2fA0hSOBtu5wPwFLLliPFrMLrVfZnOhyUNv/4yEC3EIn
         stO0xNtmJx2yNZr5Tvjctjlmyr5XWwwDmF/jSOAl0h0RrkplxbbsqEempN94sviGwwOi
         TDIA==
X-Gm-Message-State: AOAM532duaWsxmbABKUaPRkrw1gEXpfJn3IJjLlxgvBFuGOHwkQST/hH
        38HF7ayYsIdnfi1jgIcfBOtJeSTtvZs=
X-Google-Smtp-Source: ABdhPJzySpzAxjz7OJ+bMMBB8oBx0BqGHGUoxk4DkQGuq51FQ7zORAD2PyCaheUEQE07AGQXTG1bZA==
X-Received: by 2002:a2e:81d2:: with SMTP id s18mr4446362ljg.124.1593296118150;
        Sat, 27 Jun 2020 15:15:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i22sm1977921ljg.31.2020.06.27.15.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 15:15:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 9so13938049ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:15:16 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr155744lji.70.1593296116489;
 Sat, 27 Jun 2020 15:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200626075836.1998185-1-hch@lst.de>
In-Reply-To: <20200626075836.1998185-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jun 2020 15:15:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
Message-ID: <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
Subject: Re: [RFC] stop using ->read and ->write for kernel access v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> as part of removing set_fs entirely (for which I have a working
> prototype), we need to stop calling ->read and ->write with kernel
> pointers under set_fs.
>
> My previous "clean up kernel_{read,write} & friends v5" series, on which
> this one builds, consolidate those calls into the __=E1=B8=B5ernel_{read,=
write}
> helpers.  This series goes further and removes the option to call
> ->read and ->write with kernel pointers entirely.

Ack. I scanned through these and didn't find anything odd.

Which either means that it's all good, or that my scanning was too
limited. But this does feel like the right way to go about things.

Al?

                 Linus
