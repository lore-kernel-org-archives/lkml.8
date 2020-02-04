Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A49EC3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5672021582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBDHxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:53:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:38954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgBDHxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:53:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65A60AD4F;
        Tue,  4 Feb 2020 07:53:31 +0000 (UTC)
Subject: Re: [PATCH v3] mm/hotplug: Only respect mem= parameter during boot
 stage
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        david@redhat.com, bsingharora@gmail.com
References: <20200204050643.20925-1-bhe@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <1356631d-30b6-e967-9874-6c48c25304cf@suse.com>
Date:   Tue, 4 Feb 2020 08:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200204050643.20925-1-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.20 06:06, Baoquan He wrote:
> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> parameter") a global varialbe max_mem_size is added to store
> the value parsed from 'mem= ', then checked when memory region is
> added. This truly stops those DIMMs from being added into system memory
> during boot-time.
> 
> However, it also limits the later memory hotplug functionality. Any
> DIMM can't be hotplugged any more if its region is beyond the
> max_mem_size. We will get errors like:
> 
> [  216.387164] acpi PNP0C80:02: add_memory failed
> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> [  216.392187] acpi PNP0C80:02: Enumeration failure
> 
> This will cause issue in a known use case where 'mem=' is added to
> the hypervisor. The memory that lies after 'mem=' boundary will be
> assigned to KVM guests. After commit 357b4da50a62 merged, memory
> can't be extended dynamically if system memory on hypervisor is not
> sufficient.
> 
> So fix it by also checking if it's during boot-time restricting to add
> memory. Otherwise, skip the restriction.
> 
> And also add this use case to document of 'mem=' kernel parameter.
> 
> Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem= parameter")
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
