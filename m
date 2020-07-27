Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E8C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04AE2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IfxfXrJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgG0JPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:15:06 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:33530 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgG0JPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595841304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yXg+mOKMXOlPk9hYGg2gJuPP2ADAccszlFJ6TOt/+Ug=;
  b=IfxfXrJ/joTh9ku3J7FuyT0KyFAAzt4bHsRv/vFVYYBTRqQSPcbmj/IM
   v4cpmsGTUy+AKQexRzegb1s3RO+XY+BnQ4REx8EQwJsZKZiwvTtc6QgTX
   4086FOVZ5PmNZxHJm4z4pidOJ84alp/+YAVPOAUPXKur+cJu/AUNYBt3k
   A=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: /lonDtJpry0GWq2IuiXzOVqYuyFYZER9q6g6pJnZVdsuhB60qYm8sw5ir81a6lE5JD3VvhAgnZ
 uuL5JM5gPHap68Oz7Fo4P5sHe+FH6rqD/766TtL7+nfxGgX5SQLd2SdX4TYFz/FTZ0ajYT3Xbt
 rB6divUhbolOgbljhK0WH+nMFJ5IRNvSU3I9OV+jZvZifd4q2AgNFuE8TTh/foBPfTGMsl9Jqf
 0SJi+bG8Sd9zz8aeie0dIrsLOFQmPTiT1b5E8G3k8quqYAfiezZ6DqObqRbQGcB2zt1RJBuw1b
 Acc=
X-SBRS: 2.7
X-MesageID: 23569857
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,402,1589256000"; 
   d="scan'208";a="23569857"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>, <stable@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v3 1/4] xen/balloon: fix accounting in alloc_xenballooned_pages error path
Date:   Mon, 27 Jul 2020 11:13:39 +0200
Message-ID: <20200727091342.52325-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727091342.52325-1-roger.pau@citrix.com>
References: <20200727091342.52325-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

target_unpopulated is incremented with nr_pages at the start of the
function, but the call to free_xenballooned_pages will only subtract
pgno number of pages, and thus the rest need to be subtracted before
returning or else accounting will be skewed.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/balloon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 77c57568e5d7..3cb10ed32557 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -630,6 +630,12 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
  out_undo:
 	mutex_unlock(&balloon_mutex);
 	free_xenballooned_pages(pgno, pages);
+	/*
+	 * NB: free_xenballooned_pages will only subtract pgno pages, but since
+	 * target_unpopulated is incremented with nr_pages at the start we need
+	 * to remove the remaining ones also, or accounting will be screwed.
+	 */
+	balloon_stats.target_unpopulated -= nr_pages - pgno;
 	return ret;
 }
 EXPORT_SYMBOL(alloc_xenballooned_pages);
-- 
2.27.0

