Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509DAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C81320723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SsWP3Gl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgEVWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbgEVWJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:09:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C751C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:09:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c24so9551160qtw.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/iHepWlHzPkoThKK+sxZvuLmz942NkozOITiMDLCLfg=;
        b=SsWP3Gl3dor7j0epgR7q6l0aTcG1/6LtpX81BdvLzsMx/SADmJaiJ7WE1k5CydEjCA
         pnPuBZM2mv/a+4grKSRCCTTdbdmNdeqV8dc7GncgMzMLQLg8qkKEBf77ofrwwGUI1wcl
         qmcvev9OnZOnd1KQ0RoeoNhXFiGrxldEn0ax6IzVM8vek0c9MkKJ1WHcZBGETQwFtTms
         xBqS4UkhI4zfvcUzOTP6e04vN5vzN9IMJboLXc8fMiOcbJVll92sA2xGwxazmiWl8T6U
         sgb4cPGZ+AAVrYG5juLUc8yu17IxzBd/THBJyAtbZuxeyKj6x5ZzrMFvlfZW8cSRgTP+
         /OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/iHepWlHzPkoThKK+sxZvuLmz942NkozOITiMDLCLfg=;
        b=ntwb3+NbOMkYX11FC/7EzwV4FFlVGWsa/vgpXHcYaPSNVOCpI28xjrZxngdtfbDPKQ
         pcKvT+5U0eC4O9w1KDYqFiDtZFtuAk80SFEGuW0NSVQ+xKY2YMb8LEsOnN7J5PxqmuKz
         ckVtylh3CGGF3ea1gmGKJxhptDCIbZbMwR4In9hO+fqcTE83/1oA7cJeu3iqpf/ZdgCE
         PLNX+H7kf0vjBRxKJL/wovIgNRg8jKCqn3jCItQzI/qEr+n5IVdfFAk7YkYHrn9Rk28x
         psU/kfyJZc9ckIx2dIzxPh+6BuClg/iaNdr2PKi5LGhLkNl9lYTJU9LOD8nlcMjYDsdD
         B2rA==
X-Gm-Message-State: AOAM532R34UADwnitX4IBwJbleV5OViPlUE4C9/lmI7Rv4mTXmnyESXH
        UVIGJB2MCFqpBbkrLZAa2jYkvg==
X-Google-Smtp-Source: ABdhPJyvvKpnqixLclW9SLL9hQ6ovKYcUrUanoFOiGH05AztSO5V21liqHYSLrfJzvzy71hKpb6V6g==
X-Received: by 2002:ac8:d87:: with SMTP id s7mr3686244qti.210.1590185341221;
        Fri, 22 May 2020 15:09:01 -0700 (PDT)
Received: from Qians-MacBook-Air.local (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q17sm8581804qkq.111.2020.05.22.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 15:09:00 -0700 (PDT)
Date:   Fri, 22 May 2020 18:08:58 -0400
From:   Qian Cai <cai@lca.pw>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca, peterx@redhat.com
Subject: Re: [PATCH v3 0/3] vfio-pci: Block user access to disabled device
 MMIO
Message-ID: <20200522220858.GE1337@Qians-MacBook-Air.local>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159017449210.18853.15037950701494323009.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 01:17:09PM -0600, Alex Williamson wrote:
> v3:
> 
> The memory_lock semaphore is only held in the MSI-X path for callouts
> to functions that may access MSI-X MMIO space of the device, this
> should resolve the circular locking dependency reported by Qian
> (re-testing very much appreciated).  I've also incorporated the
> pci_map_rom() and pci_unmap_rom() calls under the memory_lock.  Commit
> 0cfd027be1d6 ("vfio_pci: Enable memory accesses before calling
> pci_map_rom") made sure memory was enabled on the info path, but did
> not provide locking to protect that state.  The r/w path of the BAR
> access is expanded to include ROM mapping/unmapping.  Unless there
> are objections, I'll plan to drop v2 from my next branch and replace
> it with this.  Thanks,

FYI, the lockdep warning is gone.
