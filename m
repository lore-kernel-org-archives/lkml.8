Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DE2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A7C207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598982600;
	bh=e7h+oZFFyLcbR6/8OfDuGn4bDyd8dwXNm8Vvh+oVvls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwrlcJBd/z5D1PPxzUW52wFchETtXm0EjiXyPsgq1ft0mzd9/OgugvxgrQsCN0B8B
	 Y/Q81t+98VvdhgJkl6Ejb3Q0d2nxRX/zq5hnGzW39Wk/Kd0a901rcYkINanrvWvhuj
	 GwED+okCW22lCEum6aRdl1/hefRDSwWeYGSoxDXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgIARt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbgIARt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:49:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308B7207D3;
        Tue,  1 Sep 2020 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598982596;
        bh=e7h+oZFFyLcbR6/8OfDuGn4bDyd8dwXNm8Vvh+oVvls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyM4rKR9JWi/zFbeC2kbK6rApHD6EBiMupoOzPyI+LP1Xao6kNMM4PP0d/nVX68HK
         nCVg43w11DOGTq0lZ8oqtZsQQmhHVFbbf0W219Ce5KFDZlOQ9GUIJjn09epL8FJ4eS
         /qgiAs8SXUQJ36C8gGYE+J7TJ9e680bJAir4noVo=
Date:   Tue, 1 Sep 2020 19:50:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with a function
Message-ID: <20200901175024.GA1509755@kroah.com>
References: <20200901161846.111486-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901161846.111486-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 06:18:46PM +0200, Antoni Przybylik wrote:
> This approach is more elegant and prevents some problems related to
> macros such as operator precedence in expanded expression.
> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 6e813693a766..a7db0672e81d 100644
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
> +static int gdm_tty_ready(gdm *gdm)
> +{
> +	return (gdm && gdm->tty_dev && gdm->port.count);
> +}

You obviously did not even build this patch, which is a bit rude, don't
you think?

:(
