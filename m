Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE9E2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LiYJGYFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgFZVdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:33:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4FC03E97E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:33:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f3so5503641pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=isGI70+czOYX8LYvRhZpcPAvKyFNKEPZ2af3yPbAFwI=;
        b=LiYJGYFoXJP9NdTWRWQnsw8sojKk2XNyauPgbVrUQ4KV6YX9RKsid/d8JtVlvnpxBa
         kZjOaTyiQ7C5PlTOVs3B8l8qGn6OcJon3YnViItkxbqWEA1SEy38nFZN308uIc2d/U0P
         UcJCd+T2lawIni5nxisTS95QZKtBi43/FYsys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=isGI70+czOYX8LYvRhZpcPAvKyFNKEPZ2af3yPbAFwI=;
        b=LV/yrRPG2J3IlgrnqNS1qHWU/CK3R04ZEaSZGp9VlctvMCMJ9MnjT2Nrdy+y0Uy+4l
         X+OJfFm/0LTT52Ati+60hD0NFrf5Wu+CwGJVJOyqLRamPtygCjNnuYPjHreJ0/W8lQ9y
         LFrICCbNM7zJTmxjYQKgAKs09QfiWmTzAMxA1ENweRCSiwb1cl1JlTobtWOoXPECVbXn
         S+XSWI5iCU/mIWH2NsZSHERc1qlOQ4R9KzjrFEQJvJme6PrM5TpynEOCzaU2aK0fbiHD
         uH0bgbCMjx0IGu2BXu/M0xQLtF66m6zc+7QXY6WXaqyHmEKIWQkoci/4DcKqQbzctjxn
         FPVA==
X-Gm-Message-State: AOAM53273RpQ/YJUM34AcezRdnGSnHIEFkZqivk/y5Ap8dQWqvdrAisR
        VG4G4Urb80qC5qs01TJvRj9EHg==
X-Google-Smtp-Source: ABdhPJxK5PIGVit9dOqCU8WR/AxLS9sbmSmKWgE1WwIbdSsDXubZymhiuhL1Ke1iv631E7AwjZS6EA==
X-Received: by 2002:a63:417:: with SMTP id 23mr663893pge.44.1593207181950;
        Fri, 26 Jun 2020 14:33:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p19sm26713683pff.116.2020.06.26.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:33:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:33:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 08/12] init: main: add KUnit to kernel init
Message-ID: <202006261431.BB35444FB6@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-9-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:13PM -0700, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
