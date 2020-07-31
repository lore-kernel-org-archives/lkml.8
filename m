Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A3922B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYH33ig4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbgGaQf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgGaQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:35:57 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:35:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so23357111qtm.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43NN3FBqwXjvMFcKJYOHgJ5BfI9wVCiL7/PeDGV1ITI=;
        b=hYH33ig4F61VhNRJo93K0iV18Je3rxozZKCKaxxQid7dvrdF277R5BRMc7c3OcqLYb
         8V+5HR4SCFRGSbszr4hWsXoKKJA0ZhAPznQUWv5mx051zzqZzAEdMfJKTdUbnHeI6sPs
         3jrSzoYWfsyhYHJYmGhpvtD3LRPF9tbtF0ZCQJP8hFVA7qLmNZFHM3LRgyaApSRqZ1It
         D218Ujnyt6RqsGuBFju2hHAEJWlJuXQ4Wq/nC1apupU9ZVd17Tj+d21Qc0eFrX2KNj3a
         c0dyO8xDhLSilcmQnPm8453LCA7P+Q9W4dhC6G4O81MAE+q200n2PK5oiu0Mw6KOxC82
         Z+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43NN3FBqwXjvMFcKJYOHgJ5BfI9wVCiL7/PeDGV1ITI=;
        b=afGVyPkO/FOxoGEfEEAs+TgJexVfkCv+T0vtgw2zunADEDmFdgpevRXZ+mKHNJLeVg
         xZkc6xkT8u8pB5RRhJmBgivZp2ItDx6JnF+MTEiRytu+Kekzfvj9F4HLtMFqLD0e2hWE
         g+1eyVcVnf/IjsmXNRlJwcGBCh90CUMAVcXP4TfEQGfM4VGoPNpUxkk8pPb8Je3JZIdD
         jQ2b+yaQdKkcLWaRHNwIpKPWIQPolPEN5dcDNDpxmus1wqRgg7q3ATX7CTDR8XPvCRvv
         OBHArW5kCHbJVeoEAOmuWTBz8TQu41GnB5ZlTO2Suf5wFn4Oay0fMVjAkHHL5OKYeSA3
         9Ccw==
X-Gm-Message-State: AOAM532rIhpLhrIZw1u8/wA5ZG98mKUfAvK6ZjbQbTSxMn1y9H6QUHUO
        8q6Mf6gvbGLSTyUp1Uyy0DI=
X-Google-Smtp-Source: ABdhPJxB3j64JWyYaiUV+mG//osTqVkbPJxdVL9pwPZVYtdEe9wU2BTlg1csDg6BuyeMn0qHzpZFOQ==
X-Received: by 2002:ac8:306a:: with SMTP id g39mr4520427qte.259.1596213356949;
        Fri, 31 Jul 2020 09:35:56 -0700 (PDT)
Received: from ?IPv6:2601:284:8202:10b0:c147:b41e:be5e:8b7a? ([2601:284:8202:10b0:c147:b41e:be5e:8b7a])
        by smtp.googlemail.com with ESMTPSA id x198sm9954334qka.37.2020.07.31.09.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 09:35:56 -0700 (PDT)
Subject: Re: [PATCH 2/6] perf tools: Store clock references for -k/--clockid
 option
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-3-jolsa@kernel.org>
 <9be7eb7b-4f73-84cc-95e9-e65101b30819@linux.intel.com>
 <20200731161519.GB4296@krava>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <f24e38b0-3000-1306-7058-cc440557e733@gmail.com>
Date:   Fri, 31 Jul 2020 10:35:54 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731161519.GB4296@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/20 10:15 AM, Jiri Olsa wrote:
>> It might also want to be implemented in a loop and iteration with minimal
>> time delta is chosen to improve synchronization accuracy and also mitigate
>> possible context switches between gettimeofday() and clock_gettime() calls.
> right, we could make this more accurate.. I'll post some follow up
> change with that

If it is handled through vdso (e.g., x86) both calls should be very fast
with no context switches and the margin of error is well less than the
usec resolution in the output.
