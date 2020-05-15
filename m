Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FB0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB9D2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRXa6uk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEOPJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgEOPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:09:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26178C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:09:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w64so3041545wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jx0XKJ2rCIhRcqgOXEUQmg+a5t/C06hEEw2771wCrpc=;
        b=xRXa6uk7sY5l0kUkxtMtjnnegPJEPXpzWVBtJYypcC978gemlnFTFHOMjBcbc10QpS
         QaFAcfSa6/+nIfd9VbbJnqFnAkW8Qlg6RpEaymWSUnnoPfhRsL5QVIbMrUgyPfdmVfQx
         7aIdfDpyCPW3PySPGMbIGfI1c+gV/YhTi0ckAMTrSqt7WO4reax1zYQJuV2YNIKOT+7x
         Qb4lik5t5kYa2RE/iC77TlPCRge53K4u28Vldd9Eu2XB/1YsNFE3ZzqrOlKisHqs1pf3
         EOpFnAvbVn0Nmj1veW/0FfkBCBbkbGUmJJZrxbniv9vLXecDqIY/xPw60FnWYa3dD1uU
         90Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jx0XKJ2rCIhRcqgOXEUQmg+a5t/C06hEEw2771wCrpc=;
        b=UNMSPmCfToRGOcuadOoEK7rr7eMLQaWuDn7ncxoz9CBYA+XSikdOae6yNgwv5hLzNg
         CIhRG+apeIflYt+RChLdNRZuhh5+JtjjQGOvK6E+afUR0kZbiilqt00TNLZ/ZWfGSXf6
         0rnjkeLLlUJMrZoEsFnx6pEYhlqLRrwj4Be0Cu5TNMVIXwCauoX9B+0XlPe3jLBhlBnD
         Hwi7FX2B2REQbtp4p+Y1qguu4g9LRdV2ceck+VtNesPI0tsBLkhxaXALO9cibVduSxMh
         mnF2AD9gwvafLiuzERTpnn+ZlHi+7oMGKe0uTJX2MRnsF7reH0p7byy4+4vIUGcMS2Oa
         Sfrw==
X-Gm-Message-State: AOAM530g9UIp/tqyPic4zJbYPAHKjL5pb3dDVOT+0QJOj8h2EeMmG87A
        awP98KxslnPm9s+dGiXraB6RXiIMdpk=
X-Google-Smtp-Source: ABdhPJzK6NqwmRRnGC5NyaLkwDKbAx4XTdfPDAKUwWKA5Ss6lvRh0R+qSgwZkAw0X/NDc8GIEj5t3w==
X-Received: by 2002:a05:600c:40d:: with SMTP id q13mr4585592wmb.69.1589555371482;
        Fri, 15 May 2020 08:09:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5450:281:8a7d:dd9a? ([2a01:e34:ed2f:f020:5450:281:8a7d:dd9a])
        by smtp.googlemail.com with ESMTPSA id b7sm3946043wmj.29.2020.05.15.08.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:09:30 -0700 (PDT)
Subject: Re: [PATCH 4/4] thermal: core: genetlink support for
 events/cmd/sampling
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, arnd@arndb.de,
        rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20200515141034.19154-1-daniel.lezcano@linaro.org>
 <20200515141034.19154-4-daniel.lezcano@linaro.org>
 <3b729b2a518d55c973f7daa7dc77547dfaf7b315.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2369d65a-bd97-a57b-f0d6-5d4aea918bff@linaro.org>
Date:   Fri, 15 May 2020 17:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3b729b2a518d55c973f7daa7dc77547dfaf7b315.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 16:43, Srinivas Pandruvada wrote:
> On Fri, 2020-05-15 at 16:10 +0200, Daniel Lezcano wrote:
>> Initially the thermal framework had a very simple notification
>> mechanism to send generic netlink messages to the userspace.
>>
>> The notification function was never called from anywhere and the
>> corresponding dead code was removed. It was probably a first attempt
>> to introduce the netlink notification.
>>
>> At LPC2018, the presentation "Linux thermal: User kernel interface",
>> proposed to create the notifications to the userspace via a kfifo.
>>
>> The advantage of the kfifo is the performance. It is usually used
>> from
>> a 1:1 communication channel where a driver captures data and send
>> them
>> as fast as possible to an userspace process.
> Shall I submit my RFC using KFifo on top of this series? Any
> objections?

ATM the notification is not plugged with any thermal core code path. It
is separated on purpose in order to let your RFC to get some comments.

If you want to base your RFC on top of it, I'm perfectly fine with that.

I'll review your RFC now, I wanted to do that before but got busy with
another stuff.

If you want to compare kfifo and netlink, the userspace test programs
are at:

https://git.linaro.org/people/daniel.lezcano/thermal-genl.git/

IMO, using the kfifo for the sampling and the notifications/the commands
via netlink would make more sense.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
