Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4F9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14D02076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgCXPU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:20:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbgCXPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BBB0AC92;
        Tue, 24 Mar 2020 15:20:27 +0000 (UTC)
Subject: Re: [PATCH 1/2] xen: expand BALLOON_MEMORY_HOTPLUG description
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20200324150015.50496-1-roger.pau@citrix.com>
 <42a7b408-1ea1-04fa-e70b-cbdaba54c558@suse.com>
 <20200324151855.GN24458@Air-de-Roger.citrite.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c00093fe-9b0d-02c1-0525-2a88de78a3a2@suse.com>
Date:   Tue, 24 Mar 2020 16:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324151855.GN24458@Air-de-Roger.citrite.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.20 16:18, Roger Pau Monné wrote:
> On Tue, Mar 24, 2020 at 04:13:48PM +0100, Jürgen Groß wrote:
>> On 24.03.20 16:00, Roger Pau Monne wrote:
>>> To mention it's also useful for PVH or HVM domains that require
>>> mapping foreign memory or grants.
>>>
>>> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
>>> ---
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>> Cc: xen-devel@lists.xenproject.org
>>> ---
>>>    drivers/xen/Kconfig | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>>> index 61212fc7f0c7..57ddd6f4b729 100644
>>> --- a/drivers/xen/Kconfig
>>> +++ b/drivers/xen/Kconfig
>>> @@ -19,6 +19,10 @@ config XEN_BALLOON_MEMORY_HOTPLUG
>>>    	  It is very useful on critical systems which require long
>>>    	  run without rebooting.
>>> +	  It's also very useful for translated domains (PVH or HVM) to obtain
>>
>> I'd rather say "(non PV)" or "(PVH, HVM or Arm)".
> 
> I'm fine with any of the variants. Would you mind adjusting when
> picking it up or would you like me to resend?

No need to resend. I'll use the "non PV" variant.


Juergen

