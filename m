Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52F4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D21720708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eCnCl8ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgESRjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:39:04 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16978 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:39:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec419280003>; Tue, 19 May 2020 10:36:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 10:39:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 May 2020 10:39:03 -0700
Received: from [10.2.55.90] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 17:39:03 +0000
Subject: Re: [PATCH] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
To:     Xu Yilun <yilun.xu@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>
References: <20200517011837.382189-1-jhubbard@nvidia.com>
 <20200519151037.GA20726@yilunxu-OptiPlex-7050>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2e9e6c4e-296d-b0cd-88ce-1b300b9e2e0f@nvidia.com>
Date:   Tue, 19 May 2020 10:39:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519151037.GA20726@yilunxu-OptiPlex-7050>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589909800; bh=xaoEgoCHnVQjnzVlZcdR0OFGUhzt1FfKdnkkdl3fyII=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eCnCl8ej/a+dubGQt/M1eDAXqkCPp41qd7x0+oSo1SeUyUfm46JGguGD4T0w4re4q
         ni5mQ8j0NKgUx9RydyNxzpFZuwJ+o3QNwG9Y7NELTtEcW/4N+SA+ZMySmg8Spb3Ixi
         W4vlzLPO+qELePyHUMrUu6lXY7NR9t1ZbRrXqbfATRuektif7yc/aqFyJfUeJ0LvPT
         LvM48tb4S+azJg9NMji7BVODQmFin2lYqva0ekD83OzOetCp5O4uzbLxMiVmyOiie5
         8LWsnPWR4/WVLpX0STfZfg0klXdtsj6BWTeYm5p7nsICvcj0cygju6NZiKdYudAsv3
         KDVaHU5VJEHmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-19 08:10, Xu Yilun wrote:
...
>> @@ -72,7 +63,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>>   	return 0;
>>   
>>   put_pages:
> 
> How about we also change the tag to "unpin_pages"?
> 
> Others look good to me.
> 

Sure, I'll send a v2 with that.


thanks,
-- 
John Hubbard
NVIDIA
