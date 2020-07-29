Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919702074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nAqZhoEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2KIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:08:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18831 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG2KIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:08:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f214a5e0001>; Wed, 29 Jul 2020 03:07:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 03:08:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jul 2020 03:08:11 -0700
Received: from [10.26.73.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 10:08:06 +0000
Subject: Re: [PATCH V2] usb: tegra: Fix allocation for the FPCI context
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20200712102837.24340-1-jonathanh@nvidia.com>
 <20200715113842.30680-1-jonathanh@nvidia.com>
 <20200723111934.GA1964033@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bf4c5600-067d-eaaf-6364-84a23cce497d@nvidia.com>
Date:   Wed, 29 Jul 2020 11:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723111934.GA1964033@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596017246; bh=J9aeU8QwhA/JpGumv0tXw97StQVGfr0gZpe+p+AtC6g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nAqZhoExb/n7tqUKdOPO908fv9jjGGo36/TG9jMXPo8zRbAOQek+STMLzw7OHGpMg
         mpcfwhatS3Wj/tNSzlRCMmIPDOjhpIRat4Hpvntf5Q+UBMkezzbMDsOxhgCTQdchLe
         tW89JQJ1RNiwjgn4gBdBTVBrujXBETqhf91wDF12gKiLXZpikM8odFFC/Ct8QQlpOX
         evf+EalsdJYogJD3rbemv0QPeCNv/GxzJlLtXFYMDjRqJEnldrmK6YpWuHrYGzF4VV
         EiPFovdp9SpAGsjRCNL5HCP9KeA3wBhjKup5VGPBIsFreEqhWnqjuDI6sV7eQROELN
         /t21PyBzq4JUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/07/2020 12:19, Greg Kroah-Hartman wrote:
> On Wed, Jul 15, 2020 at 12:38:42PM +0100, Jon Hunter wrote:
>> Commit 5c4e8d3781bc ("usb: host: xhci-tegra: Add support for XUSB
>> context save/restore") is using the IPFS 'num_offsets' value when
>> allocating memory for FPCI context instead of the FPCI 'num_offsets'.
>>
>> After commit cad064f1bd52 ("devres: handle zero size in devm_kmalloc()")
>> was added system suspend started failing on Tegra186. The kernel log
>> showed that the Tegra XHCI driver was crashing on entry to suspend when
>> attempting the save the USB context. On Tegra186, the IPFS context has a
>> zero length but the FPCI content has a non-zero length, and because of
>> the bug in the Tegra XHCI driver we are incorrectly allocating a zero
>> length array for the FPCI context. The crash seen on entering suspend
>> when we attempt to save the FPCI context and following commit
>> cad064f1bd52 ("devres: handle zero size in devm_kmalloc()") this now
>> causes a NULL pointer deference when we access the memory. Fix this by
>> correcting the amount of memory we are allocating for FPCI contexts.
>>
>> Cc: stable@vger.kernel.org
>>
>> Fixes: 5c4e8d3781bc ("usb: host: xhci-tegra: Add support for XUSB context save/restore")
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>>
>> Changes since V1:
>> - Corrected commit message
>> - Added Thierry's ACK
>>
>>  drivers/usb/host/xhci-tegra.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> No cc: to linux-usb@vger?  :(
> 
> I'll go queue this up, but I would have caught it sooner if you had done
> so...

Sorry about that. Thanks for queuing up!
Jon

-- 
nvpublic
