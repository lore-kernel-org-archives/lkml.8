Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1E42145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592321891;
	bh=5GIVR3dJo5E0vm7patLbsSLEMQjShmR7q3qSyjF05Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FCMzK5994toFgEYXyU3k0mHRVhBU5hOoxIhKtRiNXw6Ys67RQO661WTNrzkMMdZVW
	 1eO8kzMNmd8Kl5Ft+VTU1oZYfHdz6+9A4ngEbxZS0H2Zd6SJjU20UyOHcqkjmuGeli
	 5KKLp1BcIOQ67+a7sSJkKberdQQGjizwFLfBaUHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgFPPiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730507AbgFPPiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:38:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F96D20B1F;
        Tue, 16 Jun 2020 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321880;
        bh=5GIVR3dJo5E0vm7patLbsSLEMQjShmR7q3qSyjF05Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdvM/Dl+HECmBmYltjCVpkCdJCu4oKc9+2o14+crSPSw2cMPGPf27fqy2jtMqkcP7
         VHK3NsXisiIpgQ1xaWf8QejHnGhKMdngBTU4Kxwxq0z6mzXztuk5OEGvf4AfOuq+O2
         4jv1PCFjfrQMRvaNebbW8ERflXzd3lUCbAyPkVG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 5.4 052/134] smb3: fix incorrect number of credits when ioctl MaxOutputResponse > 64K
Date:   Tue, 16 Jun 2020 17:33:56 +0200
Message-Id: <20200616153103.274283186@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit e80ddeb2f70ebd0786aa7cdba3e58bc931fa0bb5 upstream.

We were not checking to see if ioctl requests asked for more than
64K (ie when CIFSMaxBufSize was > 64K) so when setting larger
CIFSMaxBufSize then ioctls would fail with invalid parameter errors.
When requests ask for more than 64K in MaxOutputResponse then we
need to ask for more than 1 credit.

Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2747,7 +2747,7 @@ SMB2_ioctl_init(struct cifs_tcon *tcon,
 	 * response size smaller.
 	 */
 	req->MaxOutputResponse = cpu_to_le32(max_response_size);
-
+	req->sync_hdr.CreditCharge = cpu_to_le16(DIV_ROUND_UP(max_response_size, SMB2_MAX_BUFFER_SIZE));
 	if (is_fsctl)
 		req->Flags = cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL);
 	else


