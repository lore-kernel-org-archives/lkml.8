Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CDEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8B322D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTOj9kF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHERMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:12:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43593 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728556AbgHERKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLyznuEr+YtS56JlIu4IevBHcH0S591inceyWkYffOs=;
        b=HTOj9kF97KoG3UOEA5Xpn5m7cw48OcrdOO6gi4DFtJp2vwNE2y3HW6mphgWB8VaL6vpWEF
        kbPXL4o2VKCdUbUqN9ZwVwv/njFbPID9wyBQilhPCtU9oXVQdwOQW6EOY5vUxHg1QsqKbf
        /s3+M3kBnFo4fD06RSUPq26AcZwbOAQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-F3-4tUyCPim9ynilgnwEuw-1; Wed, 05 Aug 2020 09:43:29 -0400
X-MC-Unique: F3-4tUyCPim9ynilgnwEuw-1
Received: by mail-wm1-f70.google.com with SMTP id p23so2473990wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLyznuEr+YtS56JlIu4IevBHcH0S591inceyWkYffOs=;
        b=UUmYW/An82M78UrIvEbmQjy43xlKDDra0mo5QnNYonrUHs2nXkO5pp05k9nMINxZmI
         yGej1BK88QSkpeZJOy9MEsxbgnb73bi1ko2F1CLOTI9U7BFBijwna1RDZdPnEeMQOvgC
         Taj2oPOR3qZ3Vgi86ROpz7reX6XvaA93BtO8xLE9IxOjFU62BNsOpTobte/Grdz+03VO
         xkug28VGUF62M23M6lr08Ei4Z/QNLuvWJ8YFO/uZOEZ0C7h3bT2PfAw7EskByDvNQ9z4
         +CygME6KuKKHTLyLfeb/0yzobPJZ6aaIKJor6QQg3mYcKliL+JaCPv2jQIhV3wgPX+1x
         jVvg==
X-Gm-Message-State: AOAM533F0JkxzMRXiQuvigREZ+BT9p+R6erO6WQixw/qOXI/7jFGcryv
        oXMuBzTMWmVZnW9ymuwyGk64/BmhE6weTu/5iPiLnkGoOJ4D9a1T2lgXqdRQWAgaiSlfzflnnxh
        45oYs5JYzzyk9j0ibuanur4VS
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr3278048wmc.162.1596635008084;
        Wed, 05 Aug 2020 06:43:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2OznmEqQQuS3Gj15cuXvaM9QXX3f4/5FduhQJ7Ds5R+28pqvqB/Ctrz8niF5YwYSRgpWi9w==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr3278028wmc.162.1596635007890;
        Wed, 05 Aug 2020 06:43:27 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id g25sm2752597wmh.35.2020.08.05.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:27 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jason Wang <jasowang@redhat.com>,
        v9fs-developer@lists.sourceforge.net,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 04/38] virtio_9p: correct tags for config space fields
Message-ID: <20200805134226.1106164-5-mst@redhat.com>
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
 include/uapi/linux/virtio_9p.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_9p.h b/include/uapi/linux/virtio_9p.h
index 277c4ad44e84..441047432258 100644
--- a/include/uapi/linux/virtio_9p.h
+++ b/include/uapi/linux/virtio_9p.h
@@ -25,7 +25,7 @@
  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE. */
-#include <linux/types.h>
+#include <linux/virtio_types.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
@@ -36,7 +36,7 @@
 
 struct virtio_9p_config {
 	/* length of the tag name */
-	__u16 tag_len;
+	__virtio16 tag_len;
 	/* non-NULL terminated tag name */
 	__u8 tag[0];
 } __attribute__((packed));
-- 
MST

