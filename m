Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA648C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C27120684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqIe4nQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407047AbgAPSR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:17:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26101 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387949AbgAPSR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579198674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t3VlM5eWHxNK3W2wSrtp5Pl0J5UynFugOHYM0lHZotI=;
        b=UqIe4nQ2/3lBBEF8O6bNW1YwGcWFpD98T/ymUuTAdZ/SUovgtHP33THsOUJHu5Y8fC4q5s
        1QqAQxAJuEskoSQKd9t/eut8IcrdJd4/HmrV6esUozIz9YgRKNo1Gir11uPucMmIC7lbrj
        TDsxPNmzyU2TnMcF2GD9VgYR56hb32E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-aZJcF4RYP-a0nsHacWQwpA-1; Thu, 16 Jan 2020 13:17:53 -0500
X-MC-Unique: aZJcF4RYP-a0nsHacWQwpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FD4C18C35A0;
        Thu, 16 Jan 2020 18:17:52 +0000 (UTC)
Received: from gimli.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A8AC5C241;
        Thu, 16 Jan 2020 18:17:49 +0000 (UTC)
Subject: [RFC PATCH 0/3] vfio/type1: Reduce vfio_iommu.lock contention
From:   Alex Williamson <alex.williamson@redhat.com>
To:     yan.y.zhao@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jan 2020 11:17:49 -0700
Message-ID: <157919849533.21002.4782774695733669879.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yan,

I wonder if this might reduce the lock contention you're seeing in the
vfio_dma_rw series.  These are only compile tested on my end, so I hope
they're not too broken to test.  Thanks,

Alex

---

Alex Williamson (3):
      vfio/type1: Convert vfio_iommu.lock from mutex to rwsem
      vfio/type1: Replace obvious read lock instances
      vfio/type1: Introduce pfn_list mutex


 drivers/vfio/vfio_iommu_type1.c |   67 ++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 26 deletions(-)

