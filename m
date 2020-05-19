Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57A120826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OeA0URDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgESUDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:03:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10958 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgESUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:03:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec43b280001>; Tue, 19 May 2020 13:01:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 13:03:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 May 2020 13:03:03 -0700
Received: from [10.2.90.179] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 20:03:02 +0000
Subject: Re: [PATCH] tee: convert convert get_user_pages() -->
 pin_user_pages()
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <tee-dev@lists.linaro.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
References: <20200519051850.2845561-1-jhubbard@nvidia.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ad103c96-0b84-97cd-48eb-67f5e01e0349@nvidia.com>
Date:   Tue, 19 May 2020 13:03:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519051850.2845561-1-jhubbard@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589918504; bh=I+orG+7rEdCJPZjUgf5aOsrGlbkMUn9fDowKMSsoZ2g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OeA0URDdDEoYmrSyeZbmNSjYkOHX/p9wy63Apbm2XjDHgq3miJl/i0na08Vfn43RI
         YJi/E7JgJgoXCBwYik7RTdeSvY0bKSpoOinqqc+CK+NUow8VpXp3nz1wbytGFfkjN1
         /2PyM61mbRSTw5aBh2po+7pSRo9zdFS3H+0b+8b7EHERtfPNskX7FcDvsyA2sWwjHg
         jAor6efO7gcQ8b6mDVRwikI8RefZr+5pssUoEpJQ3UMBkBTqLknnxmMKSilKMNGQos
         Pj5dDsBREkofQTJtBKeQFyv7wSW2CWQi7c09i+a2cQ0twqJbn0N6hitYffyPmO4hRw
         XOflF6r7EqEXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-18 22:18, John Hubbard wrote:
> This code was using get_user_pages*(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages*() + put_page() calls to
> pin_user_pages*() + unpin_user_pages() calls.
> 

Looks like I accidentally doubled a word on the subject line:
"convert convert". :)

I'd appreciate it a maintainer could remove one of those for
me, while applying the patch, assuming that we don't need a
v2 for other reasons.


thanks,
-- 
John Hubbard
NVIDIA
