Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118E0C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0420866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgCDSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:40:15 -0500
Received: from david.siemens.de ([192.35.17.14]:47634 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbgCDSkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:40:14 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 024IdxCw013234
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 19:39:59 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 024Idx2V020732;
        Wed, 4 Mar 2020 19:39:59 +0100
Subject: Re: x2apic_wrmsr_fence vs. Intel manual
To:     Dave Hansen <dave.hansen@intel.com>, x86 <x86@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <783add60-f6c7-c8c6-b369-42e5ebfbf8c9@siemens.com>
 <602968e1-c1e4-0980-effa-e9c40b82c8c8@intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8421f726-0ef0-f253-4d98-ec8a4556cb8e@siemens.com>
Date:   Wed, 4 Mar 2020 19:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <602968e1-c1e4-0980-effa-e9c40b82c8c8@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.20 19:27, Dave Hansen wrote:
> On 3/2/20 8:11 AM, Jan Kiszka wrote:
>> The former dates back to ce4e240c279a, but that commit does not mention
>> why lfence is not needed. Did the manual read differently back then? Or
>> why are we safe? To my reading of lfence, it also has a certain
>> instruction serializing effect that mfence does not have.
> 
> I asked around Intel about this.
> 
> The old "SFENCE, or MFENCE" recommendation was deemed insufficient
> because it has no impact on the ordering of WRMSR since it is not a
> "load or store instruction".  LFENCE's instruction-ordering semantic is
> needed because it ensures later ordering of all instructions, not just
> loads and stores.
> 
> Jan, do you think you're seeing a bug resulting from WRMSR ordering?
> 

Nope, not so far. I'm hunting a race between two guests over Jailhouse 
where the kick (sent as IPI) seems to come before the data, but changing 
the fences didn't solve it, unfortunately. Along that, I was reading 
code and manuals up and down and ran into this inconsistency. That's the 
story.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
