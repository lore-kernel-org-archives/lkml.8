Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA7DC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EA222507
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753179;
	bh=AtVRfcjq3s0KS66WD2PIO0/e7a2vkESa5UXWYT5fqgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7sZHuOqfmMRuZFaeLCraKfKG91Jw4r2hr2ZoqogHy+bI05KsS3yN5ytdP9eoleZs
	 8x1VhsrgBbyW5JDFR/l7nfqJzZ+e6YWrdePdKD2Y86R2lbDgU8dJb5JoVtTmCRbY1L
	 uDx3vCEKf20+jGYbe9y2fk0SJh//2MgsB3HqDJjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgGNS7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbgGNS7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C599122B30;
        Tue, 14 Jul 2020 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753170;
        bh=AtVRfcjq3s0KS66WD2PIO0/e7a2vkESa5UXWYT5fqgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FB2OVZs7xAkqnmWcXvWwOQtyvmK/rA3jdhOoQInrhwp9SpXgJFwAAYOR8tRr5tRc
         ecTvNA3YslCVfOF5Q0rlWBxKW/mZCduUI4YLEnqvHG5gc/gTqCOcZZS+guF6CK//db
         WR1+W5Z/32soaOA35LjEiOv8EwB7TAgZe8CcPicg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 5.7 146/166] cifs: fix reference leak for tlink
Date:   Tue, 14 Jul 2020 20:45:11 +0200
Message-Id: <20200714184122.817333975@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit a77592a70081edb58a95b9da18fd5a2882a25666 upstream.

Don't leak a reference to tlink during the NOTIFY ioctl

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org> # v5.6+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/ioctl.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -169,6 +169,7 @@ long cifs_ioctl(struct file *filep, unsi
 	unsigned int xid;
 	struct cifsFileInfo *pSMBFile = filep->private_data;
 	struct cifs_tcon *tcon;
+	struct tcon_link *tlink;
 	struct cifs_sb_info *cifs_sb;
 	__u64	ExtAttrBits = 0;
 	__u64   caps;
@@ -307,13 +308,19 @@ long cifs_ioctl(struct file *filep, unsi
 				break;
 			}
 			cifs_sb = CIFS_SB(inode->i_sb);
-			tcon = tlink_tcon(cifs_sb_tlink(cifs_sb));
+			tlink = cifs_sb_tlink(cifs_sb);
+			if (IS_ERR(tlink)) {
+				rc = PTR_ERR(tlink);
+				break;
+			}
+			tcon = tlink_tcon(tlink);
 			if (tcon && tcon->ses->server->ops->notify) {
 				rc = tcon->ses->server->ops->notify(xid,
 						filep, (void __user *)arg);
 				cifs_dbg(FYI, "ioctl notify rc %d\n", rc);
 			} else
 				rc = -EOPNOTSUPP;
+			cifs_put_tlink(tlink);
 			break;
 		default:
 			cifs_dbg(FYI, "unsupported ioctl\n");


