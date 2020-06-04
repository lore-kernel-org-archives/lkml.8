Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4EEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 02:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B201A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 02:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yig2jkEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFDCaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgFDCaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 22:30:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22225C03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 19:30:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 185so2827195pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UrWp9VyFOtxxHFJoXjWhr53J6bJYIVm1UreUvMDnDZA=;
        b=yig2jkEQD9lH93UIRifY3exnt2WK4wraBZPhZ5J3p5x0Q2OUBNE12RVyLYMyq681wy
         D7dTmBm0/QmzJ62n32b0wPBtUpt/UQANu+jTeicN9a6x3e37XvaV/mAdCR9fwr4+v/6f
         RQ+CtLxFy/Aybx4m/mtTl/4SxYVOtVEyfnqeHEldMJqVOsQABB8DvtFHMpKQUwcZMCDM
         yGl8OVV6xgNgkUb4bY4ODDVzl0JeumyKTHUVy7ffEl+fnAbd0ircnm0jnGPDwpAYh0DC
         xgg/KOhfjsY9hUZ5bERwDOlncvGOR8f2DHdXV5yRv+5GRrccd2tt8XBiJe9yzydTQQWA
         DEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UrWp9VyFOtxxHFJoXjWhr53J6bJYIVm1UreUvMDnDZA=;
        b=hOyI2kOMwg7ffwYRo5R9vBFXK4WjBemu8rDsQFL+8piX9JiG4V17QCqBOXpfGaWhhv
         wkiYQCoPF08alaSxvDN+E5aM3anCG2f7nmQS12+aOINUdd+ESVqEhi1KE/JnPcwIhTny
         JBedYTtqe+9pMeaCWz/2wvdM8cjinEZez7nVThTAw5OA9El0K/LzYHUcQ6hzXsmrz9DI
         ms0gFALuACYiysziXwogWo26IZAZ4gIc10pNk/vzk93jxnEjvsWlc7KnvlicXCsLFyE+
         b7etBVlxlqyMoshR479XZB5DU09MWKDVxbuD0QSx2gJOZPUB9XOkW4HiXFdEruHc8BAH
         Z4ew==
X-Gm-Message-State: AOAM533WSwK5+zF7B7mKG7OyNWaq9XfXsEJuiKqZI3H1kI9NzEtALJt4
        Xvw9jlsIBBIiss/2iYQdwOKMbg==
X-Google-Smtp-Source: ABdhPJxXdsY7PaC32MTCmVsbR+QEH2uUyz2w/NpjU1OPNBvP6oX51+4HjpZT0D0/QCDyDB0RbxXzng==
X-Received: by 2002:aa7:87d3:: with SMTP id i19mr1938739pfo.203.1591237834523;
        Wed, 03 Jun 2020 19:30:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id fw4sm3661331pjb.31.2020.06.03.19.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 19:30:33 -0700 (PDT)
Subject: Re: kernel/trace/blktrace.c:347:12: sparse: sparse: incorrect type in
 assignment (different address spaces)
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     kernel test robot <lkp@intel.com>, "Jan, Kara," <jack@suse.cz>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <202006031903.CiDVFCgm%lkp@intel.com>
 <BYAPR04MB496578B5C8F42E1639F56D8A86880@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1327a77d-3c9e-31d3-0b14-454803068402@kernel.dk>
Date:   Wed, 3 Jun 2020 20:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496578B5C8F42E1639F56D8A86880@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 4:34 PM, Chaitanya Kulkarni wrote:
> Jens,
> 
> On 6/3/20 4:32 AM, kernel test robot wrote:
>> tree:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
>> head:   d6f9469a03d832dcd17041ed67774ffb5f3e73b3
>> commit: c780e86dd48ef6467a1146cf7d0fe1e05a635039 blktrace: Protect q->blk_trace with RCU
>> date:   3 months ago
>> config: arc-randconfig-s031-20200603 (attached as .config)
>> compiler: arc-elf-gcc (GCC) 9.3.0
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.1-244-g0ee050a8-dirty
>>          git checkout c780e86dd48ef6467a1146cf7d0fe1e05a635039
>>          # save the attached .config to linux build tree
>>          make W=1 C=1 ARCH=arc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot<lkp@intel.com>
> 
> I think Jan has sent the patch to fix the rcu and I've sent out the 
> series to fix the rest of the issues.
> 
> Can you please let me know how can we proceed with the series so that
> we can stop these emails ?

Which patch from Jan? I saw one, and it had issues. Then there's a second
one, which is ordered behind a series that's not in my tree and wasn't
queued for 5.8. And finally, there's your series, which seemed to be a
subset of Jan's patch for patch 1.

So it's really not very clear. Maybe if folks got together and actually
put together a series to fix this it would be easier to get this done.

-- 
Jens Axboe

