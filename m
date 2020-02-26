Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A0C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C2E21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqI3sWQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgBZVE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:04:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43324 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBZVE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:04:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id p11so177799plq.10;
        Wed, 26 Feb 2020 13:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gR+JuZzac48XfpToVHHyCGCAF/+6w3C6nGVV9Mbpoj8=;
        b=tqI3sWQcFpDqyCYoZc5/kfdQ/bvuXZILJHyA5ocCPsMMXeEA8ID9a3IKeTBUbaDc7o
         tr76K9K4snL2kw55x68Iju7QPSA6p0BJilnED4wXe9SGV28BpkSU109786zNDynOIhlo
         FM/eKyBeY4slfBfe+/FYEPh7n81Wnv43DAMXtxXeBQCzX9Wv41/tPXQa+xxQsdu6DhFe
         jIuUMeN6xRBkyZS8GrsbhTAvbLMnQoW9V8V5JfEiQtwkpo6eM16UWEoUMUbTOUNpIMtS
         8DzoKBxa68PUCEOkp7ws6epfNuUOisKpHOcWc2V6QK+hYG8zR9XCWflkad80yS9dbGqp
         PePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gR+JuZzac48XfpToVHHyCGCAF/+6w3C6nGVV9Mbpoj8=;
        b=Es8IG0hKXZ3+HyAz2ofWZw0ZwiSQvtiA4mc0Ro5wwIuzrYvGHHrNEdOPpa3iQICiuf
         /Hr1r4ruxFH9c3xFiaxCBgCP0Ad6M4NVs2yKBue+N+MeXR+z1fALWMIJJc7rtBuC/iUj
         UmYujFs7nvHMH8GpTCj5/SVof/mrpqmcjNeLbujG2YJxDE1322/Ay5uTC91An+kJeD4v
         IyaX2foJPJfMZGLy7TDHZZE1cfVI4xur3pKfcam0JKbLTq0kRRVe7HqDlMpeSVt0/E5B
         Wt3F3zaS2bHUE63oEb7t3vY9PN1RVkSQYlB6BUtKv2CNm8FXy5hvJxmJzx2nsdSbNdMk
         g8CQ==
X-Gm-Message-State: APjAAAU0qag9/hVqhfAg4em5TbANIh8SJkV0bnu7Dbo6kcna8U+leF7a
        AE8vxgG6OZ5qCoQNK3sjszI=
X-Google-Smtp-Source: APXvYqyRtssdUw+UPpbfDYyVa5Q3rwR4atHxr6nuIoLHYOLVcZS2oKXCFO0yU3eIpgiX6HV+tK/PEw==
X-Received: by 2002:a17:902:d702:: with SMTP id w2mr1118124ply.243.1582751064388;
        Wed, 26 Feb 2020 13:04:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y193sm1361891pgd.87.2020.02.26.13.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 13:04:23 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Antti=20Sepp=C3=A4l=C3=A4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
Date:   Wed, 26 Feb 2020 13:04:11 -0800
Message-Id: <20200226210414.28133-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226210414.28133-1-linux@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to align buffers for DMA was first introduced with commit
3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a more supported way").
It was updated with commit 56406e017a88 ("usb: dwc2: Fix DMA alignment
to start at allocated boundary") because it did not really align buffers to
DMA boundaries but to word offsets. This was then optimized in commit
1e111e885238 ("usb: dwc2: Fix inefficient copy of unaligned buffers")
to only copy actual data rather than the whole buffer. Commit 4a4863bf2e79
("usb: dwc2: Fix DMA cache alignment issues") changed this further to add
a padding at the end of the buffer to ensure that the old data pointer is
not in the same cache line as the buffer.

This last commit states "Otherwise, the stored_xfer_buffer gets corrupted
for IN URBs on non-cache-coherent systems". However, such corruptions are
still observed. This suggests that the commit may have been hiding a
problem rather than fixing it. Further analysis shows that this is indeed
the case: The code in dwc2_hc_start_transfer() assumes that the transfer
size is a multiple of wMaxPacketSize, and rounds up the transfer size
communicated to the chip accordingly. Added debug code confirms that
the chip does under some circumstances indeed send more data than requested
in the urb receive buffer size.

On top of that, it turns out that buffers are still not guaranteed to be
aligned to dma_get_cache_alignment(), but to DWC2_USB_DMA_ALIGN (4).
Further debugging shows that packets aligned to DWC2_USB_DMA_ALIGN
but not to dma_get_cache_alignment() are indeed common and work just fine.
This suggests that commit 56406e017a88 was not really necessary because
even without it packets were already aligned to DWC2_USB_DMA_ALIGN.

To simplify the code, move the old data pointer back to the beginning of
the new buffer, restoring most of the original commit. Stop aligning the
buffer to dma_get_cache_alignment() since it isn't needed and only makes
the code more complex. Instead, ensure that the allocated buffer is a
multiple of wMaxPacketSize to ensure that the chip does not write beyond
the end of the buffer.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Boris Arzur <boris@konbu.org>
Fixes: 56406e017a88 ("usb: dwc2: Fix DMA alignment to start at allocated boundary")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/dwc2/hcd.c | 67 ++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index b90f858af960..f6d8cc9cee34 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2471,19 +2471,21 @@ static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
 
 #define DWC2_USB_DMA_ALIGN 4
 
+struct dma_aligned_buffer {
+	void *old_xfer_buffer;
+	u8 data[0];
+};
+
 static void dwc2_free_dma_aligned_buffer(struct urb *urb)
 {
-	void *stored_xfer_buffer;
+	struct dma_aligned_buffer *dma;
 	size_t length;
 
 	if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
 		return;
 
-	/* Restore urb->transfer_buffer from the end of the allocated area */
-	memcpy(&stored_xfer_buffer,
-	       PTR_ALIGN(urb->transfer_buffer + urb->transfer_buffer_length,
-			 dma_get_cache_alignment()),
-	       sizeof(urb->transfer_buffer));
+	dma = container_of(urb->transfer_buffer,
+			   struct dma_aligned_buffer, data);
 
 	if (usb_urb_dir_in(urb)) {
 		if (usb_pipeisoc(urb->pipe))
@@ -2491,49 +2493,50 @@ static void dwc2_free_dma_aligned_buffer(struct urb *urb)
 		else
 			length = urb->actual_length;
 
-		memcpy(stored_xfer_buffer, urb->transfer_buffer, length);
+		memcpy(dma->old_xfer_buffer, dma->data, length);
 	}
-	kfree(urb->transfer_buffer);
-	urb->transfer_buffer = stored_xfer_buffer;
+	urb->transfer_buffer = dma->old_xfer_buffer;
+	kfree(dma);
 
 	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
 }
 
 static int dwc2_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
 {
-	void *kmalloc_ptr;
+	struct dma_aligned_buffer *dma;
 	size_t kmalloc_size;
 
-	if (urb->num_sgs || urb->sg ||
-	    urb->transfer_buffer_length == 0 ||
+	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
+	    (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
 	    !((uintptr_t)urb->transfer_buffer & (DWC2_USB_DMA_ALIGN - 1)))
 		return 0;
 
-	/*
-	 * Allocate a buffer with enough padding for original transfer_buffer
-	 * pointer. This allocation is guaranteed to be aligned properly for
-	 * DMA
-	 */
-	kmalloc_size = urb->transfer_buffer_length +
-		(dma_get_cache_alignment() - 1) +
-		sizeof(urb->transfer_buffer);
+	kmalloc_size = sizeof(struct dma_aligned_buffer);
+	if (usb_urb_dir_out(urb)) {
+		kmalloc_size += urb->transfer_buffer_length;
+	} else {
+		struct usb_host_endpoint *ep = urb->ep;
+		int maxp = usb_endpoint_maxp(&ep->desc);
 
-	kmalloc_ptr = kmalloc(kmalloc_size, mem_flags);
-	if (!kmalloc_ptr)
-		return -ENOMEM;
+		/*
+		 * Input transfer buffer size must be a multiple of the
+		 * endpoint's maximum packet size to match the transfer
+		 * limit programmed into the chip.
+		 * See calculation of chan->xfer_len in
+		 * dwc2_hc_start_transfer().
+		 */
+		kmalloc_size += roundup(urb->transfer_buffer_length, maxp);
+	}
 
-	/*
-	 * Position value of original urb->transfer_buffer pointer to the end
-	 * of allocation for later referencing
-	 */
-	memcpy(PTR_ALIGN(kmalloc_ptr + urb->transfer_buffer_length,
-			 dma_get_cache_alignment()),
-	       &urb->transfer_buffer, sizeof(urb->transfer_buffer));
+	dma = kmalloc(kmalloc_size, mem_flags);
+	if (!dma)
+		return -ENOMEM;
 
+	dma->old_xfer_buffer = urb->transfer_buffer;
 	if (usb_urb_dir_out(urb))
-		memcpy(kmalloc_ptr, urb->transfer_buffer,
+		memcpy(dma->data, urb->transfer_buffer,
 		       urb->transfer_buffer_length);
-	urb->transfer_buffer = kmalloc_ptr;
+	urb->transfer_buffer = dma->data;
 
 	urb->transfer_flags |= URB_ALIGNED_TEMP_BUFFER;
 
-- 
2.17.1

