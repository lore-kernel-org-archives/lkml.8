Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9E2C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F8720738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCQOvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:51:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgCQOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:51:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDA10AFFD;
        Tue, 17 Mar 2020 14:51:07 +0000 (UTC)
Subject: Re: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312092531.GU23944@dhcp22.suse.cz>
 <BL0PR02MB5601B50A2D9AEE6318D51893E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312132642.GW23944@dhcp22.suse.cz>
 <4ea2e014-17ea-6d1e-a6cd-775fb6550cd2@suse.cz>
 <20200317082913.GE26018@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4e08008f-bf20-6a9c-0ffb-f6438c326612@suse.cz>
Date:   Tue, 17 Mar 2020 15:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317082913.GE26018@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/20 9:29 AM, Michal Hocko wrote:
> On Mon 16-03-20 15:53:21, Vlastimil Babka wrote:
>> On 3/12/20 2:26 PM, Michal Hocko wrote:
> 
> This sounds like a much better idea than a case by case handling. I
> wouldn't be surprised if some kernel parameters would duplicate sysctl
> values. I cannot judge the implementation unfortunately but from a quick
> glance it makes sense to me. Especially where you hooked it into because
> not all handlers are simple setters for a global value. Some of them
> have a much more complicated logic which requires a lot of
> infrastructure to be set up already. So putting do_sysctl_args right
> before the init is executed should be good enough.
> 
> Care to post an RFC to a larger audience? Let's see where we get from
> there.

FYI done: (I didn't CC everybody from this thread)

https://lore.kernel.org/linux-api/20200317132105.24555-1-vbabka@suse.cz/
