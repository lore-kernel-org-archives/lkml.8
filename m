Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AFFC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D2020717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgGUGvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:51:08 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:39483 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUGvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:51:07 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 0A5053C04C1;
        Tue, 21 Jul 2020 08:51:05 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mz1PprRM934z; Tue, 21 Jul 2020 08:50:59 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id B3F433C003F;
        Tue, 21 Jul 2020 08:50:59 +0200 (CEST)
Received: from lxhi-065.adit-jv.com (10.72.94.12) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 21 Jul
 2020 08:50:58 +0200
Date:   Tue, 21 Jul 2020 08:50:54 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Pavel Machek <pavel@denx.de>
CC:     <stable@kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
        <gregkh@duo.ucw.cz>, <erosca@de.adit-jv.com>,
        <roscaeugeniu@gmail.com>, <stern@rowland.harvard.edu>,
        <qais.yousef@arm.com>, <linux@prisktech.co.nz>,
        <mathias.nyman@intel.com>, <oneukum@suse.de>,
        <linux-usb@vger.kernel.org>
Subject: Re: hibernation reverts in 4.19.134: better alternative?
Message-ID: <20200721065054.GA8290@lxhi-065.adit-jv.com>
References: <20200720101522.GB13137@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200720101522.GB13137@amd>
X-Originating-IP: [10.72.94.12]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Jul 20, 2020 at 12:15:22PM +0200, Pavel Machek wrote:
> This is queued for 4.19.134-stable, reverting 3 patches. But it seems
> better alternative is available...
> 
> commit f3e697b7b6f5e2c570226f8f8692fb7db57215ec
> Author: Sasha Levin <sashal@kernel.org>
> Date:   Fri Jul 17 12:58:32 2020 -0400
> 
>     Revert "usb/ohci-platform: Fix a warning when hibernating"
>     
>     This reverts commit c83258a757687ffccce37ed73dba56cc6d4b8a1b.
>     
>     Eugeniu Rosca writes:
> 
> ...
> 
>     > - Backporting 987351e1ea7772 ("phy: core: Add consumer device
>     >   link support") to v4.14.187 looks challenging enough, so probably not
>     >   worth it. Anybody to contradict this?
> 
> Backporting 987351e1ea7772 to 4.4 may be "interesting", but backport

Typo? 4.14 meant?

> to 4.19 seems trivial, here, and it seems to work ok according to CIP
> test suites:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/168487477
> 
> (You can simply apply 987351e1ea7772 ignoring one file that is not yet
> present in 4.19.)

Technically yes. Backporting 987351e1ea7772 to v4.19.x avoids the panic.
But it means integrating a v5.6 feature (isn't 987351e1ea7772 one?) into
the v4.19.x stable tree. Isn't v4.19.x (just like any other stable
branch) supposed to contain just fixes?

Should then any missing prerequisite features be pumped in into the
stable tree, whenever backporting a bugfix produces unexpected results?

FWIW I confirm that:
* setup [A] leads to the issue reported in [C]
* setup [B] resolves the issue reported in [C]

[A] v4.19 + 16bdc04cc98 + 1cb3b0095c3 + 79112cc3c29f
[B] v4.19 + 16bdc04cc98 + 1cb3b0095c3 + 79112cc3c29f + 987351e1ea7
[C] https://lore.kernel.org/linux-usb/20200709070023.GA18414@lxhi-065.adit-jv.com/

-- 
Best regards,
Eugeniu Rosca
