Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBCCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4632065C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zihd5bMM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7GSAWZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgHQNuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgHQNuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:50:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4063EC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:50:12 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:50:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597672210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wZ6DLhs3/Nle2hWXNU/DY83Ezlnj/RloUcwPjKzeXfI=;
        b=Zihd5bMMlDli86Taj4JtvwpYpUqC7EB6v73VVfmCMWtCf3kotBdF/bAROQfLV0uzZp/W2D
        9OyxQ2HH3aAF1w584CRcligr7oDKrBME3pLt5tslArwX5Rkg0R7b+oUXTnpOUoVoLAAfM+
        Ii3OlPrxjTDZblfcNDHl+UQDVCoVC2R/8c95co5qZj3xvsGQ+K+PA94sQadXQbZWhM6vdM
        AqJHvU1CQ17k+rp83/olZR4VVJ5w/ep4IdhOqB9yWd2bb8u9SC6xpfiA4+FBLS92hCixUd
        YISQ+3bR0vXKyvYeZWUc5H2IlXnnsGzeQizcRRploB8o1ucvtwa6suLiGb5HvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597672210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wZ6DLhs3/Nle2hWXNU/DY83Ezlnj/RloUcwPjKzeXfI=;
        b=J7GSAWZo8tw2hAmp1FL/4OEBW3f0peMwb4DvtSd0zsKCiDLEy/QXi/hws+Cl03z2LybWu1
        OJ8AVBIra937b/Cw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200817135011.GA2072@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
laptop. PCI nvme detection fails, and the kernel becomes not able
anymore to find the rootfs / parse "root=".

Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
fixes the problem and makes me able to boot v5.9-rc1.

Please advise.

commit 61f3b89630973037f67d8e25e5d26e80a51a7b37
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Wed Jun 17 10:05:13 2020 +0200

    nvme-pci: use unsigned for io queue depth
    
    The NVMe PCIe declares module parameter io_queue_depth as int. Change
    this to u16 as queue depth can never be negative. Now to reflect this
    update module parameter getter function from param_get_int() ->
    param_get_uint() and respective setter function with type of n changed
    from int to u16 with param_set_int() to param_set_ushort(). Finally
    update struct nvme_dev q_depth member to u16 and use u16 in min_t()
    when calculating dev->q_depth in the nvme_pci_enable() (since q_depth is
    now u16) and use unsigned int instead of int when calculating
    dev->tagset.queue_depth as target variable tagset->queue_depth is of type
    unsigned int in nvme_dev_add().

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
