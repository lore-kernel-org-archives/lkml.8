Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F61C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C5B2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+NpbKGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgFOSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:23:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA7FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:23:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so186891pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IvShgxoC6bEvinDvmURRTORSW1iT83qg7H2qgSQS19E=;
        b=U+NpbKGIkE9uBSFYj785QYFB+7ya2GdLJf26a5eZptaE+Q9l3S4vQkrMwGK7idV1Q/
         FaLWXHRWuMIlQR1nmVSYMSzeaWFof6bo246BhYUINV13Iwgnpu/4WR/Gn4BWy3eofGKv
         AkLGdGsLoSUZbPWfwHx9/xA2V3pCZV1Z7gByw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IvShgxoC6bEvinDvmURRTORSW1iT83qg7H2qgSQS19E=;
        b=ZfSDxUaL+fw9Qfp6C4P7ySH5eNzjblCkzifo/Y/Bvg+LAaj0B2QTyG8T21hSCiS0ya
         8f4nQDX2EziKv1zVc/0/VetGu3TEdHwjyG8/Xv6j1Q8zNgwm/TqtKyUCgErRIhvDEDlL
         c2r71m1a2GHrxRKoB89JRn3TY6VaYJ+z5HJjLX6JC9S0vFJscSEhySCaiIZuKMlaNA28
         a1OyfcezAPrdcWurtHhYeMzbpV3J1XwBUK2TZWVpPc99jv8vA+RzjfjzmVZFnnhC+6Nj
         wHMiArROagPSHajinIdkWiX+otUhZlMnT+pusZvAyD0/xXvJsTF85au7sr2pih3xzmAx
         tEzg==
X-Gm-Message-State: AOAM533PfrJIfp6REsSW3Mnf1D6EwqlODBO7sO4WiDPPsFxJotWh6jp0
        mi6EC7rBbgS4Hgm2NSaxii1+Hw==
X-Google-Smtp-Source: ABdhPJz0RZjZviKdUtNJ9eldCEtBXBpRgBgFrvR3r26zSJFIETSsILbIXvrl1mnG2zXN6hNYIQGOpg==
X-Received: by 2002:a17:90a:1da6:: with SMTP id v35mr546338pjv.177.1592245405235;
        Mon, 15 Jun 2020 11:23:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm14373082pft.127.2020.06.15.11.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:23:24 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:23:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: add array_size_dup script to detect
 missed overlow checks
Message-ID: <202006151123.3C2CB7782@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
> Detect an opencoded expression that is used before or after
> array_size()/array3_size()/struct_size() to compute the same size.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Oh, very cool! How much does this find currently?

-- 
Kees Cook
