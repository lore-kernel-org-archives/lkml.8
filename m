Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A5C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 16:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A93206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgBWQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 11:06:33 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:45546 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBWQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 11:06:32 -0500
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 11:06:32 EST
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 7BAAE1B46;
        Sun, 23 Feb 2020 17:00:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pIxNazIaEtLK; Sun, 23 Feb 2020 17:00:35 +0100 (CET)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 397E69C3;
        Sun, 23 Feb 2020 17:00:35 +0100 (CET)
Received: from samy by function with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1j5te7-005TFX-Gy; Sun, 23 Feb 2020 16:58:19 +0100
Date:   Sun, 23 Feb 2020 16:58:19 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Colin King <colin.king@canonical.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: remove redundant initialization of
 pointer p_key
Message-ID: <20200223155819.hycmdvrsiid27jeg@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin King <colin.king@canonical.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200223153954.420731-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200223153954.420731-1-colin.king@canonical.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King, le dim. 23 févr. 2020 15:39:54 +0000, a ecrit:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer p_key is being initialized with a value that is never read,
> it is assigned a new value later on. The initialization is redundant
> and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Indeed, thanks!

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/keyhelp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/speakup/keyhelp.c b/drivers/staging/speakup/keyhelp.c
> index 5f1bda37f86d..822ceac83068 100644
> --- a/drivers/staging/speakup/keyhelp.c
> +++ b/drivers/staging/speakup/keyhelp.c
> @@ -49,7 +49,7 @@ static int cur_item, nstates;
>  static void build_key_data(void)
>  {
>  	u_char *kp, counters[MAXFUNCS], ch, ch1;
> -	u_short *p_key = key_data, key;
> +	u_short *p_key, key;
>  	int i, offset = 1;
>  
>  	nstates = (int)(state_tbl[-1]);
> -- 
> 2.25.0
> 

-- 
Samuel
j'etais en train de nettoyer ma souris et le coup est parti...
 -+- s sur #ens-mim - et en plus c vrai... -+-
