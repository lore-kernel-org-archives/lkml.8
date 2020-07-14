Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C6C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A617221ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753950;
	bh=WaI4zcf7p58FCzVfZfWBdeLKbAZ6Z+i4ih5TUkvlf/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2l7mHuK5o1K3RW69qQmC22zUJNjbkHnC2CyznYcy04s4xrdtzOix0EMymQ2bj/lt
	 ZpVLsHwpeXhOaw+XNle1p34FVuPcjuyRoaqdF9Ngk2NdOTy5Mjfv+Vetz3opuSL5l6
	 HOX0kNlQJ89PZwwXCnBW74brcA5lT/vW5EdTLw5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgGNTM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgGNSrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:47:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B2022AAE;
        Tue, 14 Jul 2020 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752423;
        bh=WaI4zcf7p58FCzVfZfWBdeLKbAZ6Z+i4ih5TUkvlf/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnN4R0nC1p8uPxZn62Z51Yi2gPHrH2Z1KBj3UCTDsXpWZWCjDywsAFfJX53V6+tQC
         O/9ddEgzYCRDX1blSBi1KtNwYIRt8ebcNATX96DQ5ughRR44LQ443UwNMsEAhA96Sz
         xxxK3ft3M4TgE1BRjgJWpwLF0jQj+3NhnNu+X4mI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/58] mlxsw: spectrum_router: Remove inappropriate usage of WARN_ON()
Date:   Tue, 14 Jul 2020 20:44:10 +0200
Message-Id: <20200714184057.973201050@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184056.149119318@linuxfoundation.org>
References: <20200714184056.149119318@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit d9d5420273997664a1c09151ca86ac993f2f89c1 ]

We should not trigger a warning when a memory allocation fails. Remove
the WARN_ON().

The warning is constantly triggered by syzkaller when it is injecting
faults:

[ 2230.758664] FAULT_INJECTION: forcing a failure.
[ 2230.758664] name failslab, interval 1, probability 0, space 0, times 0
[ 2230.762329] CPU: 3 PID: 1407 Comm: syz-executor.0 Not tainted 5.8.0-rc2+ #28
...
[ 2230.898175] WARNING: CPU: 3 PID: 1407 at drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:6265 mlxsw_sp_router_fib_event+0xfad/0x13e0
[ 2230.898179] Kernel panic - not syncing: panic_on_warn set ...
[ 2230.898183] CPU: 3 PID: 1407 Comm: syz-executor.0 Not tainted 5.8.0-rc2+ #28
[ 2230.898190] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014

Fixes: 3057224e014c ("mlxsw: spectrum_router: Implement FIB offload in deferred work")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 76960d3adfc03..93d662de106e8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -5982,7 +5982,7 @@ static int mlxsw_sp_router_fib_event(struct notifier_block *nb,
 	}
 
 	fib_work = kzalloc(sizeof(*fib_work), GFP_ATOMIC);
-	if (WARN_ON(!fib_work))
+	if (!fib_work)
 		return NOTIFY_BAD;
 
 	fib_work->mlxsw_sp = router->mlxsw_sp;
-- 
2.25.1



