Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD22C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C156208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="zfzwPgqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHaHSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgHaHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:18:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:18:42 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so850418qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tx9ov1TElvort7snu1dO9tw8+TDzzQ8tlnTaQit8sLw=;
        b=zfzwPgqs3JY0RMkQw5fCYwOxQ5+Gzj/R0aK+1z3vowOSibxcc9RhaemlClQyFWQNDb
         SJpVhZj5BzDadsx8rNSERuKmjVA559/EJCgl7W9aNpave4wH8yJgyLAOG8C77ZJ/XQFV
         DM8pmnZCZ+svxW0pgnD4TqTmwbjVWggPsurjsn3u2iwhIQjWZ9iWNC9eUwIgWmjU7gNX
         2wrEdfYE25MppFRuawUyTgO9CjLy5M+xD2iJHMKwdVUk577j7nLDIlwKS0Vd6r5AYrx3
         miDH7NWaBpsqm9jN+E8lr4nGxfVqRyRcFY5IcqoeBst7o4nuSllnzDMwNTrNWeJJbH0g
         30bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tx9ov1TElvort7snu1dO9tw8+TDzzQ8tlnTaQit8sLw=;
        b=tJxIgfr0YkoegATjQWAlMESXLt5547uLyw8j6uv2Wh+o6D7eMJPiR59JXH65QgSfFY
         Hyd9eVaBaYm4/ln+oOApfVeCuhb22b+rrc7HbzOiIeB4+y+ts0UMm/FvCsXF3gnmDodY
         dDfvDKl5zLry6XzXfkdAPAuY41uUyEvESnWCswR8DganjNh9GfTVYsOndtsiDJ9o8BF9
         Tq57bzpJU39WtTVn5bLkJBmvwXZmWE1ElEWq3E5Osj0+MlXJsD0Nxudfz8elIYvgMX3G
         l6oTstdlYdfVKN1tR9eHO9c0d4GOIwBDSgvRNF/dIsT5MujS8iJ7Ec7tSRi+rIreyXZ+
         hJKg==
X-Gm-Message-State: AOAM531K/X3GeZ14ZWKpYNfgAXEdvRgIw13TQzLCQGHjtuvkeGfnI5DF
        lEz11Z2VgdRh7Gmc32FpW/o0sw==
X-Google-Smtp-Source: ABdhPJx4uXyqr4fpHbdkcEoQU/Kpaq4fal2Z+s+LzuwDIo2Zr1YuzHgvKu+zAgkwOIvK5gApuAV82Q==
X-Received: by 2002:a05:620a:4f6:: with SMTP id b22mr66998qkh.489.1598858321407;
        Mon, 31 Aug 2020 00:18:41 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id 64sm5768514qko.117.2020.08.31.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 00:18:41 -0700 (PDT)
Date:   Mon, 31 Aug 2020 03:18:38 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200831031838.2d6d76d9@DUFFMAN>
In-Reply-To: <65d88bdd0888a69849327501a2aad186@kernel.org>
References: <20200829164920.7d28e01a@DUFFMAN>
        <65d88bdd0888a69849327501a2aad186@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 10:41:42 +0100
Marc Zyngier <maz@kernel.org> wrote:

Hi,

> 
> Could you try replacing the problematic patch with [1], and let me
> know whether this changes anything on your end? This patch probably
> isn't the right approach, but it would certainly help pointing me
> in the right direction.
> 
> [1]
> https://lore.kernel.org/lkml/20200815125112.462652-2-maz@kernel.org/

Following through a bisect session to figure out why the Wi-Fi broke
between 5.8 and 5.9-rc1, I figured out something that you might have in
mind already.

It seems that anything that makes of_bus_pci_match return true will
cause this to happen. This is why your initial fix also fails.

I believe my understanding is right since applying the following on top
of 5.9-rc1 also produces the same result.

--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -227,6 +227,7 @@ dmac_peri: dma-controller@ff6e0000 {
        };
 
        pcie0: pcie@f8000000 {
+               device_type = "pci";
                compatible = "rockchip,rk3399-pcie";
                reg = <0x0 0xf8000000 0x0 0x2000000>,
                      <0x0 0xfd000000 0x0 0x1000000>;


This was found out since the Wi-Fi pci-based ath10k Wi-Fi broke, with
2f96593ecc37e98bf99525f0629128080533867f, which changes stuff around
pci bus... things...

Am I understanding right that your fix(es) were related to the change
set where the commit is found?

My intuition is that the commit causing the boot issue could be related
to changes with PCI or PCIe subsystems, and that your fix for
of_bus_pci_match is a red herring, that only surfaced the existing
issue.

This is backed by applying the previous dts patch on top of 2f96593e,
and having Wi-Fi work. I would assume that between that commit and
5.9-rc1 there is a commit that causes the complete failure to boot,
which is unrelated to the first identified commit on 5.9-rc2.

And backed by a further bisection with this that points to
d84c572de1a360501d2e439ac632126f5facf59d being the actual change that
causes the tablet to fail to boot, as long as the pcie0 node is
identified as pci properly.

I am unsure if I should add as a Cc everyone involved in that change
set, though the author (coincidentally) is already in the original list
of recipients.

Any additional thoughts from this additional information?

-- 
Samuel Dionne-Riel
