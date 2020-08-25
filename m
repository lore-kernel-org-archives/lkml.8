Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04489C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE1F2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598347061;
	bh=9QeGB1fXHAQSQh1eR70hPqgCS2Tc/JeiZO9IWAi9qPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JSmwn7oMBnUKilUk0R9NykyRTLekt8uuE0OJmfumaH+OKFJPQBQXVNKsiG6mo7EbN
	 XttZcZiPp8Hb0uvPqddZAK3Fbk+enJ9xleEpX+NEhJ5MNQsGNOZ5iTVd4wkPHjRRrc
	 mLduUGNz6gZIoYpgWaadMEUCWir3o8O/HxnpUhlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgHYJRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbgHYJRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:17:38 -0400
Received: from coco.lan (ip5f5ad5a4.dynamic.kabel-deutschland.de [95.90.213.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6BD92068F;
        Tue, 25 Aug 2020 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598347058;
        bh=9QeGB1fXHAQSQh1eR70hPqgCS2Tc/JeiZO9IWAi9qPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QG7lkNYwhNzmsuyMt4/05k2/nQtRbBggtJoeFDNh43HKu1cyq/RW+kDL/sSos3BjP
         10aD46wy0Ay6dlEnwr/KfVlcIXcJCt/eFBMr4imMKhwDAYwvnausAPPsO+CYy7mlV/
         ZQHB0va3N/VTA1WXmQtBZoSLZIgS74HDyhUHkGwI=
Date:   Tue, 25 Aug 2020 11:17:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] staging: spmi: hisi-spmi-controller: fix spelling
 mistake "controlller" -> "controller"
Message-ID: <20200825111734.40c13380@coco.lan>
In-Reply-To: <20200820075136.186199-1-colin.king@canonical.com>
References: <20200820075136.186199-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 20 Aug 2020 08:51:36 +0100
Colin King <colin.king@canonical.com> escreveu:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the MODULE_ALIAS, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/staging/hikey9xx/hisi-spmi-controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> index 66a0b296e06f..b132b2a5d939 100644
> --- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
> +++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> @@ -354,4 +354,4 @@ module_exit(spmi_controller_exit);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_VERSION("1.0");
> -MODULE_ALIAS("platform:spmi_controlller");
> +MODULE_ALIAS("platform:spmi_controller");



Thanks,
Mauro
