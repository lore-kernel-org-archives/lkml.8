Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8145620855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pjCbM9vS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHTJDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:03:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14498 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHTJDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:03:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3e3bd5001d>; Thu, 20 Aug 2020 02:01:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Aug 2020 02:03:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Aug 2020 02:03:04 -0700
Received: from [10.25.96.247] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Aug
 2020 09:02:58 +0000
Subject: Re: [PATCH v2 0/9] Audio graph card updates and usage with Tegra210
 audio
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
References: <1596605064-27748-1-git-send-email-spujar@nvidia.com>
 <87v9highuf.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <8fa4a359-c80c-9c8f-93fa-c1cc25b322e8@nvidia.com>
Date:   Thu, 20 Aug 2020 14:32:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87v9highuf.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597914070; bh=l93EHFvud8eHnNf5HuttsftOmzf1SaVxatzJ4Lt47G8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=pjCbM9vSsTNYfabczFr41DPleV11yMC26g0HrwUCyslwN3LhT0yRZnjyHAQGv+7zn
         ERIfTz94Ctp7fikIKeSYmpySTLRP1VR/1v6a/rpZefKBcemsJ9tYInzNlXyCiUQsYu
         lTaBq6rNRYXWxM+xZIDw8sIOXPvHRPy3A337VD2zrOQanIe+NVd4mrjohacGiAPDbo
         bc3dBl+ZsvNWRVUpSSfHMpGxvRHLMsWLj5hZ1J6MCgegtrxY7msb4FF4Ae9YiqSzsp
         M+qwAt6n9Y46KVt35kxvMG2YKk42ZxqMKMSW1RyB+5sWWJ967j9U5C0eEJblT+FmCh
         Pz7MmtO821lMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuninori,

On 8/17/2020 7:23 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
> Cc Mark
>
>> This series proposes following enhancements to audio-graph card driver.
>>   * Support multiple instances of a component.
>>   * Support open platforms with empty Codec endpoint.
>>   * Identify no-pcm DPCM DAI links which can be used in BE<->BE connections.
>>   * Add new compatible to support DPCM based DAI chaining.
>>
>> This pushes DT support for Tegra210 based platforms which uses audio-graph
>> card and above enhancements.
>>
>> The series is based on following references where DPCM usgae for Tegra
>> Audio and simple-card driver proposal were discussed.
>>   * https://lkml.org/lkml/2020/4/30/519 (DPCM for Tegra)
>>   * https://lkml.org/lkml/2020/6/27/4 (simple-card driver)
> I will try to test this patch-set this week, and report/review it.

Thank you for review so far. Have you also got a chance to review 
remaining commits in the series?

>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto
