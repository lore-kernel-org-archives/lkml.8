Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6776FC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ECC2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858710;
	bh=SsqL4TC6CBnR4YGWS5myE+1yRoseKbefTptY2dvtYkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tomda8xCguooDw6N4b7sj2Ojl2MoiKBiR8CAu3Y3sq28XqN0mgWprlSHYc9keqxrT
	 WWlqJLKJG7dSl7mm6AXEAR+FNQz+hBHcBL0vRJ8HXYyiZ9A+YGi2i0GnPw+iQLXhxX
	 yimK9m+b68Chq5qfduxkkTdKEuMkzNFZYKACUkyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgAXJi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAXJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:38:27 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96BAD2070A;
        Fri, 24 Jan 2020 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858707;
        bh=SsqL4TC6CBnR4YGWS5myE+1yRoseKbefTptY2dvtYkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynJcn/hHwqHMZjKmEv40e762H1vl1JD9vFNMLhOAsPd0iI3gc2vPGZ+Mhysji8AAY
         dc5GJ0oMHXt+eAbZNkjuzJDazIGHLH62Q83CLWsSoetbLcuUsbctVYAO2+WrA7wf9D
         cgc1VeYn5m31Vmq0Jnx1NG46lvdPuqNmv5uOa4hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 020/102] powerpc/pseries: Enable support for ibm,drc-info property
Date:   Fri, 24 Jan 2020 10:30:21 +0100
Message-Id: <20200124092809.223064313@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

commit 0a87ccd3699983645f54cafd2258514a716b20b8 upstream.

Advertise client support for the PAPR architected ibm,drc-info device
tree property during CAS handshake.

Fixes: c7a3275e0f9e ("powerpc/pseries: Revert support for ibm,drc-info devtree property")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1573449697-5448-11-git-send-email-tyreld@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1053,7 +1053,7 @@ static const struct ibm_arch_vec ibm_arc
 		.reserved2 = 0,
 		.reserved3 = 0,
 		.subprocessors = 1,
-		.byte22 = OV5_FEAT(OV5_DRMEM_V2),
+		.byte22 = OV5_FEAT(OV5_DRMEM_V2) | OV5_FEAT(OV5_DRC_INFO),
 		.intarch = 0,
 		.mmu = 0,
 		.hash_ext = 0,


