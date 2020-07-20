Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1B1C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601FF2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261863;
	bh=1vkmbu4AdmaI6B55+oei26Je9Lf0eQSbr6gGBI1jgV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nmgSiFetq+JkIyeOk99AfuLPR95VKW7D+qRBzIltlaS+ji+ZnADUtHYdlPw7E4td5
	 blWHb87zHK7DYifyOmOTg75rMz5JxLjr/umuIOm7tHYB7hyrR7wDnRtJduRxvaPAgd
	 e7OAiwy2+bUVxGrKfj9NA15Tmo0ESqxss2iygmVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgGTQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388376AbgGTQPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:15:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64032206E9;
        Mon, 20 Jul 2020 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261710;
        bh=1vkmbu4AdmaI6B55+oei26Je9Lf0eQSbr6gGBI1jgV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUuA0IYQ3Z6aDxxKNFyMuCuXrdKe/vbFa2SxEOfQqxYZ0+zP7Lms/7UFLc+Mcw7Bz
         q6xdHv2Tms62/BPeyE9UCtETu0QmXhp9Pwig30QxesU8UG9oYuBlTJX4Pn8mg87+eG
         CUq+A6JB1xD6mrckTRG0/FQqwP1DS72j3YbFwb50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCH 5.7 215/244] arm64: dts: stratix10: increase QSPI reg address in nand dts file
Date:   Mon, 20 Jul 2020 17:38:06 +0200
Message-Id: <20200720152836.076914730@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

commit 3bf9b8ffc8980c1090bdd3a5570cf42420620838 upstream.

Match the QSPI reg address in the socfpga_stratix10_socdk.dts file.

Fixes: 80f132d73709 ("arm64: dts: increase the QSPI reg address for Stratix10 and Agilex")
Cc: linux-stable <stable@vger.kernel.org> # >= v5.6
Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -212,12 +212,12 @@
 
 			qspi_boot: partition@0 {
 				label = "Boot and fpga data";
-				reg = <0x0 0x034B0000>;
+				reg = <0x0 0x03FE0000>;
 			};
 
-			qspi_rootfs: partition@4000000 {
+			qspi_rootfs: partition@3FE0000 {
 				label = "Root Filesystem - JFFS2";
-				reg = <0x034B0000 0x0EB50000>;
+				reg = <0x03FE0000 0x0C020000>;
 			};
 		};
 	};


