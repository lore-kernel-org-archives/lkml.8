Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F223C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A4420675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5RW5c7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbgDBNEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388174AbgDBNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585832679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oT4Uo1Yp60nG/JqRSBwCHQqcnmWJYfv2TpClsO2iQGA=;
        b=Y5RW5c7abtW4vf4qBVJi4gmtY5gxJkwbo3ks5MQZehO+FkuHuhkQSw8CVCjVq2jWkqEM1T
        EORZyajUFTdGNh2hTscpGn0rCtfGvInzfQ1eVxUIymTj7+L6E3SGJyizLmFKMq3ACDNHoi
        5g3Lp1nVeRQ0xvp/hhLwkspNgZnMoNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Csuf1Xb4OAeqfRrgeyCEkA-1; Thu, 02 Apr 2020 09:04:36 -0400
X-MC-Unique: Csuf1Xb4OAeqfRrgeyCEkA-1
Received: by mail-wr1-f69.google.com with SMTP id h95so1442483wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oT4Uo1Yp60nG/JqRSBwCHQqcnmWJYfv2TpClsO2iQGA=;
        b=Q5m2xl0CDSHyjcg/xzcY3aRn1xKAGSZiNIK2R7G8pDEySbiFlmThF2an9sxSzxzbUS
         B9DuTV+uzkSHzSs808nYKZo99cTmy79soLJaUptjeXqJjCXC84Aqbta/gQBcXQsXiPtv
         AcQBafAV5zKhd6enLmSp6evVpgjIFdvFTRze4+h9Cf7/ZN12P12Ne69GIoeVIyrviMZp
         D/ZQNumdr8iVrk64X/QmJB1YtYWW0boiwyhC82LUYVX58dPYDSIQ3Oa/Zb1c6GBFSSQc
         T3plDDHyIDRLe+qOiaple4Jj5imt6KkP61p8sCFX/G0epN2Kw35/sx1IoobLiAu9DmLc
         gf0A==
X-Gm-Message-State: AGi0PuZEwhZwjdqB6UQut5e2Ny4qYOMjRm7E7C/coIHNS23mHkOpaMrI
        ECdbJCq0qCgWCMeXBPHkCmwOzfPdqlPBuUj47sw1NnqJeEFlVYZYs/3WqK7mmOJxuZ2DlrqLX/Y
        4fhYp98mzaYTrCS2VnxwFHeQB
X-Received: by 2002:adf:800e:: with SMTP id 14mr3328747wrk.369.1585832674539;
        Thu, 02 Apr 2020 06:04:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIe/nCBpsjbXD1D5gjLIkOslPVlF6W7YKWIfNby8hSlxW5unstzr92So9V03fZyrhMVK3yV1A==
X-Received: by 2002:adf:800e:: with SMTP id 14mr3328714wrk.369.1585832674308;
        Thu, 02 Apr 2020 06:04:34 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c1:1280:a281:9dab:554b:2fdc? (2a02-8388-07c1-1280-a281-9dab-554b-2fdc.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:1280:a281:9dab:554b:2fdc])
        by smtp.gmail.com with ESMTPSA id z12sm7627688wrt.27.2020.04.02.06.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:33 -0700 (PDT)
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
 <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
 <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <833a5e74-645a-130c-ceab-068880e0c69a@redhat.com>
Date:   Thu, 2 Apr 2020 15:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.20 20:04, Kim Phillips wrote:
> I now get a SIGSEGV when executing perf script report flamegraph.
> 
> Here's a trace:
> 
> #0  0x000055555590a9b2 in regs_map (regs=0x7fffffffbfc8, mask=16715775,
>      bf=0x7fffffffba60 "", size=512) at util/scripting-engines/trace-event-python.c:696
> #1  0x000055555590ab03 in set_regs_in_dict (dict=0x7ffff61dd500, sample=0x7fffffffbf20,
>      evsel=0x555555d7a700) at util/scripting-engines/trace-event-python.c:718

This error seems unrelated to flamegraph.py (occurs also with the 
stackcollapse.py script).

Looks like the intr_regs->regs can be 0 when running in DWARF mode (this 
error doesn't occur in the default mode). I've added a check and sent a 
patch. While at it, valgrind reported an invalid read in a different 
code path, which is fixed by the other patch I just sent a few minutes ago.

Can you please test again and report if there are any other issues?


Cheers,
Andreas

