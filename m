Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F39C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F41E20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595321564;
	bh=Q1ZLSKyLa/Et2o3NFMWlxp+Ps1RDQcricVDReZ9QMx0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=PKUOBD/D2UQmIy6EDr9qZTeD9dtdbq3jgRzormDEP0vi8uh0+0befQhlduoVzOWZk
	 MfXycwXBXUyEFfl40Bh9TWfF6kiWyBnFHtp4l+Rl+0JILLtRpK5nJ9yRvX+Ij0NDll
	 AYn7zVT8SsBEkzsqi1Hg2Dutqr4e3FPSo9e33mFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgGUIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgGUIwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:52:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A9520720;
        Tue, 21 Jul 2020 08:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321561;
        bh=Q1ZLSKyLa/Et2o3NFMWlxp+Ps1RDQcricVDReZ9QMx0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LduTKLY8lHhVfWHMPNR8LPSe6Bnf2NMjyXB6PwWo22pd2XqH+ztyeuwE1ZF77P51n
         64312mRz6bjk7dH4jqRoKNIF6h9rasbZ0PC014YF5KBlOH3B2ITbzrMDbI3eMQQxvf
         fOc4hhfKZP7j3NKcro/BmESw4DCmCfonjozgRof4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <78d63d97e3a8a8f7a9048b6eec74a9d158578833.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com> <78d63d97e3a8a8f7a9048b6eec74a9d158578833.1593788312.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 6/6] MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Jul 2020 01:52:40 -0700
Message-ID: <159532156078.3847286.3737060041313698787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2020-07-03 10:05:12)
> Add a reset binding entry to match all members of Actions Semi Owl SoCs.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---

Applied to clk-next
