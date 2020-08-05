Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F266EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA85206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeTUdYL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgHERNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728563AbgHERKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yjMsup4mt600oOWRixyKMEsWQPnME+FeaUdLXa+RES4=;
        b=OeTUdYL6WNyLdX9bFaHisO+0dkYFjolLk7WbL7bVprCilxMAmben/55uk018uTr2xIuPaJ
        e1CirkakuKSrR63ltCSNYUBqlM07RKu/a33UOmVfUHyeq/VbslQrWDeiPeKuvaycD+myYG
        tXFqPA2m620uoNzcLz4wLvZOb9Pr3Rg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-_B1xtHlaNjCvNMJxEvxGzA-1; Wed, 05 Aug 2020 09:43:32 -0400
X-MC-Unique: _B1xtHlaNjCvNMJxEvxGzA-1
Received: by mail-wr1-f72.google.com with SMTP id w7so11245640wre.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjMsup4mt600oOWRixyKMEsWQPnME+FeaUdLXa+RES4=;
        b=cSUOGSR0XbvoOy+OUrWRg7Z8tBawpID0R8K6ATgMThdt+Wxj4ATefV7SZSlTmP1ThS
         HaEMlg07VCggMEXi2a0lo07dRTSyvH+VcWcUJ2bYu09R8W3vLOttcZf4dOs6X/KH7+Ud
         QhKM2EsBVrNx2TVkbhmjaCQyokW4dIVURJcwY7cnHPJHXxlA8XeRBfIeD0ztKvhfdoPg
         AFji/07JVRp3wfJswPnbTJ8XXWx/ja3HquQ85NWjJ0SD4svfNA1B+U947LkmzF/8HkZ1
         t3DwYtGqN8lBWUHFcRx3kgGcF7DGZyG9q4mMulgPbZY0OsUl1VLDsitgKI5Q4gB497DH
         xU2w==
X-Gm-Message-State: AOAM533RxvNi0Z1aqKNL5iMYF1MBhIudr54ZbqB8Cvu9MfM1iCBjYMed
        dmSnrzfySpchCPjeTGJAkpcRDZ7Ld9GRKRf/g4VeZKiFP8RXn3YoOA7E82S9q02Kj8V+p8oZhTH
        Nrz8ZEpkaMrOxtBN3Ax9E99Sd
X-Received: by 2002:a1c:1f12:: with SMTP id f18mr3583780wmf.66.1596635010685;
        Wed, 05 Aug 2020 06:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+IkYFmgt6a8D6EfEP79DtxSQX6aDSV9q0nXGklsXwBwYON7OYUJgmN08O2YIZlhsvYQ8Cdg==
X-Received: by 2002:a1c:1f12:: with SMTP id f18mr3583770wmf.66.1596635010521;
        Wed, 05 Aug 2020 06:43:30 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id b77sm2352377wmb.3.2020.08.05.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:29 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 05/38] virtio_balloon: correct tags for config space fields
Message-ID: <20200805134226.1106164-6-mst@redhat.com>
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

Tag config space fields as having little endian-ness.
Note that balloon is special: LE even when using
the legacy interface.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_balloon.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index dc3e656470dd..ddaa45e723c4 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -45,20 +45,20 @@
 #define VIRTIO_BALLOON_CMD_ID_DONE	1
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
-	__u32 num_pages;
+	__le32 num_pages;
 	/* Number of pages we've actually got in balloon. */
-	__u32 actual;
+	__le32 actual;
 	/*
 	 * Free page hint command id, readonly by guest.
 	 * Was previously named free_page_report_cmd_id so we
 	 * need to carry that name for legacy support.
 	 */
 	union {
-		__u32 free_page_hint_cmd_id;
-		__u32 free_page_report_cmd_id;	/* deprecated */
+		__le32 free_page_hint_cmd_id;
+		__le32 free_page_report_cmd_id;	/* deprecated */
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
-	__u32 poison_val;
+	__le32 poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
MST

