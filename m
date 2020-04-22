Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56EC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE9A20735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549734;
	bh=cH8+4pwgwB93FGammqT5AqRne5uguPxc4pSIHozizFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gYE1H4vhWX5ulc4r77FETcRG8iOmB0wvytyMl940ZMFvZvmzr2cAIFappuIEIDiUf
	 ANe3FK5OS8FDlsKB1exn8xxZOfNkx+jO1VInzG0W+BFVCZVqd7MtTZXD0YOrCnKJNE
	 OOIhJajhlwJC/ayVVoecz/x5vJp/70/50SNwtclE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgDVKCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgDVKCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:02:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A43820774;
        Wed, 22 Apr 2020 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549725;
        bh=cH8+4pwgwB93FGammqT5AqRne5uguPxc4pSIHozizFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdTmbBpX+6VHcloKjan40Vwf35Ve/wPQHlNdDB7/MkOPB2gMXTahxw+yI8/1WI1nK
         PL9FCawDYupa0jrpmVF/bga1sjJSL94Si25XH71+X8w+BLsvLt0hiB5C9mWgFP27kr
         U66f5pMxH703pdeL9a/Y2dsyz9M2Vh2a2nJmHL6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Lew <clew@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 081/100] soc: qcom: smem: Use le32_to_cpu for comparison
Date:   Wed, 22 Apr 2020 11:56:51 +0200
Message-Id: <20200422095037.611762491@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

[ Upstream commit a216000f0140f415cec96129f777b5234c9d142f ]

Endianness can vary in the system, add le32_to_cpu when comparing
partition sizes from smem.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/smem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -646,7 +646,7 @@ static int qcom_smem_enumerate_partition
 			return -EINVAL;
 		}
 
-		if (header->size != entry->size) {
+		if (le32_to_cpu(header->size) != le32_to_cpu(entry->size)) {
 			dev_err(smem->dev,
 				"Partition %d has invalid size\n", i);
 			return -EINVAL;


