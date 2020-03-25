Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7292E2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E7zSW9me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgCYMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:45:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17411 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCYMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:45:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7b520f0000>; Wed, 25 Mar 2020 05:43:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Mar 2020 05:45:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Mar 2020 05:45:30 -0700
Received: from [10.26.72.231] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 12:45:30 +0000
Subject: Re: [PATCH] soc/tegra: fuse: Add custom SoC attributes
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200320113716.6105-1-jonathanh@nvidia.com>
 <20200320151035.GB3706404@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d007d8b1-6420-469a-18af-09088b8b8398@nvidia.com>
Date:   Wed, 25 Mar 2020 12:45:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320151035.GB3706404@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585140239; bh=hSYr50g/KiRq7rbDuhfXVHS/4zZ8KNe6DJGXMUcV/1g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E7zSW9mev9e5n/EFUeh7kBmqoJtXeYQsS/N3NULZOHF2s8M5LTJkDc5iN6FAqVQ4d
         iiKnZ3aJNGECdxjhEMEf7Iaf5qsTVMZtuER+lsNbqx7fk4SlCEHxdZVDrdyQj985/A
         GeDxvWHfz8jkPmN5C5CbOWcBPfxtFp02/01CtP+qm9HvDdMrhJ2QfQkZyNnL4l2SBS
         UtG87PN+i+NOIjRnvqs+1JRq3/brN+pFpMOvWYqXqJkhfo4NyNj/GQibH90NYlF3ee
         85xRhba0LQUzpiH1lE/qM0AhbWyYRurLOUKAklPhGThD702dVQNRMR/8GwA/9oN4Bf
         rrewTQbQWNKTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/03/2020 15:10, Thierry Reding wrote:
> On Fri, Mar 20, 2020 at 11:37:16AM +0000, Jon Hunter wrote:
>> Add a custom SoC attribute for Tegra to expose the HIDREV register
>> contents to userspace via the sysfs. This register provides additional
>> details about the fabrication and versioning of the device. Exposing
>> this information is useful for identifying the exact device revision and
>> device type.
>>
>> Please note that the fields in this register vary depending on the Tegra
>> generation and so instead of exposing the individual fields, just expose
>> the entire contents of the register. Details of the register fields can
>> be found in the Technical Reference Manual for each Tegra device.
> 
> That seems a little suboptimal to me. It's pretty trivial for the kernel
> to distinguish between different SoC generations in order to know what
> the fields are. It's a lot more difficult for userspace to do so. Is the
> register completely different between SoC generations or just slightly?

It looks like only Tegra194 is different which is a shame.
Unfortunately, does not appear to be documented in the public TRM at the
moment. Hopefully we can fix that.

> Having individual fields exposed as individual attributes seems like it
> would make it a lot easier for userspace to get at the needed bits.

Yes that does make sense.

Jon

-- 
nvpublic
