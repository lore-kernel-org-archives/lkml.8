Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31063C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C1220773
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="lgHo1ju3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgICDsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgICDsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:48:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B411C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 20:48:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g72so1873738qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 20:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltnD3f7HjD2+w0pdmZya1OptZlkQr+uyCb04jevIv4c=;
        b=lgHo1ju3UR6gi4QXqDYGyUrbKc1+gBfxhvCm+aXUAhzRuH6FYoAh+BAGKWsJlxQFfT
         AplBWGM43eVPQkD6w52YfxYBje9gYrnek2/TqLITDgasLCePVqvkueoeIh/SeRmTU/q2
         Jv8Ox/q/S0tJIOzz+hUwz3cVbenB4B5PnpdYdMZJcRiV4HrsW9cbWlK8sSLdNz2G1/ny
         +q4uwyaGEiA6XkkslpzoYGDBmD8Vi+DfuCjCz9qm5FWFAvOl6SOyk485qbPSBC5ITCJQ
         uEE3WPQMPUCfsKXv2gYktNc+R7yVWdTvxYhE2ua5SVEAzJRtnHXIaoLAqv8jd0zgAkTb
         Rp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltnD3f7HjD2+w0pdmZya1OptZlkQr+uyCb04jevIv4c=;
        b=K2lRsYI7HsRdb13Ka9NTxTRC3S99NnEBWEsFKXsIdGdlH0SVHyBk4bDdAjN5EjBdd2
         LyT9LwezkRVpvwnEoRhI/HacQOtQbJW1/F8ToSbVUQqf+jy9+jD8ZSUrenINUqy4gvn9
         W9idq2dVVG3wbifPqJ+b8lQfbM0kIkJYYZqrXBM2yaAMnVko9FXU5EBtqz7P40sWvVj5
         HY3qtTskzIvKHwLfbqqKO9kWLR2eG5EuHK39wTu3ziy65EeLWL6HqEmeituEn4T9sDGb
         +wGhE/xDNbyHHlAbNJjx5uTsyMenMPQci6TnojbfzVAF9msSqM3I5jAHHkznyeMZN/l3
         f24Q==
X-Gm-Message-State: AOAM531EvwDW/SSsZ7Wnv0BDrd6PgKwNnel4mRsiR2CrT4r+evQYaLxB
        hiqa2ZB76PSHgqR4mc/YuDyRew==
X-Google-Smtp-Source: ABdhPJxMCPmYqhPFNnjlNpKrmGcUQlsXZc/Tyugh4NkRtWsiEYkHpu09DB1AsLX9WA7xQi8wBLFjyQ==
X-Received: by 2002:a37:ad08:: with SMTP id f8mr1242667qkm.207.1599104881401;
        Wed, 02 Sep 2020 20:48:01 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id m17sm1393902qkn.45.2020.09.02.20.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 20:48:01 -0700 (PDT)
Date:   Wed, 2 Sep 2020 23:47:56 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200902234756.60e4c4f6@DUFFMAN>
In-Reply-To: <20200902160110.GA30014@e121166-lin.cambridge.arm.com>
References: <20200829164920.7d28e01a@DUFFMAN>
        <65d88bdd0888a69849327501a2aad186@kernel.org>
        <20200831031838.2d6d76d9@DUFFMAN>
        <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
        <20200831234542.295b1275@DUFFMAN>
        <5db50a8e5b251714cebe0a719ee9dc73@kernel.org>
        <20200901164249.GA15045@e121166-lin.cambridge.arm.com>
        <20200901143356.0425d9ba@DUFFMAN>
        <20200902160110.GA30014@e121166-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 17:01:19 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Tue, Sep 01, 2020 at 02:33:56PM -0400, Samuel Dionne-Riel wrote:
> 
> Please print a pointer as a pointer and print both bus and
> bus->parent.

Hopefully pointer as a pointer is %px. Not sure what else, if that's
wrong please tell.

---
@@ -79,6 +79,8 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
         * do not read more than one device on the bus directly attached
         * to RC's downstream side.
         */
+       printk("[!!] // bus (%px) bus->parent (%px)\n", bus, bus->parent);
+       printk("[!!] bus->primary (%d) == rockchip->root_bus_nr (%d) && dev (%d) > 0\n", bus->primary, rockchip->root_bus_nr, dev);
        if (bus->primary == rockchip->root_bus_nr && dev > 0)
                return 0;
 
--

Again, two values, verified with a bit of set and `sort -u`.

[    1.691266] [!!] // bus (ffff0000ef9ab800) bus->parent (0000000000000000)
[    1.691271] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0

and

[    1.697156] [!!] // bus (ffff0000ef9ac000) bus->parent (ffff0000ef9ab800)
[    1.697160] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0

First instance of each shown here. Last time I don't think it was.

> > +       printk("[!!] bus->primary (%d) == rockchip->root_bus_nr
> > (%d) && dev (%d) > 0\n", bus->primary, rockchip->root_bus_nr, dev);
> > if (bus->primary == rockchip->root_bus_nr && dev > 0) return 0;
> > 
> > --
> > 
> > I get two kind of results
> > 
> > [    1.692913] [!!] // bus->parent (0)
> > [    1.692917] [!!] bus->primary (0) == rockchip->root_bus_nr (0)
> > && dev (0) > 0
> > 
> > and
> > 
> > [    1.693055] [!!] // bus->parent (-256794624)
> > [    1.693058] [!!] bus->primary (0) == rockchip->root_bus_nr (0)
> > && dev (0) > 0 
> 
> Looks like this is the condition that pci_is_root_bus(bus->parent) is
> not hitting.
> 



> You are accessing a resource IORESOURCE_MEM that has nothing to do
> with bus numbers.
> 
> s/IORESOURCE_MEM/IORESOURCE_BUS
> 
> should be better ;-)

At least correct, rather than luckily working.


Thanks, as always, anything I missed, or need more precisions, do ask.

-- 
Samuel Dionne-Riel
