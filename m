Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B1C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CC520768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="rT1QSSFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439766AbgDNMBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729785AbgDNMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:01:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A96C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:01:42 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t11so11720883ils.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgFALEK+Ue6q7eNefcrOKCeZUeArF3mPFTmn/SYD2MQ=;
        b=rT1QSSFF4/o6/05hBpjbYf8t/fmGlQnkrKJwVsbXCYJ2vr+TyjgN3DH5ca2n2ylNRh
         8uB5qEZw8bYMJzIL4bgQI2s7kAZPC9u2Spi5d35Fy73Jzrc6jyj184vvFWsgv24kCnZH
         nKkbVSe3XzwCS7thKFf7xote64gCzvaMX0Qzn1sj4N6bBj4QCua7DN3AdOaVLG3hDGsl
         kV8AnZ8LTby30BWPF7V+OzBvCA21i5rXKv6a3K3htYQiMQP22yJLbF/VrS84Mfb5h4r0
         kUOI0l0F8XngwLvU8BzjgnWeA6QPYKkgkXqG/9Fp6kPEAYdeUOComlqQRYXtgD1qzY3G
         XSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgFALEK+Ue6q7eNefcrOKCeZUeArF3mPFTmn/SYD2MQ=;
        b=gfahcXo7RbzKHN2pyiVGiCrAnwDISS/qQrI2XQlvmHE6D0Ckem80qmE7mRXJKnKgId
         vGUteNQeJjm/Do4Yy2HhG5nLikSOXmnGG51/elL3vrRQluLDGkBbnzF6kT5XnDvlmA60
         fJXrYzWg0zZ3RVNIdn3Pk46Qy5x0mcvaiyGhlo2Ai0sdFLjyiQ4fLyzz7X98RMOBo+Gp
         xJKgyrSqABo5YH0prAD11rSYB93RxMV6HRpFfBiqNMQbG6pndl15dU/NAKDSIaHH0bCI
         fmiaQp3DxhoutCzy+hq5EpRp5RKMsNyCP3Iu4xLaQc3E13J7i78DyF6kmahmKuL24sHc
         W6LA==
X-Gm-Message-State: AGi0PuaJy7dvA/Gs3Z74UBa2W1YmcfzwelJgSaH1GQ8iAtTqWQM2MLrL
        MCn0mEc0r7o0sEIN2QwRHw+Ez4b3DlGdq041RsEsZGgApCDSWw==
X-Google-Smtp-Source: APiQypK2TpaffPbfIo0KZSNkmmRQZdiIT+UKHMtNHLh72rxcffXBm2gWGTylyjcxnU7IY9J/IknxxzVR5uB6GKvtFDs=
X-Received: by 2002:a92:c081:: with SMTP id h1mr5207290ile.163.1586865702036;
 Tue, 14 Apr 2020 05:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200409134558.90863-1-songmuchun@bytedance.com>
 <20200410115658.GB24814@willie-the-truck> <20200414110516.GO20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200414110516.GO20713@hirez.programming.kicks-ass.net>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Apr 2020 20:01:06 +0800
Message-ID: <CAMZfGtWk+gG7Z2bOy_bq=XnuuSJzic16zpeajhJiiekpJEFrFg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] seqlock: Use while instead of if+goto in __read_seqcount_begin
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, mingo@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 7:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 10, 2020 at 12:56:58PM +0100, Will Deacon wrote:
> > On Thu, Apr 09, 2020 at 09:45:58PM +0800, Muchun Song wrote:
> > > The creators of the C language gave us the while keyword. Let's use
> > > that instead of synthesizing it from if+goto.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/seqlock.h | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > > index 8b97204f35a77..7bdea019814ce 100644
> > > --- a/include/linux/seqlock.h
> > > +++ b/include/linux/seqlock.h
> > > @@ -125,12 +125,8 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
> > >  {
> > >     unsigned ret;
> > >
> > > -repeat:
> > > -   ret = READ_ONCE(s->sequence);
> > > -   if (unlikely(ret & 1)) {
> > > +   while (unlikely((ret = READ_ONCE(s->sequence)) & 1))
> > >             cpu_relax();
> > > -           goto repeat;
> > > -   }
> > >     kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> > >     return ret;
> >
> > Patch looks fine to me, but I'll leave it to Peter as I don't have a
> > preference either way.
>
> Linus sometimes prefers the goto variant as that better expresses the
> exception model. But like Will, I don't particularly care. That said,
> Will, would it make sense to use smp_cond_load_relaxed() here ?

I have a similar idea. Would it make sense to use smp_cond_load_acquire()
in raw_read_seqcount_begin()?

-- 
Yours,
Muchun
