Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD65C208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om0I0XPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgEVWZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:25:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37051 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731122AbgEVWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590186354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE13U10VZKBg+i9d80FBqzbnGRh0EIeAg1GDlPx5sdM=;
        b=Om0I0XPAi+ZPAtTMbjsOpsygYXZ2xovnR7V/kOIs7j8f+z3p7+IpeT9sBbTVJAMGW6318j
        9LIchdcGB2x2RcyiAXjsx0jQ/Q8Y/4dWew8U1eYfzGtlvc6in7YJcROmXNrpCaqPgyHQxA
        0VVYnWwv3FbtBCZl+8+2VjrbkDHgal0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-6-QiEK-lMru0oEIMPGdXPw-1; Fri, 22 May 2020 18:25:52 -0400
X-MC-Unique: 6-QiEK-lMru0oEIMPGdXPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189C88005AA;
        Fri, 22 May 2020 22:25:51 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9894F1059138;
        Fri, 22 May 2020 22:25:47 +0000 (UTC)
Date:   Fri, 22 May 2020 16:25:45 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca, peterx@redhat.com
Subject: Re: [PATCH v3 0/3] vfio-pci: Block user access to disabled device
 MMIO
Message-ID: <20200522162545.28bb7db4@x1.home>
In-Reply-To: <20200522220858.GE1337@Qians-MacBook-Air.local>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
        <20200522220858.GE1337@Qians-MacBook-Air.local>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 18:08:58 -0400
Qian Cai <cai@lca.pw> wrote:

> On Fri, May 22, 2020 at 01:17:09PM -0600, Alex Williamson wrote:
> > v3:
> > 
> > The memory_lock semaphore is only held in the MSI-X path for callouts
> > to functions that may access MSI-X MMIO space of the device, this
> > should resolve the circular locking dependency reported by Qian
> > (re-testing very much appreciated).  I've also incorporated the
> > pci_map_rom() and pci_unmap_rom() calls under the memory_lock.  Commit
> > 0cfd027be1d6 ("vfio_pci: Enable memory accesses before calling
> > pci_map_rom") made sure memory was enabled on the info path, but did
> > not provide locking to protect that state.  The r/w path of the BAR
> > access is expanded to include ROM mapping/unmapping.  Unless there
> > are objections, I'll plan to drop v2 from my next branch and replace
> > it with this.  Thanks,  
> 
> FYI, the lockdep warning is gone.
> 

Thank you for testing!

Alex

