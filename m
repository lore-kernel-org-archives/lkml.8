Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B91120720
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jlJV57Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHXHSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:18:03 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1341 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHXHSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:18:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43699b0000>; Mon, 24 Aug 2020 00:17:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 00:18:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 00:18:01 -0700
Received: from [10.2.58.8] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 07:18:00 +0000
Subject: Re: [GIT PULL] tee subsystem pin_user_pages for v5.8
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Olof Johansson <olof@lixom.net>
List-Id: <soc.lore.kernel.org>
CC:     ARM-SoC Maintainers <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
References: <20200526131259.GA97001@jade> <20200821184910.GB3407@lx2k>
 <f7c8bb6e-e732-2565-8b50-20f5504701c9@nvidia.com>
 <CAOesGMjKq3ECJuaMANq=AyDMLXYvorafMYS3LDr9YMH6M9VdYA@mail.gmail.com>
 <CAHUa44EGf1yayXhHUJLUmbNpueKMZ9jArT4narJLzOVWujHR9A@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d757854b-577c-b8f2-8b67-526385101d68@nvidia.com>
Date:   Mon, 24 Aug 2020 00:18:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHUa44EGf1yayXhHUJLUmbNpueKMZ9jArT4narJLzOVWujHR9A@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598253467; bh=4vttQ/KNTevcP8Lhc43eLbaEsbq1qATO1KNb7WQXbF8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jlJV57Dz0MWw2dXUqUVHlm93Zjog9Oy0yFVFI5J1AfXuALU7MrsWGfStY0/Vi1RsX
         LEEbIVkLUr7YleA5UW5lfySMW1nssaRwpRhYWEyJaZxuymi4lgxf/7a8kqJKZ2Lu79
         ulmZuZLRAegjuTAonz+y6zTQ3sG+lSUMwCwpMcp9VTcdiTv6C+JP7NER8JfPLakT1L
         whXN8beQqjp+NVV+CPrwrxWLBSdlezp+2KQvhTfwxv5fqWCEKP5lDOz26GcAjLDlm4
         GsqUw2pyKsHtkgHwNvGC0IUE79G4iFI5cKKUfENVsT+MgeQS9VceavPLT0cnG3eoRg
         I891ULHWPk7Aw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/20 11:51 PM, Jens Wiklander wrote:
> On Fri, Aug 21, 2020 at 11:19 PM Olof Johansson <olof@lixom.net> wrote:
>>
>> On Fri, Aug 21, 2020 at 12:58 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>
>>> On 8/21/20 11:49 AM, Olof Johansson wrote:
>>>> On Tue, May 26, 2020 at 03:12:59PM +0200, Jens Wiklander wrote:
>>>>> Hello arm-soc maintainers,
>>>>>
>>>>> Please pull this small patch converting the tee subsystem to use
>>>>> pin_user_pages() instead of get_user_pages().
>>>>>
>>>>> Thanks,
>>>>> Jens
>>>>>
>>>>> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
>>>>>
>>>>>     Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>     git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.8
>>>>>
>>>>> for you to fetch changes up to 37f6b4d5f47b600ec4ab6682c005a44a1bfca530:
>>>>>
>>>>>     tee: convert get_user_pages() --> pin_user_pages() (2020-05-26 10:42:41 +0200)
>>>>
>>>> Hi, I noticed this never got merged, but I don't see any follow-up here that
>>>> retracts it. Is it still pending merge such that I should queue it for v5.10?
>>>>
>>>
>>> I think so. I had marked it in my notes as "accepted, and the maintainer will
>>> eventually merge it", and I left it at that. It's still desirable.
>>>
>>
>> Looks like it conflicts with some of the later work. Jens, given the
>> timelines here it's probably easiest all around if you rebase/respin
>> and send a fresh pull request. I could fix it up but you'd still need
>> to review that so the amount of work is probably less if you do it
>> directly.
> 
> Agree, I'll send a fresh pull request once we have this rebased.
> The conflict is with the recently added call to get_kernel_pages()
> when kernel memory is shared.
> The conflict isn't trivial, I guess we need to handle the different
> types of pages differently when releasing them.
> John, would you mind rebasing and posting the patch again?
> 

Sure. Should it be against 5.9-rc2, or something else? I can do this in the morning,
about 10 hrs from now.

thanks,
-- 
John Hubbard
NVIDIA
