Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2B62077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvhLgMBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403926AbgDCNQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:16:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26806 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390852AbgDCNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585919813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izOkr1BSQDJulAYByg5NgaMKcJ6WHmg0z2BChcgtZ1o=;
        b=IvhLgMBrLjQopJ1l6WCp7lH5HfLvXxtPWXEYqyHHTHh5mlg1ZQVYpJc4XI5k95Wa6Bg3nl
        J35b4tG0xpQgM4fflfQgbXKrRmKwWVEITeq2nY+I/G28GUSj6TMDpPou5z0S3v1ijm7Xyh
        IDMI5mgyZFvmpbXiEpRorJF4EAV5WBs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-86jLnN6fPgepMkzE4Mu15A-1; Fri, 03 Apr 2020 09:16:52 -0400
X-MC-Unique: 86jLnN6fPgepMkzE4Mu15A-1
Received: by mail-wm1-f70.google.com with SMTP id s22so2024877wmh.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=izOkr1BSQDJulAYByg5NgaMKcJ6WHmg0z2BChcgtZ1o=;
        b=T+a2b0y0q7xg7L4C9j394CqrpKgQpQfTUBfWYHxUENjxpCD9PGgfTlZIwYHxeB9Bqv
         yUSSXaD4gvlzDmETN/KQ3SCFz2g0+t3/pTC+qFvaLduLdzQDII74RmAvw2HhCiY7JEsI
         aQaXCXAT1qzRuwGKKuh83b3uoh1rcCMtG5yFxU6eoM9fdl6FIbbuk+WtuaOipuM3TRWd
         eEvuxoRn8ViQMNV9jIM0fTNTNvmNeIrxA/ygVbD9wIQw3wEBBIV8BQfMysjmC46VKlV7
         2PLYmwCJxkzLBRNImcMmUSIk4U2mQCPRJjgLykpOuMJbagVdbooiELjhGc3kO1EhxJyp
         fM9A==
X-Gm-Message-State: AGi0Pubh/lpV5IAqWtB/8C4Kx29IFV5kiAIHUXwCkYLkzyLF9OBZWp65
        mQcP8AwAHDUqbCLfr/HXV1FxBagfDoKBGdQvcxhgUarmNVdhirYVyb0lOSUykivLAv6vywKCe/j
        F8na0bxU2gwYJnQ4AbQlgvuas
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr8924891wrs.20.1585919811103;
        Fri, 03 Apr 2020 06:16:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIa2NLz9OGQj4FGUNxyoDHqAatWI/l10frH2PpuCDGPpiYh2zF1KU/LgdHFx+mVLgPN1dm5Ew==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr8924870wrs.20.1585919810807;
        Fri, 03 Apr 2020 06:16:50 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c1:1280:a281:9dab:554b:2fdc? (2a02-8388-07c1-1280-a281-9dab-554b-2fdc.cable.dynamic.v6.surfer.at. [2a02:8388:7c1:1280:a281:9dab:554b:2fdc])
        by smtp.gmail.com with ESMTPSA id b5sm1812721wrs.16.2020.04.03.06.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:16:49 -0700 (PDT)
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
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
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <bf95c9f1-1970-fce4-c6f2-dc231730e7ab@redhat.com>
Date:   Fri, 3 Apr 2020 15:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403124028.GA18559@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.20 14:40, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
>> On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
>>> When running perf script report with a Python script and a callgraph in
>>> DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
>>> function.
>>>
>>> Added a check for this condition (same check as in builtin-script.c:595).
>>>
>>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>>> ---
>>
>> Tested-by: Kim Phillips <kim.phillips@amd.com>
> 
> Thanks, added this to that patch.
> 

Great, thanks!


Cheers,
Andreas

