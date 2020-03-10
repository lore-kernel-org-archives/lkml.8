Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528C9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5DF22522
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTaAXrLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCJOXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:23:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55601 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbgCJOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583850229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=05PIOiFb78HsL2N8Fu5QTXsjc0scQVZNt+rybP6Bu5M=;
        b=KTaAXrLAbgoeFOFDb3Lroj1ihGyacyGiHwuzhfBJ3LYUxVe8CtQg+mKdWTXhFj5GZhwm3M
        qK+DeBsNMKEUXhXtRp4h66sPCJHTTAQP1podI7iPPHhH0CxeR7ylUAhq0Kxkw8Ts7UHq+P
        zlxRCJoI2UgoE7MNSy3NvhJ684mwYDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-BpZmEdNTPWa396AMN9XpVw-1; Tue, 10 Mar 2020 10:23:47 -0400
X-MC-Unique: BpZmEdNTPWa396AMN9XpVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A0C108C30F;
        Tue, 10 Mar 2020 14:23:45 +0000 (UTC)
Received: from localhost (ovpn-12-154.pek2.redhat.com [10.72.12.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB8D060BEE;
        Tue, 10 Mar 2020 14:23:44 +0000 (UTC)
Date:   Tue, 10 Mar 2020 22:23:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: Remove the redundant conditional check
Message-ID: <20200310142341.GG27711@MiWiFi-R3L-srv>
References: <20200308013511.12792-1-bhe@redhat.com>
 <20200310101044.GE8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310101044.GE8447@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/20 at 11:10am, Michal Hocko wrote:
> On Sun 08-03-20 09:35:11, Baoquan He wrote:
> > In commit f70029bbaacbfa8f0 ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> > the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY, so the
> > conditional check in paging_init() doesn't make any sense any more.
> > Remove it.
> 
> Please expand more. I would really have to refresh the intention of the
> code but from a quick look at the code CONFIG_HIGHMEM still makes
> N_MEMORY != N_NORMAL_MEMORY. So what what does this change mean for that
> config?

Thanks for looking into this. I was trying to explain that
CONFIG_MOVABLE_NODE made N_MEMORY have chance to take different enum
value.
 
Do you think the below saying is OK to you?
 
~~~
In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY.  Before
commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
(N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
doesn't have any chance to be equal to N_NORMAL_MEMORY. So the  conditional
check in paging_init() doesn't make any sense any more. Let's remove it.
~~~
 
Thanks
Baoquan

