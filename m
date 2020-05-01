Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DBDC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C652166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzqeOd5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEAVvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:51:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726307AbgEAVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588369860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6K9N0GoO7o+fp5KFhAqVxNdfg4MrM4tfiBE4omn4UAM=;
        b=IzqeOd5mbN+oHGZePSfk5dmwopjq9yDXdi7mSUxnArjnbBPd1VJlFfM1H8JcR4/ddTcF8F
        cdX5JsWKFWWjuibHEQzVUMiaG5d/wDDWJ8HsGQ7i4c9IdAo3sCUH7ZvGgGP3rWtLrVRfUu
        VPz4cEWS+E10zxyhHcgQNGuaBOvOPCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-sMW5MDQdPf2jRstx2gYxqQ-1; Fri, 01 May 2020 17:50:56 -0400
X-MC-Unique: sMW5MDQdPf2jRstx2gYxqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1EF845F;
        Fri,  1 May 2020 21:50:55 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74DF210016EB;
        Fri,  1 May 2020 21:50:55 +0000 (UTC)
Date:   Fri, 1 May 2020 15:50:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v5.7-rc4
Message-ID: <20200501155054.39bdad7e@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.7-rc4

for you to fetch changes up to 5cbf3264bc715e9eb384e2b68601f8c02bb9a61d:

  vfio/type1: Fix VA->PA translation for PFNMAP VMAs in vaddr_get_pfn() (2020-04-23 12:10:01 -0600)

----------------------------------------------------------------
VFIO fixes for v5.7-rc4

 - copy_*_user validity check for new vfio_dma_rw interface (Yan Zhao)

 - Fix a potential math overflow (Yan Zhao)

 - Use follow_pfn() for calculating PFNMAPs (Sean Christopherson)

----------------------------------------------------------------
Sean Christopherson (1):
      vfio/type1: Fix VA->PA translation for PFNMAP VMAs in vaddr_get_pfn()

Yan Zhao (2):
      vfio: checking of validity of user vaddr in vfio_dma_rw
      vfio: avoid possible overflow in vfio_iommu_type1_pin_pages

 drivers/vfio/vfio_iommu_type1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

