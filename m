Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F680206FA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRoXLk7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgCNBM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:12:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43377 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726591AbgCNBM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584148375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sRohLXaxjRGCa+ATXvR+suguw8D8taFzKqY4DxDFXfo=;
        b=eRoXLk7v2HDgECW0leE3FbsewV/H2DCoDnZ9hQ0oDJjIFMp0zsIsX73GdrrsOQXDcOx9fv
        11zrKDTknBH7d2PqAYkJzTkjnVGu4xePi6pkfFrVrr8TAEuBeXuS9FO0aNke7Zz4GH4/kW
        X+t6c49F0n3IZPV3tWHuR36faNy8RkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-N7MHovnZM-6qZy1S0sDg_A-1; Fri, 13 Mar 2020 21:12:53 -0400
X-MC-Unique: N7MHovnZM-6qZy1S0sDg_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA5E1005509;
        Sat, 14 Mar 2020 01:12:52 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A825DA2C;
        Sat, 14 Mar 2020 01:12:48 +0000 (UTC)
Date:   Sat, 14 Mar 2020 09:12:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v3] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200314011245.GB8518@MiWiFi-R3L-srv>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312141749.GL27711@MiWiFi-R3L-srv>
 <20200313145619.GD21007@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313145619.GD21007@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/20 at 03:56pm, Michal Hocko wrote:
> On Thu 12-03-20 22:17:49, Baoquan He wrote:
> > This change makes populate_section_memmap()/depopulate_section_memmap
> > much simpler.
> 
> Not only and you should make it more explicit. It also tries to allocate
> memmaps from the target numa node so this is a functional change. I
> would prefer to have that in a separate patch in case we hit some weird
> NUMA setups which would choke on memory less nodes and similar horrors.
> 
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> I do not see any reason this shouldn't work. Btw. did you get to test
> it?

Forget replying to this comment. Yes, I have tested it before each post.

