Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A1E206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="oVWM6T5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgENJhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:37:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A84C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:37:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so2000332lfh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Gj0cNxCY34MN1EL7DKRnwUOlinn6Wz+qtY7EpWgz5M=;
        b=oVWM6T5qZTorNnMZprnZOFTQiXbb4XbmVvFkT7FzHv9IpJGm8S3O+vQnaZOON2iK3v
         JJmYe7DK9Kk46bakSudSmewV9tYtLrAJelqpH90nTEdK2VJU3z6p2veVBw9i0Pj4qfEh
         25uwitsnpu/9GZtCVbF36DKWxme9aL/hXO6yHQsnOG0ZXJSywTZkNd1u+E++RrTVQxC9
         330RYbOiJgbJfDg3T3sM7JDfeCyw9Q8urwfZ41UHPSQPqE2rwNz8O/KoBuF/DGcQlocl
         YXFSZJnthWJx1Vs86AyjOBu1d4/4wAF6O8Oztf1P0XGe9SnW5ZMdrNJfBTMwe1BE0Yyt
         41bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Gj0cNxCY34MN1EL7DKRnwUOlinn6Wz+qtY7EpWgz5M=;
        b=OsZ/TW5u/rvDPOywr2vRh+Ki/X3u6ZVwS8TzLfTJYVzdw3r9kLfOUiHlnz7Wqh7YMq
         jutrLhIcKB3JSD5meWTCWVosKjdI2o5ULw8lotrIob6MpQnmJ11ha3vtc11RGsiW+hJc
         IP8EF7ssN/zHc1Ngxl4d9iTPTMd8jehHsk6z7BZvd51KnQ/kE2jjNezwUGk29mM69YA9
         KDs7tY6uwHY6fMdibUZ53je8FtsxEi7sXrcUu7PguGNgkOWHwoRrmTKp7R7IBm0+qc4I
         ev7gGg0oOrdPQUJbjZI/jgJTVFX+9yzGm7RocHJoSkiZSNbJBVHQp0Pk57MoFwGwt9S8
         Jj1Q==
X-Gm-Message-State: AOAM531+aKqpReoDPNSWyQuhCHgpFssTv5iHIAAZWw/MzWwx7brkPtca
        nZZ1fQgyLywZbUSQpnKCEV+EhZBG2Xo=
X-Google-Smtp-Source: ABdhPJwxSDqV5OeLS9W2cuCCEbpgT+k+80gl6sncjS9yh7y8GD02pIYkoXe52KVnpd8P8A4t9cCOIw==
X-Received: by 2002:a19:8107:: with SMTP id c7mr1198346lfd.38.1589449058740;
        Thu, 14 May 2020 02:37:38 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:428e:17ae:1023:2fd9:377b:94c8? ([2a00:1fa0:428e:17ae:1023:2fd9:377b:94c8])
        by smtp.gmail.com with ESMTPSA id d16sm1172540ljj.84.2020.05.14.02.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 02:37:38 -0700 (PDT)
Subject: Re: [PATCH] MIPS: update tlb even if pte entry has no change
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Bibo Mao <maobibo@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1589422677-11455-1-git-send-email-maobibo@loongson.cn>
 <b46f4ac1-9738-6037-d60a-faebf2b4365c@cogentembedded.com>
Message-ID: <f165deac-1a71-dd88-dfe5-c1701f31567b@cogentembedded.com>
Date:   Thu, 14 May 2020 12:37:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b46f4ac1-9738-6037-d60a-faebf2b4365c@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2020 12:35, Sergei Shtylyov wrote:

>> From: bibo mao <maobibo@loongson.cn>
>>
>> If there are two threads reading the same memory and tlb miss happens,
>> one thread fills pte entry, the other reads new pte value during page fault
>> handling. PTE value may be updated before page faul, so the process need
> 
>     Fault.

    And "needs".

>> need update tlb still.

    Oh, and one "need" is enough. :-)

>> Also this patch define flush_tlb_fix_spurious_fault as empty, since it not
>> necessary to flush the page for all CPUs
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> [...]

MBR, Sergei
