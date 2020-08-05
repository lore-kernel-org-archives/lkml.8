Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720E4206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdzJi/1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgHET35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:29:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728554AbgHERKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBRZHl7JCJFhcfupZL8iAhY/apUMRtB5oC1LWGAgU4A=;
        b=BdzJi/1qxsjYplX9UHJnssT/2ipPnfKLyXNtuqAX0EdvC5yBvGeOWH0tkFtWUfQZRVCCP7
        t4glj4Ud13UVyITwsXvJLny6e170e6e9PebDU5jGr+Qi+T1Y/H0X2Zm0Ty6w90ouiGlr+H
        UgNupPu+ZtSu7YxmEUkQp5NZPSsBQx0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-RHgXzudWO8anti7-jtQNlw-1; Wed, 05 Aug 2020 09:44:03 -0400
X-MC-Unique: RHgXzudWO8anti7-jtQNlw-1
Received: by mail-wm1-f70.google.com with SMTP id u144so2740420wmu.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XBRZHl7JCJFhcfupZL8iAhY/apUMRtB5oC1LWGAgU4A=;
        b=nMu2xPXb37FeQzs86ow0OYxGOnKW+7vK6xizNMF5hZY0EDf2aFs1fVwH6eSkDf3YkG
         1fi8ThJD1iBqUlQyv3DqxGtCUGPgBf82bTo6tavynUkjX7xZKs6jYAdxO9ZplAZTvlH2
         eOGXeWfsXRw7K2S1epWgOqR1OFUvCwLESBivMDc9l8X67xunIeCOMLpvivF03Vsr1zDT
         j/g9KAc55UOdq0MCS3suC2f47vwYcXnn4Ow4VWUHR4XMlP4i2CfjERli8FNsH5HcUN4P
         Ea8lI9np19uuLC1xCwrQZPgwVYBfgBMuonddhJu/RnWs31XlV5AsTMuWjwdjG71RL7vX
         r1Sg==
X-Gm-Message-State: AOAM533K0hZFjCvjgw+U4CIy1jyB+7yyJN/duW6+uZaOAwENALGtYnVX
        nDqTIdLFsYqYd2O/k7/JSt5WHwTVt6TXbP6p3387ufIef2XCq5gWekTsPWngO5JFq89Q5DkHhQS
        u390o+QxzeYj5PgHzuecIL8C8
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3291799wml.35.1596635042166;
        Wed, 05 Aug 2020 06:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDiytpas+5HWe7CFND1zqnudLwtNEfOy8SdQ5eObOxwbDWWrns+xYAUPDW5UZJfGlbiTGXfw==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3291789wml.35.1596635041995;
        Wed, 05 Aug 2020 06:44:01 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id x2sm3035450wrg.73.2020.08.05.06.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:01 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v3 16/38] virtio_scsi: correct tags for config space fields
Message-ID: <20200805134226.1106164-17-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/scsi/virtio_scsi.c       |  4 ++--
 include/uapi/linux/virtio_scsi.h | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 0e0910c5b942..c36aeb9a1330 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -746,14 +746,14 @@ static struct scsi_host_template virtscsi_host_template = {
 
 #define virtscsi_config_get(vdev, fld) \
 	({ \
-		typeof(((struct virtio_scsi_config *)0)->fld) __val; \
+		__virtio_native_type(struct virtio_scsi_config, fld) __val; \
 		virtio_cread(vdev, struct virtio_scsi_config, fld, &__val); \
 		__val; \
 	})
 
 #define virtscsi_config_set(vdev, fld, val) \
 	do { \
-		typeof(((struct virtio_scsi_config *)0)->fld) __val = (val); \
+		__virtio_native_type(struct virtio_scsi_config, fld) __val = (val); \
 		virtio_cwrite(vdev, struct virtio_scsi_config, fld, &__val); \
 	} while(0)
 
diff --git a/include/uapi/linux/virtio_scsi.h b/include/uapi/linux/virtio_scsi.h
index cc18ef8825c0..0abaae4027c0 100644
--- a/include/uapi/linux/virtio_scsi.h
+++ b/include/uapi/linux/virtio_scsi.h
@@ -103,16 +103,16 @@ struct virtio_scsi_event {
 } __attribute__((packed));
 
 struct virtio_scsi_config {
-	__u32 num_queues;
-	__u32 seg_max;
-	__u32 max_sectors;
-	__u32 cmd_per_lun;
-	__u32 event_info_size;
-	__u32 sense_size;
-	__u32 cdb_size;
-	__u16 max_channel;
-	__u16 max_target;
-	__u32 max_lun;
+	__virtio32 num_queues;
+	__virtio32 seg_max;
+	__virtio32 max_sectors;
+	__virtio32 cmd_per_lun;
+	__virtio32 event_info_size;
+	__virtio32 sense_size;
+	__virtio32 cdb_size;
+	__virtio16 max_channel;
+	__virtio16 max_target;
+	__virtio32 max_lun;
 } __attribute__((packed));
 
 /* Feature Bits */
-- 
MST

