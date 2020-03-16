Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028FC5ACBF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ABD20722
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326025;
	bh=+YZAPcAAS0q81TrNb09xZY/jNelvp3jwoe0bSJrRCdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSW8E0htC25815gJht4NyYNZ0sW+p4nwUN+CPBMzwPn94b0LsFJYIggSEZfNLZvme
	 Vorc/7PIfmMRBpshSo77aqwQNEXcne3GCrwBr53PKcesT4Mq2rN8U7DBn1w7dll2s8
	 St0IIdUEv058UQvNCUuu96z7i+FcnhG7Byvobrsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgCPCdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729563AbgCPCdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0DD0206E9;
        Mon, 16 Mar 2020 02:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326015;
        bh=+YZAPcAAS0q81TrNb09xZY/jNelvp3jwoe0bSJrRCdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2A8ia+tPcRFGnL5qtCDS6AQsrZpvIQiAUTCt1paioi3/XoUARuIqGNPu0uovoW+4
         vUOtsl29pWiAzOElpxYsQTLNsbKnVI6d28IMJwkGYmuwqqjsYWKdNr8feKJ8PaqkMd
         S6iU1A4WjRf81zUQIjdOD56QGXMkZuW98dJL7vBs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 5.5 13/41] cifs: add missing mount option to /proc/mounts
Date:   Sun, 15 Mar 2020 22:32:51 -0400
Message-Id: <20200316023319.749-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 92b9c8221f078..7659286954d3a 100644
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

