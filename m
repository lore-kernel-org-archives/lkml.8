Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7B82082F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGv9Om6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgFPSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:43:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:43:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so8773235plt.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQRkR7McObJFQyLrKaEvXEWgrNkrjo6daR1hjZ5rIUg=;
        b=aGv9Om6OtQxg3xs0G6MCndunFofM9NkscGXm8UQatgIx5QpFMqn3s52ln98T0M4HpX
         5kYwgyH5LAhdYSYBtFxmUWOfkqVLksFx9tRc3dH8CHI0VqIKXrkk8yIWvBfKFeUy+231
         rXjhY93RauL3WQ3NFrpmjWHZayqrY/ilrKMrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQRkR7McObJFQyLrKaEvXEWgrNkrjo6daR1hjZ5rIUg=;
        b=JePf54kk/T7fTGD4pcW1l97RSGz97mUDNMtQT/1hO7DFZHmmxdwop0WGEHv0MuLzQb
         jvEBBG1dpuIoDb32UJJkn2WoyuYuQzx5xyNMoe0hnImF9KobkddmAlMoD6mXLdzsI4WE
         BbxWTjhh1BuejengqvCfSwzZQeSr9kdHL+l+uoW7S7jc1nWLcKMynZQ7B7qsb55dLjqJ
         lV2gRA+t1KExEXQNc/T6WREeU2iytXmJ8WoDfcpVmHAjmfT4clDqFULlAMv0zRQXc1zF
         wMCKN8tQHrkn+la+4ZYCqCIiGunW0Msxyr0NbduJQhvXsDQpDJVoRX7aZQjFIMlxyki5
         JNMw==
X-Gm-Message-State: AOAM531b3Bl+idlymFCY0oYFLcYEd68O060xZIsqnXo/6CTlsyTgWnPf
        6vk/TnaKElRPozzlk0eGr+X9Fw==
X-Google-Smtp-Source: ABdhPJxA4+z6TtVV0+DvTH5XeX29TqiO/aEuQqXeIYyFm21Prg7/V3OnPdBDGg2xoDLYY7Z4PWkDlQ==
X-Received: by 2002:a17:90a:e387:: with SMTP id b7mr4511819pjz.176.1592333025739;
        Tue, 16 Jun 2020 11:43:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm15445770pgj.62.2020.06.16.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:43:44 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:43:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] cifs: misc: Use array_size() in if-statement controlling
 expression
Message-ID: <202006161143.5A4226EC3A@keescook>
References: <20200615224112.GA12307@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615224112.GA12307@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 05:41:12PM -0500, Gustavo A. R. Silva wrote:
> Use array_size() instead of the open-coded version in the controlling
> expression of the if statement.
> 
> Also, while there, use the preferred form for passing a size of a struct.
> The alternative form where struct name is spelled out hurts readability
> and introduces an opportunity for a bug when the pointer variable type is
> changed but the corresponding sizeof that is passed as argument is not.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
