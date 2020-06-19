Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36395C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1105E2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592568431;
	bh=JG6wlESc37vW6YVMVRhjMEDRMoyDJ8cmczp3+E0WE5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SuwtDGVSwPgtLwdVAWEOJ7HZrPdU3u3DC5uqFu3ZvedBJBXdIcf0l1JywNheALddC
	 sddSqT8fgXTlAtXZUfSGlQ6gJph0dNaAH/Y+7u4cReJ2MiPZwyAAogyZNtMX+we3Q2
	 sToVmVYdsDSIHPxitLPASGheIRS3gDomhSD/ocIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbgFSMHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:07:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32821 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbgFSMHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:07:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id o26so7438875edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FCgGElYZkmUmaA6JH2fsnooqQnU7ecDqoues9JmTDO4=;
        b=liet1sk2OZC/E0wskDpeTTREqZ2K6z0V+Ar5IK4CUmCMwoLfWqsOsJUO+GNmWghycG
         RjA0ue7krIvNwLSw8FlF16PRmzy41KoGUQZLwjM9MhIGYX/7exGL9ygDvYtzs160DFC5
         scEf4vccuHK556BPmVN/Pqj6NetFyxj958AkxOP2T6ogW+xtD8z2RiEO+2rPAzoVBmiZ
         mPh3novCLXB0zLzgbtxCZm0X0ubG2nXAAXjXva9ZYhKM4/oGSYrSfwsqmjUKQHJeZJGE
         kkriH9xJf7vhY4GSKXf11dn4hFPBI92DjdUBp37uhPt94PPfTGjk+DBt6s3KZj2DTgJc
         ku7A==
X-Gm-Message-State: AOAM530QOrjMaPpFon9X7jahVcIh9G3D3swOh1y1dX0BfvHk2s9fDe44
        NC2aJZmJRJuvqISw8Sowld8=
X-Google-Smtp-Source: ABdhPJwanPG2AiqwbdvTfmxmMlKJkv9Ym8BRRBtspbNfvUfvQbUcEvc9LjS5GY4fUw4XoO9ZCSziWg==
X-Received: by 2002:aa7:ccc2:: with SMTP id y2mr2879408edt.97.1592568426584;
        Fri, 19 Jun 2020 05:07:06 -0700 (PDT)
Received: from localhost (ip-37-188-189-34.eurotel.cz. [37.188.189.34])
        by smtp.gmail.com with ESMTPSA id t9sm4650506ejy.43.2020.06.19.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 05:07:05 -0700 (PDT)
Date:   Fri, 19 Jun 2020 14:07:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
Message-ID: <20200619120704.GD12177@dhcp22.suse.cz>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-06-20 18:54:51, Daniel Jordan wrote:
[...]
> @@ -1390,6 +1391,15 @@ static unsigned long probe_memory_block_size(void)
>  		goto done;
>  	}
>  
> +	/*
> +	 * Use max block size to minimize overhead on bare metal, where
> +	 * alignment for memory hotplug isn't a concern.

This really begs a clarification why this is not a concern. Bare metal
can see physical memory hotadd as well. I just suspect that you do not
consider that to be very common so it is not a big deal? And I would
tend to agree but still we are just going to wait until first user
stumbles over this.

Btw. memblock interface just doesn't scale and it is a terrible
interface for large machines and for the memory hotplug in general (just
look at ppc and their insanely small memblocks).

Most usecases I have seen simply want to either offline some portion of
memory without a strong requirement of the physical memory range as long
as it is from a particular node or simply offline and remove the full
node.

I believe that we should think about a future interface rather than
trying to ducktape the blocksize anytime it causes problems. I would be
even tempted to simply add a kernel command line option 
memory_hotplug=disable,legacy,new_shiny

for disable it would simply drop all the sysfs crud and speed up boot
for most users who simply do not care about memory hotplug. new_shiny
would ideally provide an interface that would either export logically
hotplugable memory ranges (e.g. DIMMs) or a query/action interface which
accepts physical ranges as input. Having gazillions of sysfs files is
simply unsustainable.
-- 
Michal Hocko
SUSE Labs
