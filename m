Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956CDC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7848120675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgEEOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:20:11 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgEEOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:05 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M9nEJ-1jSNK23B49-005rjT; Tue, 05 May 2020 16:15:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>, Wei Liu <wl@xen.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] xenbus: avoid stack overflow warning
Date:   Tue,  5 May 2020 16:15:37 +0200
Message-Id: <20200505141546.824573-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A6tw1zrTOAQW5yW+MxCDJvOopLSS/Ga3YzKkHajnYByzROmhf/Z
 UCjmaSkpNjyjF6nnYkDrgoDTQcQKOsy9GqpcEYeDBFITW4FIlbQVan7MDSfBvVH5vKDNaMG
 I57/Bb6kf/hHfTGPMDXpo9MiGKtA/lQKOkRk2jrdXtJteCeqspXA4ZRf6fi0zCQjBphQskO
 vo1QzWOdqSAs5HBhhLKyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AVDw9QU2Bq0=:RtvByz9YZEMaNPXxSQQaan
 cDa1tb8w5qa0/seyrGG5bEJDTWS1bQ6DU6Z3caE8AVZWP1DLGjx3JqQeK/1xFSA7XkiiMJyhk
 g9yWhIyFP3lr0xAKhrdIAeNeM227xqBDcoaJzkkSz7XLlBTcbuKxl+ZBf6c7IvRpJTium5Wpy
 wbna0RoQzxMBC5A1ijVWpzJPTQ7zvqxiSFQvyLxdIYvMvoRuaB1v0r0X2ffQfaZ/Czv/uqxyY
 E9XMnNAgucakN6lhB6eQ6MOsvvookARXupmUbbnYbrkjFuSavXZ5pPP4YBTM6PZq3heRt0Ffb
 JXcfBQqCOIzDgg7z68QhXEjzhQzOU4skSyZfx4/PAjDqxOMtEfkTgAIUF067/bJHW4AdVoJMY
 X+QbTqcaz/Ajz1Bf4V8+HNe3gCPNTAZr5Ybk5lRqkDoEqY/Ks4zyMQ/eR4+CxwQJ9LlAs7EQJ
 h6UvsBe6lcNJlmhfiIaAlxlQjzHwYJ2LmHLpAEq9YFUPDzY2vcYxrehJKsZD3z9sR9EMwrX1I
 SCBTxeQ5jjvIOIGLuslnh9tYC1VW3T9yt9QsuzcNAm2vg28xGYLkrNxvRpFlltV+SGz4EriaI
 ZKIpN/t8zQ1fTUnto9/GFaHTg0xIITo1QroKaSzEh2NeBZt5Z1ioW6I3pIWOY2xIhgHsRK/NH
 UIcynKaRVx7azRrZE9UI8sHcKSwYGlA0KhQM/SBjFqUO6NKyqrqMAwhYjVYdRmoSIMoeKxDMm
 ZE/GCuMVoM+OE+Jo4mT72blCEhI8HrcXl2M0M3aXX9f7P/C/S9P0oo9BzRoS655scEfNndInz
 7spEwdABS87Ga/MwDfUpMag/fwUWsaGdnX00Lewh0xtIkUjZQc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __xenbus_map_ring() function has two large arrays, 'map' and
'unmap' on its stack. When clang decides to inline it into its caller,
xenbus_map_ring_valloc_hvm(), the total stack usage exceeds the warning
limit for stack size on 32-bit architectures.

drivers/xen/xenbus/xenbus_client.c:592:12: error: stack frame size of 1104 bytes in function 'xenbus_map_ring_valloc_hvm' [-Werror,-Wframe-larger-than=]

As far as I can tell, other compilers don't inline it here, so we get
no warning, but the stack usage is actually the same. It is possible
for both arrays to use the same location on the stack, but the compiler
cannot prove that this is safe because they get passed to external
functions that may end up using them until they go out of scope.

Move the two arrays into separate basic blocks to limit the scope
and force them to occupy less stack in total, regardless of the
inlining decision.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/xenbus/xenbus_client.c | 74 +++++++++++++++++-------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 040d2a43e8e3..23ca70378e36 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -470,54 +470,62 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 			     unsigned int flags,
 			     bool *leaked)
 {
-	struct gnttab_map_grant_ref map[XENBUS_MAX_RING_GRANTS];
-	struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
 	int i, j;
 	int err = GNTST_okay;
 
-	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
-		return -EINVAL;
+	{
+		struct gnttab_map_grant_ref map[XENBUS_MAX_RING_GRANTS];
 
-	for (i = 0; i < nr_grefs; i++) {
-		memset(&map[i], 0, sizeof(map[i]));
-		gnttab_set_map_op(&map[i], addrs[i], flags, gnt_refs[i],
-				  dev->otherend_id);
-		handles[i] = INVALID_GRANT_HANDLE;
-	}
+		if (nr_grefs > XENBUS_MAX_RING_GRANTS)
+			return -EINVAL;
 
-	gnttab_batch_map(map, i);
+		for (i = 0; i < nr_grefs; i++) {
+			memset(&map[i], 0, sizeof(map[i]));
+			gnttab_set_map_op(&map[i], addrs[i], flags,
+					  gnt_refs[i], dev->otherend_id);
+			handles[i] = INVALID_GRANT_HANDLE;
+		}
+
+		gnttab_batch_map(map, i);
 
-	for (i = 0; i < nr_grefs; i++) {
-		if (map[i].status != GNTST_okay) {
-			err = map[i].status;
-			xenbus_dev_fatal(dev, map[i].status,
+		for (i = 0; i < nr_grefs; i++) {
+			if (map[i].status != GNTST_okay) {
+				err = map[i].status;
+				xenbus_dev_fatal(dev, map[i].status,
 					 "mapping in shared page %d from domain %d",
 					 gnt_refs[i], dev->otherend_id);
-			goto fail;
-		} else
-			handles[i] = map[i].handle;
+				goto fail;
+			} else
+				handles[i] = map[i].handle;
+		}
 	}
-
 	return GNTST_okay;
 
  fail:
-	for (i = j = 0; i < nr_grefs; i++) {
-		if (handles[i] != INVALID_GRANT_HANDLE) {
-			memset(&unmap[j], 0, sizeof(unmap[j]));
-			gnttab_set_unmap_op(&unmap[j], (phys_addr_t)addrs[i],
-					    GNTMAP_host_map, handles[i]);
-			j++;
+	{
+		struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
+
+		for (i = j = 0; i < nr_grefs; i++) {
+			if (handles[i] != INVALID_GRANT_HANDLE) {
+				memset(&unmap[j], 0, sizeof(unmap[j]));
+				gnttab_set_unmap_op(&unmap[j],
+						    (phys_addr_t)addrs[i],
+						    GNTMAP_host_map,
+						    handles[i]);
+				j++;
+			}
 		}
-	}
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, j))
-		BUG();
+		if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref,
+					      unmap, j))
+			BUG();
 
-	*leaked = false;
-	for (i = 0; i < j; i++) {
-		if (unmap[i].status != GNTST_okay) {
-			*leaked = true;
-			break;
+		*leaked = false;
+		for (i = 0; i < j; i++) {
+			if (unmap[i].status != GNTST_okay) {
+				*leaked = true;
+				break;
+			}
 		}
 	}
 
-- 
2.26.0

