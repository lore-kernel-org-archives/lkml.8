Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611BC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1B022464
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747660;
	bh=tfUQ0OtFWUwt3ZmIEKievnhC9gC19+ww/xJKGMsOyjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1bx93zfRXWu8AZPq8Hec8nq6Fyl5AfgOuKMwfPUYvTgEkM+lelr9/nfujG6Uys0Ac
	 ky3xxloAO6E++bor0cCK2qkcr846dgNa+fgSjbbX3rZA2TxPDMW+6YJXLuQ9KrpiPt
	 V91l6DxEb7NTFUfwJPjRAl2epmWY8741a8e4G9aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgBCQeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbgBCQeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:34:14 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D4F2082E;
        Mon,  3 Feb 2020 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747653;
        bh=tfUQ0OtFWUwt3ZmIEKievnhC9gC19+ww/xJKGMsOyjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvRTIiMTFn4GzDNjmjtvcU7byU8eXdRZIuRNsCgJzRIuUJETKhped4IF4FU1HylVH
         iPHK3T2YebYl1+hi9TpkFnyKbED/uigwiOH52Rxzl8oYq5Dk/KG8hw3t31ckYyb1Ri
         izfPkjoH/1Bp1ZwdVNZRjYfyiqnPLpl7oKhd8m/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH 5.4 02/90] cifs: fix soft mounts hanging in the reconnect code
Date:   Mon,  3 Feb 2020 16:19:05 +0000
Message-Id: <20200203161917.912939807@linuxfoundation.org>
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

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit c54849ddd832ae0a45cab16bcd1ed2db7da090d7 upstream.

RHBZ: 1795429

In recent DFS updates we have a new variable controlling how many times we will
retry to reconnect the share.
If DFS is not used, then this variable is initialized to 0 in:

static inline int
dfs_cache_get_nr_tgts(const struct dfs_cache_tgt_list *tl)
{
        return tl ? tl->tl_numtgts : 0;
}

This means that in the reconnect loop in smb2_reconnect() we will immediately wrap retries to -1
and never actually get to pass this conditional:

                if (--retries)
                        continue;

The effect is that we no longer reach the point where we fail the commands with -EHOSTDOWN
and basically the kernel threads are virtually hung and unkillable.

Fixes: a3a53b7603798fd8 (cifs: Add support for failover in smb2_reconnect())
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -312,7 +312,7 @@ smb2_reconnect(__le16 smb2_command, stru
 		if (server->tcpStatus != CifsNeedReconnect)
 			break;
 
-		if (--retries)
+		if (retries && --retries)
 			continue;
 
 		/*


