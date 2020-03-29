Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E57206E6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y1BLDeev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC2BaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 21:30:02 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6805 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgC2BaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 21:30:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7ff9ea0000>; Sat, 28 Mar 2020 18:29:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 28 Mar 2020 18:30:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 28 Mar 2020 18:30:01 -0700
Received: from [10.2.58.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 29 Mar
 2020 01:30:01 +0000
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>, <david@redhat.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
 <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
 <20200328011031.olsaehwdev2gqdsn@master>
 <40facd34-40b2-0925-90ca-a4c53fc520e8@nvidia.com>
 <20200328025605.cpnbnavl27pphr7g@master>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b1b41da1-2ced-8bb8-7162-e5c820543244@nvidia.com>
Date:   Sat, 28 Mar 2020 18:30:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328025605.cpnbnavl27pphr7g@master>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585445354; bh=9sORjZpObiNxVTBG6AeMlZWTC5Qzs8EADfHHkxo4EYU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Y1BLDeevZe4MEpmaZ9f8mxKfm9/zUS8O5oXF091zN16cu8aNF5zOCrzYgWDVUp4bS
         u478hEEb4Y5Cp7o+LLZPU3gLn3JXIetcZbIrv830nO7LeEdpdkL2JFnMg4j7PWIuVT
         PnrVzHwn2x2MQls1OGXOg3+g3/fR1ZJAPwZRJiFhv206m9XdMxiJozT/C3J6glePl/
         0mR4FlEW8eow9kp4blILusi3iqv+fhOzSqAeKfYvqreupOS41VzgnuLglxR5JzNLyp
         QUGuAPmVlIBB3zuSTWduioVQfeNZFyVTbcuLdtahApeFalHWwWGUxXuC/8x28MBeEp
         HiuGjC6nH8wQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/20 7:56 PM, Wei Yang wrote:
...
>> Further note: On my current testing .config, I've got MAX_NUMNODES set to 64, which makes
>> 256 bytes required for node_order array. 256 bytes on a 16KB stack is a little bit above
>> my mental watermark for "that's too much in today's kernels".
>>
> 
> Thanks for your explanation. I would keep this in mind.
> 
> Now I have one more question, hope it won't sound silly. (16KB / 256) = 64,
> this means if each function call takes 256 space on stack, the max call depth
> is 64. So how deep a kernel function call would be? or expected to be?
>

64 is quite a bit deeper call depth than we expect to see. So 256 bytes on the stack
is not completely indefensible, but it's getting close. But worse, that's just an
example based on my .config choices. And (as Baoquan just pointed out) it can be much
bigger. (And the .config variable is an exponent, not linear, so it gets exciting fast.)
In fact, you could overrun the stack directly, with say CONFIG_NODES_SHIFT = 14.

  
> Also because of the limit space on stack, recursive function is not welcome in
> kernel neither. Am I right?
> 
Yes, that is correct.

thanks,
-- 
John Hubbard
NVIDIA
