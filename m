Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE9C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321822053B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU7nxNbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGWDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:03:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbgEGWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588889023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aspV1wJ37EFxEstXvcVEniumgTmeoY91YcA15b/xS8E=;
        b=LU7nxNbDItAGiU4CfK7K3bjKk9iTvV3dqSVhnYGOu8XIZi/F9jOjpGIsuLuDzJwEJTKzQA
        N7/1TSrjcII7wRi0zoMCprOXozREsBM9l6ifR0jDmVz4impPV9FLKPiYwCVYs1/eeKqazF
        gxIq7tcouwJZTszbPPkoTKYzxlh1r6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-LL_F_fyvPrOgRP04awRMaA-1; Thu, 07 May 2020 18:03:39 -0400
X-MC-Unique: LL_F_fyvPrOgRP04awRMaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63581180081D;
        Thu,  7 May 2020 22:03:38 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AED8B579AD;
        Thu,  7 May 2020 22:03:34 +0000 (UTC)
Date:   Thu, 7 May 2020 16:03:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 2/3] vfio-pci: Fault mmaps to enable vma tracking
Message-ID: <20200507160334.4c029518@x1.home>
In-Reply-To: <20200507214744.GP228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
        <158871569380.15589.16950418949340311053.stgit@gimli.home>
        <20200507214744.GP228260@xz-x1>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 17:47:44 -0400
Peter Xu <peterx@redhat.com> wrote:

> Hi, Alex,
> 
> On Tue, May 05, 2020 at 03:54:53PM -0600, Alex Williamson wrote:
> > +/*
> > + * Zap mmaps on open so that we can fault them in on access and therefore
> > + * our vma_list only tracks mappings accessed since last zap.
> > + */
> > +static void vfio_pci_mmap_open(struct vm_area_struct *vma)
> > +{
> > +	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);  
> 
> A pure question: is this only a safety-belt or it is required in some known
> scenarios?

It's not required.  I originally did this so that I'm not allocating a
vma_list entry in a path where I can't return error, but as Jason
suggested I could zap here only in the case that I do encounter that
allocation fault.  However I still like consolidating the vma_list
handling to the vm_ops .fault and .close callbacks and potentially we
reduce the zap latency by keeping the vma_list to actual users, which
we'll get to eventually anyway in the VM case as memory BARs are sized
and assigned addresses.

> In all cases:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!
Alex

