Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42435206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584048361;
	bh=FuZuhVOIaC6t+YBF/y8j+Vmvps8Myt39UP1HC8AeZdE=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=nG6XI/3DuuPTe7AcEFs46trz3ItnYYS6JQL8W5SjSOph+HuU4Okcbb66ym6m5vl1u
	 4VizoaGj4lRZaf9kExOffjWVl/b0P/O26ay3tDXaLttPVT7LXyYdzXle0xzwD3ToKW
	 WS+Ad6eHlR89kf3SU5Bl05tOdgzTGjCS+f17CVWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCLV0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:26:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38684 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCLV0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:26:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id k21so7124516oij.5;
        Thu, 12 Mar 2020 14:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KzmB/PVQNzoILuMqxOXGlQsrFB0zDdTxr/prf+++rBU=;
        b=PHIrf55H6fYhv0wBsD98FqaX1yCCfep8OyxZnfeJyKVLrgKqqGikhcjpMKErURibJ9
         s8sXdF9k9mX7oBTq+EuvfPt/o+P+iuoycURjMb/gFBesmRBNocbcb6QrgRn2Ab4Ga27P
         QVj6sYVnnaaoSZkEz7VQuwnHlz65lLkzfpH/bVXgGLqmfLuSnsueCxe+UiM+3y1lWsj+
         UnOVvjxyzBn82X8XI4iKJzN+I4Zgu3qEz2y8dKFHRsEH9mS/+IwVUig9zR0XgroDAaIa
         9o42TNK7MJAqqCeRDythiN3TPjVPKbbxJsb8pj1v/087jWgKjG/io/qvcYf/ixKp/tzF
         Xh4Q==
X-Gm-Message-State: ANhLgQ0bIPAXMtroBtIp76PO+doESt2J6KjDlPpl35kNAm8IGuNMo+Yo
        f7+ukmDyyI/jlLSr4JeOQg==
X-Google-Smtp-Source: ADFU+vs5oaKdcWrgh4OBTzrvCccKA2l+y656PUslBK3ctVm3IytDEfBkblthdbEUCNdioMthNfx9RA==
X-Received: by 2002:aca:af97:: with SMTP id y145mr4204869oie.24.1584048359472;
        Thu, 12 Mar 2020 14:25:59 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm6993332oid.30.2020.03.12.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:25:58 -0700 (PDT)
Received: (nullmailer pid 27240 invoked by uid 1000);
        Thu, 12 Mar 2020 21:25:57 -0000
Date:   Thu, 12 Mar 2020 16:25:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Sergey.Semin@baikalelectronics.ru,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache
 drivers
Message-ID: <20200312212557.GB27332@bogus>
References: <20200306130731.938808030702@mail.baikalelectronics.ru>
 <CAK8P3a0PjNS9+sAiPnDgkmLsnJ6=hR_Vk8oqe493t-Ad_mGa9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0PjNS9+sAiPnDgkmLsnJ6=hR_Vk8oqe493t-Ad_mGa9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:19:47PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 6, 2020 at 2:07 PM <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > From: Serge Semin <fancer.lancer@gmail.com>
> >
> > Aside from PCIe/SATA/DDR/I2C/CPU-reboot specific settings the Baikal-T1
> > system controller provides three vendor-specific blocks. In particular
> > there are two Errors Handler Blocks to detect and report an info regarding
> > any problems discovered on the AXI and APB buses. These are the main buses
> > utilized by the SoC devices to interact with each other. In addition there
> > is a way to tune the MIPS P5600 CM2 L2-cache up by setting the Tag/Data/WS
> > L2-to-RAM latencies. All of this functionality is implemented in the
> > APB/AXI EHB and L2-cache control block drivers to be a part of the kernel soc
> > subsystem (as being specific to the Baikal-T1 SoC) and introduced in the
> > framework of this patchset.
> >
> > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> I have no objection to the drivers, but I wonder if these should be
> in drivers/bus and drivers/memory instead of drivers/soc, which have
> similar drivers already. The driver for the L2 cache is not really a
> memory controller driver, but it may be close enough, and we
> already have a couple of different things in there.

I don't have the driver side in my inbox, but isn't setting up cache 
latencies in a driver a little late?

Rob
