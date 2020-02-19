Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524EDC3402F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259B220801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1qtW8nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBSDqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:46:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38606 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726439AbgBSDqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582083983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5voZACXFV81htqnt4nR2mt4oTLYSPf9zR9T58PnHHYo=;
        b=J1qtW8nY2Ljocdr8vVuFkfVudomMQHUIVFp029Lsfnp8CkFDeNzXfgMhuw3tTl0soduZcf
        WvLquHnK+pUyOA+PZ54Wth3lC+Gw13YJRkQQugZwbjQ4wvDMcogf5U/Z7dvLA1E1NPsT30
        l8hkfHd/nxqpTr2amXxZJCx1Txxg3QY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-_BJfIkVtNZyK6a-9dyXMLA-1; Tue, 18 Feb 2020 22:46:19 -0500
X-MC-Unique: _BJfIkVtNZyK6a-9dyXMLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E5998017CC;
        Wed, 19 Feb 2020 03:46:18 +0000 (UTC)
Received: from localhost (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D95425C13C;
        Wed, 19 Feb 2020 03:46:14 +0000 (UTC)
Date:   Wed, 19 Feb 2020 11:46:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 RESEND] mm/sparsemem: pfn_to_page is not valid yet on
 SPARSEMEM
Message-ID: <20200219034612.GB4937@MiWiFi-R3L-srv>
References: <20200219030454.4844-1-bhe@redhat.com>
 <CAPcyv4iZCnSpypshYpXCL35yT4KZfgXqDqS8cFDGpXC-A72Utg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iZCnSpypshYpXCL35yT4KZfgXqDqS8cFDGpXC-A72Utg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/20 at 07:25pm, Dan Williams wrote:
> On Tue, Feb 18, 2020 at 7:05 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > From: Wei Yang <richardw.yang@linux.intel.com>
> >
> > When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> > doesn't work before sparse_init_one_section() is called. This leads to a
> > crash when hotplug memory:
> 
> I'd also add:
> 
> "On x86 the impact is limited to x86_32 builds, or x86_64
> configurations that override the default setting for
> SPARSEMEM_VMEMMAP".


'When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP' in the current log
is a little duplicated with the overriding saying?

