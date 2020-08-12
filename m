Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B442D206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwJrziSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHLDMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 23:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLDMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 23:12:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECAAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 20:12:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e11so863467otk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QvRwyqfBzSBusxVG0abxrCHTZbe0s1N2buN7nWa0Szc=;
        b=XwJrziScHTqWx9Fqu0aY4Ltd+VHIGc9aInW0KHF02tjHpDykR7F9RT3l+pfey+BrcL
         CZ+JWyi3mWH8jy2QrdcDsFYWCoV+FJ3ZGjOPSPqeUaaI7MVpNVw5rhOey4+FgNFN5nz3
         W41p9wLK45Z6mxrejE73sgsub05gUF/KRvfCYu7BcNDNYOrEPiy7wZSlU2jCrjkltfb/
         u3kM3ug6xbXTA9Cd/UuNeXZiC6z8bgwhOTpkhdFTo3RMfNprtky4Vu0dgndCLez3N9Me
         UmvgYaKpalSCc2NDLXshPYD37THkMxL+AB+EUocm96NmdkiH42niPjOVH+aG45PLEIPl
         5KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QvRwyqfBzSBusxVG0abxrCHTZbe0s1N2buN7nWa0Szc=;
        b=RNADek4hs9ErRdp8PRojrM+JNg1GWZltRGw836+WGbo/X9vUilwAtT+RpJn1feu7E2
         8mAlxhaYdiRXjNCfXcYZElKXQRqvvFf9cE5faFBmL0z6m9iowQ4GTQKHTxAMHfa+7m5b
         CcrP1hbXHNiMa5BnV14f56zOESI/THORs5O6wV4Sgx+HAUl3eRsWf93UjJi5/etB5c/C
         4eONL9poDmlsn7zuE7bIeOtA/1A5GXmz8wNGrDMAFCKX09k87pJnmgCFaZ8S3kT5taHA
         q1NV4S/aS3UxEZ2tRqbocgRQ/xbo1hXCgKJvbVB4kYqR4K15mFN8l7LVUDQuVymfjxiu
         K9Qg==
X-Gm-Message-State: AOAM530/exJzDt+dNG3wUIBKh7LN/IgDo+A5YFEnDfmNlGNCPW7lW5vh
        Ivrx3LVjSbabyUjpi+NSBGU=
X-Google-Smtp-Source: ABdhPJwpoerVRGLdzSd1HDbEVT7xeh77OeDuTdgZ8TIDWGp4KEm5FcLDTNShZUc9tmBAq0Iw6g5pJw==
X-Received: by 2002:a9d:b82:: with SMTP id 2mr7537873oth.202.1597201935255;
        Tue, 11 Aug 2020 20:12:15 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([2601:282:803:7700:c1d8:5dca:975d:16e])
        by smtp.googlemail.com with ESMTPSA id d19sm225767oig.8.2020.08.11.20.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 20:12:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf sched timehist: Fix use of CPU list with summary
 option
To:     Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20200807164937.44921-1-dsahern@kernel.org>
 <CAM9d7chXrXh1QfJfwsEJ_Tk0_EDNL9ajBE8H0QYCSn_yuLhNUA@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <47111ff4-c61a-3a12-adb6-748b98fd0be0@gmail.com>
Date:   Tue, 11 Aug 2020 21:12:10 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7chXrXh1QfJfwsEJ_Tk0_EDNL9ajBE8H0QYCSn_yuLhNUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 12:42 AM, Namhyung Kim wrote:
>> @@ -2575,7 +2575,8 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>>         }
>>
>>         if (!sched->idle_hist || thread->tid == 0) {
>> -               timehist_update_runtime_stats(tr, t, tprev);
>> +               if (!cpu_list || test_bit(sample->cpu, cpu_bitmap))
>> +                       timehist_update_runtime_stats(tr, t, tprev);
>>
>>                 if (sched->idle_hist) {
>>                         struct idle_thread_runtime *itr = (void *)tr;
>> @@ -2848,6 +2849,9 @@ static void timehist_print_summary(struct perf_sched *sched,
>>
>>         printf("\nIdle stats:\n");
>>         for (i = 0; i < idle_max_cpu; ++i) {
>> +               if (!test_bit(i, cpu_bitmap))
> 
> Shouldn't it check cpu_list as well?
> 

oh, right. will fix.
