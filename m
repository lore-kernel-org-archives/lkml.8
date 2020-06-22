Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D34C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D89420732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiC0d1z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgFVRpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:45:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729605AbgFVRps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592847946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iN1S6As8dV2WMckXA3iY7pg1t1BvSi4m/4p8lQdBlfU=;
        b=NiC0d1z7Qwno4ZT6EGSRmk4lgTiQiYS97klbPUB70WmtM4AIOVR7iwQUlEUkdU4PoIIDA9
        7oVinS2VnOFw/xHv5Dkr/klG6CueukR4G5eOKg2imYKReL+VDcPtC43fw0fR/HvNL+clEE
        oPeo+k2FR8DYEM3XiOwmM49hZmiJdoA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-4S_ZYQxiOrC3rKS9_RgZEg-1; Mon, 22 Jun 2020 13:45:44 -0400
X-MC-Unique: 4S_ZYQxiOrC3rKS9_RgZEg-1
Received: by mail-ed1-f69.google.com with SMTP id dh12so8389197edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iN1S6As8dV2WMckXA3iY7pg1t1BvSi4m/4p8lQdBlfU=;
        b=INgMuwrs5/BymtcTkLR0fTPEnyfMVQvUEXTsznrkoMvgrBS5v9knRH9xFZWVwW/R84
         Hl42BaHDN1ntslISsucXIgoLtdymO7xLc+ILp95RMQI13V1U0FJjQoRkzpeZGs6Fetrv
         wJXEW/Ump7K7UvgyyLdQ+om65/sUNWhTd/q+HrqbvsDWfOOVsAjoXmLlEbvZMosKzT5O
         RgD6iV6mSftuZPbeyVKsrgHnYTUQwPX+MakfbDBwjorDM+6NKIuZSzZ9vl9qnEmXla6N
         0mlXZtDVV5WVRApusHVrcO5cYrLFSeXTJtfEcvLFxYxeRoFpfjrBXx1CyX7rfh/n/TPg
         algg==
X-Gm-Message-State: AOAM531NYFv2RwZ26R10lRbFYKAyB2pI9OOlUoD+ndHFPfGnnGJYq6b5
        SQk8o7YnjIt0xPzwq5W2FyheeEo09Y01E68XXtCEIfYdp9kdHhsEFEwoSvv6pIFqynRCr7plNuJ
        pi7sQbyuSSRo3CgcoU+GYFcTG
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr16033319ejc.92.1592847941681;
        Mon, 22 Jun 2020 10:45:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXnqy48BNgsYwxS/iGCifBfsQBi7L3gWZRCZjduRvvwvz0FB8axec/JLUWfZGfbuNYBReHKA==
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr16033292ejc.92.1592847941379;
        Mon, 22 Jun 2020 10:45:41 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c1:12f0:2a0d:3df8:7645:8915? (2a02-8388-07c1-12f0-2a0d-3df8-7645-8915.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:12f0:2a0d:3df8:7645:8915])
        by smtp.gmail.com with ESMTPSA id p9sm6947423ejd.50.2020.06.22.10.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 10:45:40 -0700 (PDT)
Subject: Re: [PATCH v2] perf flamegraph: explicitly set utf-8 encoding
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200619130745.153113-1-agerstmayr@redhat.com>
 <20200619153232.203537-1-agerstmayr@redhat.com>
 <20200622163127.GB30611@kernel.org>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <4a02db6c-3a47-09aa-1534-48926d425633@redhat.com>
Date:   Mon, 22 Jun 2020 19:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622163127.GB30611@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.20 18:31, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 19, 2020 at 05:32:31PM +0200, Andreas Gerstmayr escreveu:
>> on some platforms the default encoding is not utf-8,
>> which causes an UnicodeDecodeError when reading the flamegraph template
>> and writing the flamegraph
> 
> Thanks, applied.

Thank you!

Cheers,
Andreas


> 
> - Arnaldo
>   
>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>> ---
>>
>> changelog v2: also write to stdout with utf-8 encoding
>>
>>   tools/perf/scripts/python/flamegraph.py | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
>> index 61f3be9add6b..65780013f745 100755
>> --- a/tools/perf/scripts/python/flamegraph.py
>> +++ b/tools/perf/scripts/python/flamegraph.py
>> @@ -17,6 +17,7 @@
>>   from __future__ import print_function
>>   import sys
>>   import os
>> +import io
>>   import argparse
>>   import json
>>   
>> @@ -81,7 +82,7 @@ class FlameGraphCLI:
>>   
>>           if self.args.format == "html":
>>               try:
>> -                with open(self.args.template) as f:
>> +                with io.open(self.args.template, encoding="utf-8") as f:
>>                       output_str = f.read().replace("/** @flamegraph_json **/",
>>                                                     json_str)
>>               except IOError as e:
>> @@ -93,11 +94,12 @@ class FlameGraphCLI:
>>               output_fn = self.args.output or "stacks.json"
>>   
>>           if output_fn == "-":
>> -            sys.stdout.write(output_str)
>> +            with io.open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
>> +                out.write(output_str)
>>           else:
>>               print("dumping data to {}".format(output_fn))
>>               try:
>> -                with open(output_fn, "w") as out:
>> +                with io.open(output_fn, "w", encoding="utf-8") as out:
>>                       out.write(output_str)
>>               except IOError as e:
>>                   print("Error writing output file: {}".format(e), file=sys.stderr)
>> -- 
>> 2.25.4
>>
> 

