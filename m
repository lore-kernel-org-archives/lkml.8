Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A32FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD572072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qeJM2oCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCWP7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:59:45 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8206 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCWP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:59:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e78dcc30000>; Mon, 23 Mar 2020 08:58:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 23 Mar 2020 08:59:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 23 Mar 2020 08:59:43 -0700
Received: from [10.26.73.76] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Mar
 2020 15:59:41 +0000
Subject: Re: [PATCH v1 0/2] Support built-in Mic on Tegra boards that use
 WM8903
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200320205504.30466-1-digetx@gmail.com>
 <c27c2087-14cf-614d-a8c0-05072a54f24b@wwwdotorg.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <da88ddff-e665-8cee-6f03-1a396602b076@nvidia.com>
Date:   Mon, 23 Mar 2020 15:59:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c27c2087-14cf-614d-a8c0-05072a54f24b@wwwdotorg.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584979139; bh=b6ALMa2hKrIs0XbyLi35X2cWmMd8kYGLuEPCzNi1WWw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qeJM2oCYmyTdv+5PKAJvYMTxoKTABCkjwRlWYo1L/hJ+ZjVMCUCoNkpWljEu+UXEi
         X9jtz/nigahYl9DIIc0Dmwv/DrUu9QaIyMPH7YB7lVEwftRVsOE7OYA3DYBenxfwO2
         BhXhVR4/uaBV53jjEdrafrkxGTtBO1C4uEwSZnqdBDuECOp3Y7Iu/IH+qqIluXu4zC
         fMIvd8R3zW5YT86pKzp2fH+prd9E3y2gcKZjdzRHSdjhnqT+NVTLAnO4x8SOZ4BqWw
         TxjzK8CFwYrhwvGtEcLNHmDVbtbdKBIvgTwfDGABeddiF/i+7wmoJ2PNJDnZJ6V1QH
         TjGm39gokcADQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2020 22:30, Stephen Warren wrote:
> On 3/20/20 2:55 PM, Dmitry Osipenko wrote:
>> Hello,
>>
>> This small series adds audio route for built-in microphone on NVIDIA Tegra
>> boards that use WM8903 CODEC. In particular this is needed in order to unmute
>> internal microphone on Acer A500 tablet device. I'm planning to send out the
>> device tree for the A500 for 5.8, so will be nice to get the microphone
>> sorted out. Please review and apply, thanks in advance.
> 
> It's been a long time since I looked at this code, but the series looks
> plausible,
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> (I wonder why machine->gpio_int_mic_en was already parse but never used!)

Looking at the ventana schematics, it appears that the internal-mic
signals was connected to a header and not an actual mic, so maybe we
never had a proper internal-mic on any board but allowed one to be
connected.

Anyway, looks good to me as well.

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
