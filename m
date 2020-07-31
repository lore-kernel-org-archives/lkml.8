Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C9DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244F921775
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5qSEmko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgGaBV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgGaBV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:21:57 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9FFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:21:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v21so14278326otj.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WhCSkMbJs+BIgp6gsZopFGoFqV6gwEHPHN197f+fHXw=;
        b=J5qSEmkoxPyRKsnwzDMkVy2jWwMJUfSbD8cEq3Qk+H5OHZTfEVpiBMc1Dora2PkQTt
         3nA6g8XZVREicL4c+ym12YbHp/t5ZCQECm5BUQ4yxrQ6HGSb2YreWauJOlzwZmcg24HS
         8GXvDZ0kGYdfeJq2zY+Tr57vuI2zHIUABrjGZp4nuAulzVukth4rBpe3VGD42kSO71jp
         ztNiQycHcIXzlmXHBnyYWa49oFYmVGfYyGrbQDKKZczaxzy4mC7gE0GsogHqw6zBCpr1
         LHJX6UG5vcBeZsgB6an0ua/5b8WxokI+m7DbhlQa9ChbT6tQb6OLA2usMsjhdDNUjsTJ
         jXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WhCSkMbJs+BIgp6gsZopFGoFqV6gwEHPHN197f+fHXw=;
        b=nm/Uo5rFdDfs16rS6zY7QwAFE8AFC92hJLonpKo5h5CcQVufA1RligBr8tiqMUqaK3
         WKYKkvxqlbPzUdAp2UGpEYGt/BqVhsuPPb9pRrcmzrUtNV1Xu0xzqLjYq2Yu/xboH1sD
         NxNhAdPe6ACcfkd0Qt4pPHTVju0tdr6UV4AGnP7qgK4OLeSph19OfSrBTmBHQVPn3aW4
         artdNkbfm2BqFMKnCoaQot0vCXmi2aE+MIvLhuDuskPpTzHjWvjGN7FSYKN4XXr22Jr8
         L9zCgssADmWVPwOK+LLqGxE/l9V6sey6+3epn/VN/Zer6TEnZxmobLIvz0USxV3waxAP
         VAuA==
X-Gm-Message-State: AOAM531hafes2k9MOTs8qxH1bOTPeSt5tVLSrWa/clp7MEzSrbsyYV+Z
        xbBorJ01XTK9X1JAFnh9IMM=
X-Google-Smtp-Source: ABdhPJxXO+IkVsgpc+8vFcsgkgtc3AwIYa5p+xgFZ1TRYgAl0p+r15Jb6EiVFZcTXcFDcvFvlB6dfw==
X-Received: by 2002:a05:6830:14d4:: with SMTP id t20mr1097641otq.166.1596158516190;
        Thu, 30 Jul 2020 18:21:56 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([2601:284:8202:10b0:5917:9d89:e57d:b88d])
        by smtp.googlemail.com with ESMTPSA id 92sm1124053otg.32.2020.07.30.18.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 18:21:55 -0700 (PDT)
Subject: Re: [PATCH 0/6] perf tools: Add wallclock time conversion support
To:     peterz@infradead.org, Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730221423.GH2638@hirez.programming.kicks-ass.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
Date:   Thu, 30 Jul 2020 19:21:54 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730221423.GH2638@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 4:14 PM, peterz@infradead.org wrote:
> On Thu, Jul 30, 2020 at 11:39:44PM +0200, Jiri Olsa wrote:
> 
>> The patchset is adding the ability to display TOD/wallclock timestamp
>> in 'perf script' output and in 'perf data convert --to-ctf' subcommand,
>> so the converted CTF data contain TOD/wallclock timestamps.
> 
> But why? Wallclock is a horrible piece of crap. Why would you want to do
> this?
> 

Same reason I brought this up 9+ years ago: userspace lives on
time-of-day, and troubleshooting is based on correlating timestamps from
multiple sources. To correlate a perf event to syslog or an application
log, we need time-of-day.
