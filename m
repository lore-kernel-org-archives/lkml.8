Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0241C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973412088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SOQtldw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbgFXEwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgFXEwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:52:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 21:52:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x207so574173pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6f53wfu9QNcdQT3ZJDSOeI3w2U50C/xG0fFlCdqBwh8=;
        b=SOQtldw9KnegRbDuujQK6mSW72Ar+eCo9OL6sqQyLe4507FK6z15J0tVonL3ROJGKX
         jmUWzV1kGTM8ch5wLol9h8AUoGlp2vmbh9AfB5HB82Nf6nd9MDgTkfuVbQTqVcoi6m9O
         rflkv7LK/GEf+O4d4akCkHJ7Zge7ftnPwuhiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6f53wfu9QNcdQT3ZJDSOeI3w2U50C/xG0fFlCdqBwh8=;
        b=ECCoTIV8zJanspNYM83RyRBTDPLwxTsgBMjJ+XICEMsNQUTcu96FXulnmv7j4zVJ4I
         XRnYp7txlPDU+VGcWnC+7hw6EZp4N9nmcuFHosX+9D8fQMgNOZef3AnlD0Gt8ztK6huI
         9lW456KSHILJJRoLfdVAcHvYM6g4ohl44CyRG5pHrwL4D1qa8iAhMorj99BMHF1twlK2
         tiMiCr1pCPCQKizsvs5YYByDlzDbkdvTvR1xN0LdjA1N0bxNiS+8M2SaE53il3Dzsg16
         jcbdKSbMBdLuHfjR9nheQbFL1wZhL70OH3uktR/riW3zUzTHcNwhQbQ+0sVxCsYLhppM
         rd4g==
X-Gm-Message-State: AOAM5336DGwtZfD0J5cTaGwnBWCsa7D4hwXY4Je9s25WSSaP8ZNKK1ib
        Ymo+7CCeboc6OXB5gwnncDuevw==
X-Google-Smtp-Source: ABdhPJwX4es65nYyfcxHOhK/hXQNs9Mgx96rrroztpO1dJ1CT4SWu7NO7yDI/cU1cNN8RdLutBMqkA==
X-Received: by 2002:a65:6710:: with SMTP id u16mr14011070pgf.45.1592974330709;
        Tue, 23 Jun 2020 21:52:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q92sm3895838pjh.12.2020.06.23.21.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 21:52:09 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:52:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 05/10] x86: Make sure _etext includes function sections
Message-ID: <202006232152.733212868D@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
 <20200623172327.5701-6-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623172327.5701-6-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:22AM -0700, Kristen Carlson Accardi wrote:
> When using -ffunction-sections to place each function in
> it's own text section so it can be randomized at load time, the
> linker considers these .text.* sections "orphaned sections", and
> will place them after the first similar section (.text). In order
> to accurately represent the end of the text section and the
> orphaned sections, _etext must be moved so that it is after both
> .text and .text.* The text size must also be calculated to
> include .text AND .text.*
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
