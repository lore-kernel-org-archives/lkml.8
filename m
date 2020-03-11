Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08847C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01B2222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG4E40h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgCKBPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:15:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727841AbgCKBPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583889316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHNqNcapHNYcvUWYaYS5wNa5BPRKhXutIKImD0HOT6s=;
        b=WG4E40h5GFMzS8vYWmUpGrQI2ekCZ+wVV8N3ys5UiUbpFuCCqGYiMFAeQ2Gc3ltkihoSus
        c2lvhhVu6UHSpBBT7ycgdF0oH2c0gyg4ynzY9eT0BWauqs/tsWD2NeA8D6DQVcroTFkV2e
        0tO5Fr0YGsbFczWf9xFPhV++Gw/KcOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-fGbS7vi4Pl-Tlw9EUtWfxw-1; Tue, 10 Mar 2020 21:15:15 -0400
X-MC-Unique: fGbS7vi4Pl-Tlw9EUtWfxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E469B13F6;
        Wed, 11 Mar 2020 01:15:13 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2257C909FA;
        Wed, 11 Mar 2020 01:15:12 +0000 (UTC)
Date:   Wed, 11 Mar 2020 09:15:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: Remove the redundant conditional check
Message-ID: <20200311011510.GH27711@MiWiFi-R3L-srv>
References: <20200308013511.12792-1-bhe@redhat.com>
 <20200310101044.GE8447@dhcp22.suse.cz>
 <20200310142341.GG27711@MiWiFi-R3L-srv>
 <20200310143240.GL8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310143240.GL8447@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/20 at 03:32pm, Michal Hocko wrote:
> On Tue 10-03-20 22:23:41, Baoquan He wrote:
> > On 03/10/20 at 11:10am, Michal Hocko wrote:
> > > On Sun 08-03-20 09:35:11, Baoquan He wrote:
> > > > In commit f70029bbaacbfa8f0 ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> > > > the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY, so the
> > > > conditional check in paging_init() doesn't make any sense any more.
> > > > Remove it.
> > > 
> > > Please expand more. I would really have to refresh the intention of the
> > > code but from a quick look at the code CONFIG_HIGHMEM still makes
> > > N_MEMORY != N_NORMAL_MEMORY. So what what does this change mean for that
> > > config?
> > 
> > Thanks for looking into this. I was trying to explain that
> > CONFIG_MOVABLE_NODE made N_MEMORY have chance to take different enum
> > value.
> >  
> > Do you think the below saying is OK to you?
> >  
> > ~~~
> > In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> > the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY.  Before
> > commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
> > (N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
> > doesn't have any chance to be equal to N_NORMAL_MEMORY. So the  conditional
> > check in paging_init() doesn't make any sense any more. Let's remove it.
> 
> Yes this describes the matter much better. I have obviously misread the
> code when looking at it this morning. Being explicit in the changelog
> would have helped at least me. Thanks!

Will update log and repost, thanks.

