Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50003C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D39D2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921431;
	bh=nmcxt3WZtflwJ7Qs7MCerLyMF7yzlsKp1exKahSiFsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PiTitV6FTjM3Ps67s/6uq6LDrdQEskKR5SAUTjkGs3sIbxeGPB3al6k+GavaLy0+Z
	 y0XCDdxsMmZZdJPUVlG+Tr8cC5xG1S5wz357UTaa6DD29Pzdk7u34p/rfvfkC3fubk
	 ryy7YnDseOwFxK43ekBZ1Kzj+tURh8nEIipC+y74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgHTLB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731102AbgHTKNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:13:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F902075E;
        Thu, 20 Aug 2020 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918424;
        bh=nmcxt3WZtflwJ7Qs7MCerLyMF7yzlsKp1exKahSiFsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xmtDr7FI86dZBMmFSsYOeOqBQ44fE0ckdaKKA9h0+lXQfciQxahwj+14fPvP2GZvh
         ND0I5/RCYw4Dz+yE6QwWSbqEXyi8ETsFEL1BYgA3w0d6JPUo0EbqlFMx/diKQLiLlR
         9aSP5i55rq6X5S8DpJMQkV+z/fqtR/ri/hMTAxAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.14 165/228] xen/balloon: make the balloon wait interruptible
Date:   Thu, 20 Aug 2020 11:22:20 +0200
Message-Id: <20200820091615.822015614@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

commit 88a479ff6ef8af7f07e11593d58befc644244ff7 upstream.

So it can be killed, or else processes can get hung indefinitely
waiting for balloon pages.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200727091342.52325-3-roger.pau@citrix.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/balloon.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -633,11 +633,13 @@ static int add_ballooned_pages(int nr_pa
 	if (xen_hotplug_unpopulated) {
 		st = reserve_additional_memory();
 		if (st != BP_ECANCELED) {
+			int rc;
+
 			mutex_unlock(&balloon_mutex);
-			wait_event(balloon_wq,
+			rc = wait_event_interruptible(balloon_wq,
 				   !list_empty(&ballooned_pages));
 			mutex_lock(&balloon_mutex);
-			return 0;
+			return rc ? -ENOMEM : 0;
 		}
 	}
 


