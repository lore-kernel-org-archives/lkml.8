Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C50DC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B8E2072A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 13:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwCicZqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgCONBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 09:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728541AbgCONBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 09:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584277296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Vu5zsudYYqS5yEggDJZCdE3LfHp+URDrrnpUuluAkU=;
        b=OwCicZqnkgWJub2BpzAjUfu9nwy4meCOIpYYO49NK/Eu3UH8snxdMDnMz+PiXT2Hojor4C
        17rTYdH3fzTn5Cvj0f2l1nMOL0LWKmyC5e4pTVoamL+HOOosv1eq5SfKVIke1t5oUE44ti
        tF6QB+jOV6JiMCzCaPAi36ihsIBbPJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-VhV55TBoPV-qeirjvcTtSg-1; Sun, 15 Mar 2020 09:01:34 -0400
X-MC-Unique: VhV55TBoPV-qeirjvcTtSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAFED13EA;
        Sun, 15 Mar 2020 13:01:32 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4E792718C;
        Sun, 15 Mar 2020 13:01:29 +0000 (UTC)
Date:   Sun, 15 Mar 2020 21:01:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v3] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200315130127.GB3486@MiWiFi-R3L-srv>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312141749.GL27711@MiWiFi-R3L-srv>
 <20200313145619.GD21007@dhcp22.suse.cz>
 <20200314005334.GO27711@MiWiFi-R3L-srv>
 <20200314125638.GC10912@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314125638.GC10912@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/20 at 01:56pm, Michal Hocko wrote:
> On Sat 14-03-20 08:53:34, Baoquan He wrote:
> > On 03/13/20 at 03:56pm, Michal Hocko wrote:
> > > On Thu 12-03-20 22:17:49, Baoquan He wrote:
> > > > This change makes populate_section_memmap()/depopulate_section_memmap
> > > > much simpler.
> > > 
> > > Not only and you should make it more explicit. It also tries to allocate
> > > memmaps from the target numa node so this is a functional change. I
> > > would prefer to have that in a separate patch in case we hit some weird
> > > NUMA setups which would choke on memory less nodes and similar horrors.
> > 
> > Yes, splitting sounds more reasonable, I would love to do that. One
> > question is I noticed Andrew had picked this into -mm tree, if I post a
> > new patchset including these two small patches, whether it's convenient
> > to drop the old one and get these two merged.
> 
> Andrew usually just drops the previous version and replaces it by the
> new one. So just post a new version. Thanks!

I see, will post a new version, thanks.

