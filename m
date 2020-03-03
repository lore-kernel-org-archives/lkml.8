Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E46C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1635F20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgCCXwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:52:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37208 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCCXwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:52:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A316515AABE60;
        Tue,  3 Mar 2020 15:52:30 -0800 (PST)
Date:   Tue, 03 Mar 2020 15:52:30 -0800 (PST)
Message-Id: <20200303.155230.957175056528856630.davem@davemloft.net>
To:     madalin.bucur@oss.nxp.com
Cc:     netdev@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        madalin.bucur@nxp.com
Subject: Re: [PATCH net 3/4] fsl/fman: detect FMan erratum A050385
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1583250939-24645-4-git-send-email-madalin.bucur@oss.nxp.com>
References: <1583250939-24645-1-git-send-email-madalin.bucur@oss.nxp.com>
        <1583250939-24645-4-git-send-email-madalin.bucur@oss.nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 03 Mar 2020 15:52:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@oss.nxp.com>
Date: Tue,  3 Mar 2020 17:55:38 +0200

> @@ -37,6 +38,11 @@
>  #include <linux/interrupt.h>
>  #include <linux/of_irq.h>
>  
> +#ifdef CONFIG_ARM64
> +/* only some ARM64 platforms are affected */
> +#define DPAA_FMAN_ERRATUM_A050385 1
> +#endif

Please use Kconfig for expressing this.

Create a CONFIG_DPAA_ERRATUM_A050385 and 'select' it in the
driver Kconfig entry when ARM64 is true.

Thank you.
