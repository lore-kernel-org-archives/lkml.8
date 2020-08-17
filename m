Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4183AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5572072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtVA7iU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHQHvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHQHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8EC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:50:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so7812564pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=icNSOECLsd5SUXfd5TuaMF79ZSufKyjXu5CGDwSmkn8=;
        b=jtVA7iU7RBZyxMWCG9Iyfrk+0pNMJHlFoejLzG9GR2sQce1Shph+IZpnifGzZlA8WG
         3g93Yt5HTfFfyBKjvsTLJpbeaDhwW91Ri5TBkapvAOB06S5pOlFGxD1UnqEU35AG7tI6
         vhTLM7owNiknbxbQm2fvP2SvCwAsMtNojF+HlbYjBNtdiX6+3W9Owv9PYsCgR3dMxNz0
         dKESu03dgakXlHn28LLotPgzH0/wFokPpHn2MsAyw51JwFclhN14ZywS++5rp+Fgq7JA
         pAk2Q7QCuHTTVZBvfvqDP3N4VlqMgwa+qkXqLWga3EzW4+9I4mfnBB52RVcqxl3aMZDG
         R71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=icNSOECLsd5SUXfd5TuaMF79ZSufKyjXu5CGDwSmkn8=;
        b=KTYTHjZ1xiVi9EsDgJ3FvuH5hBYYHbUqlLcXmEn7KTbFLwiQ7F8OE7071uwDu4JOu1
         SWbQBmgGppklLFItbnHvp5SHRBC0wMb3CXG3C7CADB7/SYlXIVlS+gfvTPmgd8wX90DI
         8gVMebqZv1WjkBOtTdRfzUnxhWW58d0vMcEsf/LIoF1XQUeZ0jvOEzzoVfLDann+oJhV
         IkgKO7Cr3hZppLqav5+R+Pqh0piUul2rJ85vsq9Utebn6dIwyDplff2OepIe3o/jwP95
         QyhLu0LKhpBUNUWjbXL55rz9ywR4z+qHPAm4zq2rqhOItZ9b9X6VBN5rMTMCZpbL2lgy
         CYKQ==
X-Gm-Message-State: AOAM530d8XYk79zLyzyogPtVyxR0JXhmuuvICvcPFqeD1fSqqjv7jwcX
        CPlk95/IW32K0Lha3GhwmvM=
X-Google-Smtp-Source: ABdhPJyVbSk+noMPCYXy+iUTWyP7ZiTTXI2sxxqqHxiSZhmmP0LuqlyN/tN0USwsCiBCZKkVwdwa4g==
X-Received: by 2002:aa7:8a08:: with SMTP id m8mr10556767pfa.135.1597650657872;
        Mon, 17 Aug 2020 00:50:57 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id 124sm18908762pfb.19.2020.08.17.00.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 00:50:57 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:19:21 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 0/3] char: use generic power management
Message-ID: <20200817074921.GE5869@gmail.com>
References: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:19:34PM +0530, Vaibhav Gupta wrote:
> Linux Kernel Mentee: Remove Legacy Power Management.
> 
> The purpose of this patch series is to upgrade power management in char
> drivers. This has been done by upgrading .suspend() and .resume() callbacks.
> 
> The upgrade makes sure that the involvement of PCI Core does not change the
> order of operations executed in a driver. Thus, does not change its behavior.
> 
> In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
> helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
> pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
> their job.
> 
> The conversion requires the removal of those function calls, change the
> callbacks' definition accordingly and make use of dev_pm_ops structure.
> 
> All patches are compile-tested only.
> 
> Test tools:
>     - Compiler: gcc (GCC) 10.1.0
>     - allmodconfig build: make -j$(nproc) W=1 all
> 
> Vaibhav Gupta (3):
>   amd64-agp: use generic power management
>   sis-agp: use generic power management
>   via-agp: use generic power management
> 
>  drivers/char/agp/amd64-agp.c | 24 ++++++------------------
>  drivers/char/agp/sis-agp.c   | 25 ++++++-------------------
>  drivers/char/agp/via-agp.c   | 25 +++++--------------------
>  3 files changed, 17 insertions(+), 57 deletions(-)
> 
> -- 
> 2.27.0
> 
