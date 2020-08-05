Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2418BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF43206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckbDlnzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgHERO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:14:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728564AbgHERKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uSDwrcCetgi4o90pPq2a185JxUqvTMJB/oDG7IEBOg=;
        b=ckbDlnzHVb8+0VTyn4dEN5UPG1k56gdg/kIcBEu04AWf+fPAPeeyrx2cKCjR6kbhUYcr3g
        +5zocUljjKDGsIrzHSS8N/Ymw+ig/xxr+Y3yfgqlyfnrk39A7f7Ys9xN4yW7bC8BxbIeZ0
        afaWkP/ZBvJKeKhXlQZNX9Pa/CwLvBk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-QyGb9_AFOAiBEPKvq4WfKg-1; Wed, 05 Aug 2020 09:43:43 -0400
X-MC-Unique: QyGb9_AFOAiBEPKvq4WfKg-1
Received: by mail-wr1-f69.google.com with SMTP id w1so11635317wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uSDwrcCetgi4o90pPq2a185JxUqvTMJB/oDG7IEBOg=;
        b=IIAQJP5KXVaiUHX9kw4iX7SZ1opcdQSEqJNtkRMh/OU4+reC+f29z4nHlu7NyWe379
         /mp4iB9X9KYlpapZh70QMl/r9DZjmEKhUGQZmSb3Rj2StueOl5cC8tFK8sbiVtBLf8LF
         DTR2957Eb88CMExkzheB4HfEA/UbUdo1IfgN4XRcz091WzNoA/ZRiqmzrDnsVZOtRl6n
         JWMBAHUWu3pUQvl+g/0KVgYZoqb9kJovdV9N949qPw3/t4B32J+jLP0JMH1Sv2ikjKHs
         3Kwndzj9/+a2OxgEohUEvsrPFRXVntndlRy84aIkGvl2bVBM0CRMFJbtufgNIvgQ4K2L
         M0eQ==
X-Gm-Message-State: AOAM5324x6c2NFXygVI/UAhOgQlhJZL5LIb/cpicujT6AZ6vXUoOTeQx
        +nw5Ls0/Pm3bK2hmBv5NIH0UzXaDUFAUURKrJbZ8xd3OgxPaZwxI4Jc5NQqH3rzjM1W62Lk9sIx
        UQaY25NGYFVgaR15WIujrjmBt
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr2990184wrn.2.1596635022297;
        Wed, 05 Aug 2020 06:43:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcyZAwzw/sc3TIrW5clO3yeQkU/17FbRDELsyAj0Cdv9z6ug93Lv7U5iCEnIGFjwxAFgiVMg==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr2990172wrn.2.1596635022086;
        Wed, 05 Aug 2020 06:43:42 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id y203sm2957420wmc.29.2020.08.05.06.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:41 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/38] virtio_fs: correct tags for config space fields
Message-ID: <20200805134226.1106164-10-mst@redhat.com>
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

Since fs is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index b02eb2ac3d99..3056b6e9f8ce 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -13,7 +13,7 @@ struct virtio_fs_config {
 	__u8 tag[36];
 
 	/* Number of request queues */
-	__u32 num_request_queues;
+	__le32 num_request_queues;
 } __attribute__((packed));
 
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
MST

