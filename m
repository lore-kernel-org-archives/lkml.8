Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902ABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D1206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593507528;
	bh=dO/4Dals1e24Wdm4wJvVv8JziMJlFugbaMPs/6clEpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jLcWbBLNUSfhbQbOtaUWxvWLjBwOM8hoBVXklXLZXCsox+FFLPOH87gYl8mwQi/h4
	 Yq23Nz9XuarllwjQg4/3JpiAX121Ib5VS71s/gadbsuL+peCkOS9VVTls/bsoTfGQx
	 b/rEgwBlJkVwCYWc08QCwhvPcXV5pkNKQ0CWMULw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgF3I6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbgF3I6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:58:44 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D70D206BE;
        Tue, 30 Jun 2020 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593507522;
        bh=dO/4Dals1e24Wdm4wJvVv8JziMJlFugbaMPs/6clEpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVXEpJbvQeie03eAJcshyULh0sFvGwWEV+S52zdtC6OzS80mPh2GRx8mWn/o9DmdR
         e6MtlWRYwwmqoHPBNah3Y471sIOAOFhIaLbJvOPjcJl6ZDs2jTRLLMQSxU1w+OhPYM
         5MqaHSXNB1xjFpEwQebO/y8AYZUl6nSdRrvgeOqA=
Date:   Tue, 30 Jun 2020 10:58:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630085839.GE637809@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:59:32PM -0300, Daniel Gutson wrote:
> --- /dev/null
> +++ b/drivers/misc/spi_lpc/bios_data_access.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SPI LPC flash platform security driver
> + *
> + * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
> + *
> + */
> +#ifndef BIOS_DATA_ACCESS_H
> +#define BIOS_DATA_ACCESS_H

What BIOS?  Is this a UEFI thing?  ACPI?  Uboot?  Fastboot?

> +
> +#include <linux/types.h>
> +
> +enum PCH_Arch {

Why the upper-case name?

> +	pch_none,
> +	pch_6_c200,
> +	pch_7_c210,
> +	pch_c60x_x79,
> +	pch_communications_89xx,
> +	pch_8_c220,
> +	pch_c61x_x99,
> +	pch_5_mobile,
> +	pch_6_mobile,
> +	pch_7_8_mobile,
> +	pch_1xx,
> +	pch_c620,
> +	pch_2xx,
> +	pch_3xx,
> +	pch_4xx,
> +	pch_495,
> +	pch_5xx,
> +	PCH_Archs_count

Do these have real values that the hardware expects?  If so, you need to
assign them numbers, right?  If not, what do all of these mean?

> +};
> +
> +enum CPU_Arch {
> +	cpu_none,
> +	cpu_bdw,
> +	cpu_bdx,
> +	cpu_hsw,
> +	cpu_hsx,
> +	cpu_ivt,
> +	cpu_jkt,
> +	cpu_kbl,
> +	cpu_skl,
> +	cpu_ivb,
> +	cpu_snb,
> +	cpu_avn,
> +	cpu_cfl,
> +	cpu_byt,
> +	cpu_whl,
> +	cpu_cml,
> +	cpu_icl,
> +	cpu_apl,
> +	cpu_glk,
> +	cpu_tgl,
> +	cpu_amd,
> +	CPU_Archs_count
> +};
> +
> +enum RegisterSource { RegSource_PCH, RegSource_CPU };

Again all of the Caps, please don't use, that's not Linux styles (and
checkpatch.pl should have warned you about this, did you run it on your
patch?)

thanks,

greg k-h
