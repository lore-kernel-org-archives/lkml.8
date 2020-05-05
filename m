Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33592C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B634206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jlUDA7Xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgEEAVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 20:21:00 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3656 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgEEAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 20:21:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb0b1260000>; Mon, 04 May 2020 17:19:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 17:20:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 May 2020 17:20:59 -0700
Received: from [10.2.56.198] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 May
 2020 00:20:59 +0000
Subject: Re: [PATCH hmm v2 2/5] mm/hmm: make hmm_range_fault return 0 or -1
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        <dri-devel@lists.freedesktop.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        <intel-gfx@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        <nouveau@lists.freedesktop.org>,
        "Yang, Philip" <Philip.Yang@amd.com>
References: <2-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9cf9f4f0-58b7-1992-6c6e-eed226ba42c0@nvidia.com>
Date:   Mon, 4 May 2020 17:20:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588637990; bh=IxP1FX28IvHHn1UJ333IIWhaZQbrlpthRJPkCq5tlOE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jlUDA7Xe/cEVYvcoOLBLT9WxsiTxB4eaIcRkJbYt7sChT+skJNIVNGkwSxeX311N9
         8Icf+Bb+N7FsISzQG4Ci4zeBXx95nSpEwUjZe7BytMfOd9TIqtDhoWdCDk3g2renix
         JJp4862GZJKQrIMSPPWchAxpo2TL3LdIgZ1nciGXyRvtuaWnU7bnlRQkU6QhCIwddA
         zZt1IUaeh+IgfHdHcJKHNaZAmd2XKaHg3iGk3SkLeBMTYoH9nYDLidjG4h/hxqZ6a6
         Hae57Q5zwNGF0Ax1wOvaZcYkMzvipoDz/QPdM+7uCWP3VezcDvR1L7Kvdm3oMQaoTe
         S2aJNC1fom1GQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-01 11:20, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> hmm_vma_walk->last is supposed to be updated after every write to the
> pfns, so that it can be returned by hmm_range_fault(). However, this is
> not done consistently. Fortunately nothing checks the return code of
> hmm_range_fault() for anything other than error.
> 
> More importantly last must be set before returning -EBUSY as it is used to
> prevent reading an output pfn as an input flags when the loop restarts.
> 
> For clarity and simplicity make hmm_range_fault() return 0 or -ERRNO. Only
> set last when returning -EBUSY.

Yes, this is also a nice simplification.

> ...
> @@ -590,10 +580,13 @@ long hmm_range_fault(struct hmm_range *range)
>   			return -EBUSY;
>   		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
>   				      &hmm_walk_ops, &hmm_vma_walk);
> +		/*
> +		 * When -EBUSY is returned the loop restarts with
> +		 * hmm_vma_walk.last set to an address that has not been stored
> +		 * in pfns. All entries < last in the pfn array are set to their
> +		 * output, and all >= are still at their input values.
> +		 */

I'm glad you added that comment. This is much easier to figure out with
that in place. After poking around this patch and eventually understanding the
.last handling, I wondered if you might like this slightly tweaked wording
instead:

		/*
		 * Each of the hmm_walk_ops routines returns -EBUSY if and only
		 * hmm_vma_walk.last has been set to an address that has not yet
		 * been stored in pfns. All entries < last in the pfn array are
		 * set to their output, and all >= are still at their input
		 * values.
		 */

Either way,

     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>   	} while (ret == -EBUSY);
> -
> -	if (ret)
> -		return ret;
> -	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
> +	return ret;
>   }
>   EXPORT_SYMBOL(hmm_range_fault);
> 

