Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9E1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2FB20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNORJ8kq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgEOOEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:04:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C44AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:04:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d26so1955625otc.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhaGDwcFvYYQSyxtP5zz3pYpd2ByNv+4SWaajJkndn8=;
        b=KNORJ8kq1Gen0hNTu+37ufRX5aY4Kmr1hzRvbwKE0DfzoEa3SOU3xL1PAqVLsacebr
         DTumFHmRLk4FIG2nR6g+CfRs9YRkX4Ai+PzMhQws78n6JDg8fqOKRmIL2bh9r154zD1I
         wgZxznRoGzaCIaSugoJgNPMBKMbGPipgOFukxiWtcclx73cUfXAuWEPHXNl2aNtFfahF
         MgE0AMilI6uvOLBsn84e+XVpwD1Ux0ah42r1/d6E0ztndkf4SgcqhhV4FmiPLm8AmgWh
         Iv4QuEBmwqw3e5lqMrtT7fbTeFjwn97jGjXKbB2QcFv3Kx0yGoyYZBaWk2R79xlh9az4
         2ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhaGDwcFvYYQSyxtP5zz3pYpd2ByNv+4SWaajJkndn8=;
        b=DzdU1Bl3PpKBKxX3cFYDqmFsitqPv4F3q2YXl/8z/maUbW5aqQSiRchfvwyjdIBWvd
         afEmhz2M4E1RLz6BWJy4B09ZmpQlt6DNQQCNJQpTs1ga+6XRSx1P6ZJnwmlXsWNBq4dE
         sXZfK161izqVORrH72wosy772xVItkdkemyb/IjAUnllwwGTt+WZYPcs+bwyEVnZQMHh
         KPMbwWvt82N8OOmZm3NAoAhk4HkT7yRXiHQDG0WYb0XxiqmQDHcK8pPJx9zsZrPzLQDo
         voh7tqTI+uoSYzSn2sW9CJMTbS+7sU1fDZYp+Mr+tIuM+y/L6DUO14IUtPYt49YFVk9W
         OL0w==
X-Gm-Message-State: AOAM530WXh6Pdy4SH6RYYqvCq+aVdMVyuZx080AVu5r6Df+BbdpLwklh
        TPHYGRmhUL9dgzXkAjog/DaOGY2Hk6e7JcpsAfrpaw==
X-Google-Smtp-Source: ABdhPJw+kqqaChkK32YWE+vUnKeeTZCq4bzalcGBIXCpDSqcYOdjWP5sp+C5qinG4e7JKrO4saXLOnFdN5uqRO6oabU=
X-Received: by 2002:a9d:7608:: with SMTP id k8mr2547789otl.233.1589551485552;
 Fri, 15 May 2020 07:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200513124021.GB20278@willie-the-truck> <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck> <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck> <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck> <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck> <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
 <20200514142450.GC2978@hirez.programming.kicks-ass.net> <26283b5bccc8402cb8c243c569676dbd@AcuMS.aculab.com>
In-Reply-To: <26283b5bccc8402cb8c243c569676dbd@AcuMS.aculab.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 15 May 2020 16:04:33 +0200
Message-ID: <CANpmjNNLs+PZfcsb06fdfokzDG0dZSfxDh=b-tvCWt4qoBEZng@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     David Laight <David.Laight@aculab.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 15:55, David Laight <David.Laight@aculab.com> wrote:
>
> From: Peter Zijlstra
> > Sent: 14 May 2020 15:25
> ..
> > Exact same requirements, KASAN even has the data_race() problem through
> > READ_ONCE_NOCHECK(), UBSAN doesn't and might be simpler because of it.
>
> What happens if you implement READ_ONCE_NOCHECK() with an
> asm() statement containing a memory load?
>
> Is that enough to kill all the instrumentation?

Yes, it is.

However, READ_ONCE_NOCHECK() for KASAN can be fixed if the problem is
randomly uninlined READ_ONCE_NOCHECK() in KASAN_SANITIZE := n
compilation units. KASAN's __no_kasan_or_inline is still conditionally
defined based on CONFIG_KASAN and not __SANITIZE_ADDRESS__. I'm about
to send a patch that does that for KASAN, since for KCSAN we've been
doing it for a while. However, if that was the exact problem Peter
observed I can't tell.

Thanks,
-- Marco
