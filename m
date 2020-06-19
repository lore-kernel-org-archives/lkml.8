Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8860C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E44520890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgFSXbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:31:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:58563 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730480AbgFSXbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 19:31:25 -0400
IronPort-SDR: EqpB4QRoaYRhKAkMy9LBBClhFdW6eTBgE2N2fUaKiOzHzrnZn8wXQRlSDSWnuDTsNX5G3OhR4t
 bDSgg8YkkNtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="123403550"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="123403550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 16:31:25 -0700
IronPort-SDR: xLtwvaWjtaHWQKnz/TlwPD49xVRdUcU8TFHQz4MXD8QUerzEqPstVlodQfZJfyVCVLjF/X+9LY
 j9N0UTCz3xxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="477780861"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.171.94]) ([10.209.171.94])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2020 16:31:24 -0700
Subject: Re: DMA Engine: Transfer From Userspace
To:     Federico Vaga <federico.vaga@cern.ch>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5614531.lOV4Wx5bFT@harkonnen>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
Date:   Fri, 19 Jun 2020 16:31:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5614531.lOV4Wx5bFT@harkonnen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2020 3:47 PM, Federico Vaga wrote:
> Hello,
> 
> is there the possibility of using a DMA engine channel from userspace?
> 
> Something like:
> - configure DMA using ioctl() (or whatever configuration mechanism)
> - read() or write() to trigger the transfer
> 

I may have supposedly promised Vinod to look into possibly providing something 
like this in the future. But I have not gotten around to do that yet. Currently, 
no such support.
