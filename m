Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5542C47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731BF21582
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CB1zlWsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEJCOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 22:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEJCOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 22:14:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA74C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 19:14:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so2392922plo.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cEaISn4aYW6sNpdaPku8rFfOgtLafeMU2iyoWjdjjIo=;
        b=CB1zlWscAJiNGPFdk+mvKg1Ror2ZwaWyjHTl6hA63TPJAJ54YNXsmNndHRRgWBadoh
         m7h089nXKGmFJtDB0dgKycY4IG7kCuSFeDgqhw2StcpmsTcA8ScQK7/9//qEl4RglKLb
         q2za0cl72jGSP41zzdmNeOVJl3CbJ8mZEyTUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cEaISn4aYW6sNpdaPku8rFfOgtLafeMU2iyoWjdjjIo=;
        b=TIjGxPoQlZJaBH35BwdeLN+/AH8ErFT2V9Dv/rMQRaOk6t0rgkoeoL3sjosSArQM+7
         hjuGArIr7uGkRQm9UPfTGqMpdTttnL0Eus/1dunh80bt8g8guqGWVraVez1x3a4X8syz
         aEY0f3L2ETGwljJeQZvVFNHD8EI7hUY05rwTU0s/PGdofLEj13YfNkjZzSo2BHqOglUY
         3Pe3PbmIFaDipY5E1lNCTNO1vwbEbQTx1qOHELbuKMARk9lpGQJkL02YQ3UY9iE0U75Z
         IBB686RGn0StT/AXCgKnXAkWWkDvSSWyJYdXWzgo/JC3DQR+8alfttfGgTYwzy+cZ9E2
         esjA==
X-Gm-Message-State: AGi0PuatZjGMNbJjZiNaYkYC4M00IhdvyoGlrL6X5Vh7o+XgbVyOjs5s
        9q1F+U6tQ7il8TilpHKyTfuqFu9f3LI=
X-Google-Smtp-Source: APiQypK/WEi9HEriHyYud4v8Zjn3umQzs6Ce8tTau6FjoLV4/bJA8pc/CHX7Or5DHWDchH0mPHswFA==
X-Received: by 2002:a17:90a:8b:: with SMTP id a11mr13947466pja.163.1589076853704;
        Sat, 09 May 2020 19:14:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d126sm5691398pfc.81.2020.05.09.19.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 19:14:12 -0700 (PDT)
Date:   Sat, 9 May 2020 19:14:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Emese Revfy <re.emese@gmail.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: remove always false $(if ...) in Makefile
Message-ID: <202005091914.4B8CACB91@keescook>
References: <20200510020044.958018-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510020044.958018-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 11:00:44AM +0900, Masahiro Yamada wrote:
> This is the remnant of commit c17d6179ad5a ("gcc-plugins: remove unused
> GCC_PLUGIN_SUBDIR").
> 
> $(if $(findstring /,$(p)),...) is always false because none of plugins
> contains '/' in the file name.
> 
> Clean up the code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
