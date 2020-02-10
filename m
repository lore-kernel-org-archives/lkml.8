Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A20C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A131B20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340191;
	bh=Mq505x1SzBTKjGllZXHAFtewzgb+wYXOj6L972X3xHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGs5heEu0LAdWx+tzxlxue23wSs2YusayZm77doK+61badoLTX/GeO3l9gz5UDKvf
	 1jxhQJABqDGgtfiqqKGVRuSMkuJFScuYDy2+V48RVZM7axHyuZskQE68xtq7XYri0p
	 3KI2X893lr2q9xJqfUOx8Xt8+UGaFYyRvRtFTxs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgBJNJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbgBJMjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:15 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A929320873;
        Mon, 10 Feb 2020 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338354;
        bh=Mq505x1SzBTKjGllZXHAFtewzgb+wYXOj6L972X3xHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLo/ogtyZNvqXWvJ1yrkYXjKDNqIecq8VxTuPbjKP5JnSegRg+DClx+zN/gE+GVjZ
         IUx2v98Ey25JCQ4ZQUzkGfizcVtjv8ZBo+lh73QWq211KA7aJN50O6kFUZyawviyar
         ZVOTLpXf23G0i+/WsZLNh4IoicE9TDCqsgr0KGhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.5 010/367] net: stmmac: Delete txtimer in suspend()
Date:   Mon, 10 Feb 2020 04:28:43 -0800
Message-Id: <20200210122424.790129576@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolin Chen <nicoleotsuka@gmail.com>

[ Upstream commit 14b41a2959fbaa50932699d32ceefd6643abacc6 ]

When running v5.5 with a rootfs on NFS, memory abort may happen in
the system resume stage:
 Unable to handle kernel paging request at virtual address dead00000000012a
 [dead00000000012a] address between user and kernel address ranges
 pc : run_timer_softirq+0x334/0x3d8
 lr : run_timer_softirq+0x244/0x3d8
 x1 : ffff800011cafe80 x0 : dead000000000122
 Call trace:
  run_timer_softirq+0x334/0x3d8
  efi_header_end+0x114/0x234
  irq_exit+0xd0/0xd8
  __handle_domain_irq+0x60/0xb0
  gic_handle_irq+0x58/0xa8
  el1_irq+0xb8/0x180
  arch_cpu_idle+0x10/0x18
  do_idle+0x1d8/0x2b0
  cpu_startup_entry+0x24/0x40
  secondary_start_kernel+0x1b4/0x208
 Code: f9000693 a9400660 f9000020 b4000040 (f9000401)
 ---[ end trace bb83ceeb4c482071 ]---
 Kernel panic - not syncing: Fatal exception in interrupt
 SMP: stopping secondary CPUs
 SMP: failed to stop secondary CPUs 2-3
 Kernel Offset: disabled
 CPU features: 0x00002,2300aa30
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

It's found that stmmac_xmit() and stmmac_resume() sometimes might
run concurrently, possibly resulting in a race condition between
mod_timer() and setup_timer(), being called by stmmac_xmit() and
stmmac_resume() respectively.

Since the resume() runs setup_timer() every time, it'd be safer to
have del_timer_sync() in the suspend() as the counterpart.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4860,6 +4860,7 @@ int stmmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 chan;
 
 	if (!ndev || !netif_running(ndev))
 		return 0;
@@ -4873,6 +4874,9 @@ int stmmac_suspend(struct device *dev)
 
 	stmmac_disable_all_queues(priv);
 
+	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
+		del_timer_sync(&priv->tx_queue[chan].txtimer);
+
 	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 


