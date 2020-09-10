Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9CBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0142080A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599717285;
	bh=Rr43ETN5BnzQnh/AFr/VfVFBOAJWVE/smD7x0ee6+uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QI5sK+qTo3bypkESxdEuGaIZk8h74NKWF8l5gpSWwlIMu8S3+IBTsuGPrGTIZMN/y
	 TsZyNP46NoM6YUJXMEMPyB1P5tR8BRPCr8esuqX4GaBU9iGLPPspovTSnnJ8rMSXBr
	 Usb4oj1uozUuqfIIB4kgq6678ypCQlBTbL7mhuTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIJFym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgIJFw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:52:26 -0400
Received: from localhost (unknown [122.179.50.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A3A2080A;
        Thu, 10 Sep 2020 05:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599717143;
        bh=Rr43ETN5BnzQnh/AFr/VfVFBOAJWVE/smD7x0ee6+uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azvVm+IWvehvYY+s1HCB4ERwEKVwMQ5t9T1K3DBKkeP1KKsj+f4itjrORb7vzMxDm
         6dyZwRwHF1To/S7EAf0hqf5w/FLkkvVMwYFQHo3s8XTjnY88179Z3DOt8SERJY8H0h
         qgISUJwBsyUeD3yj2ZFrbUgEu3M8YR2JF1g6AMC0=
Date:   Thu, 10 Sep 2020 11:22:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soundwire: intel: Remove ununsed function
Message-ID: <20200910055215.GP77521@vkoul-mobl>
References: <20200909131531.31380-1-yuehaibing@huawei.com>
 <14a09132-d0ed-7129-73df-cbeb3154429b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a09132-d0ed-7129-73df-cbeb3154429b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-20, 08:46, Pierre-Louis Bossart wrote:
> 
> 
> On 9/9/20 8:15 AM, YueHaibing wrote:
> > If CONFIG_PM is not set, build warns:
> > 
> > drivers/soundwire/intel.c:488:12: warning: 'intel_link_power_down' defined but not used [-Wunused-function]
> > 
> > Move this to #ifdef block.
> 
> Yes, thanks for the report, it's a valid issue, but maybe the fix is to add
> __maybe_unused more consistently and remove the CONFIG_PM dependency.
> 
> Vinod, what would you prefer?

__maybe_unused is the recommendation, it should be updated to use that

Thanks
-- 
~Vinod
