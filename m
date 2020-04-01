Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB38C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43234206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759033;
	bh=4Ki+qkxU39QDsDVJd+9zZO5BdWzNnwZi+XZF9+iCI3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1s78bqMUP6b05hLG9XLuKJNyh03A+qQKujATB5FfSpAbncuL+KBjmeqzuidagdo8
	 YyZjlgaXUNVcxeBEEK1c93P1K3oHxnzPLUIP+HBZIV+29Q11fnP4sIUgR8obd5cmtS
	 SwZDJHzHKF1kFiZb381epVllJsIDqQER/mxuRTLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbgDAQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387634AbgDAQhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:37:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1685A206F8;
        Wed,  1 Apr 2020 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759025;
        bh=4Ki+qkxU39QDsDVJd+9zZO5BdWzNnwZi+XZF9+iCI3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDth68QNSSOtSP9zl9D3DNbpb9sybVeN5u1gnFZY+TxdpNkjznrn2lQlxGJRlpskV
         xFpMnLa4DcBdu+JV2X0ENb+x6Wl38Kx9/LI5OhCGMKWHXVR/zDEke/LJLKkd76gXWV
         gRiiigEDQ8EFkcxmrWu8Vo0ake/A0Lwqn2r1ZUkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 053/102] dt-bindings: net: FMan erratum A050385
Date:   Wed,  1 Apr 2020 18:17:56 +0200
Message-Id: <20200401161542.741085212@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit 26d5bb9e4c4b541c475751e015072eb2cbf70d15 ]

FMAN DMA read or writes under heavy traffic load may cause FMAN
internal resource leak; thus stopping further packet processing.

The FMAN internal queue can overflow when FMAN splits single
read or write transactions into multiple smaller transactions
such that more than 17 AXI transactions are in flight from FMAN
to interconnect. When the FMAN internal queue overflows, it can
stall further packet processing. The issue can occur with any one
of the following three conditions:

  1. FMAN AXI transaction crosses 4K address boundary (Errata
     A010022)
  2. FMAN DMA address for an AXI transaction is not 16 byte
     aligned, i.e. the last 4 bits of an address are non-zero
  3. Scatter Gather (SG) frames have more than one SG buffer in
     the SG list and any one of the buffers, except the last
     buffer in the SG list has data size that is not a multiple
     of 16 bytes, i.e., other than 16, 32, 48, 64, etc.

With any one of the above three conditions present, there is
likelihood of stalled FMAN packet processing, especially under
stress with multiple ports injecting line-rate traffic.

To avoid situations that stall FMAN packet processing, all of the
above three conditions must be avoided; therefore, configure the
system with the following rules:

  1. Frame buffers must not span a 4KB address boundary, unless
     the frame start address is 256 byte aligned
  2. All FMAN DMA start addresses (for example, BMAN buffer
     address, FD[address] + FD[offset]) are 16B aligned
  3. SG table and buffer addresses are 16B aligned and the size
     of SG buffers are multiple of 16 bytes, except for the last
     SG buffer that can be of any size.

Additional workaround notes:
- Address alignment of 64 bytes is recommended for maximally
efficient system bus transactions (although 16 byte alignment is
sufficient to avoid the stall condition)
- To support frame sizes that are larger than 4K bytes, there are
two options:
  1. Large single buffer frames that span a 4KB page boundary can
     be converted into SG frames to avoid transaction splits at
     the 4KB boundary,
  2. Align the large single buffer to 256B address boundaries,
     ensure that the frame address plus offset is 256B aligned.
- If software generated SG frames have buffers that are unaligned
and with random non-multiple of 16 byte lengths, before
transmitting such frames via FMAN, frames will need to be copied
into a new single buffer or multiple buffer SG frame that is
compliant with the three rules listed above.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/powerpc/fsl/fman.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
index df873d1f3b7c5..2aaae210317bb 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -110,6 +110,13 @@ PROPERTIES
 		Usage: required
 		Definition: See soc/fsl/qman.txt and soc/fsl/bman.txt
 
+- fsl,erratum-a050385
+		Usage: optional
+		Value type: boolean
+		Definition: A boolean property. Indicates the presence of the
+		erratum A050385 which indicates that DMA transactions that are
+		split can result in a FMan lock.
+
 =============================================================================
 FMan MURAM Node
 
-- 
2.20.1



