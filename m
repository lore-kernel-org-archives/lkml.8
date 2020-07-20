Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B4F22BF5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzaOgEgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGTBCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgGTBCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:02:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE3AC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:02:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a24so8228497pfc.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ca542pBq1PPBrcky+qLS22aaKt8lZZIIoQ77Avc1ldc=;
        b=YzaOgEgbtBPVqDtWpGiyWNmcJ66bxJmMjPQMr3UnEZOhDky155ZHGk9RRisYxhz/I5
         97TKRnm1fxj3tsqkU8Izyt9H/tXdMDUzVeIf99ZqLAr7IU18j4BKDOeHR3+r2oZKPELm
         /eHC+MWkWbdfhoy+wgkea6V8T0X5IDrP3NQiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ca542pBq1PPBrcky+qLS22aaKt8lZZIIoQ77Avc1ldc=;
        b=bfrQnAnjbueTnwOtsKsraG2kVvGz1QpKaAPWCH8sesZIL1UTggvBvPGjacGgczEOoZ
         CUlrc09Tx4PSt2ZjfxWPOcyREh1M0LdEcS8Lhn6jXmx6cvl4Qaq9mmnYIMS3x2yxGG+i
         jMkG0kxfCRETJXIlRWu1HuVfVbZE1LDeCKpCqXDtwGzPoWu7EuuiVKTG/AQz4BWcGJdY
         jPb/L7SAJ68vgPh6F6hY1J2mQvmnW2MP0L6CJUiM9Jkr5KwWiUTrR7TjATRwG1PegvHY
         +MTTH1hcOh1O2HDjAW7bBirtrJX5lYiE94duLxBWXDPWEP2vtSbYzBoURLUpxpGiDtOu
         JsGg==
X-Gm-Message-State: AOAM533gQ830telbMSVMBDqGTgWPVlcW2OpFF99hzURwMsW51hsuqrd/
        4ZIL8WQaFjK80r3iJu1qvsAKdA==
X-Google-Smtp-Source: ABdhPJx2hZirPwk7iOr7nJlIJXs1ZDJxJ6ysBFW4SaOThhgRb0LDF31Sn3KaNJMSoLmldg34RyThAQ==
X-Received: by 2002:a63:cb03:: with SMTP id p3mr16640113pgg.444.1595206936363;
        Sun, 19 Jul 2020 18:02:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r2sm14441026pfh.106.2020.07.19.18.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 18:02:15 -0700 (PDT)
Date:   Sun, 19 Jul 2020 18:02:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, jpoimboe@redhat.com, jkosina@suse.cz,
        tglx@linutronix.de, steve@sk2.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] docs: process/index.rst: Fix reference to nonexistent
 document
Message-ID: <202007191802.E3B03B06B0@keescook>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
 <20200718165107.625847-5-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718165107.625847-5-dwlsalmeida@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 01:50:59PM -0300, Daniel W. S. Almeida wrote:
> From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
> Fix the following warning:
> 
> WARNING: toctree contains reference to nonexistent document
> 'process/unaligned-memory-access'
> 
> The path to the document was wrong.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
