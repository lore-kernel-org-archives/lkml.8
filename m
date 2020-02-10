Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE3C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A07E20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339370;
	bh=KRykSBo4yYqiwd/BI7WBlxl3wr8PlhHRWXsjQKXvnVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wX31uCxxl2Nd8U1I18y0kBYzeRAYNtHnfPUrKjTcmYm15FSxIeyMXISi0v3oLh0WT
	 AtACJHURPozt2SPDQWroPHiHW9BhcS1M0hZlu6lAD85ojt21v1gkyOVAnMsNgZM+hE
	 XM0i/2P54n5oEWOaRiML+G0laA2W96Xlg12G2BpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgBJM4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbgBJMln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E40C208C3;
        Mon, 10 Feb 2020 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338503;
        bh=KRykSBo4yYqiwd/BI7WBlxl3wr8PlhHRWXsjQKXvnVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqH5YE0YvrUDGumtkszq7BZBT7A2svk/VoL1BfUz9bjv2sb/Gmc/dpkOXYRlT6iSJ
         HcGw5Ay9n49lhbMFVwp+egYWKeIz4EuvZIsXVFFXM8Yt/HFDmp3fnhHoN8RbOki8PB
         dp/WBjxBv9yqBg52ocEPGXmWYeLgfSG0HL5t//Yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Liang Li <liang.z.li@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 5.5 301/367] virtio-balloon: Fix memory leak when unloading while hinting is in progress
Date:   Mon, 10 Feb 2020 04:33:34 -0800
Message-Id: <20200210122451.342996527@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

commit 6c22dc61c76b7e7d355f1697ba0ecf26d1334ba6 upstream.

When unloading the driver while hinting is in progress, we will not
release the free page blocks back to MM, resulting in a memory leak.

Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Liang Li <liang.z.li@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200205163402.42627-2-david@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -968,6 +968,10 @@ static void remove_common(struct virtio_
 		leak_balloon(vb, vb->num_pages);
 	update_balloon_size(vb);
 
+	/* There might be free pages that are being reported: release them. */
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		return_free_pages_to_mm(vb, ULONG_MAX);
+
 	/* Now we reset the device so we can clean up the queues. */
 	vb->vdev->config->reset(vb->vdev);
 


