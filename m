Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04046C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C015F206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgEVJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEVJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:21:53 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DDAC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:21:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 1F7462D2B;
        Fri, 22 May 2020 11:21:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OYOLJKbB0yKe; Fri, 22 May 2020 11:21:48 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 3DEC82C0C;
        Fri, 22 May 2020 11:21:48 +0200 (CEST)
Received: from samy by function with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jc3sA-00GDlb-Nu; Fri, 22 May 2020 11:21:46 +0200
Date:   Fri, 22 May 2020 11:21:46 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     MugilRaj <dmugil2000@gmail.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taging: speakup: remove volatile
Message-ID: <20200522092146.6ijoma4re7ijai7a@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        MugilRaj <dmugil2000@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

MugilRaj, le ven. 22 mai 2020 14:46:28 +0530, a ecrit:
> fix checkpatch.pl warning, which is Use of volatile is usually wrong: see
> Documentation/process/volatile-considered-harmful.rst

Yes, but the proper fix is usually not to just remove the volatile
qualifier, which will not fix anything and potentially break things.

Fixing this requires really understanding what is at stake here, between
the read_buff_add function and the use of synth_full(). That goes
through interrupt handlers, tty disciplines, and the actual behavior
expected by speakup. Not a simple task, henceforth :)

> Signed-off-by: MugilRaj <dmugil2000@gmail.com>
> ---
>  drivers/staging/speakup/speakup_decext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/speakup/speakup_decext.c b/drivers/staging/speakup/speakup_decext.c
> index ddbb7e9..22baaeb 100644
> --- a/drivers/staging/speakup/speakup_decext.c
> +++ b/drivers/staging/speakup/speakup_decext.c
> @@ -21,7 +21,7 @@
>  #define SYNTH_CLEAR 0x03
>  #define PROCSPEECH 0x0b
>  
> -static volatile unsigned char last_char;
> +static unsigned char last_char;
>  
>  static void read_buff_add(u_char ch)
>  {
> -- 
> 2.7.4
> 
