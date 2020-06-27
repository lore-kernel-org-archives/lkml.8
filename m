Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA44C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4221556
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593256118;
	bh=IvkYD8vvMsO8UUZWc8OESQ8D1oIdB2bt3FlKlWN+/PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ngltiSNivIi/LSRBjRr2ykHU+Xq3hIJAY4wDcMCAqLelAjZ9cvoPCcEEhWzpBIPi
	 Z5jGqfhJEmKL8mg5Hc/tDgCM6a0cr9Arl/doQ09C6Ph7INhmtATsOTuOItUn0+KGdc
	 zr3LCM5vcaAg0IjwVTSAawICVqnFruhUHNx4zNrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgF0LIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgF0LI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:08:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFAB621532;
        Sat, 27 Jun 2020 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593256105;
        bh=IvkYD8vvMsO8UUZWc8OESQ8D1oIdB2bt3FlKlWN+/PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlWD9hqR3pco/94yNhfdc/ExIZvtqMLuXkBsjsGDuOB+CytlR2Y2D/RTGXPi/DaAg
         WWn8z8v/DgGvTE6nTAWVKx2+K9USPwkPqDEJZcOaVGLeDgMvXGSZfs61chB7hrEmVz
         b9FTMA/c2JF/K5qX2Ug0Y0zoeA4oTbAREutVMAFk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jp8h6-006s0z-8F; Sat, 27 Jun 2020 12:08:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tero Kristo <t-kristo@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Andrew Perepech <andrew.perepech@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/3] irqchip/ti-sci-inta: Remove dead code in ti_sci_inta_set_type()
Date:   Sat, 27 Jun 2020 12:08:06 +0100
Message-Id: <159325548742.93134.4456384570058657240.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <1591437017-5295-1-git-send-email-yangtiezhu@loongson.cn>
References: <1591437017-5295-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, matthias.bgg@gmail.com, brgl@bgdev.pl, tglx@linutronix.de, yangtiezhu@loongson.cn, t-kristo@ti.com, lokeshvutla@ti.com, nm@ti.com, ssantosh@kernel.org, andrew.perepech@mediatek.com, linux-mediatek@lists.infradead.org, stephane.leprovost@mediatek.com, linux-arm-kernel@lists.infradead.org, pedro.tsai@mediatek.com, bgolaszewski@baylibre.com, fparent@baylibre.com, linux-kernel@vger.kernel.org, lixuefeng@loongson.cn
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jun 2020 17:50:15 +0800, Tiezhu Yang wrote:
> In the function ti_sci_inta_set_type(), the statement "return -EINVAL;"
> out of switch case is dead code, remove it.

Applied to irq/irqchip-5.9:

[1/3] irqchip/ti-sci-inta: Remove dead code in ti_sci_inta_set_type()
      commit: 3d21f0b4126650a92f2df531a5f3a2d27aa9a09f
[2/3] irqchip/ti-sci-inta: Fix return value about devm_ioremap_resource()
      commit: 4b127a14cb1385dd355c7673d975258d5d668922
[3/3] irqchip/ti-sci-inta: Fix typo about MODULE_AUTHOR
      commit: ef6b0bf43be5c17790a14a8ed806d7d8fe0a25be

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

