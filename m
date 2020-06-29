Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3997BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F6F206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuFaCFQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbgF2TSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731834AbgF2TRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:17:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E432C02E2F4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:27:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so14835310wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WpCx9wlLkUF/9BjY/GSmmZuh83h0/gYp6cSgw55h1ks=;
        b=vuFaCFQbsN0wObGUMWiRJxLtNYxJ0D4oGlZnGvvMS0hv+E+raFBtm15LJ31LILkXy8
         a92fLI0UQlsQkt5DtNXbLVLyO8W1EUTtEDN3zSefvXsRg8oUmsgXBCuy2JBewo5H31di
         xD3EU6HAoKSFEGtuPl3//qrQ4phTVgfQXt9y286djiTzt09Tk0yIEd11VGWCteZyW/Tr
         FjGeED+4Dw345WikbF+FoL+I7OYl9QMOnNPt1Gp4i0iI1pkB1Y55Uus5Ieyn5o+oJsin
         ExEHQS/Sn/FoPcBVfy9XwDns7Wana0wsi5uyJ3gAvhqnvjBXDIVL7fD2IuOvEoSV4K/w
         bMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpCx9wlLkUF/9BjY/GSmmZuh83h0/gYp6cSgw55h1ks=;
        b=Na5qgDMr8UhmraQpxgNSaVgVjvDvgRYuGis+LhLYNGpue0hr7jexysyqYms/gWqx0/
         TgQAXhPbxvuiQuTTrhGeLu0/oPyJG+bp6unBno4vmcFo0OvNqrsult4f/WMWo4y1XDyP
         fe/LFfTbW4HqjFCnTxpV8GMCPcjpdTHnCmySFwzz4+r4e5PUsoixU05TOEl16J4YIkeW
         CI+hRsY+4FiG1c6UtsTemK6BPw35Z+/kM2sv+XX0qUH4mpVKchN0NKbxOyT+Lltne87E
         CRzC4cns+auoAiIKfAEclIhoU79mOcSVKW9UQNJKNOY/pA+RRo6xLedNf00x+fTe0eg4
         TRMA==
X-Gm-Message-State: AOAM532eiIWogzvUbJkmFwfusksYX3HxcwjgoBxqo8lXZCW6cT5Gnitl
        E4WIZpFtvYO6PdUm6v3q2J2wKo1yoLU=
X-Google-Smtp-Source: ABdhPJxtFivGPYcWB67LI7zAbVSDQ6qLN1rJhZmqOsqNq4J+C2829AxMq50IR49aEIqObEXJ7j/hNg==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr16380764wml.36.1593440873894;
        Mon, 29 Jun 2020 07:27:53 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r1sm39557232wrt.73.2020.06.29.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:27:53 -0700 (PDT)
Date:   Mon, 29 Jun 2020 15:27:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] kdb: prevent possible null deref in kdb_msg_write
Message-ID: <20200629142751.qsljmbbj5neoanpc@holly.lan>
References: <20200629135923.14912-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629135923.14912-1-cengiz@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:59:24PM +0300, Cengiz Can wrote:
> `kdb_msg_write` operates on a global `struct kgdb_io *` called
> `dbg_io_ops`.
> 
> Although it is initialized in `debug_core.c`, there's a null check in
> `kdb_msg_write` which implies that it can be null whenever we dereference
> it in this function call.
> 
> Coverity scanner caught this as CID 1465042.
> 
> I have modified the function to bail out if `dbg_io_ops` is not properly
> initialized.

That can't possibly be the right fix!

If dbg_io_ops were NULL in this part of the code then the system
is seriously broken and we would need to panic()... but since we
know that is isn't NULL (as you said, we already checked it before
we entered kdb) then we can just remove the check.


Daniel.

> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  kernel/debug/kdb/kdb_io.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 683a799618ad..85e579812458 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -549,14 +549,15 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	if (msg_len == 0)
>  		return;
>  
> -	if (dbg_io_ops) {
> -		const char *cp = msg;
> -		int len = msg_len;
> +	if (!dbg_io_ops)
> +		return;
>  
> -		while (len--) {
> -			dbg_io_ops->write_char(*cp);
> -			cp++;
> -		}
> +	const char *cp = msg;
> +	int len = msg_len;
> +
> +	while (len--) {
> +		dbg_io_ops->write_char(*cp);
> +		cp++;
>  	}
>  
>  	for_each_console(c) {
> -- 
> 2.27.0
> 
