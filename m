Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0435C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D1420870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgCEHqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:46:34 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:51920 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgCEHqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:46:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id CAA4D148D;
        Thu,  5 Mar 2020 08:46:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J-IGOv4z-aAj; Thu,  5 Mar 2020 08:46:30 +0100 (CET)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BFC5312B7;
        Thu,  5 Mar 2020 08:46:30 +0100 (CET)
Received: from samy by function with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1j9lDB-001Dcl-Bm; Thu, 05 Mar 2020 08:46:29 +0100
Date:   Thu, 5 Mar 2020 08:46:29 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: speakup: Fix a typo error print for softsynthu
 device
Message-ID: <20200305074629.i2ntpvmlpn4nwb7y@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200305072151.403-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305072151.403-1-zhenzhong.duan@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan, le jeu. 05 mars 2020 15:21:51 +0800, a ecrit:
> When softsynthu device fails the register, "/dev/softsynthu" should be
> printed instead of "/dev/softsynth".

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> Cc: William Hubbs <w.d.hubbs@gmail.com>
> Cc: Chris Brannon <chris@the-brannons.com>
> Cc: Kirk Reiser <kirk@reisers.ca>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/speakup/speakup_soft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/staging/speakup/speakup_soft.c
> index 9d85a3a1af4c..28cedaec6d8a 100644
> --- a/drivers/staging/speakup/speakup_soft.c
> +++ b/drivers/staging/speakup/speakup_soft.c
> @@ -388,7 +388,7 @@ static int softsynth_probe(struct spk_synth *synth)
>  	synthu_device.name = "softsynthu";
>  	synthu_device.fops = &softsynthu_fops;
>  	if (misc_register(&synthu_device)) {
> -		pr_warn("Couldn't initialize miscdevice /dev/softsynth.\n");
> +		pr_warn("Couldn't initialize miscdevice /dev/softsynthu.\n");
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Samuel
N: beep beep Miam miam? 
y: ++
a: kill -MIAM -1
 -+- #runtime < /dev/miam -+-
