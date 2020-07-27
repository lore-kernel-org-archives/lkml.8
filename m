Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9831C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48052073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595874891;
	bh=/6ecmPTwGZh0HJD/tKrVVhgyBKwRvNKRilfFJFLPLRE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=s2/UPxxM9ji8B24dAi6Hdrf9QFqmlq8tMAkpllZmWSXTmqUiKXmtNoExVHvekEp07
	 QbsO5pk/B1dy8gA62F4U4sFarSgJfhWptYD4nFZ3gNOiIljVIFR+uueJuO/Sl4CsiB
	 PobcXClpd+lnGN9Kfp8gzyzN3UmHTgtTdInoDUJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbgG0Seu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgG0Set (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:34:49 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D553C2073E;
        Mon, 27 Jul 2020 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595874889;
        bh=/6ecmPTwGZh0HJD/tKrVVhgyBKwRvNKRilfFJFLPLRE=;
        h=Date:From:To:Cc:Subject:From;
        b=Mtb29WVInF00AWMYet9071bMLwMc1bsrSW1JrvwTIsj+RmWjGJl91HIdr22gETFo6
         s4POcfIJ32hclb45r3qWApFzDHS40NxNG1RuWZr8/3454dwt0cpo7B0BbaUnTp3iR1
         A0pi0gACHHtUgWLt/ZS7/zi3lnFEH0cr3it5XzNs=
Date:   Mon, 27 Jul 2020 13:40:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Manish Chopra <manishc@marvell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: qlge: Use fallthrough pseudo-keyword
Message-ID: <20200727184042.GA29074@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/qlge/qlge_mpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
index 94d504af84ff..e85c6ab538df 100644
--- a/drivers/staging/qlge/qlge_mpi.c
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -1174,7 +1174,7 @@ void ql_mpi_idc_work(struct work_struct *work)
 	case MB_CMD_PORT_RESET:
 	case MB_CMD_STOP_FW:
 		ql_link_off(qdev);
-		/* Fall through */
+		fallthrough;
 	case MB_CMD_SET_PORT_CFG:
 		/* Signal the resulting link up AEN
 		 * that the frame routing and mac addr
@@ -1207,7 +1207,7 @@ void ql_mpi_idc_work(struct work_struct *work)
 		 */
 		ql_link_off(qdev);
 		set_bit(QL_CAM_RT_SET, &qdev->flags);
-		/* Fall through. */
+		fallthrough;
 	case MB_CMD_IOP_DVR_START:
 	case MB_CMD_IOP_FLASH_ACC:
 	case MB_CMD_IOP_CORE_DUMP_MPI:
-- 
2.27.0

