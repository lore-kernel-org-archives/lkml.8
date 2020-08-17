Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7042063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689495;
	bh=fMKPC68/uXyegGO1IEJSumlFPYTRRHQb7Pdm6W8QMTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ws2XuAKlbWYIOABdlSwYBsiQRhyq+Ex1zbibH2oTfRPz0vw5jLLGHkY6xuSm5tBfK
	 FDRurLLLxRHJAOiBuKpZwa9zste9u8yLcyIZQqVareccd1NSwpgrYrUqnA4zQKMhLb
	 EVkZEfimjTIsiJ/ANJaenLyxk8btLP7ikH0cm0eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbgHQSiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbgHQP6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:58:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE38207DA;
        Mon, 17 Aug 2020 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679926;
        bh=fMKPC68/uXyegGO1IEJSumlFPYTRRHQb7Pdm6W8QMTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TO8UUinOF0EN+kf2SVhSNYpgyjfgUdwSXIfXolCVYZVU5C39JesTRofnmIy6KlbM3
         IpC6eiWHdPOSlyHTMCeTpWLGJBowPbtW5d60BZI72eV/Il+dkm/vXc6ueVbuy1z3g1
         0wZaGTPz2eQtHnT9JL14eTk9QNYDUiBi9WC+lyVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.7 381/393] xen/balloon: fix accounting in alloc_xenballooned_pages error path
Date:   Mon, 17 Aug 2020 17:17:11 +0200
Message-Id: <20200817143838.089819229@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

commit 1951fa33ec259abdf3497bfee7b63e7ddbb1a394 upstream.

target_unpopulated is incremented with nr_pages at the start of the
function, but the call to free_xenballooned_pages will only subtract
pgno number of pages, and thus the rest need to be subtracted before
returning or else accounting will be skewed.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200727091342.52325-2-roger.pau@citrix.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/balloon.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -631,6 +631,12 @@ int alloc_xenballooned_pages(int nr_page
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


