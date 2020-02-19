Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB4EC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AD2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582127266;
	bh=dBGpk8COWykA2HKIsIUCWVEXJBH0+ZiIy7I2ni2qit4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rzFOemoGA5qUyuxrfinbURzx70uMP1Kx8lRJM84j7auHNsUQeJGEo6dOkCKSbfD1+
	 zTx9m4Mx4dGpgyL7hdiOFNv99Er14esMXvA7zTzALYh34llLGDmvsCB+pw1wwo0Kaj
	 TaiuscnuYPqG/3+LjOQIlvjl9Enwng2+SOePc3eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:47:45 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:44596 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgBSPrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:47:43 -0500
Received: by mail-qt1-f172.google.com with SMTP id j23so496999qtr.11;
        Wed, 19 Feb 2020 07:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ar2wlN6dePLPhoLZZdzWfBNN9k6fU+94pITjgWF6huI=;
        b=sclZeeHgnDkV2FYKT4/orsaaiuStLqZ7oDvYPByVLnhQ45JVzoiKCg9SNfqUizUXM1
         PdKKpACiSBRuyoCuBePSMjBUHNo4RiVhaQpzsZ0g7GEoD+iOQEGeIRwVuOnx3h26J1Ll
         f5WxGv/gxdwlLwPEZh458ue58Eg3YNYlrnY6R/Sku7ouKhgxM9m9fDbsXTYOg9cY3pqZ
         OyfPMBpISOolqyPwsuMfSyNBaRCjilHCmXNoPo5yFAw3iJv73AZ+2e5WTTAsqnTmKPn/
         NyriSK0FpjMHtR07Ra8dLqT9DO+YQCvCmVSBG1mQ8yH0AkBapksPiboe4tPq1PuZCEzV
         R3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ar2wlN6dePLPhoLZZdzWfBNN9k6fU+94pITjgWF6huI=;
        b=LSfTOgjn1GwsFm1IhtzgTe8dTA8Gp6BD6q1Lt3vGquAoSvifKVqfMcznzL03UwaDl2
         pFEXgqak5EB5Gv4gqmxzc3r9ftqIbC1BOHzkg8ylB/FPYUsllKAiN8LpFenqGd8MmMzf
         VvONEStyH3OEn5qqRgbZyopq5b6+710HDNEqkr9HwZQ1xVfsoBb+EKYNrR6lXEVpfTx9
         V0998M/FrJXG6rwCxNzv/UmOv2YK0YrZZgCjVPIjYYrmYDbPchypxOhblmcLmoTW4DuS
         3d2wC2XMj18EIECxW5u8nuqeY8G8HBiulcR2b2lW78wCRTcM6ZdnhH9KnVWllpY004yU
         TIIQ==
X-Gm-Message-State: APjAAAUax0nOPIdurs47bvYYmnMuFUPia/J6hA4oh4uVStu+kkJPDrtL
        mx67GgnTHqjDWAaZbTC0epg=
X-Google-Smtp-Source: APXvYqxiGhWxAr3upotVXemfaiuWz84Txa2Lq+b0+qGHZn+DYTYAHiXZHToFua0j8OQIpcpsuftSGw==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr22727495qti.228.1582127261138;
        Wed, 19 Feb 2020 07:47:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:e7ce])
        by smtp.gmail.com with ESMTPSA id i28sm183939qtc.57.2020.02.19.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:47:40 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:47:40 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
Message-ID: <20200219154740.GD698990@mtj.thefacebook.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
 <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com>
 <20200219151922.GB698990@mtj.thefacebook.com>
 <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:43:05AM -0500, Mathieu Desnoyers wrote:
> The regression I'm talking about here is that CONFIG_CPUSET=y changes the
> behavior of the sched_setaffinify system call, which existed prior to
> cpusets.
> 
> sched_setaffinity should behave in the same way for kernels configured with
> CONFIG_CPUSET=y or CONFIG_CPUSET=n.
> 
> The fact that cpuset decides to irreversibly change the task affinity mask
> may not be considered a regression if it has always done that, but changing
> the behavior of sched_setaffinity seems to fit the definition of a regression.

We generally use "regression" for breakages which weren't in past
versions but then appeared later. It has debugging implications
because if we know something is a regression, we generally can point
to the commit which introduced the bug either through examining the
history or bisection.

It is a silly bug, for sure, but slapping regression name on it just
confuses rather than helping anything.

-- 
tejun
