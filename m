Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2722072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgAJROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:14:05 -0500
Received: from ms.lwn.net ([45.79.88.28]:52024 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgAJROE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:14:04 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F24AE77D;
        Fri, 10 Jan 2020 17:14:03 +0000 (UTC)
Date:   Fri, 10 Jan 2020 10:14:03 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devices.txt: fix spelling mistake: "shapshot" ->
 "snapshot"
Message-ID: <20200110101403.67edea17@lwn.net>
In-Reply-To: <20200110100427.236530-1-colin.king@canonical.com>
References: <20200110100427.236530-1-colin.king@canonical.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 10:04:27 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix spelling mistake in text.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/admin-guide/devices.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 1c5d2281efc9..2a97aaec8b12 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -319,7 +319,7 @@
>  		182 = /dev/perfctr	Performance-monitoring counters
>  		183 = /dev/hwrng	Generic random number generator
>  		184 = /dev/cpu/microcode CPU microcode update interface
> -		186 = /dev/atomicps	Atomic shapshot of process state data
> +		186 = /dev/atomicps	Atomic snapshot of process state data
>  		187 = /dev/irnet	IrNET device
>  		188 = /dev/smbusbios	SMBus BIOS
>  		189 = /dev/ussp_ctl	User space serial port control

Applied, thanks.

jon
