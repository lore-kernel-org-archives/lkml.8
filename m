Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA0C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47892206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585989427;
	bh=BOEF89PmLtxWItJ4Ac43lz43W+BauK1mhsW9EBH4E+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=td0+M/kBTb7cUj2zj5BSKR+uEjZZPTyuDlf10tNyleLGWJ0VZyv1HdCD78SL4I5KN
	 1LlC6GqFf1gNTZodbK8yMTL7E7ZY/NdH3gNTmzwkzCQ5fJRvuPCxO5HLFxQSwZLHyB
	 AdCAl8IKLsa1UvniSB6fQXFB3AhPwEqgb3j2xne8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDDIhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:37:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42582 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:37:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so11238909wrx.9;
        Sat, 04 Apr 2020 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2IKLP5+Lnpj7TErBDUZEt4b8eOSvt+6KEofztKrAcwY=;
        b=X7Ch2DXO3Vt+7MyyHIh+a3vlUqdkg1RHVW3Sbq4lmCCfZQ9jniOjraj2m1hPGOYVT1
         JjKtiC9va3+NzEH012CJMDgR4LEty+Dpb4A8rgThQ3OZb7DWBeBfsN1EvB7o1T+ctd9l
         7bWmClFRip6/+4/23VPhdmDQD1duXWg7rWS5nInsChQzYSpLGEI2IPk+whyoH0bRBviI
         7p50GjQQhueCwnJZLIc/P2Hukc0zcfaSuRGzlXFuD+hNfIT99AtOB1YM84VNVOEbgjRh
         oX/PtyCqpibSYdiD2QYUDxvpOJQ7CT9UTN5/songCW+2IgWYVueroZtUT0CM7NUy1vUN
         Giqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2IKLP5+Lnpj7TErBDUZEt4b8eOSvt+6KEofztKrAcwY=;
        b=QeN++dStTAWfkwQD1K15Kz8XVl4kD5bfZtr8LEObdnxXyG3KuNyqGOYnmIUQ9JeAPw
         nMcAg3f3/1JQkANwfXXwEZ0jtjKiVOq4OW9jfcVWaJ/i+AC5QLigB1ETghhVKlqXMur9
         EwrKrVm9khys8tvWXlqkAyGSFbFb7TrJgoUGmuiX7m+c/yOordtjm/TaS5JMa7MN2Ogu
         6ZqCSlTnSq+Aw4LDRbmx2N3ZBIfTwwfI9H8u4TGhr001pzkHjZGyd7KkIn8kIvXvpM/y
         yS3a3KU1xCnDXNEJWh1EGnwGfrCTwaipN93oVFkUrosPYkriresqlQpRiRwHm32pezNs
         OcdQ==
X-Gm-Message-State: AGi0PuZ5qQx/2kzLd1U8Aj+nQdAK7eoqnIrSuZfamwGPkiUdIE2jt4zw
        k1x1C4klIM0gSzKHmKdryYk=
X-Google-Smtp-Source: APiQypI6aFybBTSdjK5ZWlsQCIR0Vy7jv9JUIHPlRJzjVfdqwMoVzIHWJQCcbA/pukLqSxvE6Sxqmw==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr10475315wrv.11.1585989423608;
        Sat, 04 Apr 2020 01:37:03 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r9sm15541004wma.47.2020.04.04.01.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 01:37:02 -0700 (PDT)
Date:   Sat, 4 Apr 2020 10:37:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        kbuild test robot <lkp@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sam Lunt <samuel.j.lunt@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Jones <tonyj@suse.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes and some improvements
Message-ID: <20200404083700.GB21353@gmail.com>
References: <20200403145443.24774-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, this is on top of a previous submitted
> perf-core-for-mingo-5.7-20200325 tag,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 0d33b34352531ff7029c58eda2321340c0ea3f5f:
> 
>   perf dso: Fix dso comparison (2020-03-24 10:57:38 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.7-20200403
> 
> for you to fetch changes up to 9ff76cea4e9e6d49a6f764ae114fc0fb8de97816:
> 
>   perf python: Fix clang detection to strip out options passed in $CC (2020-04-03 10:04:59 -0300)

>  68 files changed, 1376 insertions(+), 78 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
