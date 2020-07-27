Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F46DC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD32C2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860323;
	bh=s5Q4ctpRsBm8oESX+lpNjsYimsvbDT/V1ZnkvyV0PMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtRzhkOgYCXbYo6SdBFagPciMaubV6unCLbwZ1FNUb7nsj88O8eXzOl0WOqKlIJQt
	 UovnrplMe0Q19Gqo9rn+MlOS8ArW7X+7Zx1Cj4+fc9yAdjBMPUZqN0DYG9/YXf5nOX
	 X8FQ7tYr18R2lny0GLwrOWXFHpxj/f2l6xu4ac6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbgG0OcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731435AbgG0OTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:19:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1D620825;
        Mon, 27 Jul 2020 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859585;
        bh=s5Q4ctpRsBm8oESX+lpNjsYimsvbDT/V1ZnkvyV0PMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJkptTPnTVogYm70HpjH0PwTQcCHfu65O/TlHlv7+tO0lhV8eeH6WcOUPsjK9fw79
         SlFil32a6PNbWbPjTtY2ay7En8nGbTTuR30DvHVbK74wltBYSB98RXKnSGuEgPumNp
         hfXtEb/nk1KvJIaB9Ob3EuMxHV3k9j9VnRuQle3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 5.7 028/179] exfat: fix wrong hint_stat initialization in exfat_find_dir_entry()
Date:   Mon, 27 Jul 2020 16:03:23 +0200
Message-Id: <20200727134934.039735126@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

commit d2fa0c337d97a5490190b9f3b9c73c8f9f3602a1 upstream.

We found the wrong hint_stat initialization in exfat_find_dir_entry().
It should be initialized when cluster is EXFAT_EOF_CLUSTER.

Fixes: ca06197382bd ("exfat: add directory operations")
Cc: stable@vger.kernel.org # v5.7
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exfat/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1160,7 +1160,7 @@ found:
 			ret = exfat_get_next_cluster(sb, &clu.dir);
 		}
 
-		if (ret || clu.dir != EXFAT_EOF_CLUSTER) {
+		if (ret || clu.dir == EXFAT_EOF_CLUSTER) {
 			/* just initialized hint_stat */
 			hint_stat->clu = p_dir->dir;
 			hint_stat->eidx = 0;


