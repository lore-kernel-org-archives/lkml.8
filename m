Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD0EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A63D206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976164;
	bh=2+/pO2FWS81LBJUUa126UILD7S9Fn08gFTclDXknYgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nRY+vRZWw4Ys3VWsbfLgBe2XBDZ5yz24Gokus35piXDcK9qguzJXWVLr5dlUukqZo
	 5+N8l8UTIQfgmSINZHhetjbLFWYQnd9XqMkkLG2S2p+ZU4M/zV9mzhUo9a/I5xGE+4
	 AQFCtecwfCqbuYuqNs6ZOuvo7wdhP1WG4fVQXHwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgIAQCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAQCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:02:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF662078B;
        Tue,  1 Sep 2020 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598976154;
        bh=2+/pO2FWS81LBJUUa126UILD7S9Fn08gFTclDXknYgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jIkHsMSqW3UsOOAygtQ2L1XMBVEgDBQkJNtrcUMyHbql1/5KZbvBIeMfwCdPd22j
         gHLj0W03Aa+uljsP+wXGybKlYsXuFVDjSdH9nViohuQfc24zsQIqpNXZwF+J1tIOJR
         zkoXAO8guA2XTadgkg0c0CIPMf9tATVtDDglgFq0=
Date:   Tue, 1 Sep 2020 18:03:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with an inline
 function
Message-ID: <20200901160301.GA1454403@kroah.com>
References: <20200901154437.110056-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901154437.110056-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:44:37PM +0200, Antoni Przybylik wrote:
> This approach is more elegant and prevents some problems related to
> macros such as operator precedence in expanded  expression.
> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 6e813693a766..e789b7348dee 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -27,8 +27,6 @@
>  
>  #define MUX_TX_MAX_SIZE 2048
>  
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> -
>  static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
>  static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
>  static DEFINE_MUTEX(gdm_table_lock);
> @@ -36,6 +34,11 @@ static DEFINE_MUTEX(gdm_table_lock);
>  static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
>  static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
>  
> +inline int gdm_tty_ready(gdm *gdm)

Why is this a global function?

And really, no need to make it inline, just make it a normal function
and the compiler will inline it if needed.

thanks,

greg k-h
