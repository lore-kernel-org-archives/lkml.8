Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B692C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62796214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099695;
	bh=aA6z5Im+fckIqDKy07hv31qtqVKsbkx6P9lhSktTShc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SI7Av4uQFWj/JY5m2oYiNn5/tdYrdTLla5Bh1LGsznTpOTSXdSkOm+uDac/8ETjhN
	 YyqPdCtSArbOvxwPBxecG9iNAcXsEJz1hzDq4iudnK8MZYkFZDt+Sophm+JFa7jHXZ
	 h9ZT4UC0ruWNOQItW73qvksez0HjUab/jqALovKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgD1SlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730736AbgD1SlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:41:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D312085B;
        Tue, 28 Apr 2020 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099263;
        bh=aA6z5Im+fckIqDKy07hv31qtqVKsbkx6P9lhSktTShc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lnw3tP1RhzFKDolaB8+/vSdZgb1gVvykZYAY4pe+eaZjWzkCpbEU8/DJL3nvKQjQo
         4+IF0YDrTxb5KDOzPSABS71dln17P99/2mWjOm9h2+l3AFy6pLuIx04AzMGVYt3wgc
         ClDlkupf+OGJHOBjdwss8awQudNo74CnjQvNp5P4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.19 124/131] UAS: no use logging any details in case of ENODEV
Date:   Tue, 28 Apr 2020 20:25:36 +0200
Message-Id: <20200428182240.848679067@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 5963dec98dc52d52476390485f07a29c30c6a582 upstream.

Once a device is gone, the internal state does not matter anymore.
There is no need to spam the logs.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Fixes: 326349f824619 ("uas: add dead request list")
Link: https://lore.kernel.org/r/20200415141750.811-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/uas.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -190,6 +190,9 @@ static void uas_log_cmd_state(struct scs
 	struct uas_cmd_info *ci = (void *)&cmnd->SCp;
 	struct uas_cmd_info *cmdinfo = (void *)&cmnd->SCp;
 
+	if (status == -ENODEV) /* too late */
+		return;
+
 	scmd_printk(KERN_INFO, cmnd,
 		    "%s %d uas-tag %d inflight:%s%s%s%s%s%s%s%s%s%s%s%s ",
 		    prefix, status, cmdinfo->uas_tag,


