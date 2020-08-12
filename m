Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F9A20829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dtgd6HtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHLM4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgHLM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597236990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wtUEuaiFxIPvaNcjkG30c2D0ZFttoyb0SDwoRwrTnz8=;
        b=Dtgd6HtNyu0jQuyVmijRBgXKDSytj/1bWgp/uLTgiHuILdzrh7UpuvSaFDY3106szDOkeQ
        4lQQLOzYz8oeA8k9X9U/bXc8DGxqHOYOaNg/O6EuSobCjqIXBfSJR6M2wsuIuZytrji6Bk
        3HIXfesZRhbUJt0kHvg544sUXvT+wz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-yYuXOglJOHOU5GhVukWnIQ-1; Wed, 12 Aug 2020 08:56:17 -0400
X-MC-Unique: yYuXOglJOHOU5GhVukWnIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE2379EC0;
        Wed, 12 Aug 2020 12:56:15 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4F9260C84;
        Wed, 12 Aug 2020 12:56:04 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net v2] vsock: fix potential null pointer dereference in vsock_poll()
Date:   Wed, 12 Aug 2020 14:56:02 +0200
Message-Id: <20200812125602.96598-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported this issue where in the vsock_poll() we find the
socket state at TCP_ESTABLISHED, but 'transport' is null:
  general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
  CPU: 0 PID: 8227 Comm: syz-executor.2 Not tainted 5.8.0-rc7-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  RIP: 0010:vsock_poll+0x75a/0x8e0 net/vmw_vsock/af_vsock.c:1038
  Call Trace:
   sock_poll+0x159/0x460 net/socket.c:1266
   vfs_poll include/linux/poll.h:90 [inline]
   do_pollfd fs/select.c:869 [inline]
   do_poll fs/select.c:917 [inline]
   do_sys_poll+0x607/0xd40 fs/select.c:1011
   __do_sys_poll fs/select.c:1069 [inline]
   __se_sys_poll fs/select.c:1057 [inline]
   __x64_sys_poll+0x18c/0x440 fs/select.c:1057
   do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

This issue can happen if the TCP_ESTABLISHED state is set after we read
the vsk->transport in the vsock_poll().

We could put barriers to synchronize, but this can only happen during
connection setup, so we can simply check that 'transport' is valid.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Reported-and-tested-by: syzbot+a61bac2fcc1a7c6623fe@syzkaller.appspotmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
 - removed cleanups patch from the series [David]

v1: https://patchwork.ozlabs.org/project/netdev/cover/20200811095504.25051-1-sgarzare@redhat.com/
---
 net/vmw_vsock/af_vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 27bbcfad9c17..9e93bc201cc0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1032,7 +1032,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		}
 
 		/* Connected sockets that can produce data can be written. */
-		if (sk->sk_state == TCP_ESTABLISHED) {
+		if (transport && sk->sk_state == TCP_ESTABLISHED) {
 			if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
 				bool space_avail_now = false;
 				int ret = transport->notify_poll_out(
-- 
2.26.2

