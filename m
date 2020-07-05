Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED116C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DEF2074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGEUaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgGEUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:30:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F6C061794;
        Sun,  5 Jul 2020 13:30:02 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 599C1846;
        Sun,  5 Jul 2020 20:30:01 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:30:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: LVM
Message-ID: <20200705143000.51c350b7@lwn.net>
In-Reply-To: <20200627103138.71885-1-grandmaster@al2klimov.de>
References: <20200627103138.71885-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 12:31:38 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied but...

> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 921888df6764..30ba3573626c 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -27,7 +27,7 @@ config BLK_DEV_MD
>  
>  	  More information about Software RAID on Linux is contained in the
>  	  Software RAID mini-HOWTO, available from
> -	  <http://www.tldp.org/docs.html#howto>. There you will also learn
> +	  <https://www.tldp.org/docs.html#howto>. There you will also learn

This HOWTO, once one finds it beyond that link, starts by saying:

	This HOWTO is deprecated; the Linux RAID HOWTO is maintained as a
	wiki by the linux-raid community at http://raid.wiki.kernel.org/

So clearly adding HTTPS isn't really the optimal fix here...

jon
