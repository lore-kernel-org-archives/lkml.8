Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A46C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD0A20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748040;
	bh=rcQDecP37dL91YXleyWQRqGSr0A+L9q6Ie3Ao5CUXLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2zJGQJBvK5GoIhC3cfoA2eDd/zSemAWRe1EIY+y1PdEbppWMc622iYt6R4iV1uTS
	 TetY62oCbHK9PeEppEXjpaRyu8o+PEjAGURBKojwP+YLplep5zlH733r6KeJRAb0cU
	 qRIb6WZszLCbcZxbHVuXZK2hp6c5LgSiBN3D+m/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgBCQkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731136AbgBCQgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:36:09 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E3E222D9;
        Mon,  3 Feb 2020 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747768;
        bh=rcQDecP37dL91YXleyWQRqGSr0A+L9q6Ie3Ao5CUXLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TT2rrDdD6zNoMdmoIYgMho2p7tbYE3lrl1jHl2M4R1yUOPBIIpgfUZzhUVJu8MW5O
         DHHtV8shE9VGAhuz7rn+M50kRZLQzHzzIHrHEikWENKC4k9gtz3dnotRAjxj9ZMlt+
         HIzIxU8n/Q6FRVigTNarBYndERA+xaFKtDGk5YGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+eba992608adf3d796bcc@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH 5.4 22/90] Bluetooth: Fix race condition in hci_release_sock()
Date:   Mon,  3 Feb 2020 16:19:25 +0000
Message-Id: <20200203161920.591354269@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 11eb85ec42dc8c7a7ec519b90ccf2eeae9409de8 upstream.

Syzbot managed to trigger a use after free "KASAN: use-after-free Write
in hci_sock_bind".  I have reviewed the code manually and one possibly
cause I have found is that we are not holding lock_sock(sk) when we do
the hci_dev_put(hdev) in hci_sock_release().  My theory is that the bind
and the release are racing against each other which results in this use
after free.

Reported-by: syzbot+eba992608adf3d796bcc@syzkaller.appspotmail.com
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_sock.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -831,6 +831,8 @@ static int hci_sock_release(struct socke
 	if (!sk)
 		return 0;
 
+	lock_sock(sk);
+
 	switch (hci_pi(sk)->channel) {
 	case HCI_CHANNEL_MONITOR:
 		atomic_dec(&monitor_promisc);
@@ -878,6 +880,7 @@ static int hci_sock_release(struct socke
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 
+	release_sock(sk);
 	sock_put(sk);
 	return 0;
 }


