Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32785C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F7220659
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5L5JtKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgFDUOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:14:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33016 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgFDUOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591301657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfjJTqzLy4RB96gNpe7W2IyNFqvkTW8Rkb74loa30+g=;
        b=b5L5JtKLbASqoGpCQ3Y3XBnYCiTGjywYalTFv+OcHXDt9/QAKJwf/55ggolqH1eZkWcikJ
        P1U4fpFDCoWPcAvIQTuUi2hSxmXScMyx2RHKJ2I87fwhRTGo5LTgNrYRfxw5h0gw/vJDvE
        OrJX/BdkeXkKBHp42MGdiubIDzjOFf8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-C5ORKRHXPvK5mUGI4zLgTg-1; Thu, 04 Jun 2020 16:14:15 -0400
X-MC-Unique: C5ORKRHXPvK5mUGI4zLgTg-1
Received: by mail-wr1-f71.google.com with SMTP id h6so2875894wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nfjJTqzLy4RB96gNpe7W2IyNFqvkTW8Rkb74loa30+g=;
        b=eWpovRtOspd0CF0ElSNDGYk8euHf6xqQ22WWFr+PwtmntaYS4qnexhD6vrYcJcyTpW
         KHI5k0Tfn38zvHxZDwcOU859jb1cAfnfJR1tqh3cgs22DQ5PHFbsv4gjFdKxzmJQUlys
         pmF+HDC7y35AoaLeHr9f6IFY/R4YsaDVGXbChxTUPLXYg25y+JX46WR7PA/H3Xnm7NAK
         Ra52imkNXYR4bqBqnXd297W428PgzQvh15gAhBH4SOprLnbTVMV7bEx6Jyc+sDQbT2nv
         O9o9Dlf1y+FlN+Jw9MGS6q0MK6GXNlkQmH6nPWJAE6YIyJTUqNhBUjpmDheMrQyzoNxD
         qiYQ==
X-Gm-Message-State: AOAM532DAzmQDtVexvcUF5+PrrcjjY5l0qKOyYRLqIeWLVwwIAnqm35T
        mlQkn90vQ393nXK3Zannq9UJNb4FwyaHTpXoHzncuJyVfnVZ89+IwcvmzEl61QzBEhyyS2aWfGt
        opsaTwa7PfU466dCkNtghNtiY
X-Received: by 2002:a1c:143:: with SMTP id 64mr5868251wmb.182.1591301653819;
        Thu, 04 Jun 2020 13:14:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLHVFWDumGFiXykNBmg7FRXYUzyB+TNWC5L35KaMz1P9rEjS+HApHOpLXnjqNudr2XW8Rj7g==
X-Received: by 2002:a1c:143:: with SMTP id 64mr5868239wmb.182.1591301653533;
        Thu, 04 Jun 2020 13:14:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id l2sm9072625wru.58.2020.06.04.13.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 13:14:12 -0700 (PDT)
Subject: Re: system time goes weird in kvm guest after host suspend/resume
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kvm@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <87pnagf912.fsf@nanos.tec.linutronix.de>
 <87367a91rn.fsf@nanos.tec.linutronix.de>
 <CAJfpegvchB2H=NK3JU0BQS7h=kXyifgKD=JHjjT6vTYVMspY2A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a1c32fe-d124-0e47-c9e4-695be7ea7567@redhat.com>
Date:   Thu, 4 Jun 2020 22:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvchB2H=NK3JU0BQS7h=kXyifgKD=JHjjT6vTYVMspY2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 21:28, Miklos Szeredi wrote:
> time(2) returns good time, while clock_gettime(2) returns bad time.
> Here's an example:
> 
> time=1591298725 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> time=1591298726 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> time=1591298727 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> time=1591298728 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> time=1591298729 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> 
> As you can see, only time(2) is updated, the others remain the same.
> date(1) uses clock_gettime(CLOCK_REALTIME) so that shows the bad date.
> 
> When the correct time reaches the value returned by CLOCK_REALTIME,
> the value jumps exactly 2199 seconds.

clockid_to_kclock(CLOCK_REALTIME) is &clock_realtime, so clock_gettime
calls ktime_get_real_ts64, which is:


        do {
                seq = read_seqcount_begin(&tk_core.seq);

                ts->tv_sec = tk->xtime_sec;
                nsecs = timekeeping_get_ns(&tk->tkr_mono);

        } while (read_seqcount_retry(&tk_core.seq, seq));

        ts->tv_nsec = 0;
        timespec64_add_ns(ts, nsecs);

time(2) instead should actually be gettimeofday(2), which just returns
tk->xtime_sec.  So the problem is the nanosecond part which is off by
2199*10^9 nanoseconds, and that is suspiciously close to 2^31...

Paolo

