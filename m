Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D59214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gkxYnGfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFQN4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:56:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42344 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFQN4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:56:13 -0400
Received: from zn.tnic (p200300ec2f0bb000a115b7d9110c62d9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:a115:b7d9:110c:62d9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0D621EC02A1;
        Wed, 17 Jun 2020 15:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592402171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aMj667K2+MgzaYdx9Hm5TzQHu3XKGsh8QibgzJEAQTo=;
        b=gkxYnGfimZ25xG09InR85i8oKDw2LhigeKcZmCwXx7PukO2/iLxtxqDr8IiHxTICrGODmP
        7hLINuFrkgyjT5PplCO/WORTLEuq2y4aaI2FMboM2fA1zVNmrdy5vDkR56WRFskgWPOHD7
        tCQrTxA0F53i6gqxHTLmtDN3B4uqSr0=
Date:   Wed, 17 Jun 2020 15:56:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] edac: Fix reference count leak in
 edac_pci_main_kobj_setup.
Message-ID: <20200617135603.GF10118@zn.tnic>
References: <20200528202238.18078-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528202238.18078-1-wu000273@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 03:22:37PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> kobject_init_and_add() should be handled when it return an error,
> because kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Previous
> commit "b8eb718348b8" fixed a similar problem. Thus replace calling
> kfree() by calling kobject_put().
> 
> Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/edac/edac_pci_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
> index 72c9eb9fdffb..53042af7262e 100644
> --- a/drivers/edac/edac_pci_sysfs.c
> +++ b/drivers/edac/edac_pci_sysfs.c
> @@ -386,7 +386,7 @@ static int edac_pci_main_kobj_setup(void)
>  
>  	/* Error unwind statck */
>  kobject_init_and_add_fail:
> -	kfree(edac_pci_top_main_kobj);
> +	kobject_put(edac_pci_top_main_kobj);
>  
>  kzalloc_fail:
>  	module_put(THIS_MODULE);
> -- 

This and

https://lkml.kernel.org/r/20200528203526.20908-1-wu000273@umn.edu

merged into a single patch and applied.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
