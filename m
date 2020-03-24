Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B330DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B358208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055733;
	bh=NdXj8AobCtKW15pxvIDIVPmaMMy5Xo0phZ+4bEez/Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhYvX1TGvESWJ8KHhdyLWlgSVECODEmwGhFfnOW06NeuVbBfeoLzwk9vevqdMokyX
	 bDN5f6X0c5DDFIk9ITu6wW+35CtRbF8+AWjibHgKqYQtJukvILCW+fx/wwy4rMrcVV
	 YV78DVrZ9zTTGfVz3fKDR4HYy4hrLee099rrCcEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCXNPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgCXNPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:15:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD30208CA;
        Tue, 24 Mar 2020 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055729;
        bh=NdXj8AobCtKW15pxvIDIVPmaMMy5Xo0phZ+4bEez/Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/QOR3fTtEHshLi7uM4Wu4TxRr748xFRgA+vVZKks2Nf8CjrmcjneuuxA5bFgapnO
         EZDASfwzkxiU53I8xn1n+JaB53nZXOeQIGi7v/rictXsbw2xInHNgoSNxZ5OMwOx4O
         GvZJx68VzcFeZ/NvdySvwQjwrqWhpkarFlmdmwBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 011/102] cifs: add missing mount option to /proc/mounts
Date:   Tue, 24 Mar 2020 14:10:03 +0100
Message-Id: <20200324130807.702016298@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit ec57010acd03428a749d2600bf09bd537eaae993 ]

We were not displaying the mount option "signloosely" in /proc/mounts
for cifs mounts which some users found confusing recently

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 637624ab6e464..115f063497ffa 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -530,6 +530,8 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
 
 	if (tcon->seal)
 		seq_puts(s, ",seal");
+	else if (tcon->ses->server->ignore_signature)
+		seq_puts(s, ",signloosely");
 	if (tcon->nocase)
 		seq_puts(s, ",nocase");
 	if (tcon->local_lease)
-- 
2.20.1



