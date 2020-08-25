Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0C92076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598399537;
	bh=cpl2NMcCvB4e05/2Ng+vLlDNVSMOHT2mnJhujSPNZfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OC5Lb1fxPUYvp9dGiWYjP8EfYBRM++j7FxFKaw5dZQIeEDGEBRGQLo+EQQ+TCqxCo
	 +J7BTgNaqqiN34iccu4mwY1aLXQMcGqO2XJx2MVVYxmRI2qR4J/JaIqEQZ5BowbDU2
	 WPLCZFJK8C7Pcrf0sD7kNkMxZTmX9p8jkgZUiJa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHYXwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgHYXwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:52:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF4520706;
        Tue, 25 Aug 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598399535;
        bh=cpl2NMcCvB4e05/2Ng+vLlDNVSMOHT2mnJhujSPNZfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qKT+jfW0x0cEBaRNnmniDD+NJJv6dYtIMRh6+MAaQL7kCvhE58TBFswqwK9Al1D4L
         vzu/JEqF4MiN61wbJ1dk9vvwGVgx1L0MK73fS/ecYLbLDLBIX/0gcaJ5zFR9qmRcCm
         oCRwjE6v0kKpA1jTfNrtzQ9QmL57I8x58XPd1/g8=
Date:   Tue, 25 Aug 2020 16:52:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH mmotm] x86/numa: fix build when CONFIG_ACPI is not set
Message-Id: <20200825165214.2b5e1fbf53d68fd3714c8050@linux-foundation.org>
In-Reply-To: <70e5ee34-9809-a997-7b49-499e4be61307@infradead.org>
References: <70e5ee34-9809-a997-7b49-499e4be61307@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 08:20:27 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when CONFIG_ACPI is not set/enabled by adding
> <acpi/acpi_numa.h> in the #else (!CONFIG_ACPI) block.
> 
> ../arch/x86/mm/numa.c: In function ‘numa_setup’:
> ../arch/x86/mm/numa.c:43:3: error: implicit declaration of function ‘disable_srat’; did you mean ‘disable_irq’? [-Werror=implicit-function-declaration]
>    disable_srat();
>    ^~~~~~~~~~~~
> ../arch/x86/mm/numa.c:45:3: error: implicit declaration of function ‘disable_hmat’; did you mean ‘disable_dma’? [-Werror=implicit-function-declaration]
>    disable_hmat();
>    ^~~~~~~~~~~~
>
> ...
>
> --- mmotm-2020-0824-1606.orig/include/linux/acpi.h
> +++ mmotm-2020-0824-1606/include/linux/acpi.h
> @@ -709,6 +709,8 @@ static inline u64 acpi_arch_get_root_poi
>  #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
>  #define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (0), .cls_msk = (0),
>  
> +#include <acpi/acpi_numa.h>
> +
>  struct fwnode_handle;
>  
>  static inline bool acpi_dev_found(const char *hid)

I don't think there's anything in -next that caused this?  It's in
mainline also?

