Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE6E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYpUOwon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgGaERd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 00:17:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24506 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbgGaERc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596169051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=reeNLg+TD55rsNB2iiTvcYYEevnQu1S+px9nBOesrWc=;
        b=NYpUOwonBG8hjWFcVIf6hIdgUks9Mhvrj/1hvOkvN/16DTeXJpQ8fqgCKI46Ri7KzQ7fJZ
        fX9aFPGGp1QCR7tCZSwlAf2FlwSgTkDjCTQHr9P6tXmhMjKBSpoe4Om2U2UD3CwFSfvhg/
        ZNhXjPimtwqrTSncCRgqahpwdZahKM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-MFzPlCQiNNC59nag-YGbIg-1; Fri, 31 Jul 2020 00:17:29 -0400
X-MC-Unique: MFzPlCQiNNC59nag-YGbIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF11800685;
        Fri, 31 Jul 2020 04:17:27 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F8B7100238C;
        Fri, 31 Jul 2020 04:17:22 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next] tun: add missing rcu annotation in tun_set_ebpf()
Date:   Fri, 31 Jul 2020 00:17:20 -0400
Message-Id: <20200731041720.61187-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expecte prog_p to be protected by rcu, so adding the rcu annotation
to fix the following sparse warning:

drivers/net/tun.c:3003:36: warning: incorrect type in argument 2 (different address spaces)
drivers/net/tun.c:3003:36:    expected struct tun_prog [noderef] __rcu **prog_p
drivers/net/tun.c:3003:36:    got struct tun_prog **prog_p
drivers/net/tun.c:3292:42: warning: incorrect type in argument 2 (different address spaces)
drivers/net/tun.c:3292:42:    expected struct tun_prog **prog_p
drivers/net/tun.c:3292:42:    got struct tun_prog [noderef] __rcu **
drivers/net/tun.c:3296:42: warning: incorrect type in argument 2 (different address spaces)
drivers/net/tun.c:3296:42:    expected struct tun_prog **prog_p
drivers/net/tun.c:3296:42:    got struct tun_prog [noderef] __rcu **

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7adeb91bd368..9b4b25358f9b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2983,7 +2983,7 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
 	return ret;
 }
 
-static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog **prog_p,
+static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
 			void __user *data)
 {
 	struct bpf_prog *prog;
-- 
2.18.1

