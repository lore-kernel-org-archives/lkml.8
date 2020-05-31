Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E74C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A5B20657
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="rfRrDaAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgEaTyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgEaTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 15:54:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8929C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:54:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u17so5058845qtq.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7XuZ6aq76nVXApifOY2tG3hlgqIdoWHIRTm6SmU1IWw=;
        b=rfRrDaAQqj+IjOPvQ5SjzWVnMlF8hM1Dnqt7EGG/u1/3Cl4FN+dl2rcIbi5LLczCl6
         LuSumHz4P+n5vH+SkCqDCfNTXPDs+SW/2SZbZdqhx3VTrd/9BNdG7meMD+ZId/zD2IFH
         EcmI6NMMa81iFBOB0eQAkbq2XjYJ/Zr4cqrx2r9xW8ZKFBlZfrw7yjSuF7xFcD+4cc6c
         5LTf41Ykx5+6UcHSR7iyKYppo1sGOxJhLK2OxgqXsFXuOQnJepEG3jjP5LJT1AgKzY0n
         z4fl1a2BRFHl11bNXCfj2Ans4ZJIL6rwHO7nXE678upGPF2axK895/hu+D+/31KT13rF
         OaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7XuZ6aq76nVXApifOY2tG3hlgqIdoWHIRTm6SmU1IWw=;
        b=Q66PPhKSbSrUAuAhAmqYMcQTpLmPD9nDv0VWRjiZ8WVYu3clvq4DUwE3IbhJEBAMKB
         C2fbCj95ukqYVJuJstgi33VXL+aBDDyHYjClNVC79qadhz/+9I/z38lGOSFxciy6rvNK
         kGLNzYLzJR/Ddixe0Rm54QrfmyqcHT/ktErlHSoYsnNhNv7f86PZWpIXoNttRv9oyqXs
         Mlmiuzdbulg7LPx8T+QLcxGK9WnENMWoNdFKq2/U2kZTdHS18cnC9ps0FHgGyNaPJ0ar
         vXEKKmOMTXMzHSGYNcGJzrnZMaDkuxjjePo4zx2Eh02zOKwsdbYVMumMNsM9GTglr4Ku
         HZLA==
X-Gm-Message-State: AOAM533koLx8w7DeArIDwRDTcwBB8kO4ebcmDleVY+Yr8KMj9dGmBBwz
        RD/3/uMcwITM42L3wWM6Huhaxg==
X-Google-Smtp-Source: ABdhPJwjea7g2IEFnXWWlyL99mFelHskN3S8VW5AnNKyXrLg873OsEm6oCzujM3a/gZjNYgco+jfxg==
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr18231962qtc.257.1590954882766;
        Sun, 31 May 2020 12:54:42 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a664:2e00:a5da:931a:7f23:1d4d])
        by smtp.gmail.com with ESMTPSA id 130sm12286900qko.113.2020.05.31.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 12:54:42 -0700 (PDT)
Date:   Sun, 31 May 2020 15:54:40 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com,
        logang@deltatee.com, Shyam-sundar.S-k@amd.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] ntb perf, ntb tool and ntb-hw improvements
Message-ID: <20200531195439.GB4620@kudzu.us>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:21:47PM -0500, Sanjay R Mehta wrote:
> v3: 
> - Increased ntb_perf command re-try sleep time
> - avoid false dma unmap of dst address.
> 
> v2: Incorporated improvements suggested by Logan Gunthorpe

Pulled into the ntb branch.

Thanks,
Jon

> 
> Links of the review comments for v3:
> 1. https://lkml.org/lkml/2020/3/11/981
> 2. https://lkml.org/lkml/2020/3/10/1827
> 
> Logan Gunthorpe (1):
>   ntb: hw: remove the code that sets the DMA mask
> 
> Sanjay R Mehta (4):
>   ntb_perf: pass correct struct device to dma_alloc_coherent
>   ntb_tool: pass correct struct device to dma_alloc_coherent
>   ntb_perf: increase sleep time from one milli sec to one sec
>   ntb_perf: avoid false dma unmap of destination address
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c    |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c    |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_gen1.c |  4 ----
>  drivers/ntb/test/ntb_perf.c        | 23 ++++++++---------------
>  drivers/ntb/test/ntb_tool.c        |  6 +++---
>  5 files changed, 11 insertions(+), 32 deletions(-)
> 
> -- 
> 2.7.4
> 
