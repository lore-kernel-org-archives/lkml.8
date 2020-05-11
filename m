Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2FDC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D872020661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bRH+BqW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgEKUmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1736CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:42:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so7775018pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L0ujHhYjn1+l5Du4Cf/Op9n57dP6YBTeNtQSbhJ4WaM=;
        b=bRH+BqW3tymeUZNtM20Cab39LSZo4tL64IdqbXNToOvjNU2SuNaAGoMFZJ2rJ+QdRR
         zpKcz52/K+qJHrcnYQ3khK54m63b0uXv984/UkJUslY0F9FMq9sBaL0GiAvJ0gR+DB+X
         +bEcr8D70A7VIniiugQ6RIc0qJZDr7pR2CbVh9OK3GD4qaiwcAowS0E/typzsCO1F3dq
         GpGjQHSOqzpqyi5PGcmA8WDIEQ03efsE4ydkyqLYl7Yp31Ip3CjUWmEKMEeXiGJinUzn
         UAPdQsNxX99mznyVI6pJKApSu8fcytMCICpdLV1M6Ve0XBTdqghurkXf7aWy1QeWi26h
         xkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L0ujHhYjn1+l5Du4Cf/Op9n57dP6YBTeNtQSbhJ4WaM=;
        b=aRmJTHInpTYjz3XrueKmZRXvR5cFauR0S2/4s8B4lx5ionrfIgyUSLgSQhBZmTksab
         iEMnegWc2sK91CCsU4842CEInykwKOiYX/c7RwLckcy5khwwYnaW/breVlR3EqmUyfnx
         msm2BK/EA9dY9sbTeSX+ahDegFBBdVskBblx3tNVSrdStPqbVnyaOZ1eWzVXKt4Lr+0y
         w+6KUo0J5ODN6Uys+2u57ke6NJOArpClnhy9m3bDHItcUgqVJJmjomDFlkhMgOGqH8Ls
         blcTLlb7FZuiArVAXS52wODODpTYf3N6VkK+FXHgohfJbCMbtpLOl29MnWttjW1Vac2e
         mV/Q==
X-Gm-Message-State: AGi0PubSUlAB0BQaRHZquVAi/KXSR2Sn4d69RxevAo0maJHzR+tjUfmY
        qqDglF0IiQLIJ9CK3KDTDjOaNA==
X-Google-Smtp-Source: APiQypJqGUDfmLWXT4BAaNDoVAbixKZ7OGc6VuC7mSLh0WTg9haz0ObS+LOPNwBpO+Zzp2972AASbw==
X-Received: by 2002:a17:90a:ea07:: with SMTP id w7mr24663889pjy.172.1589229734487;
        Mon, 11 May 2020 13:42:14 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:911f:9a95:56a4:6995? ([2605:e000:100e:8c61:911f:9a95:56a4:6995])
        by smtp.gmail.com with ESMTPSA id s22sm10036420pfd.51.2020.05.11.13.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 13:42:13 -0700 (PDT)
Subject: Re: [PATCH] trace: Remove duplicate semicolons at the end of line
To:     Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mingo@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        wangle6@huawei.com
References: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
 <20200511164019.354a6d60@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd5edf3f-3f33-f199-4479-3cb740467b23@kernel.dk>
Date:   Mon, 11 May 2020 14:42:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511164019.354a6d60@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 2:40 PM, Steven Rostedt wrote:
> On Mon, 11 May 2020 19:21:02 +0800
> Xiaoming Ni <nixiaoming@huawei.com> wrote:
> 
>> Remove duplicate semicolons at the end of line in
>> include/trace/events/iocost.h
> 
> This looks like it should go through Jens's tree.

I'll add it for 5.8, thanks.

-- 
Jens Axboe

