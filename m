Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A97C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638B720772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRScaUvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgF3UGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:06:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31272 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgF3UGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593547607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5YRZUUFvZuEyDjzkGzSnf3/D+5vRip2ZXUd5lXnW6Ts=;
        b=gRScaUvn8yzubxLnFWM/OjV5gKKnjciF6locUi+BlwxI4dXuI98c36UAFuciifxjc4IUpE
        zsYiNeDURvKOj4x1BgL1n9Vz8RPnXMVt8LzH4OTN+qFwm7Pmooy9sfeB5+ZtHb7Sd4D8Ix
        sM7mxN2/hQK9RvE8AjIzbXuGTWOjdEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-nUvQHNLROGi-O-XdjHPCdg-1; Tue, 30 Jun 2020 16:06:45 -0400
X-MC-Unique: nUvQHNLROGi-O-XdjHPCdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE779879512;
        Tue, 30 Jun 2020 20:06:44 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-115-86.phx2.redhat.com [10.3.115.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A84197BEA0;
        Tue, 30 Jun 2020 20:06:44 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/2] iommu: Move AMD and Intel Kconfig + Makefile bits into their directories
Date:   Tue, 30 Jun 2020 13:06:34 -0700
Message-Id: <20200630200636.48600-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset imeplements the suggestion from Linus to move the
Kconfig and Makefile bits for AMD and Intel into their respective
directories.

v2: Rebase against v5.8-rc3. Dropped ---help--- changes from Kconfig as that was
    dealt with in systemwide cleanup.

Jerry Snitselaar (2):
      iommu/vt-d: Move Kconfig and Makefile bits down into intel directory
      iommu/amd: Move Kconfig and Makefile bits down into amd directory


