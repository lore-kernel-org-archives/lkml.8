Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D9AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BB020768
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599667787;
	bh=bpmlhJ4tGdUygZ0/mU+qkvtjvF8E6W97OEIUrPW+wVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CCbZlOZvH0yo9s7V3uglttsaUOvW4zow+vd2VwKpKo2Fvv2NL36T2RhsLu7kIa0pc
	 8AuC+pQwoOjp0yrR6DILGe8qWt+OWaIbeiX1FkyFoj3aXe1IN60V1/xfHS3qCDSEo7
	 sqArPHgtGo7m7YVdCJMpm46+0dAuUQ0lBLavABlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgIIQJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbgIIQGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:06:35 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F8E20768;
        Wed,  9 Sep 2020 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599667593;
        bh=bpmlhJ4tGdUygZ0/mU+qkvtjvF8E6W97OEIUrPW+wVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=04tj+YLe815u7occsUkDlqWPh8fsWJwmzVj+cPDMA6A6lZlNEKhJZW25btGXYld4/
         ctgde9kGYq1iXDsQKthPM5pR7c6M7/faY2Jcm65SjrZRPshUVEY5Q7mWYoM03P5j/Z
         eqit/buQNgXBT2HHYZgB5ftulbL8bNHe2iwU0/BM=
Received: by mail-oi1-f177.google.com with SMTP id a3so2884877oib.4;
        Wed, 09 Sep 2020 09:06:33 -0700 (PDT)
X-Gm-Message-State: AOAM532uCIAZSDtflbUpNUA8VqFOM7hGa9Puhnes1vQy1YoZQ5wmr0Cp
        Uku7KhYPHF7KQR51j/N6gFhCOpWe6N7aJ8tlsA==
X-Google-Smtp-Source: ABdhPJzuWcr018b5cvylq7G23uicZG1s4aX+2Ts28vwJYpMm8l0+Gg0ibgIJwv92Dm+R1ZI60FQM3vXmWFQxTyajfqA=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr1109062oii.106.1599667592564;
 Wed, 09 Sep 2020 09:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200909123710.50b16d37@canb.auug.org.au>
In-Reply-To: <20200909123710.50b16d37@canb.auug.org.au>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Sep 2020 10:06:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tH+zAjdoC807Z7-89P5e6BUHVXd4Udbcp21a3XPx=VQ@mail.gmail.com>
Message-ID: <CAL_Jsq+tH+zAjdoC807Z7-89P5e6BUHVXd4Udbcp21a3XPx=VQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the pci tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the pci tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:

Uggg. I guess 0-day just doesn't do arm32 builds anymore as it caught
more obscure build issues, but not this one (and some others I've had
recently).

> drivers/pci/controller/dwc/pci-dra7xx.c: In function 'dra7xx_pcie_establish_link':
> drivers/pci/controller/dwc/pci-dra7xx.c:142:6: warning: unused variable 'exp_cap_off' [-Wunused-variable]
>   142 |  u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>       |      ^~~~~~~~~~~
>
> Introduced by commit
>
>   3af45d34d30c ("PCI: dwc: Centralize link gen setting")
>
> --
> Cheers,
> Stephen Rothwell
