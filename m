Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C707CC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6EB21473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVRnZ43L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgDXOKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:10:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47133 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726959AbgDXOKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YISBwJYsavRufK2YVlZv26rC95P8RMJPnrWfPZRnJTQ=;
        b=YVRnZ43L5YmTaW7I41O8qp6XaI79ckeR+xYz1blNslp4wA7CrYPrGP30loWmz58otk/fI7
        1B7u74BwJddA99HkfEZJ3i8WJmcwwvoy0rvq94nRYC0nMtOPmkSwXSR0unn+Il1+yopNWp
        SWpVm9h4kgAlApcFPigPGHlwUSFw8ZY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-_6RJhafPPmWja1K4lUW7fA-1; Fri, 24 Apr 2020 10:10:31 -0400
X-MC-Unique: _6RJhafPPmWja1K4lUW7fA-1
Received: by mail-wr1-f72.google.com with SMTP id o8so4363705wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YISBwJYsavRufK2YVlZv26rC95P8RMJPnrWfPZRnJTQ=;
        b=HdCTQY/LLzDwP8yjh3VPnBS3QvUZZ/UL5WjK+e+XgoYSHhXnYoUxjX1RzovCGf8B2O
         uHS3J7IWyUH23CvWLGtu/8d4jaQ0y+HxYaFOWj9WN6kHFk0Jq87QzB4dQhWp/xmM7uH8
         KzpTl5svBOSBnYyg9O1zsviK/LdABNxGDBrMvnDfbYgu4aPL8kezsQV/ZhTVHHgB2TQk
         Sje0dR745ou67R0IA5oaGbGV9Vq7ybgFHjQRA2gLwwtSLyqAzmHq4UMr0xabC0bUoO5C
         NsxSwxrutLDIZkOuvdSK/5SE7r/ZXCzZnqOUJL3/Ukfr5T6VgXaH2mD+rTtuMlnD8mXA
         Dhmw==
X-Gm-Message-State: AGi0PuZJktzgyfqhIjIGE88wUvcLyNG7M7uDENnNX9HAMPvjwfhw5D+p
        lW9z3t+LEYebE8vmwz4C7+tsnmhZDdEmMfsacS4NJ9/K9QryZCthpIOwcBctP+/OAcV0vlelHJw
        sBRjaqHyEhHX5dwZ6w53nQicP
X-Received: by 2002:adf:a543:: with SMTP id j3mr11313251wrb.34.1587737430603;
        Fri, 24 Apr 2020 07:10:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJQcB3BYlHB9guLOfnnI5zPnUKl7YMzf0eGsqOOceN9Y9fuvzHVFQyvSoLgNFYwYq4+FFar5w==
X-Received: by 2002:adf:a543:: with SMTP id j3mr11313226wrb.34.1587737430434;
        Fri, 24 Apr 2020 07:10:30 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c1:12f0:2a0d:3df8:7645:8915? (2a02-8388-07c1-12f0-2a0d-3df8-7645-8915.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:12f0:2a0d:3df8:7645:8915])
        by smtp.gmail.com with ESMTPSA id u17sm9574479wra.63.2020.04.24.07.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 07:10:29 -0700 (PDT)
Subject: Re: [GIT PULL] perf/core improvements and fixes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkft-triage@lists.linaro.org
References: <20200420115316.18781-1-acme@kernel.org>
 <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
 <20200424130722.GK19437@kernel.org>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
Date:   Fri, 24 Apr 2020 16:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424130722.GK19437@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.20 15:07, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel Díaz escreveu:
>> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
>>>>   85 files changed, 1851 insertions(+), 513 deletions(-)
> 
>>> Pulled, thanks a lot Arnaldo!
>   
>> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
>> script: Add flamegraph.py script"):
>>    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
>> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
>> in package perf-python requires /usr/bin/sh, but no providers found in
>> RDEPENDS_perf-python? [file-rdeps]
> 
> 
> yeah, the flamegraph scripts are the outliers, there, everything else is
> using /bin/bash, so I'll switch to that, ok Andreas?

Sure, no problem. Thanks!


Cheers,
Andreas

