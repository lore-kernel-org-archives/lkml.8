Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF8CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7848D2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591141924;
	bh=c5PiNtFbxRsfiZT7znD/U4b0jNuZrwdW6moQU7mUwSQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=SoeCA2aiwPmOlIWvkm96idwjy2xgeQ4dwYEeoHfD2wq3hPG5Pma2t5Eknle1zIkKY
	 5Jiq/xQU5LVMNJZTB2etUJONh+Yiy0/y2ZBheXCuyVZhd4MST3Rp/MFeyDOSlaSdVx
	 0Eg/Xh13gPOEa7f9Hano4tsNE2VGPw83LO5HR5Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgFBXwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:52:03 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116BBC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:52:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o13so423873otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AyHVm8H1V2i3mmbLZOQuNvzAiH5+9jtSq16k4ss/D+g=;
        b=Mt/tNa3CVtFoIPP9vs1G/pzU5s4Hc6kChAN1MjUSn58bltrswAMU5AiNUP9Mv+2kcT
         a0Y+fguR9tlG17LumUx/nVW31QoG9Ug8bjp5s8nsUGMBAh/HdduyvCCg86G5877Cg3GZ
         e/JVfVdPupzlXxohI4txQdgepZULQhGfZ+0wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AyHVm8H1V2i3mmbLZOQuNvzAiH5+9jtSq16k4ss/D+g=;
        b=uOqDPxTXzBElYJj20nSIupII66yiXb0LgKkvUpCFA55CVed3JBFD9Hi0sEJ3pyP02h
         7eneiewUbZEWmkeOe7WqqfFCPXModU3AWr7DoGqRNqJ/fFhn2IJBHWGzJCHRdbIAa7dU
         cfXqfjJAhwTzQ7cz03TwGEVxgX/kwmV7y8fhO2a74as1dGYNM4GWoLh69EvmiUl+3kw3
         OqnW1qN2avdKZbzHhyTDwXi58xwYs7AL1nGwlMe0+JE9kr2YAuKwKsANronVr61yr03A
         1xI157DOWd62NsvJCWPqSKsxD4EWmrMgFNHzPtBjgqfTImUscjQ+M83Zo5KS3AxKEGB2
         HCwg==
X-Gm-Message-State: AOAM533HbGseuOLmNInIMH25gLhDlaNmskCgez2s/3Gi1HH03jPQLfK6
        tKFBzOLOcP1DvfTlcas5znv5sg==
X-Google-Smtp-Source: ABdhPJwfqIxeVFPyYSW0HnX9GqZroEW760c16l5ACTIbwO8NZ7kNchICQfi7gL3an3LAcN3OQ3in4Q==
X-Received: by 2002:a9d:3bc2:: with SMTP id k60mr1217092otc.242.1591141921377;
        Tue, 02 Jun 2020 16:52:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k7sm81222oon.29.2020.06.02.16.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 16:52:00 -0700 (PDT)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To:     Alexander Monakov <amonakov@ispras.ru>,
        linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, skhan@linuxfoundation.org
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c0f9f676-eff8-572d-9174-4c22c6095a3d@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 17:51:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/20 1:22 AM, Alexander Monakov wrote:
> Hi,
> 
> Adding Shuah Khan to Cc: I've noticed you've seen this issue on Ryzen 2400GE;
> can you have a look at the patch? Would be nice to know if it fixes the
> problem for you too.
> 

I am not seeing any change in behavior on my system. I still see:

I can't read perf counters.

The question I asked in my previous thread on this:

--------------------------------------------------------------------
I see 2 banks and 4 counters on my system. Is it sufficient to check
the first bank and first counter? In other words, if the first one
isn't writable, are all counters non-writable?

Should we read the config first and then, try to see if any of the
counters are writable? I have a patch that does that, I can send it
out for review.

I changed the logic to read config to get max banks and counters
before checking if counters are writable and tried writing to all.
The result is the same and all of them aren't writable. However,
when disable the writable check and assume they are, I can run

perf stat -e 'amd_iommu_0 on all events and get data.

perf stat -e 'amd_iommu_0/cmd_processed/' sleep 10

  Performance counter stats for 'system wide':

                 56      amd_iommu_0/cmd_processed/

       10.001525171 seconds time elapsed


perf stat -a -e amd_iommu/mem_trans_total/ sleep 10

  Performance counter stats for 'system wide':

              2,696      amd_iommu/mem_trans_total/

       10.001465115 seconds time elapsed

I tried all possible events listed under amd_iommu_0 and I can get
data on all of them. No problems in dmesg.
--------------------------------------------------------------------

This patch doesn't really address that question.

thanks,
-- Shuah
