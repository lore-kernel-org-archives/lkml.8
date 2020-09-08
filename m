Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ED5C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7763821D7D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599559116;
	bh=zSnodsALxdxvcq+qusW2trVf+HAR9fNJZUSpVvfiNeI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=L4bSQbo4J7Wf7YDAzvgrkeavyDRp/K9Bx0OpycKgBo2GEyofckkxt7FtCHk2DCOJv
	 0I8wso1yHBRocoKnUS7viwuxePTuz8U+FoP9n3qD9PeitYe6v1K6Sh6ruu3LeEIUO5
	 nnb86bJUWU6xojZCeG0/eN74zpUA4rmNC4RU/jbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIHJ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgIHJ6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:58:33 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23C121D7B;
        Tue,  8 Sep 2020 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599559112;
        bh=zSnodsALxdxvcq+qusW2trVf+HAR9fNJZUSpVvfiNeI=;
        h=From:To:Cc:Subject:Date:From;
        b=RVZJeXIYbyelGvM13mRqFKLtS/I/8/6PmuLBbTpPQCeYgDRErg3/kGlEV6uSyRz4E
         YFHczhFoxs/tyXxGjSW96AcJj47KvfZpZiERci5ikw/WNOz06u1MdJpYV47gnCPWhg
         blaRSl/dzRrgdCPwJtHYrAi/wTVSPyfH8RyvxXMk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFaOQ-00B3YG-Mr; Tue, 08 Sep 2020 11:58:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dwc3-of-simple: add support for Hikey 970
Date:   Tue,  8 Sep 2020 11:58:23 +0200
Message-Id: <731e13f9fbba3a81bedb39f1c1deaf41200acd0c.1599559004.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding driver is needed for Hikey 970 to work,
as otherwise a Serror is produced:

    [    1.837458] SError Interrupt on CPU0, code 0xbf000002 -- SError
    [    1.837462] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #205
    [    1.837463] Hardware name: HiKey970 (DT)
    [    1.837465] Workqueue: events deferred_probe_work_func
    [    1.837467] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=--)
    [    1.837468] pc : _raw_spin_unlock_irqrestore+0x18/0x50
    [    1.837469] lr : regmap_unlock_spinlock+0x14/0x20
    [    1.837470] sp : ffff8000124dba60
    [    1.837471] x29: ffff8000124dba60 x28: 0000000000000000
    [    1.837474] x27: ffff0001b7e854c8 x26: ffff80001204ea18
    [    1.837476] x25: 0000000000000005 x24: ffff800011f918f8
    [    1.837479] x23: ffff800011fbb588 x22: ffff0001b7e40e00
    [    1.837481] x21: 0000000000000100 x20: 0000000000000000
    [    1.837483] x19: ffff0001b767ec00 x18: 00000000ff10c000
    [    1.837485] x17: 0000000000000002 x16: 0000b0740fdb9950
    [    1.837488] x15: ffff8000116c1198 x14: ffffffffffffffff
    [    1.837490] x13: 0000000000000030 x12: 0101010101010101
    [    1.837493] x11: 0000000000000020 x10: ffff0001bf17d130
    [    1.837495] x9 : 0000000000000000 x8 : ffff0001b6938080
    [    1.837497] x7 : 0000000000000000 x6 : 000000000000003f
    [    1.837500] x5 : 0000000000000000 x4 : 0000000000000000
    [    1.837502] x3 : ffff80001096a880 x2 : 0000000000000000
    [    1.837505] x1 : ffff0001b7e40e00 x0 : 0000000100000001
    [    1.837507] Kernel panic - not syncing: Asynchronous SError Interrupt
    [    1.837509] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #205
    [    1.837510] Hardware name: HiKey970 (DT)
    [    1.837511] Workqueue: events deferred_probe_work_func
    [    1.837513] Call trace:
    [    1.837514]  dump_backtrace+0x0/0x1e0
    [    1.837515]  show_stack+0x18/0x24
    [    1.837516]  dump_stack+0xc0/0x11c
    [    1.837517]  panic+0x15c/0x324
    [    1.837518]  nmi_panic+0x8c/0x90
    [    1.837519]  arm64_serror_panic+0x78/0x84
    [    1.837520]  do_serror+0x158/0x15c
    [    1.837521]  el1_error+0x84/0x100
    [    1.837522]  _raw_spin_unlock_irqrestore+0x18/0x50
    [    1.837523]  regmap_write+0x58/0x80
    [    1.837524]  hi3660_reset_deassert+0x28/0x34
    [    1.837526]  reset_control_deassert+0x50/0x260
    [    1.837527]  reset_control_deassert+0xf4/0x260
    [    1.837528]  dwc3_probe+0x5dc/0xe6c
    [    1.837529]  platform_drv_probe+0x54/0xb0
    [    1.837530]  really_probe+0xe0/0x490
    [    1.837531]  driver_probe_device+0xf4/0x160
    [    1.837532]  __device_attach_driver+0x8c/0x114
    [    1.837533]  bus_for_each_drv+0x78/0xcc
    [    1.837534]  __device_attach+0x108/0x1a0
    [    1.837535]  device_initial_probe+0x14/0x20
    [    1.837537]  bus_probe_device+0x98/0xa0
    [    1.837538]  deferred_probe_work_func+0x88/0xe0
    [    1.837539]  process_one_work+0x1cc/0x350
    [    1.837540]  worker_thread+0x2c0/0x470
    [    1.837541]  kthread+0x154/0x160
    [    1.837542]  ret_from_fork+0x10/0x30
    [    1.837569] SMP: stopping secondary CPUs
    [    1.837570] Kernel Offset: 0x1d0000 from 0xffff800010000000
    [    1.837571] PHYS_OFFSET: 0x0
    [    1.837572] CPU features: 0x240002,20882004
    [    1.837573] Memory Limit: none

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

v2: removed a hunk enabling a quirk that was causing Serror panic()
     on arm. It turned that such hunk were not needed at all.

 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 8852fbfdead4..336253ff5574 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -176,6 +176,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
+	{ .compatible = "hisilicon,hi3670-dwc3" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
-- 
2.26.2


