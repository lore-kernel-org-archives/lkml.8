Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94D1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896A220724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbtT92jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbgFWJZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731996AbgFWJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:25:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:25:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so547425wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q25Robvc8p0VCT45Ku6+CqjX7ikyGj3nKC2Rkm2Sa7U=;
        b=MbtT92jRqhblgP01XYQ289lWx/8/mAZpF2odAygIsMJx7tzVhKf77HPio8ytt2Nlrj
         mz5Hd4SfeetgCbA7EMe00zMQnfEt1VnV895LdA33HSMDUUOhUIvqmY8Baws3UdibTvA6
         Htnjr127Ypdcinq7hAOrpTvgfRiWXrgmo+DATS8V0nsXZRbjyjq0R3I2H/NzzFQ3Qp+g
         tkJgvtIm44r4BqDzPXQwuKHCHw7uGgia3CYyzKlkG6g0jbtx3gIplFyjg/or6P3+F7ng
         yY2DOK4V1zSG0QoAcANXRGjw3nZSAqiNLi/B+R2QuoBPixfWCoBJRUVb3fF0h0BhgInm
         Sn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q25Robvc8p0VCT45Ku6+CqjX7ikyGj3nKC2Rkm2Sa7U=;
        b=O65eLtqM7ZTReE2U9b2kB8Fgv+D4UtzoUPfA03XplwebWG120S0AsPrU4yG7XSEHHz
         N3lNCVqnblw3z8b5pbn5Z3utwqaL++eaGzARJnpNsjjk0aaVOFobcBxtEtSBO8t1hU5f
         WAkFQmNzy7V7SIeVfLCizBX6DSPpf7QzcXN8cbZF6as+29fOQ3+IxlMATzkqEwejALrk
         2VBrG12dMBYuC9Kczv0olpUmknZLkZrHRn5eypiuvauVdbcU2OQa4KGO/etz/Y/nqwkM
         bbGomcNDYtkZ+UnNheYyqtiOaxvv0touQDFEoKvU8yrOwi0Uab/LWtXtcpKOMg0O200x
         08hw==
X-Gm-Message-State: AOAM532p7OTK0V/ZG9SwNMF19yR7YO1I3WwnQZtFFDnA2yh3vMpN/WYr
        6kzOZ6vjPTCAY4soCkF18v37JA==
X-Google-Smtp-Source: ABdhPJyl/Wvp1EmPvPKbYZpgmTNv8myFw0amWQE5G3nU/EjHi1cPOLHWOuSUY3bGl4PIoPk41iA8jw==
X-Received: by 2002:a1c:9896:: with SMTP id a144mr22578733wme.75.1592904340254;
        Tue, 23 Jun 2020 02:25:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u20sm2789618wmc.44.2020.06.23.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:25:39 -0700 (PDT)
Date:   Tue, 23 Jun 2020 10:25:36 +0100
From:   Quentin Perret <qperret@google.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, viresh.kumar@linaro.org,
        arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        tkjos@google.com, adharmap@codeaurora.org, lkp@lists.01.org
Subject: Re: [cpufreq] d83f959b5e:
 kmsg.cpufreq:cpufreq_online:Failed_to_initialize_policy_for_cpu:#(-#)
Message-ID: <20200623092536.GA52234@google.com>
References: <20200615165554.228063-3-qperret@google.com>
 <20200622005457.GI5535@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622005457.GI5535@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the report.

On Monday 22 Jun 2020 at 08:54:57 (+0800), kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: d83f959b5e7a6378a4afbff23de2a2d064d95749 ("[PATCH 2/2] cpufreq: Specify default governor on command line")
> url: https://github.com/0day-ci/linux/commits/Quentin-Perret/cpufreq-Specify-the-default-governor-on-command-line/20200616-005920
> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> 
> in testcase: kernel-selftests
> with following parameters:
> 
> 	group: kselftests-x86
> 	ucode: 0xdc
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> 
> [    8.715369] intel_pstate: Intel P-state driver initializing
> [    8.721146] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 0 (-61)
> [    8.728900] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 1 (-61)
> [    8.736615] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 2 (-61)
> [    8.744400] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 3 (-61)
> [    8.752222] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 4 (-61)
> [    8.760010] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 5 (-61)
> [    8.768077] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 6 (-61)
> [    8.775891] cpufreq: cpufreq_online: Failed to initialize policy for cpu: 7 (-61)

That, I think, is because of the issue I reported here:

    https://lore.kernel.org/lkml/20200615174141.GA235811@google.com/

The v2 (to be posted shortly) will address this.

Thanks,
Quentin
