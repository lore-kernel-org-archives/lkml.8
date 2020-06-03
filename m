Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195CEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECA72072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591166029;
	bh=D+CwQxp+ouzL1zptDEKtjRzdDgXKKyuOJ9H3NAgLKpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T/XUNPv6NNs+u8J4fHDdaURuKJEspW3Lq+WbBgGgaHYGXosmjqyWTUfyl630EUS0e
	 R7bN0n2v5a5i6SSlpMpy5n3ER6vOVXMhA6FDISU2zBkcEPn3gA0buZCyU41fslsXsF
	 1ElqXnzw0cpjeTi40OltiRLGiGbyLoW5zQmQH61M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgFCGds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFCGdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:33:47 -0400
Received: from localhost (unknown [122.179.53.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C75720679;
        Wed,  3 Jun 2020 06:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591166027;
        bh=D+CwQxp+ouzL1zptDEKtjRzdDgXKKyuOJ9H3NAgLKpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yjulCORUNUiFxoCl05KRpYvlTg9yBAaSMXvFsHX8RJ7/c+hCC7OkXEuXM6JNmX2sp
         AOGhAtKLqOPTLPYJwIECsAEcQXIZVC8u+O5oqtQ4UXxKtL6lTVf86M0YS7sEa6n8xW
         2k2Lsn2ZLWopqg023mPYklFX1bnNepn9RxM4HpCI=
Date:   Wed, 3 Jun 2020 12:03:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 0/9] Add shared workqueue support for idxd driver
Message-ID: <20200603063342.GA41080@vkoul-mobl>
References: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
 <95eb8203-a332-37ae-28fb-5a2af4d1daba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95eb8203-a332-37ae-28fb-5a2af4d1daba@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 01-06-20, 15:09, Dave Jiang wrote:
> Vinod,
> Obviously this series won't make it for 5.8 due to being blocked by
> Fenghua's PASID series. Do you think you can take patches 4 and 5
> independently? I think these can go into 5.8 and is not dependent on
> anything. Thanks.

I was out last week, can you resend these two after merge window and we
can do the needful

Thanks

-- 
~Vinod
