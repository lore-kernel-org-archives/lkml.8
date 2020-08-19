Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39625C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179B42078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nR7G5SwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHSTZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSTZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:25:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:25:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so1558069pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uIHy/4+dOTIzbxPNc7n6E/xZy0w8cFL8jWiQ0sl5YxQ=;
        b=nR7G5SwFp2JNr6fuvAhbEb1o7xKTXFbeB+0VOd0exvnNhw75pIp+ZO987UkhaH7KCl
         kt1OPnfzX8XXOQntKZrAGq3pqfKbPDeKB4RyDO/DBvTuEIq3gwsuXc9J1yqb82gXjhr4
         jPaPFV/gvbpptAaLLv3YEznM/o1wZjgGklS6dY52+sTfbOS9zYUi2owz1OQqd7f9Vn/v
         B2DwrK73+KEfTU3mWrj68bpX71UhgsCbVXK1aFFeFTHJ0kOMzZVHeG1bYX25Pgfy9LPe
         5D5UmMGCQp9rJ2Txbw97Nz+dmPiqGWjC7//2sslnuoM5Jwz8xmO9fDin91pG11CTB6Ge
         KXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uIHy/4+dOTIzbxPNc7n6E/xZy0w8cFL8jWiQ0sl5YxQ=;
        b=Q0++qxXCyX/duTZmiCCYRbWVg+ipe7rF4jPZ/gw5osN/EvnsLKs+An83X5uqeMafWY
         A2wtBRduGp4WziU554mZo8dRdg521Y+k+7yjeSxQfZxyMLd7SsfIoyvx8Hvqv2Son9KK
         7GjY+u5YRTgHHFGs9xA29/WAAFc5GYqFthrc9t2nEWHsY3uy1PqUh3c3RdrzqgB3pZZM
         AqMbcI42YkgDIp4lK893V3Ii+4KGuY2QJJRXnVxeXyQyeZfCrY1oOSzJfIdaqTf/bxXq
         L7YGdzRqY0+saJErZZtsoRNc/ZG2Au9YXU7O3Vo/yRzRbCm/zWQf7NR/+7MFsX2Dqnep
         Y21Q==
X-Gm-Message-State: AOAM533NHI79RLHlQ5h9fEobWsJW0RUA9jjpr9N8V5EJL80jxgyZr4w3
        F2XT4oFhnuxq0FkLkZx17ioXDw==
X-Google-Smtp-Source: ABdhPJz1lVEXLMArBIyCI0+M+EFSrZu0FfBjeeBhrzI2UstOIY8JV80nnGdwZefu7jVKH0RReO6PnA==
X-Received: by 2002:a17:902:7245:: with SMTP id c5mr1136646pll.317.1597865153509;
        Wed, 19 Aug 2020 12:25:53 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s185sm26735618pgc.18.2020.08.19.12.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 12:25:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
To:     david.fugate@linux.intel.com, Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
Date:   Wed, 19 Aug 2020 13:25:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 12:11 PM, David Fugate wrote:
> On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
>> On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>>> If drive does not support zone-append natively, enable emulation
>>> using
>>> regular write.
>>> Make emulated zone-append cmd write-lock the zone, preventing
>>> concurrent append/write on the same zone.
>>
>> I really don't think we should add this.  ZNS and the Linux support
>> were all designed with Zone Append in mind, and then your company did
>> the nastiest possible move violating the normal NVMe procedures to
>> make
>> it optional.  But that doesn't change the fact the Linux should keep
>> requiring it, especially with the amount of code added here and how
>> it
>> hooks in the fast path.
> 
> Intel does not support making *optional* NVMe spec features *required*
> by the NVMe driver.

It's not required, the driver will function quite fine without it. If you
want to use ZNS it's required. The Linux driver thankfully doesn't need
any vendor to sign off on what it can or cannot do, or what features
are acceptable.

> It's forgivable WDC's accepted contribution didn't work with other
> vendors' devices choosing not to implement the optional Zone Append,
> but it's not OK to reject contributions remedying this.  Provided
> there's no glaring technical issues, Samsung's contribution should be
> accepted to maintain both spec compliance as well as vendor neutrality.

It's *always* ok to reject contributions, if those contributions cause
maintainability issues, unacceptable slowdowns, or whatever other issue
that the maintainers of said driver don't want to deal with. Any
contribution should be judged on merit, not based on political decisions
or opinions. Obviously this thread reeks of it.

-- 
Jens Axboe

