Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF12EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D520724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM5801L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMKzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:55:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58810 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbgCMKzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584096935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKE4vw7Aq1hkeMcRey40fPC/eJbamV54hF6NTYtSkDU=;
        b=cM5801L0zlIE2JURaVX7C/h4w88RhYNHQu4LQH6ZQ+v4Z/ePsRa+2bcBaXyeO2aKY6jD0C
        75pOuqD6Wckz+YfyuSL1E45ySwgnrSwONUEaZ9AJNdWBIX62v91IuH9GcfEaXUzdt/eiQ2
        tmqcdTVXPceOeVpkK5KIepP+R6T323c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-xiJ0T0aOOeuAPdCscmJDng-1; Fri, 13 Mar 2020 06:55:31 -0400
X-MC-Unique: xiJ0T0aOOeuAPdCscmJDng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAF8B801E6C;
        Fri, 13 Mar 2020 10:55:30 +0000 (UTC)
Received: from localhost (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B087C19C6A;
        Fri, 13 Mar 2020 10:55:29 +0000 (UTC)
Date:   Fri, 13 Mar 2020 18:55:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20200313105526.GM27711@MiWiFi-R3L-srv>
References: <20200313214214.4d2e2af6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313214214.4d2e2af6@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/20 at 09:42pm, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (x86_64
> allnoconfig) produced this warning:

I tried with allnoconfig on x86_64, make doesn't trigger below warnings.

Hi Andrew,

Should we fix this kind of warning? If have to, I'll try to make several 
macro functions like subsection_map_init does for !CONFIG_SPARSEMEM.

> 
> mm/sparse.c:311:12: warning: 'fill_subsection_map' defined but not used [-Wunused-function]
>   311 | static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>       |            ^~~~~~~~~~~~~~~~~~~
> mm/sparse.c:306:13: warning: 'is_subsection_map_empty' defined but not used [-Wunused-function]
>   306 | static bool is_subsection_map_empty(struct mem_section *ms)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> mm/sparse.c:301:12: warning: 'clear_subsection_map' defined but not used [-Wunused-function]
>   301 | static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>       |            ^~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commits
> 
>   38eb09ac7c29 ("mm/sparse.c: introduce new function fill_subsection_map()")
>   334411156ba6 ("mm/sparse.c: introduce a new function clear_subsection_map()")
> 
> Or maybe laster patches.
> 
> -- 
> Cheers,
> Stephen Rothwell


