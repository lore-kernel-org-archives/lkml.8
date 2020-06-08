Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CAFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB2208A9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591637815;
	bh=DYngZGs8hXVYCLRG3E+VatlpANa4VIrxDG07fqZWnyA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FlrSDpsZO1ScRcENbfoJ3dpo2x0H/m4b/nUQZQfKJ+y7qJ4UfkIp7x5UFqossNmYX
	 TorivG7O47ZOBTA+1eOG8XAkhANkTOWy4IMBwm4oG9otg8pdG3Cc2W7CWtFt1BTeVW
	 R2UELQwWquTgpQeVI0hMusgciwjA/MTK3g8c4o2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgFHRgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgFHRgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:36:52 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3A6206D5;
        Mon,  8 Jun 2020 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591637812;
        bh=DYngZGs8hXVYCLRG3E+VatlpANa4VIrxDG07fqZWnyA=;
        h=Date:From:To:Cc:Subject:From;
        b=ezmGM/tmG507JIOrsLpR3Vbm/ehuVRZXeUlnd74ffWLdbRoTVOT4+FALWqEwxql0X
         phHyCdcBX5lkJmoiO2ydoNCV2VLaBGj2otWmDeMrAiK7H248LcXqGerrOjpa+SLBkN
         1IVYcm/C58rrbv4CgXzyeKpcG26fjuQTsMbV7+js=
Date:   Mon, 8 Jun 2020 12:42:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] c6x: traps: Mark expected switch fall-through
Message-ID: <20200608174202.GA32421@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

Fix the following warning through the use of the new the new
pseudo-keyword fallthrough;

arch/c6x/kernel/traps.c:335:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
  335 |    ie_num = 8;
      |    ~~~~~~~^~~
arch/c6x/kernel/traps.c:336:3: note: here
  336 |   default:
      |   ^~~~~~~

Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/c6x/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index 2b9121c755be1..bd0a477d3816d 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -333,6 +333,7 @@ asmlinkage int process_exception(struct pt_regs *regs)
 
 		case EXCEPT_TYPE_SXF:
 			ie_num = 8;
+			fallthrough;
 		default:
 			ack_exception(type_num);
 			do_trap(&iexcept_table[ie_num], regs);
-- 
2.27.0

