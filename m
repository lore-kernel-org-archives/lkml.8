Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0C8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163B120661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217824;
	bh=i/BoBTbHaCjR2uOW+bt2S3QNtnumEbfBPYU9+J9pbMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mop5SRw/5MPXUmKydHrZx+/1drWVDsshEt+kV/fozpD+2Agfv2BswN5FxeW27X/FW
	 xolRfMNcv3zHEpcSkNsKCbICZ0u1LArGyMZM4c6vOYLJVC+Ev/+Dzy2PN7oh2V9OXn
	 Y8Nb7fr2/bHsszoRSa5IjNiuBAHPEoIcOdKTOAA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404459AbgAPXhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:37:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389119AbgAPXbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:31:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A446820684;
        Thu, 16 Jan 2020 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217483;
        bh=i/BoBTbHaCjR2uOW+bt2S3QNtnumEbfBPYU9+J9pbMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHgbhU/TL2OJxlOhSD7LP3qUKSfxUnaLV1LN9Mms8+sOfNPeVUo4dm/gJK54MKekJ
         ZsxCUZrAWU21Tn+jfViTGUaIbi354OYbF+5ZVk5Wwc47Nd8mmndI4WGtsi/ceq8+O6
         vu6rwur3Y8/bq6iblLwJbQybAf7lRvHaqLsrv3II=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 17/71] iwlwifi: dbg_ini: fix memory leak in alloc_sgtable
Date:   Fri, 17 Jan 2020 00:18:15 +0100
Message-Id: <20200116231711.947825988@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit b4b814fec1a5a849383f7b3886b654a13abbda7d upstream.

In alloc_sgtable if alloc_page fails, the alocated table should be
released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -532,6 +532,7 @@ static struct scatterlist *alloc_sgtable
 				if (new_page)
 					__free_page(new_page);
 			}
+			kfree(table);
 			return NULL;
 		}
 		alloc_size = min_t(int, size, PAGE_SIZE);


