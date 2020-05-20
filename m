Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DED20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="WDGtbCVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgETAGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgETAGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:06:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430CDC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:06:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r22so585025pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqQJphs4dbH8l1OCiHVqe97WM4gwnpKo7IbEOxUcuq8=;
        b=WDGtbCVBE8fAUQyK7b2ulxbQd5NoTpIwjwmAiZ+xjWv23qgDFYqB+n3uEENMJF4evR
         eQybQUIovab5oL9uP2JzO7/swZQR7Lac/N+9LuMDnYRN/vux1dRM8Ai+UvXrMQDNSXds
         giu/CUiz0LCzZo+rFtSn5hr/VzyiBazjBkDWxSalBmaM+kZsF/jtgZp30ifXQT1tndDm
         K+cmlhk0mNBeLKQKLjGb4kejQKR5OPHQmKhNzy3M33KYeBeHFzFAx78BBq1Ia0Aqb/q7
         iy8kDskGmclrjdQEtx9kzAivf9ZcpoqlwCE0HuGoG13qLjJvN7c+Be8TZbWz/AnWavDM
         W6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqQJphs4dbH8l1OCiHVqe97WM4gwnpKo7IbEOxUcuq8=;
        b=nSGcnpyt/xvM1eDBFuVLPjdsVlwUNWdYYP/d3gdYJhk3ngwoIWHgzAA4TbnYKJupvz
         gJ3M+9jdqzwQm9/4NDUQtNjw/M6vJpvhs1ZnFN9Yuf0tHeamaXt86DzD/edjm0G9wk6M
         P51AUuqhwsFrYqRXJQ0Lqtm0B69EB1NQyGmI4p7cVafKWs+6s4gPUuUsaYVmi4gAsLAV
         FPZjKmdmkqJAmWrUM2MHmmZtoZktaJG5QNXxwK2MRrb139yvJhXAypU3EVlbdDgcZKGT
         v2Md7PpNabue+1cKVHm8979eMlx0ggxgSaGdT6D0P5V5LdkM3F8BnpS41lRV+aXcPHQa
         TN7A==
X-Gm-Message-State: AOAM532sT/h8ky1KqfjaXTbVSXvcil+/xqvdwdyyKOcoZmXqeMT8h+W9
        pBvpk6meNGWdKhCq7Vb15AgaBA==
X-Google-Smtp-Source: ABdhPJxROAqekSmuMlHLMi/sAPCSy2KV5BTqjcZH0X10PmVEw2MHWo2h4USoKLaDBzISBwMyAVnWjg==
X-Received: by 2002:a62:1cc9:: with SMTP id c192mr1482493pfc.197.1589933205590;
        Tue, 19 May 2020 17:06:45 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id v1sm452386pgl.11.2020.05.19.17.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 17:06:45 -0700 (PDT)
Date:   Tue, 19 May 2020 17:06:37 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 01/25] net: core: device_rename: Use rwsem instead of
 a seqcount
Message-ID: <20200519170637.56d1a20a@hermes.lan>
In-Reply-To: <87lfln5w61.fsf@nanos.tec.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
        <20200519214547.352050-2-a.darwish@linutronix.de>
        <20200519150159.4d91af93@hermes.lan>
        <87v9kr5zt7.fsf@nanos.tec.linutronix.de>
        <20200519161141.5fbab730@hermes.lan>
        <87lfln5w61.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 01:42:30 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Stephen Hemminger <stephen@networkplumber.org> writes:
> > On Wed, 20 May 2020 00:23:48 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >> No. We did not. -ENOTESTCASE  
> >
> > Please try, it isn't that hard..
> >
> > # time for ((i=0;i<1000;i++)); do ip li add dev dummy$i type dummy; done
> >
> > real	0m17.002s
> > user	0m1.064s
> > sys	0m0.375s  
> 
> And that solves the incorrectness of the current code in which way?

Agree that the current code is has evolved over time to a state where it is not
correct in the case of Preempt-RT. The motivation for the changes to seqcount
goes back many years when there were ISP's that were concerned about scaling of tunnels, vlans etc.

Is it too much to ask for a simple before/after test of your patch as part 
of the submission. You probably measure latency changes to the nanosecond.

Getting it correct without causing user complaints.


