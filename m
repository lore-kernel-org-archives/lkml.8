Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AF2207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="SUD9wzKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHCPPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:15:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253FBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:15:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so34591012wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRgcxqpC2efMEL9W8jlRcgPY7vIoCAo/VNXdd6tUD/w=;
        b=SUD9wzKr/3P2x6YjkkJR4VYMnEY1xlXykMlyvod+sPtx81Pe+VAU/Qv9NdgeqmVA4a
         6dUpNRdD8YJzlmhQd2IZAztWDoN6exreIwHPEPSyJRRMk9ScigmaTvv0kp6Ufu4XfmCP
         IMxdpKyi010H4ybO9yHiXI2jvFIRx2Dik8j9aMvxvB3NXtmEghghKgDKYrqLWYFRptwS
         egSMzel9kkEMSbqQOwqU57cH17H321SEohky3IaYg810VJw5Z85c5Uz7L5h/dehQxvyc
         Ew1QNa8PFg2m5KPYuQVd/TY5Hm2QR7ffbTwQ52gH/cT3sJa7XUrmlNdVe83QCjde+7Yg
         T+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRgcxqpC2efMEL9W8jlRcgPY7vIoCAo/VNXdd6tUD/w=;
        b=tXrbDrPJpm1aLf59Twj2mJJjFc7mVnWkKOhDKIcqZOZPMwmXgo72dky8Waf2dcD8jP
         8lNPhxDJ/m9Yxu2rruN6svUE0rL+aKHnumh9rNTJlQ8OzImAjg30M1x9oxeGromBVwFF
         4Sisy0L1M2KRTXrFUtJ5cyXUMx7vlZlzTSCW7+nZoVNHHp0fmn48yZ3EM98QjsQuicfH
         0sqz8MDSJPqrJiFfnmEn8vLbDUKV4MBWw4V3ovOsYPiN7jfTSiYw8/bCMY4Sd/ulSdjo
         HEYR1e38T1RK4h5MQ+KDYXmOQccC4cd2SIe3yMgp/VXIQE46bvHBun0p9vNAB+Kh7XEW
         iWtQ==
X-Gm-Message-State: AOAM530n7yQP88skKGy/eQzbMjT6Wusts76lMvd+09F+nAGYOphENkNM
        dnsMHQgV5Gvn4Q6fBbyVNy+zcP4xVliBKb0HRX5B9Q==
X-Google-Smtp-Source: ABdhPJzMUvQrkFMEjrfp8LRYvyTBsCuddDFCT+waMKo1jgBz4Wt7ZWjJF4QB3D9+HFdpRZnnJr+TalY0EQoSXwre8zo=
X-Received: by 2002:a5d:5712:: with SMTP id a18mr15195681wrv.184.1596467713900;
 Mon, 03 Aug 2020 08:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200803143231.GE2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200803143231.GE2674@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 3 Aug 2020 08:15:02 -0700
Message-ID: <CALCETrXhgmkRNaZq9QFWjVVYiX+t=ML_e-oDw2PPEFxQdoA+6Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool,x86_64,paravirt: Add pv_ops[] support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, mbenes@suse.de,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 7:33 AM <peterz@infradead.org> wrote:
>
>
> Thomas wanted paramuck vs noinstr, here goes. Very rough, very nasty,
> mostly works.
>
> It requires call sites are the normal indirect call, and not mangled
> retpoison (slow_down_io() had those), it also requires pv_ops[]
> assignments are single instructions and not laundered through some
> pointless intermediate helper (hyperv).
>
> It doesn't warn when you get any of that wrong.
>
> But if you have it all lined up right, it will warn about noinstr
> violations due to paramuck:

I certainly agree that pv_ops is mucky, but could you expound on
precisely what this patch actually does?  On a very quick
read-through, I'm guessing you're complaining about any call to pv_ops
in a noinstr section?  But maybe this is only calls to pv_ops that
aren't themselves noinstr?
