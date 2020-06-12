Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96FAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B204D207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="eNoIDLXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:00:53 -0400
Received: from sender4-pp-o92.zoho.com ([136.143.188.92]:25226 "EHLO
        sender4-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:00:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591977590; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ATQJhj0fE03xuSNVt21N+EI8x9Em6KCI5bBIbxOkYI0W1s7DvVkeehXwcgYzHC5HpNjiMNcKJw8nxKIV6YhWgUvjRtnwqSEIRPwaMX8GU1yPEGSCopuZR1PvMjCMrQqXs/47ELzovLSxUj4eUXnGfJujTRhQYGbHSOk38Q8qIXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591977590; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=AbCyrlMVxtFExEvwn074Cj50QCw50WDefmOdHOqkC0s=; 
        b=fuCA20tyRes58chU5EVP7KuGNEgDQ1A3BkV7zOsOaSmmuNtTxfe8en+52yqtCnxdCsmQKL3E7Mx3X8J7B8A5trsvhinQUJqDMyv5/UY5ALynWsM4U4GHaTlXjNd+p+hxJmofGOJaQlcDvSjHus0uefx7WZDAz9csj3qTt/n+nDw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=jwib4dOSM4dN3RdXv+76K4G5TxQ+2UkhB8qPHsbvUdrrJ2zTmRf5BX66PW6cvNYcpcble5sSv1JL
    lZzNJRcGyyEmxucQTypF2ncMei/TrRY2NNc6/I7PfM9OSzbPyeO+  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591977590;
        s=zm2020; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=AbCyrlMVxtFExEvwn074Cj50QCw50WDefmOdHOqkC0s=;
        b=eNoIDLXcYUZA1jnq/kGKhMX7uuFz2EFIhfeKC4fpGtMxpNg7iS+ptLB2wgOAeJCn
        x6blyjT6/BlVGFZZxaeHYY6STACwc/oa6z3UCNA0Y3wovBaLaeBhx2aBbAlM0KLelfM
        Wv6GLvvl0LE8AhdjkWLet01cAMTFEPmjtxblsbbI=
Received: from YEHS1XPF1D05WL.lenovo.com (111.197.254.230 [111.197.254.230]) by mx.zohomail.com
        with SMTPS id 15919775869391016.4366660991806; Fri, 12 Jun 2020 08:59:46 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm writecache: correct uncommitted_block when discarding uncommitted entry
Date:   Fri, 12 Jun 2020 23:59:11 +0800
Message-Id: <20200612155911.96528-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

When uncommitted entry has been discarded, correct wc->uncommitted_block
for getting the exact number.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4367cc7..64b4527 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -855,6 +855,8 @@ static void writecache_discard(struct dm_writecache *wc, sector_t start, sector_
 				}
 				discarded_something = true;
 			}
+			if (!writecache_entry_is_committed(wc, e))
+				wc->uncommitted_blocks--;
 			writecache_free_entry(wc, e);
 		}
 
-- 
1.8.3.1

