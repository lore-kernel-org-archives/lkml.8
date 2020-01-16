Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707EBC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4782720748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="UKMzH9xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgAPNTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:19:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39384 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:19:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id t17so18883445eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nYT35nhT2lsEtNB1ESex5/sMswFYTRyoI4xH0ZN8d4E=;
        b=UKMzH9xFrX3Q3+LkCyouI+2n90HqLC7o8sbn/lcf5apIa7W4NX1T3rhYTWyL8fL+x5
         CxmlmdZ6gwyugMBCAQUpajJo4PFpgRiT01vRDjttJH7MJrXdiT1ib7Wv/LUUcUWTZ8/v
         LmnOGSx35otVQk7lG68YfJv6KCSWIX2SbfT9lcc+s1vOYB0g01ivqv2ohbMPFd7eASyk
         Hj9IcGxZQI5WIT/WetLbLs4c33dkF7qrkQoZ7Z6vOBl38i8giNi2Q2NGcg4DPYTcQxGn
         NVY1Q5Msj1uxHOsQNt8kXxaD8LxPmpcw0QXOpe2OLKmfiUErrkDi73U+xNb+iqktBqDm
         OtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nYT35nhT2lsEtNB1ESex5/sMswFYTRyoI4xH0ZN8d4E=;
        b=ayoI8AYXdFM//WTxl4/PCpTL7uLhYJxS6thQCmTAjqKuXWqUrhw9kApqwx6OZuVQtX
         xjsmxzBsJ0wV4zLBDqbHh8vuwZv2zprUFhVpPuEPFB8KzeBgYAWvXtBcLyPtEpV/ZxC3
         yZSA73bChMYqRYlTfhj0+rY3HUKGR7hfA+g85A/PvG/rZADHz+1bWTVMKiJb7YJHPOF9
         VTiSgIsV8nkXjzTuk9exq17og/r4JsTJiAa3yFeFpua+FNGi/qdRxzHSRUqOwAUNX2hf
         bjI8KCTHjL4PGGHHSc1jRxS29X5MnahWDxeCmQnyD/FkDWM8E59IDK+lkWO5UkVQ7LfE
         73Jg==
X-Gm-Message-State: APjAAAUECueCwmtTYq8DdtU1UD9Q6Clc7NRZrW7siex+rqdc65098DCs
        ZkZcsGTzO7Y2EaprwBwm2TMco9sQegI=
X-Google-Smtp-Source: APXvYqzJYTZWvZdiMLI5kN15fT+Ftw5hRG2DhYUjaRX4cs5VO8LbhUXOu2o0BK7ritcN1K7F6EXwAA==
X-Received: by 2002:a17:906:1ec8:: with SMTP id m8mr2912443ejj.355.1579180739817;
        Thu, 16 Jan 2020 05:18:59 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:116c:62f5:3efc:cdfd? ([2001:1438:4010:2540:116c:62f5:3efc:cdfd])
        by smtp.gmail.com with ESMTPSA id x15sm791941edl.48.2020.01.16.05.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 05:18:58 -0800 (PST)
Subject: Re: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
To:     Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1579006500-127143-1-git-send-email-alex.shi@linux.alibaba.com>
 <FC618797-2F5E-4F73-A244-0DC19AA1CB74@lca.pw>
 <739f4470-8dfe-bb2f-8100-2134f48868b6@linux.alibaba.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <959b6558-a745-7e85-f1c4-5eee39df375e@cloud.ionos.com>
Date:   Thu, 16 Jan 2020 14:18:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <739f4470-8dfe-bb2f-8100-2134f48868b6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/20 3:31 AM, Alex Shi wrote:
> 在 2020/1/14 下午9:46, Qian Cai 写道:
>>> On Jan 14, 2020, at 7:55 AM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>>
>>> This macro are never used in git history. So better to remove.
>> When removing unused thingy, it is important to figure out which commit introduced it in the first place and Cc the relevant people in that commit.
>>
> Thanks fore reminder, Qian!
>
> This macro was introduced in 1da177e4c3f4 Linux-2.6.12-rc2, no author or commiter could be found.

FYI, seems it was introduced in commit 3aa1dc7725 [PATCH] multithread 
page reclaim in history tree.

Thanks,
Guoqing

