Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB09AC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EBC20643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g+lUGDLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEHHa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:30:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 00:30:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so514464pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D3oWt1mR7W1fBju5sOZCALufL9LTYQI0+PIjjh/49vw=;
        b=g+lUGDLBGSWijIL9KUUhb2df2DC/dxrr4YW85noO/M5yoMhI6ZU/Autsip8G/fse6h
         uSKgvDtYUCRl4RPHGdBAg5MEz3RZGRDjFyhksTRzPkvd7GSX0ezgE8NPGWim3IvGDt3B
         J77MyE9NDGLWcl41ImtrN+Cr4dL9RHGZuw2no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D3oWt1mR7W1fBju5sOZCALufL9LTYQI0+PIjjh/49vw=;
        b=bMLq7kEs53Idh4vRi9bdGuZlH2GU4nKhYMX43yX9PEBF6SEpgEnIPGHe1s6gFECJYH
         GX/KLqKBeNatmEIhsTwDjq2QMtw6iUxK1h3a3QR+U5WzT+mjkPm3dB0LhZoLJSFO/isv
         de3j6mgemxr+v7gaKyTYcqcmhSGFz0Vhd+ozlmtEz0qWbF15kXTc9ih4xF1SQYwkdaXj
         eAp72i6DqKk5gYbArsqtnogt8WNaIgVUxXVIOIFpKlOyRYPsGnnru107KdVGYicJmOjT
         VaRW+xrsrwgyg1+hd15tSe0wYwH6gTqlBpfR/7atiTDEh0WBDtScF95xRQINIZTwvAlw
         ClRQ==
X-Gm-Message-State: AGi0PuYEM5U0Rz1ylTPteHIp9DpdPFt4Z9YL4yGPQwYeEgpxcWGyEYrz
        2z4vpkj0IChO4k6YHIQLLhZZqSiRuak=
X-Google-Smtp-Source: APiQypIzaG1zsfaHvo9d7Ad2JjjHsm85REYliO9XUs9tK378O6fzUaHuGsllh/59F/+r2DvJ/RLsRQ==
X-Received: by 2002:a63:ef04:: with SMTP id u4mr1065970pgh.280.1588923023898;
        Fri, 08 May 2020 00:30:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e196sm873440pfh.43.2020.05.08.00.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:30:22 -0700 (PDT)
Date:   Fri, 8 May 2020 00:30:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/lkdtm: Use grep -E instead of egrep
Message-ID: <202005080030.93412F1F93@keescook>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <20200508065356.2493343-2-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508065356.2493343-2-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 04:53:56PM +1000, Michael Ellerman wrote:
> shellcheck complains that egrep is deprecated, and the grep man page
> agrees. Use grep -E instead.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
