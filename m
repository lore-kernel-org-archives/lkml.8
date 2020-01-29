Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF6DC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154FD206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ekFvSkub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgA2QZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:25:06 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17767 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:25:05 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e31b1d20001>; Wed, 29 Jan 2020 08:24:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 08:25:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 Jan 2020 08:25:05 -0800
Received: from [10.2.164.115] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 16:25:04 +0000
Subject: Re: Re: [RFC PATCH v1 4/5] media: tegra: Add Tegra Video input driver
 for Tegra210
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Helen Koike <helen.koike@collabora.com>, <jonathanh@nvidia.com>,
        <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1580235801-4129-1-git-send-email-skomatineni@nvidia.com>
 <1580235801-4129-5-git-send-email-skomatineni@nvidia.com>
 <3cdea635-a9ca-7b9c-3c99-8f489f4d669a@collabora.com>
 <162488d0-4e74-963a-3366-e4c1f7cf04ca@nvidia.com>
 <20200129100906.GE2479935@ulmo>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <8bf0ab06-a37e-4816-86e2-805b46787d5a@nvidia.com>
Date:   Wed, 29 Jan 2020 08:25:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129100906.GE2479935@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580315090; bh=6I/ImPF+IqDUZJDIu1hFpXvjuHGZpz3pV5FXxWX2E/w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=ekFvSkubLBuF+i4LUc1Nl3qYT/n5NnQFbyBNrrDVVqMJ25q5z+NZPU7FctyuwSii0
         wcADGpjGgmP/extSwxt3O/PDeO1WmsuAF7p5CxUwK6sxAsgLuafOLULq9e6TkCmoJX
         AjwysvWDMYdtSJjulG6f86Ap7WOEqAf+BWbFQ8UlxgfZyd8/SwJ5wWtJfdHKPYnRyV
         teffbOfUIU02M8YW1ndE7/a72cVYUhQFGkOOBvqRcKIDgAQxPk569XNZFtpNIW0LJE
         G7zsSHs3DXjjzubEv4FfHzyOZV8Hz7eMeebsZ5pZtoVC4ZTG0flUd7bpZ6xlN5BsNl
         yC8JmG4Sd1PoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/29/20 2:09 AM, Thierry Reding wrote:
> On Tue, Jan 28, 2020 at 02:13:17PM -0800, Sowjanya Komatineni wrote:
>> On 1/28/20 1:45 PM, Helen Koike wrote:
> [...]
>>> On 1/28/20 4:23 PM, Sowjanya Komatineni wrote:
> [...]
>>>> +const struct tegra_csi_fops csi2_fops = {
>>>> +     .hw_init = csi2_hw_init,
>>>> +     .csi_start_streaming = csi2_start_streaming,
>>>> +     .csi_err_status = csi2_error_status,
>>>> +};
>>> If I saw correctly, you don't have other instances of struct tegra_csi_fops with different functions.
>>> So why not exposing the functions directly instead of creating a global variable?
>> Currently driver supports Tegra210 only. Later we will add for Tegra186 and
>> Tegra184 support too where we will have separate csi fops.
> Perhaps this structure should be prefixed with a tegra210_ to make that
> more obvious?
Will fix prefix in v2
>>>> +EXPORT_SYMBOL(csi2_fops);
> Also, why do we need to export these? These will be built as linked into
> the Tegra VI driver, which is the only one that uses these, right? Would
> it not be enough to just make it global? Why the need to export?
>
> Thierry
Will fix in v2
