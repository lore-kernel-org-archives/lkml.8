Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACA8C4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BE421D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aB6CJYWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgBZDxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:53:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgBZDxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582689228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPawdqnS4wqhOXPwRMpMZXtAzJ3OHZG8p6E7J26KlZ8=;
        b=aB6CJYWvr+5zDahbGBXsuld47MifqtKcFymaX6I4He6rm9e53C/R8MyYEjIE+fVTAOMXuY
        lLPF2PJnPpOHppfcijpMOGJk4WZBfVgGozYykbsRTWAKUkg4diQdU2DXwEjPAWQIgyAQRR
        /Zu1IXtMlfbMYde9Q+mnRvwZMVid7H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-qbuKqQ2GNoKbWmazEt9ICw-1; Tue, 25 Feb 2020 22:53:44 -0500
X-MC-Unique: qbuKqQ2GNoKbWmazEt9ICw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50C58017CC;
        Wed, 26 Feb 2020 03:53:42 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ECBF92966;
        Wed, 26 Feb 2020 03:53:39 +0000 (UTC)
Date:   Wed, 26 Feb 2020 11:53:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 4/7] mm/sparse.c: only use subsection map in VMEMMAP
 case
Message-ID: <20200226035336.GF24216@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-5-bhe@redhat.com>
 <20200225095713.GL22443@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225095713.GL22443@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/20 at 10:57am, Michal Hocko wrote:
> On Thu 20-02-20 12:33:13, Baoquan He wrote:
> > Currently, subsection map is used when SPARSEMEM is enabled, including
> > VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> > supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
> > and misleading. Let's adjust code to only allow subsection map being
> > used in VMEMMAP case.
> 
> This really needs more explanation I believe. What exactly happens if
> somebody tries to hotremove a part of the section with !VMEMMAP? I can
> see that clear_subsection_map returns 0 but that is not an error code.
> Besides that section_deactivate doesn't propagate the error upwards.
> /me stares into the code
> 
> OK, I can see it now. It is relying on check_pfn_span to use the proper
> subsection granularity. This really begs for a comment in the code
> somewhere.

Yes, check_pfn_span() guards it. People have no way to hot add/remove
on non-section aligned block with !VMEMMAP.

I have added extra comment to above section_activate() to note this,
please check patch 5/7. Let me see how to add words to reflect the
check_pfn_span() guard thing.

