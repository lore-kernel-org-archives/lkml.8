Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7EAC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F99420721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615226;
	bh=fwR0V1cq/YSDhhql/2sy5/+ZtJJnxpF1Wz065Hb34Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWHjU3WqsuPy9LDfI+gtDteQhSW4cDzz38Y9oR25jZdPNI1uHeRbS9A+fupkPEZG6
	 S0ZVxoaC7QPWWBK2r3VA+fTMDhuK8DL0IcBOQJlFgE9nmVSp5yOC/xZCIyLS0QZfqb
	 sOzCO55F7zMFQIWC2jwW4ARshUafTGPC7iEFmA3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgEDSAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbgEDSAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2229520721;
        Mon,  4 May 2020 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615221;
        bh=fwR0V1cq/YSDhhql/2sy5/+ZtJJnxpF1Wz065Hb34Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAwyvPz+t8nlWOELMhGSVQ0h9Aq6BaSEo82TwVkVilA/kuOagba428vY5d6rQ8l6v
         waibYWMazrS/fr9W2xKR4Iv8n720tN/EVXoTI4F6f9lEc24gviLVVCVWc2w6zpiV8h
         xbu1wuuXGVeCuyQX+SPhu85y6oYL1FvNX+uBsxXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sunwook Eom <speed.eom@samsung.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 15/26] dm verity fec: fix hash block number in verity_fec_decode
Date:   Mon,  4 May 2020 19:57:29 +0200
Message-Id: <20200504165445.923422760@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
References: <20200504165442.494398840@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunwook Eom <speed.eom@samsung.com>

commit ad4e80a639fc61d5ecebb03caa5cdbfb91fcebfc upstream.

The error correction data is computed as if data and hash blocks
were concatenated. But hash block number starts from v->hash_start.
So, we have to calculate hash block number based on that.

Fixes: a739ff3f543af ("dm verity: add support for forward error correction")
Cc: stable@vger.kernel.org
Signed-off-by: Sunwook Eom <speed.eom@samsung.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-verity-fec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -436,7 +436,7 @@ int verity_fec_decode(struct dm_verity *
 	fio->level++;
 
 	if (type == DM_VERITY_BLOCK_TYPE_METADATA)
-		block += v->data_blocks;
+		block = block - v->hash_start + v->data_blocks;
 
 	/*
 	 * For RS(M, N), the continuous FEC data is divided into blocks of N


