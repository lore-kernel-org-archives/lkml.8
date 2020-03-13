Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D62C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F81A206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ3qLAVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCMMp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:45:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44953 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:45:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so5164220pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucxAtWg1LHrjjOIs0T3dvmXxXT2OEZyobDAYu1RrNzU=;
        b=eZ3qLAVi8gGl5YnMPhHn+O6+PevTmKJau7EZHlIPRsyUjt/5Xl276DwOflkssGVj3I
         H5AbWhs2oesXUlyhzYv8G4iqwPhEtMCWU9Db4Kq0WzvCJLY0hGGlyq9/cKWt1Meb/294
         WVRAv+xSva8a2KYZQOqCfdqnek1z0MkrMWc8AQsr6xwp1dfOMGqu1zz5soyNyDOyV3GW
         Eaj1q6iSql980j9bJF9rH2JqlaDT040bYRvuDxVSSaIpSkB/9Gxfhlw2oN3kDDe2hVtj
         +MaQ1EIvh4w8HCvZhWO8+1/2GB1A9Fu+1ZEx6Ixy0dIhXLYxNeJoI8XCBAeN+r/msC5e
         Qbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucxAtWg1LHrjjOIs0T3dvmXxXT2OEZyobDAYu1RrNzU=;
        b=ef4YSPTPQ8LsXOa1topMIhCkwFbJGuOYC1rV2N6vI6P/N6TDPBJbA76Oy/Dc7A1bcD
         Mm/UIN5DnPYEDOEFx8sBIgzMDwQDkq8UanCtCf+GAbGCxpn85PaJjRe/htECKHKQaVSX
         3o6/bB8uyAJYr089dHbiVvHmVF3uIuLaqJnjId0SDJiDbHq56nl6qQoWVL++zI5uenXB
         pYD6gxHSX0EkiITqGX9NSPid3XLb3B/OePMGrtYsoEtXjU0NmyOyBDk0b/D3wnaL1oyw
         0xVhVKm6zdNC1O0MFsbymqIsw6cfDb4YuwmZXhxT7ww63/OwFMG7chFRp3jrS98gw45q
         sjuQ==
X-Gm-Message-State: ANhLgQ0bIVYkxCIJsQsASNdlJp4KajNBI5sVrf1fxTRa7GKChDOkKx58
        RlQ0jvObMI5pLRiwJC1stXOFe0TB
X-Google-Smtp-Source: ADFU+vsN3WR8L6C8d0YcnwHDKxxGPYbK1eLMVhY1C4QpUGqLpiIbOVemWQ6wKp2Mal+JNjVNwc/dDg==
X-Received: by 2002:a62:17d1:: with SMTP id 200mr13170106pfx.227.1584103524820;
        Fri, 13 Mar 2020 05:45:24 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id x18sm47265859pfo.148.2020.03.13.05.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:45:24 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:15:22 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] unicore32: replace setup_irq() by request_irq()
Message-ID: <20200313124522.GC7225@afzalpc>
References: <20200304005137.5523-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304005137.5523-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guan Xuetao, 

On Wed, Mar 04, 2020 at 06:21:37AM +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> Hi unicorn maintainers,
> 
> if okay w/ this change, please consider taking it thr' your tree, else please
> let me know.

i have not seen any recent pull request from you for unicore32, if
this patch is okay, please consider ack-ing this so as to take via
tglx.

Regards
afzal
