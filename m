Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7106EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500FF20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNY2SIEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbgFWSEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:04:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:04:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so9046379wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMyNyMJgXdnDE8dwyWtDRLMYZCApSGZoNnTanpCNMz4=;
        b=DNY2SIEqqg213W0g0T1faTmSZ6dBln1UGUK/rijjLxojRCce8hOkLkT+7v4hj73zxJ
         sb2tRMmbp/i2e+0YWsaATQ8zHIWcg2fKZ6Nkj98z5IqY4QNWEDB2mXz69DefkTZn8xx0
         FeWJgsHgkrrDXtkKrEGdm43P3iVhP6zUmtFMxIZDY9weu3Y+eiW5W/nLqhNHdLUhhGoD
         gnT8dPQAcBuRixz5P/BDF6r+WZwVkxThIhMJ0C6qrV5qKzK0IdyZA8eI3ePdYLTX85ag
         0VMr8Sd92U4n19cJ329Sa1NO3O8kWQbPK1I2kMJWRv6SdeT1aDYNTxs0NrmQoa9c0SiY
         dQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMyNyMJgXdnDE8dwyWtDRLMYZCApSGZoNnTanpCNMz4=;
        b=Dabc+48pRZXhKZeTcAa+5XVk4ZgeRJYPy3V/og1D1vFeAOBCYDc8RnNO0YRPxh9hGb
         oaFvhdfi6hoNG9ZfPuQzCk0+gH9RzHRNk/Gj1KnP0YDxhtZ8oVeGKBj6i8SCNYON3Fxk
         TuKnW+XdpvePyTCMgBVnnfOd8C1hSQB+jNwhZcc2mArCnP69//VuPB3VRWoIKr4Ws0QY
         2cKO2EBhB4Rj3vYL0Y83r2EWqFuCwotng9fi4H0HquQ1EPaRIBlq6v3YZljcxGbQNN6f
         MlAFxLJ70hXMlUTBtuyCoFUHHZJf5xX6eHstw+J1es6gpDyEaAAjMGpVT9v7p7DDaTrz
         yifA==
X-Gm-Message-State: AOAM532opFu3g+816pJtwThvYmOxpnhBhTPGgVsorj6vjpigOqdeqp7E
        dpRwsYAvu1Qpg64p6WGz7pwXQRHKqgakew==
X-Google-Smtp-Source: ABdhPJzf8QrpXcRaMKR0n1A2i2w8BDw+Gir+VgL42qsH/jZ2RAO6SqlzOQkuQuN1npWj+Lpo2pMlsg==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr23887574wrv.289.1592935481174;
        Tue, 23 Jun 2020 11:04:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id i17sm17528076wrc.34.2020.06.23.11.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:04:40 -0700 (PDT)
Date:   Tue, 23 Jun 2020 19:04:37 +0100
From:   Quentin Perret <qperret@google.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        tkjos@google.com, adharmap@codeaurora.org, viresh.kumar@linaro.org,
        rafael@kernel.org, rjw@rjwysocki.net
Subject: Re: [PATCH v2 0/2] cpufreq: Specify the default governor on command
 line
Message-ID: <20200623180437.GA248517@google.com>
References: <20200623142138.209513-1-qperret@google.com>
 <002201d64987$5dc93b90$195bb2b0$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002201d64987$5dc93b90$195bb2b0$@net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tuesday 23 Jun 2020 at 10:54:33 (-0700), Doug Smythies wrote:
> Hi Quentin,
> 
> Because I am lazy and sometimes do not want to recompile
> the distro source, I have a need/desire for this.

Good to know I'm not the only one ;-)

> Tested these two grub command lines:
> 
> GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 consoleblank=300 intel_pstate=disable cpufreq.default_governor=schedutil cpuidle_sysfs_switch cpuidle.governor=teo"
> 
> And
> 
> #GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 consoleblank=450 intel_pstate=passive cpufreq.default_governor=schedutil cpuidle_sysfs_switch cpuidle.governor=teo"
> 
> And all worked as expected. I use Ubuntu as my distro, and also had to disable a startup script that switches to "ondemand", or similar, after 1 minute.

Good, thanks for giving it a try.

> As a side note (separate subject, but is one reason I tried it):
> My i5-9600K based computer seems to hit a power limit during boot approximately 3 seconds after kernel selection on grub.
> This had no effect on that issue (even when selecting powersave governor).

Interesting ... Could you confirm that compiling with powersave as
default doesn't fix the issue either?

Other question, when does the intel_pstate driver start on your device?
Before or after that 3 seconds boot time?

Thanks,
Quentin
