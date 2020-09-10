Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D4C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AC920719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKpyRZF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgIJRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:02:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727808AbgIJQ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599757066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1N39+l9Ba/WkrqUymZo6lvs+0CWTXq8+9In9bijFEEk=;
        b=FKpyRZF083iFmSs87VLe1ptwiUnjd/vfBMzLUMdTxEfAEq1NJlcG3Gvkzqwrx/8bkzb9dj
        b99EXH8RL0qtD8xOWtDBbj44POVRNrwv8BKoVQmE95TXfhWjAAyAYF0RkqBxFHPJh8IIYB
        6KeLC8e8gLi7YD6AHLxLALPqgRHT6l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-b_SV9j85Oa6bodKfoGhiyA-1; Thu, 10 Sep 2020 12:57:42 -0400
X-MC-Unique: b_SV9j85Oa6bodKfoGhiyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A74B420E7;
        Thu, 10 Sep 2020 16:57:41 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48C97100239A;
        Thu, 10 Sep 2020 16:57:36 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:57:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Auger Eric <eric.auger@redhat.com>
Subject: Re: MSI/MSIX for VFIO platform
Message-ID: <20200910105735.1e060b95@w520.home>
In-Reply-To: <c94c36305980f80674aa699e27b9895b@mail.gmail.com>
References: <c94c36305980f80674aa699e27b9895b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 16:15:27 +0530
Vikas Gupta <vikas.gupta@broadcom.com> wrote:

> Hi Alex/Cornelia,
> 
> We are looking for MSI interrupts for platform devices in user-space
> applications via event/poll mechanism using VFIO.
> 
> Since there is no support for MSI/MSIX handling in VFIO-platform in kernel,
> it may not possible to get this feature in user-space.
> 
> Is there any other way we can get this feature in user-space OR can you
> please suggest if any patch or feature is in progress for same in VFIO
> platform?
> 
> Any suggestions would be helpful.

Eric (Cc'd) is the maintainer of vfio-platform.

vfio-platform devices don't have IRQ indexes dedicated to MSI and MSI-X
like vfio-pci devices do (technically these are PCI concepts, but I
assume we're referring generically to message signaled interrupts), but
that's simply due to the lack of standardization in platform devices.
Logically these are simply collections of edge triggered interrupts,
which the vfio device API supports generically, it's simply a matter
that the vfio bus driver exposing a vfio-platform device create an IRQ
index exposing these vectors.  Thanks,

Alex

