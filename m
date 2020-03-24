Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511B920714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+lJZjp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCXTFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:05:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44620 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727672AbgCXTFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585076729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQXiLSPViiwhkM4wrjCnhSuUkI66tAeCX4Yqeo47LM0=;
        b=g+lJZjp+LyJLeuuvP6wBHqmKThWuy7im4rfdRES8k8roCcHmOykCqnJulNQoohHg4V0j40
        4vB8WtAF4ZxqmCZdLI8Ar+x9TKc6JHJ0HujppHz4L5APR1LXtCecS8Hr22uIPpU4k4zFnf
        0TxpbRWYYMLAC0uR/cX83zPA6Y0ioQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-Q97Z_sLmMk2KUfEAlBwzig-1; Tue, 24 Mar 2020 15:05:20 -0400
X-MC-Unique: Q97Z_sLmMk2KUfEAlBwzig-1
Received: by mail-wr1-f72.google.com with SMTP id v6so9581590wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQXiLSPViiwhkM4wrjCnhSuUkI66tAeCX4Yqeo47LM0=;
        b=imIMF8TXbrGbpxMLZleZpKt6tad2i2G0tbJu+qH0MvKvYeUtgIgkcYFNjnrCAmBaUu
         mxIBM7dPCdmWfMInpiUPpaI88NUaCOqsX4Oa+nqWXlOyUiBj3iNFO5XOIRAmmdcB2BKw
         AEU64wiXfYAjo3VFUJOsdiXLVvrsi902CsJ29O4onEOYvh79RHGDPwuUs/WQ2/sPyW/q
         03HTDtbT1maRhpjUATYir55RyZxPpZL19jCM9G02YKAfgC9ER7kddD49SRgzJOiVHSL6
         LStTn3ztUE2JgkFw9VULHO89HbfA6lB3CzIJhNufowMXIq5+OZf21WKAphyxoP/2bu9W
         3NJg==
X-Gm-Message-State: ANhLgQ1inGS8+bbgiB/oVZHPF9Fpc8NJ1D9cSVtjog2Ky8IUWN157ce7
        2dQ34lYSZghxlijeEUmmN7fOVArvdd0Qxi7mB10NvY6BlUrI6+1wp+DPvpvGSf3ykOAH+cLujAM
        y50zj2hq3RAwedDT1IFm0c5Wf
X-Received: by 2002:a5d:5512:: with SMTP id b18mr37873109wrv.215.1585076718694;
        Tue, 24 Mar 2020 12:05:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvCwZF8umZimKZ0fX4KBKd6SkdPPDeMQceX7ZFtFqLDzwaX6Tb7PBxq6cohUgvQyzxBRw1sQw==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr37873075wrv.215.1585076718459;
        Tue, 24 Mar 2020 12:05:18 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c1:1280:a281:9dab:554b:2fdc? (2a02-8388-07c1-1280-a281-9dab-554b-2fdc.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:1280:a281:9dab:554b:2fdc])
        by smtp.gmail.com with ESMTPSA id m7sm7785372wro.41.2020.03.24.12.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 12:05:16 -0700 (PDT)
Subject: Re: [PATCH] perf script: add flamegraph.py script
To:     Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users@vger.kernel.org
Cc:     Martin Spier <mspier@netflix.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200320151355.66302-1-agerstmayr@redhat.com>
 <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
Date:   Tue, 24 Mar 2020 20:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.20 17:16, Kim Phillips wrote:
> On Ubuntu 19.10, where python 2.7 is still the default, I get:
> 
> $ perf script report flamegraph
>    File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 46
>      print(f"Flame Graph template {self.args.template} does not " +
>                                                                 ^
> SyntaxError: invalid syntax
> Error running python script /usr/libexec/perf-core/scripts/python/flamegraph.py
> 
> Installing libpython3-dev doesn't help.

Hmm, I was hoping that I can drop support for Python 2 in 2020 ;) (it's 
officially EOL since Jan 1, 2020)

The Ubuntu 18.04 release notes mention that "Python 2 is no longer 
installed by default. Python 3 has been updated to 3.6. This is the last 
LTS release to include Python 2 in main." 
(https://wiki.ubuntu.com/BionicBeaver/ReleaseNotes) - so imho it should 
be fine to drop Python 2 support.

I tested it with a Ubuntu VM, and by default the Python bindings aren't 
enabled in perf (see 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1707875).

But you can compile perf and select Python 3:

$ make -j2 PYTHON=python3

in the perf source directory (libpython3-dev must be installed).


Does this work for you?


Cheers,
Andreas

