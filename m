Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6046C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC3920678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586419173;
	bh=PnH5m1FDospWcQGC77SnK6HqxZHyM1JKFuCxGMduYno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=16r1O++tpP1kUGP5lJdJRd89ctuz3J1xCTs4EnpKa0DFVaQWLGnC6GVA8QNuB39X8
	 273FL1lh6wWfLG67i0dBm93BD8Y/LhXF1JA72j/vryzaWLePY1hmhGbcTvoWgW2d7h
	 RMgxoEbF3BdQVXLbMwozVEkYEhlaqmv0iheUDQn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDIH7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:59:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53703 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:59:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so2911314wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7aTkrJXqv2ZbDFk7CEzBnxc6D6u1o+Ia6P0f4mFbFV8=;
        b=RtBySiUDfA2Rebd9Q4iBdX15N5MYedefaju9wr4+DD+nv9V5/x5UqyfmWwkWuC1C33
         4HMsuIIozI0v4xQvQJ3MsSbMi8n5EJgZIr9gnA0YB6bs4yA/PfeeRoQCB3VLaWrMnNJg
         RbxATp88Vek9JZJZyuKYaWocI7LxpnV7NIYk1HKxhOS/jrgaQSWcr4kedJDfGNajUyO5
         N7H/LkzoSR2u6ZXpHMHZBip/qDMA9u96yanq8hm0ZiyDOiNiLe+SgdlDekhpZa54j/Cj
         HoCeuWRWaedDvpHW3Jgnb99ifcKbyTX52FNxh3u2t+LiwMZJ5V8dLTME8Wo+OWBjedZH
         PPaw==
X-Gm-Message-State: AGi0Pubgn2xVbf4Ykv2r6qjfhSgmpnT+NY8YLXAEM5CYCmYt14kTHITJ
        fdq004jmMmqp4XllVzo2+iM=
X-Google-Smtp-Source: APiQypLF3rX8q4/0ETJueh+0y6VY0OOa4Qm9U2dPCpWP+b4Cb0cvwVi9cfda2DXukoQvwZZcCvJTsQ==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr9019734wml.181.1586419170075;
        Thu, 09 Apr 2020 00:59:30 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id b82sm2901790wmh.1.2020.04.09.00.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 00:59:28 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:59:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] powerpc/pseries/hotplug-memory: stop checking
 is_mem_section_removable()
Message-ID: <20200409075927.GC18386@dhcp22.suse.cz>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-2-david@redhat.com>
 <87sghdjf1y.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sghdjf1y.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-04-20 17:26:01, Michael Ellerman wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> > In commit 53cdc1cb29e8 ("drivers/base/memory.c: indicate all memory
> > blocks as removable"), the user space interface to compute whether a memory
> > block can be offlined (exposed via
> > /sys/devices/system/memory/memoryX/removable) has effectively been
> > deprecated. We want to remove the leftovers of the kernel implementation.
> >
> > When offlining a memory block (mm/memory_hotplug.c:__offline_pages()),
> > we'll start by:
> > 1. Testing if it contains any holes, and reject if so
> > 2. Testing if pages belong to different zones, and reject if so
> > 3. Isolating the page range, checking if it contains any unmovable pages
> >
> > Using is_mem_section_removable() before trying to offline is not only racy,
> > it can easily result in false positives/negatives. Let's stop manually
> > checking is_mem_section_removable(), and let device_offline() handle it
> > completely instead. We can remove the racy is_mem_section_removable()
> > implementation next.
> >
> > We now take more locks (e.g., memory hotplug lock when offlining and the
> > zone lock when isolating), but maybe we should optimize that
> > implementation instead if this ever becomes a real problem (after all,
> > memory unplug is already an expensive operation). We started using
> > is_mem_section_removable() in commit 51925fb3c5c9 ("powerpc/pseries:
> > Implement memory hotplug remove in the kernel"), with the initial
> > hotremove support of lmbs.
> 
> It's also not very pretty in dmesg.
> 
> Before:
> 
>   pseries-hotplug-mem: Attempting to hot-add 10 LMB(s)
>   pseries-hotplug-mem: Memory hot-add failed, removing any added LMBs
>   dlpar: Could not handle DLPAR request "memory add count 10"

Yeah, there is more output but isn't that useful? Or put it differently
what is the actual problem from having those messages in the kernel log?

From the below you can clearly tell that there are kernel allocations
which prevent hot remove from happening.

If the overall size of the debugging output is a concern then we can
think of a way to reduce it. E.g. once you have a couple of pages
reported then all others from the same block are likely not interesting
much.
-- 
Michal Hocko
SUSE Labs
