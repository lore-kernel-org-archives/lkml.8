Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D64C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34307206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee7z1+oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgDFJab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:30:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbgDFJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586165429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vm6kWbgKBBg6+wO/3BClKzp87CtAj5bz2y/9ANO1OI=;
        b=ee7z1+oZLnpMlztYcLco4fiqCyDD1ePMp8pPMa7U2xDK2blMw0puxt8j/Wrov8CjT3NdSl
        7K5a/wJD3JcXcSOu6puxhhYfHTjlM3JSO8q4itEepvCCeraOsDwMFMRNstkerjVNeRvTQo
        hbCpbF0/ujSuf9RjD31r+yJ7CDgo+hM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-R8tg8OMmO8WGPVNOS6wxkw-1; Mon, 06 Apr 2020 05:30:26 -0400
X-MC-Unique: R8tg8OMmO8WGPVNOS6wxkw-1
Received: by mail-wr1-f70.google.com with SMTP id t25so8065574wrb.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 02:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5vm6kWbgKBBg6+wO/3BClKzp87CtAj5bz2y/9ANO1OI=;
        b=Ayi9+gTbnOEkyhB+DxOi/v0p8PeS1Tz9UlDSLXVl5+V9KpLyYI7CtKihkpXBP3HYQP
         LZQ0xpnOUNSXK53KGpDuMM7O8LaChI3/vhf0H2L4VlZ5Hw6/l5N8YzBjMgW5qutXQhRk
         AaWHM4sOP7bG041QshheIFFjzkfFRKi5ahy4vnZ5Mko2izjzxI7UgabINdE/eRiIEFGV
         oYHMOHGjQp9kJoQdVqBzxu8kgdd5GO9NEQuh4ITh4tfe/mIVaKUDhgY9bLxpiVLN5X7f
         CA0995gNNzDJI5HIopFqcoLM0LBHbWvjc9pgEHQQmGuIF0a/ivZdpysHDbAdzm4DisM3
         +3RA==
X-Gm-Message-State: AGi0PuYAdFmNVswmYtjuCcB7lj6YoLnYL32yKaIMJIUxpew3OnPWtwYu
        KP/1wAGLMR7BOoUGybMmoQbNibexmEe475tFBdi6+eUndHPYjPkKgN3beElTEfV56xoqllOOVOI
        EHLoxl7ZfYDbEJXRhFpA3fy3h
X-Received: by 2002:a5d:414f:: with SMTP id c15mr25202515wrq.60.1586165424916;
        Mon, 06 Apr 2020 02:30:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ/v17VA65MhscpVSHfNFvdhG7jS9Miws02PLAA3/c8tTAOhummOFUJXNthKzKFGfyXHjJG1Q==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr25202483wrq.60.1586165424680;
        Mon, 06 Apr 2020 02:30:24 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c1:1280:a281:9dab:554b:2fdc? (2a02-8388-07c1-1280-a281-9dab-554b-2fdc.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:1280:a281:9dab:554b:2fdc])
        by smtp.gmail.com with ESMTPSA id t12sm26687712wrm.0.2020.04.06.02.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 02:30:24 -0700 (PDT)
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
 <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
 <20200403124028.GA18559@kernel.org>
 <bf95c9f1-1970-fce4-c6f2-dc231730e7ab@redhat.com>
Message-ID: <0a942366-c8dd-4767-ee84-fdc0024b035f@redhat.com>
Date:   Mon, 6 Apr 2020 11:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bf95c9f1-1970-fce4-c6f2-dc231730e7ab@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.20 15:16, Andreas Gerstmayr wrote:
> On 03.04.20 14:40, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
>>> On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
>>>> When running perf script report with a Python script and a callgraph in
>>>> DWARF mode, intr_regs->regs can be 0 and therefore crashing the 
>>>> regs_map
>>>> function.
>>>>
>>>> Added a check for this condition (same check as in 
>>>> builtin-script.c:595).
>>>>
>>>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>>>> ---
>>>
>>> Tested-by: Kim Phillips <kim.phillips@amd.com>
>>
>> Thanks, added this to that patch.
>>
> 
> Great, thanks!

Ah, I thought you were referring to my initial flamegraph.py perf script.
Is there anything I can do to get it merged?


Cheers,
Andreas

