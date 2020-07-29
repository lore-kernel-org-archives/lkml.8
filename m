Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB70CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DBA20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB1P3hOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgG2TsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:48:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32419 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgG2TsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596052099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g6E6oxh17gWdFsve5u7k1i5BDdfNHe2sq9hYCnsEY64=;
        b=RB1P3hODBMxArlrk2KVA9jDpHyvB4/9P75FqWU/Y86a/yvlZ2oylbOhfq9JM+8+WxHHAWi
        iVhmTmpDu9fDS/k/N5pKuJPpSU8Z2IVzTGa7XmpdwwiezQSRfId3/yitCY3WsYYkma62SV
        lgzgwP4vZjFZYiXteW6Olvu6IUw2s8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-DnRjCcLqMwCpki9ZXGyb-g-1; Wed, 29 Jul 2020 15:48:17 -0400
X-MC-Unique: DnRjCcLqMwCpki9ZXGyb-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14FC58015F4;
        Wed, 29 Jul 2020 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8858A5C5B7;
        Wed, 29 Jul 2020 19:48:07 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
        virtualization@lists.linux-foundation.org (open list:VIRTIO BLOCK AND
        SCSI DRIVERS), Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/1] virtio-scsi: fix missing unplug events when all LUNs are
 unplugged at the same time
Date:   Wed, 29 Jul 2020 22:48:05 +0300
Message-Id: <20200729194806.4933-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-scsi currently has limit of 8 outstanding notifications so when more=
 that=0D
8 LUNs are unplugged, some are missed.=0D
=0D
Commit 5ff843721467 ("scsi: virtio_scsi: unplug LUNs when events missed")=0D
Fixed this by checking the 'event overflow' bit and manually scanned the bu=
s=0D
to see which LUNs are still there.=0D
=0D
However there is a corner case when all LUNs are unplugged.=0D
In this case (which is not fully scsi confirmant IMHO), all scsi=0D
commands to such device respond with INVALID TARGET.=0D
=0D
This patch proposes to detect this and remove the LUN in this case=0D
as well.=0D
=0D
Maxim Levitsky (1):=0D
  scsi: virtio-scsi: handle correctly case when all LUNs were unplugged=0D
=0D
 drivers/scsi/virtio_scsi.c | 10 ++++++++++=0D
 1 file changed, 10 insertions(+)=0D
=0D
-- =0D
2.26.2=0D
=0D

