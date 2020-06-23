Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB89C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E374320675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945483;
	bh=mN4gSfA1BZ9tDTLJPfcnd7yd2OXQBhvuB2726QAx6WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yPAXqL8OHvtWvGUXA13VBLqVqWAgLl7PSTCrTlRkJXkDehhiTqNeadLuS3LOu2NS3
	 H0TGQpbedVFEEzb/whUuPXSlS8Q8R2orGzJoXoDjrOwXIAOzarubLgsPO9B6yZlI1z
	 uc5NhQ2RseJtkQ2Djv+8frKIFTz+IdZugtGdvDUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392788AbgFWUvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389782AbgFWUsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:48:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5ABF20781;
        Tue, 23 Jun 2020 20:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945288;
        bh=mN4gSfA1BZ9tDTLJPfcnd7yd2OXQBhvuB2726QAx6WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heOhB0fC9gDYLrFmGLRkTlbiy5vVW/L6ZQ7A1db5DLJfH9zZvhPLZPT1wfnehpPVA
         NUQp8Ad7/ZjhdryFH/iZDYWdzYrzX/GkQSlmxHGKCcORQzCK3vARNUkZ1qsIOpIz17
         wGLTODwKyiyS6XY0RZLB0hmIR8e/8qpEJtNmwtBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4.14 113/136] drm/qxl: Use correct notify port address when creating cursor ring
Date:   Tue, 23 Jun 2020 21:59:29 +0200
Message-Id: <20200623195309.362736178@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

commit 80e5f89da3ab949fbbf1cae01dfaea29f5483a75 upstream.

The command ring and cursor ring use different notify port addresses
definition: QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR. However, in
qxl_device_init() we use QXL_IO_NOTIFY_CMD to create both command ring
and cursor ring. This doesn't cause any problems now, because QEMU's
behaviors on QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR are the same.
However, QEMU's behavior may be change in future, so let's fix it.

P.S.: In the X.org QXL driver, the notify port address of cursor ring
      is correct.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: <stable@vger.kernel.org>
Link: http://patchwork.freedesktop.org/patch/msgid/1585635488-17507-1-git-send-email-chenhc@lemote.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/qxl/qxl_kms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -181,7 +181,7 @@ int qxl_device_init(struct qxl_device *q
 				&(qdev->ram_header->cursor_ring_hdr),
 				sizeof(struct qxl_command),
 				QXL_CURSOR_RING_SIZE,
-				qdev->io_base + QXL_IO_NOTIFY_CMD,
+				qdev->io_base + QXL_IO_NOTIFY_CURSOR,
 				false,
 				&qdev->cursor_event);
 


