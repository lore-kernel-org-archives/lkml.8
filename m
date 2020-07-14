Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECA2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4B622B51
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753295;
	bh=ecVI2sKbstIFHqe7Mbv87GVVyEHewlYBn/1nEgvvHG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PaV8q6ttlf9rWQbFYL4LHLrdQjl9PBPGu/eGMCSzCsfQmtRA7mmiJ809uvMMfaMEx
	 KtkBYAYWXgb7eWptGdpCiPqsIlLNHWAAxS8B5TuXzpej5Zl7STVYKx4/SDgWwwA8tw
	 iga9y7/rtzTeQWYAEcB6I5j2wFZs5CBm6ErAMuKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgGNTBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731278AbgGNS7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E78C22B4D;
        Tue, 14 Jul 2020 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753175;
        bh=ecVI2sKbstIFHqe7Mbv87GVVyEHewlYBn/1nEgvvHG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DA0Ea6vPvWNu+IjB/YPTna2IzVj60ZEQRQPmzW5ez6TbN7KJ+yscObTuWqkIYH5ZE
         4nz77GeEPrnFUmwVPzpHn1dDTO2i0mlb/u77QZEiyOSMQ04ARSIq6TlJPXPRp4XltN
         2sqjZC9j0+QjxQMwPeilOqt0TyfcvOFIxwmlcKoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 5.7 148/166] smb3: fix unneeded error message on change notify
Date:   Tue, 14 Jul 2020 20:45:13 +0200
Message-Id: <20200714184122.912946785@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

commit 8668115cf2db40e22e7be02652a3673d8d30c9f0 upstream.

We should not be logging a warning repeatedly on change notify.

CC: Stable <stable@vger.kernel.org> # v5.6+
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2misc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -354,9 +354,13 @@ smb2_get_data_area_len(int *off, int *le
 		  ((struct smb2_ioctl_rsp *)shdr)->OutputCount);
 		break;
 	case SMB2_CHANGE_NOTIFY:
+		*off = le16_to_cpu(
+		  ((struct smb2_change_notify_rsp *)shdr)->OutputBufferOffset);
+		*len = le32_to_cpu(
+		  ((struct smb2_change_notify_rsp *)shdr)->OutputBufferLength);
+		break;
 	default:
-		/* BB FIXME for unimplemented cases above */
-		cifs_dbg(VFS, "no length check for command\n");
+		cifs_dbg(VFS, "no length check for command %d\n", le16_to_cpu(shdr->Command));
 		break;
 	}
 


