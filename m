Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F9DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30BB206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7wUw8j8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgFVL4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgFVL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:56:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14C5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:56:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so9421705lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCTwJ5maNqWLHygNTmQMqdfqZE/2c++0+GRwCzlwMGk=;
        b=Y7wUw8j8F6/JpDfJgrNXWvY2VzjjpPGaskcdn/2dADL195kBOcOkY8vEi+Gi/Bd9sm
         qcpdmqH7U2Ahp5ATeCr7iu0OK713VKJ/g7nSZlsJAL+FFbz6Hq71v9FXyrluTwUbCqfy
         kCxSeVoIyyWOPSoVv2EpbiplatNTAziIJ6LlJMq2dolrXC6ziEiYcPXBv2CUAGTDbG6v
         62C+/VXScoi/RvtaqwUtwYdBwN1vKBMoUckVZ40RrJe01QdRU9u0t68VzSttH+uWHHdq
         kLkvxHdau1NzKYC7lNLnT1umidUEiRdmoVrzi1KxLAXwelBMz6Own1ebnteje0WUuehj
         FV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCTwJ5maNqWLHygNTmQMqdfqZE/2c++0+GRwCzlwMGk=;
        b=uD64gGYg0V/MrQi8yCa0S2uafmYkci8J8a7LTQ+5mJaPiX3xn1xTtCTZl4DCuCL0xb
         Q/q/qYSyQxbhN/3yTfHAR2S9IBY6fHyAeN7Yo7RaqWrLet3pBvaMpREIMesCA97NWohH
         qS08re/y2U8K8ppDDOqcBe3ilJz/wBnYZ5XIaxi27MvKZOp1dBiV6EhWipGn+IbOc9Jl
         k2TGwMvKC+WBGYL7uvliwO87laMmvf/Ggqp02FB60cw+udQTdPnxZe4UicKFbvvWHAK/
         y/QqMgNd++XIBTxdwCtt0EZslqY0Ho/G90yXUDsFjAgVNaxgaqLPAJHjgvb0Y9n/EEgi
         GVfw==
X-Gm-Message-State: AOAM5337ctvqK+jf1nUhlKNf3h3hAWMyxuneexJJiazmTMVhlxQf9QtR
        +917TwyVMXon2vQ/eAG+wdpxtwek0BpwvFFFTPA=
X-Google-Smtp-Source: ABdhPJwyR4dRgzCUIkWwd4/ZOil4bjFdQRphpxw2+xgL7FVScNkknIdIMZzjnHl2lqyt/JnoX4fEhDZOlXn8RGPC1+o=
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr9505639lfd.83.1592827004147;
 Mon, 22 Jun 2020 04:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200621102634.n43ozcsiravdi2ie@debian.debian-2>
 <4d1ef78e-f001-a685-9a69-afa68454fdc7@oracle.com> <6CFD253C-824B-4F95-BBB0-F53123DBC323@alien8.de>
 <20200622094616.GO576888@hirez.programming.kicks-ass.net>
In-Reply-To: <20200622094616.GO576888@hirez.programming.kicks-ass.net>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Mon, 22 Jun 2020 19:56:31 +0800
Message-ID: <CAKq8=3+ynBCootJ8QcyKctzPUFJA0SNrJ-w=kxniqGcg_hcVYw@mail.gmail.com>
Subject: Re: [PATCH -next] arch/x86: Return value from notify_die should to be checked.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boris Petkov <bp@alien8.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 5:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 22, 2020 at 11:17:51AM +0200, Boris Petkov wrote:
> > On June 22, 2020 10:52:23 AM GMT+02:00, Alexandre Chartre <alexandre.chartre@oracle.com> wrote:
> > > So the appropriate change to make Coverity happy
> >
> > Or we can stop "fixing" the kernel in order to shut up tools and not do anything.
>
> Agreed, no change required here.
Ok, thanks for everyone.
