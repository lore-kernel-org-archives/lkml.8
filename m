Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EA4C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4742217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f86CXZ7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgBFJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:44:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56839 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgBFJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580982286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j89ZRjyPySj2i0cFZw0Myu3qfhZaIsYmgVAkyvTqqt8=;
        b=f86CXZ7ZbKrTfUNmV5+3YYQBSgv+B7xhY+wprP+3EaC0lgEGxsquw4cfD1qQ7QjwXdMwgh
        4zGDtJ02bQ1OkDvdXFnN7ytgPzNTdHSHk0hD++nYBdtNuOKQJ2gdqJldZ89N3fBQ/P5HDc
        owNFkvu9YnH6PdEfT7/h5e1P8O+06ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-gaGIx37vOA6F7prUHUnx9A-1; Thu, 06 Feb 2020 04:44:42 -0500
X-MC-Unique: gaGIx37vOA6F7prUHUnx9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C76D8010F7;
        Thu,  6 Feb 2020 09:44:41 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BEB15C1B0;
        Thu,  6 Feb 2020 09:44:37 +0000 (UTC)
Date:   Thu, 6 Feb 2020 17:44:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@kernel.org, jgross@suse.com,
        bsingharora@gmail.com
Subject: Re: [PATCH v3] mm/hotplug: Only respect mem= parameter during boot
 stage
Message-ID: <20200206094435.GG26758@MiWiFi-R3L-srv>
References: <20200204050643.20925-1-bhe@redhat.com>
 <e374a011-4f13-ee7a-fc31-dae6878037d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e374a011-4f13-ee7a-fc31-dae6878037d4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 09:55am, David Hildenbrand wrote:
> On 04.02.20 06:06, Baoquan He wrote:
> > In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> > parameter") a global varialbe max_mem_size is added to store
> > the value parsed from 'mem= ', then checked when memory region is
> > added. This truly stops those DIMMs from being added into system memory
> > during boot-time.
> > 
> > However, it also limits the later memory hotplug functionality. Any
> > DIMM can't be hotplugged any more if its region is beyond the
> > max_mem_size. We will get errors like:
> > 
> > [  216.387164] acpi PNP0C80:02: add_memory failed
> > [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> > [  216.392187] acpi PNP0C80:02: Enumeration failure
> > 
> > This will cause issue in a known use case where 'mem=' is added to
> > the hypervisor. The memory that lies after 'mem=' boundary will be
> > assigned to KVM guests. After commit 357b4da50a62 merged, memory
> > can't be extended dynamically if system memory on hypervisor is not
> > sufficient.
> > 
> > So fix it by also checking if it's during boot-time restricting to add
> > memory. Otherwise, skip the restriction.
> > 
> > And also add this use case to document of 'mem=' kernel parameter.
> > 
> > Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem= parameter")
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> >   In discussion of v1 and v2, People have concern about the use case
> >   related to the code change. So add the use case into patch log and
> >   document of 'mem=' in kernel-parameters.txt.
> > 
> >  Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++--
> >  mm/memory_hotplug.c                             |  8 +++++++-
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index ddc5ccdd4cd1..b809767e5f74 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2533,13 +2533,22 @@
> >  			For details see: Documentation/admin-guide/hw-vuln/mds.rst
> >  
> >  	mem=nn[KMG]	[KNL,BOOT] Force usage of a specific amount of memory
> > -			Amount of memory to be used when the kernel is not able
> > -			to see the whole system memory or for test.
> > +			Amount of memory to be used in cases as follows:
> > +
> > +			1 for test;
> > +			2 when the kernel is not able to see the whole system memory;
> > +			3 memory that lies after 'mem=' boundary is excluded from
> > +			 the hypervisor, then assigned to KVM guests.
> 
> I remember that there were more use cases, but forgot where that was
> documented :)

In fact, as long as it's not used for test, hotplug will be helpful, e.g
the 2nd use case. We use 'mem=' to skip these bad part of boot memory DIMMs,
while hotplug can help us to extend RAM with good DIMMs. No need to
discard the partly broken memmory board.

> 
> I do wonder if we want to change that now without anybody complaining.
> Yes, I brought up a possible use case but don't know if it is relevant
> in practice (IOW, nobody complained yet :) ).

Yes, I should hold it a while. Worry it's not clear enough. But in
kernel-parameters.txt, I can't write too many details about use case.

> 
> Would like to get Michals opinion on this.

Sure, will hold.  Thanks.

