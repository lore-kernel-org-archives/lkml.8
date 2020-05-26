Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3ED20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520964;
	bh=78N8hQGhGPFVLaXmK4KVhx2rUwxFGMkns25RJDOs+mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IBKsC/GtcNKAsePWwn3bS7XppgwvWoUMSE7iMCxTF2amdSHwXEhxJN9FHumdJ/Ejn
	 q12VRtB0buw35llpYJAnIRpq2iTNJKGKjm6jtgtyUZ1bfKej43yxKBPaOEZBCS7CP0
	 dZIQZLV2MafM/0eV4cpvZ7DIB7TxQM27fmO0Mp+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbgEZTJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391897AbgEZTJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:09:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A24A208B3;
        Tue, 26 May 2020 19:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520184;
        bh=78N8hQGhGPFVLaXmK4KVhx2rUwxFGMkns25RJDOs+mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyiNg+iJuWPlEBMf3tZ0rPBgFSuqhWuFfJ+PBiQa5QPNCTDjVyNwZ8hhCPR0Kfc53
         wn1quKjU+lwd70NcPTBqQedZ17fqf/M3Tp7YsGD2/xOAogpwXBl8PyhjdIHVVS6WhO
         +2+b+fjq+67ODusKcx4r+bmyafO62NzeWE8FfT04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Subject: [PATCH 5.4 091/111] ipack: tpci200: fix error return code in tpci200_register()
Date:   Tue, 26 May 2020 20:53:49 +0200
Message-Id: <20200526183941.551886747@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 133317479f0324f6faaf797c4f5f3e9b1b36ce35 upstream.

Fix to return negative error code -ENOMEM from the ioremap() error handling
case instead of 0, as done elsewhere in this function.

Fixes: 43986798fd50 ("ipack: add error handling for ioremap_nocache")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Link: https://lore.kernel.org/r/20200507094237.13599-1-weiyongjun1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ipack/carriers/tpci200.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -306,6 +306,7 @@ static int tpci200_register(struct tpci2
 			"(bn 0x%X, sn 0x%X) failed to map driver user space!",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
+		res = -ENOMEM;
 		goto out_release_mem8_space;
 	}
 


