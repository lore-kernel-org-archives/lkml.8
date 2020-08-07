Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2ABC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C282086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pffN5J35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHGTuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:50:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA3C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:50:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so2206841qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xPLtymiQg2y4JB5oQWdwnFadkPkWDyI5nAC63HUN+CU=;
        b=pffN5J35KRXYgXr9be/UZwiLh3UqwshG0hVvTFcAL1SPO5swvegGTPvKEfVTY4hBJ5
         z/sr1wTQKwJVT/1rTFHRqN0gTIjCawLtlcE+cd9V3GLsjubD28vRVIkEhcXEtsyqI20F
         NZB3RqD31IHd+IZHB68VSGwg2ah6+9OIHe2+gNQQLIjOJ78BQSkDJRwQoeel0eHg/EWO
         ESO0SDag36cW4ESpB72IhSLTmnEufNOrdbFw7cuG/bn9QNB9CHdlqgAzK1djCrf15b8r
         1631g7mlvn5s6FH9rzpnxLEtL0wfqy6TK43cjZCdOD2Skt7xYRdCpi8ckmZHigTiEPwz
         yVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xPLtymiQg2y4JB5oQWdwnFadkPkWDyI5nAC63HUN+CU=;
        b=P5bxLMUQk6A2hBZI9B1MmSVIU4ZAQP+y8NNX0OWuNY48VG0DzwsFO3TwRWujbYjCrC
         YROOxQZMECYzfCQTm8iTkr1ysMAs8uBVZPrDMdBvJFI9yr5w3pszlPoAtdKoU1CWP/ft
         RN7IUNXuVSWQEo5he1mQMAPWs3JQ7NkynWrZBv13LZJQykC6FCSDld4lsXepCyid0rbc
         Pn2eY2OAZWRkxia7pEFzpkzqNJh8+XYQU/IJpdDF4fWGPn3EWFUqdMGkzhgIYgCy48d7
         n1Mk9gJfgQd7lZzHGuvRyGw6Yb4N1yVUwN3jdgeKpLYa3b9x61thgi6+lKxTzgDZb1ao
         Q5hQ==
X-Gm-Message-State: AOAM532Yzjt03LqxGigOJN4awBDGEJv7ESs89pNxKllMrjkamGjKyiEv
        UcatAvbz9UHW6FRoFFjGoDQ=
X-Google-Smtp-Source: ABdhPJw8Mn79G4RLYXrr5qkzB6NtLr8gYvsSEqOJF6zl1xkGLj/CWKYvtUCG4tOOY+zZmKW7JI6Twg==
X-Received: by 2002:ac8:4511:: with SMTP id q17mr15572932qtn.117.1596829849801;
        Fri, 07 Aug 2020 12:50:49 -0700 (PDT)
Received: from ?IPv6:2601:282:803:7700:44d:befa:b4a6:7c92? ([2601:282:803:7700:44d:befa:b4a6:7c92])
        by smtp.googlemail.com with ESMTPSA id m66sm7613522qkf.86.2020.08.07.12.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 12:50:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf sched: Prefer sched_waking event when it exists
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Ahern <dsahern@kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
References: <20200807164844.44870-1-dsahern@kernel.org>
 <20200807194335.GF2456573@kernel.org>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <d1e7bc58-122e-5e33-9f7c-d0cdfe4bb9b2@gmail.com>
Date:   Fri, 7 Aug 2020 13:50:47 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807194335.GF2456573@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 1:43 PM, Arnaldo Carvalho de Melo wrote:
>> @@ -2958,9 +2967,10 @@ static int timehist_check_attr(struct perf_sched *sched,
>>  
>>  static int perf_sched__timehist(struct perf_sched *sched)
>>  {
>> -	const struct evsel_str_handler handlers[] = {
>> +	struct evsel_str_handler handlers[] = {
>>  		{ "sched:sched_switch",       timehist_sched_switch_event, },
>>  		{ "sched:sched_wakeup",	      timehist_sched_wakeup_event, },
>> +		{ "sched:sched_waking",       timehist_sched_wakeup_event, },
>>  		{ "sched:sched_wakeup_new",   timehist_sched_wakeup_event, },
>>  	};
>>  	const struct evsel_str_handler migrate_handlers[] = {
>> @@ -3018,6 +3028,11 @@ static int perf_sched__timehist(struct perf_sched *sched)
>>  
>>  	setup_pager();
>>  
>> +	/* prefer sched_waking if it is captured */
>> +	if (perf_evlist__find_tracepoint_by_name(session->evlist,
>> +						  "sched:sched_waking"))
>> +		handlers[1].handler = timehist_sched_wakeup_ignore;
>> +
> 
> 
> ouch, can't we figure out if its present and then don't ask for the
> wakeup one to be recorded?
> 

This is the analysis side. If someone recorded with sched:* we do not
want to analyze both sched_wakeup and sched_waking. Rather, it should
prefer the latter and ignore the former.

