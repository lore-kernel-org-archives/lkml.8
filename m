Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD73C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF2A207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGWNoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:44:24 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58583 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgGWNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:44:24 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 10D452002EE2B;
        Thu, 23 Jul 2020 15:44:21 +0200 (CEST)
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
 <20200703142939.28663-3-pmenzel@molgen.mpg.de>
 <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
Date:   Thu, 23 Jul 2020 15:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus, dear Christian,


Am 03.07.20 um 17:29 schrieb Christian König:
> Am 03.07.20 um 16:29 schrieb Paul Menzel:
>> The newly added hexint helper is more convenient for bitmasks.
>>
>> Before:
>>
>>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>>      4294950911
>>
>> After:
>>
>>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>>      0xffffbfff
>>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com> for this one.
> 
> Feel free to add my Acked-by to the other two, but I'm not familiar 
> enough with the code to review those.

Thank you. Sorry for being ignorant, but what is the way forward?


Kind regards,

Paul
