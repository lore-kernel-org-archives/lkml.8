Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211DC35673
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADA2206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7XZxJNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBVUTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:19:18 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46909 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgBVUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 15:19:17 -0500
Received: by mail-yb1-f196.google.com with SMTP id n131so2609879ybg.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 12:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WADuPIsDeqMiQa1Kjwh+f+e8DqndWx2oX6/Mg9I/9FQ=;
        b=T7XZxJNA4YA5IOsFqpzb6HvCN2gxktbCdUmDyPbIOdKnrnhNFRmEw7jgISUU5LC5Di
         7GI1N4QC4VvnC6G/FL5192ZcK9lmedR91U/qFHxBfE7rByQu6qqZVqEZZUWrpTzl3a/Q
         mIpnx7basOylgJwZP5kGW4p4vv86mOr+QGetSJ5zDbhVDeRr8AVTLJOF1gqXbzW0EloT
         sqCjEKNe2S8AFHjet3hxBW5nr2f3HevL0HdAu2lu8qfL7YbTFomT1uo7POxFb6gKGC6g
         HXtMQuG5+6ds0oktE6iVDqUSxR6rB1JGxgsu9rami87FlW+JCsIkJ2UTqyzmbgiSJVQq
         Oo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WADuPIsDeqMiQa1Kjwh+f+e8DqndWx2oX6/Mg9I/9FQ=;
        b=B5njESelIGgIG2tc0M6W2OAFlBW+EfeDFzRewNU6iZeqLZGXXEo0z+XtQoJHpVGXsg
         z3SMSL6iywscOjoNmEppAYPF6YiYT+k2//GRypJE2oArxPPRq6xuDcQ0BxHRfGRjtYSQ
         xlzV4mnQ0jBwp07BFu7CiuZD7Fn0fqXelJMsONP+rzQ02NjWSkJGiIfWp9WPtRMMNEFo
         e1oHsVY7m4YJGLrqdebR9KhmXIbkB7Z0Lw9+BC6Bzpg1qwKewKJ3I2cZdUpmwExDuTsA
         1F2YR6xTsKIMLbldc1E03uUrIP62NTRsOEbUs3HUul14eLgkWRgp19GhqIVRylWTULrO
         /jbQ==
X-Gm-Message-State: APjAAAX99v1BScCZgomPLtdReRSpzz6lbTag5AlNHHBKy91niNZvrcSH
        I6Iw2FisZnIcSOR592JuUsLli07pjpo=
X-Google-Smtp-Source: APXvYqw8UbwB9mLrmC64ZWh7JV539oXFeK63+2Cql7DQdHyBy/BKJUnqUhOYnVVTqxvBVmFmw5Cc4g==
X-Received: by 2002:a25:cd46:: with SMTP id d67mr18225521ybf.70.1582402755848;
        Sat, 22 Feb 2020 12:19:15 -0800 (PST)
Received: from localhost (c-75-72-120-152.hsd1.mn.comcast.net. [75.72.120.152])
        by smtp.gmail.com with ESMTPSA id x184sm2979879ywg.4.2020.02.22.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 12:19:15 -0800 (PST)
Date:   Sat, 22 Feb 2020 14:19:14 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/191] 4.19.106-stable review
Message-ID: <20200222201914.l5fdb4xcxrcphfhv@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20200221072250.732482588@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:39:33AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.106 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Feb 2020 07:19:49 +0000.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.106-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 27ac98449017eb9c569bcc95c65f29ca3948148f
git describe: v4.19.105-192-g27ac98449017
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.105-192-g27ac98449017


No regressions (compared to build v4.19.105)

No fixes (compared to build v4.19.105)

Ran 29020 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ltp-cap_bounds-64k-page_size-tests
* ltp-cap_bounds-kasan-tests
* ltp-commands-64k-page_size-tests
* ltp-commands-kasan-tests
* ltp-containers-64k-page_size-tests
* ltp-containers-kasan-tests
* ltp-cpuhotplug-64k-page_size-tests
* ltp-cpuhotplug-kasan-tests
* ltp-cve-64k-page_size-tests
* ltp-cve-kasan-tests
* ltp-dio-64k-page_size-tests
* ltp-dio-kasan-tests
* ltp-fcntl-locktests-64k-page_size-tests
* ltp-fcntl-locktests-kasan-tests
* ltp-filecaps-64k-page_size-tests
* ltp-filecaps-kasan-tests
* ltp-fs-64k-page_size-tests
* ltp-fs-kasan-tests
* ltp-fs_bind-64k-page_size-tests
* ltp-fs_bind-kasan-tests
* ltp-fs_perms_simple-64k-page_size-tests
* ltp-fs_perms_simple-kasan-tests
* ltp-fsx-64k-page_size-tests
* ltp-fsx-kasan-tests
* ltp-hugetlb-64k-page_size-tests
* ltp-hugetlb-kasan-tests
* ltp-io-64k-page_size-tests
* ltp-io-kasan-tests
* ltp-ipc-64k-page_size-tests
* ltp-ipc-kasan-tests
* ltp-math-64k-page_size-tests
* ltp-math-kasan-tests
* ltp-mm-64k-page_size-tests
* ltp-mm-kasan-tests
* ltp-nptl-64k-page_size-tests
* ltp-nptl-kasan-tests
* ltp-pty-64k-page_size-tests
* ltp-pty-kasan-tests
* ltp-sched-64k-page_size-tests
* ltp-sched-kasan-tests
* ltp-securebits-64k-page_size-tests
* ltp-securebits-kasan-tests
* ltp-syscalls-64k-page_size-tests
* ltp-syscalls-compat-tests
* ltp-syscalls-kasan-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
