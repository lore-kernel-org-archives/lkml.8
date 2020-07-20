Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A82C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39C922C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF2pByvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGTOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:34:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51175 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727982AbgGTOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595255673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yRLvzSgd5JXKqp0y2dRzttHbtXvNZ2pju4sRCN1pW8Y=;
        b=dF2pByvZAESueDxyeraNHqapw36z0BsFNIVumnnkmYS+hASEyCAsS0cYErqwp2T9KExmsd
        fk4vQunA+axlahLzKrdJiy2CIhBn9tC8OlB8esO9h45x8uzX9cTLRC7IKUL04cSyqC0d0S
        6lnWTdVNpd8zqnkyFthSSsbXlrUAvFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Qviih4syMtqsophRGSqoIQ-1; Mon, 20 Jul 2020 10:34:29 -0400
X-MC-Unique: Qviih4syMtqsophRGSqoIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 738B2800460;
        Mon, 20 Jul 2020 14:34:28 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B1255C1D4;
        Mon, 20 Jul 2020 14:34:28 +0000 (UTC)
Date:   Mon, 20 Jul 2020 08:34:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO fix for v5.8-rc7
Message-ID: <20200720083427.50202e82@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.8-rc7

for you to fetch changes up to b872d0640840018669032b20b6375a478ed1f923:

  vfio/pci: fix racy on error and request eventfd ctx (2020-07-17 08:28:40 -0600)

----------------------------------------------------------------
VFIO fixes for v5.8-rc7

 - Fix race with eventfd ctx cleared outside of mutex (Zeng Tao)

----------------------------------------------------------------
Zeng Tao (1):
      vfio/pci: fix racy on error and request eventfd ctx

 drivers/vfio/pci/vfio_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

