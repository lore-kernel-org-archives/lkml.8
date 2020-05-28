Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D570C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39272084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590678182;
	bh=FlElzWr+Sp5QKJidb+0J5RSKJXutVhvf/ybI9w4urPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VVMzmWOsLgZuxpnbFKiZzGDpX6Kjh2cBMLrxwEPMrIDcRDy72LmdSiMm16uJG+3On
	 igTDlO7MPESSfCOwz2NixiLvccA/FaeNbdPqHwJdBI1VqjsMU2dj+VgDThTc4uLQQm
	 NaBiUGXDuFSkPRO12yeGyET5OKPZda6kPbXykyFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404154AbgE1PDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:03:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38453 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403912AbgE1PCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:02:53 -0400
Received: by mail-io1-f66.google.com with SMTP id d7so30342812ioq.5;
        Thu, 28 May 2020 08:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qgmco4ffaTrukcokfI+4N6+JaZOIcIstDQ+dZwHwNQw=;
        b=UqUwomZsg9Ht1iMFnOh/Loay+FPVyQ39547mvHvlQsAMZHT6Z4ubRloFERhi9i2YyP
         XcTcbUZe90wJiBBTjq0ON/hs4u2apx8cOHIAaaf/tENl4UjRjwW8oD4l6HQNWen0d7gq
         9afO9z6tIF+dkejKfbnyNGmtXgDYapC19tqId/TCMQLVg4mHLPO1HRW/gLOEm1xjBLwC
         T0zQxjOEPDp3ZCLD9xYxnAAgudSEhibMXF+Mvim0xrQgaHz9daMiir/oAa9bBsS3CwRs
         HuDdToZEOx/rLdHzJ1lJCuZFgNs/Zz54rJT9wNz40LRPYlIVizENNfap0iJMO/dO97eh
         CxLA==
X-Gm-Message-State: AOAM531RyQAUh7JM7F7eE3GDSRJFr8s2r6SoDD791XjMrWi9fs27jCRT
        RtzM2qZp/a07OAXLmmOkdRLjUbs=
X-Google-Smtp-Source: ABdhPJyuBA73B/aLP9SLW5z3RxwwrWs7+0j5gkm719znfP/EHR8vhewhVVFrOLI7s7LuGdVfJ6o7UQ==
X-Received: by 2002:a02:3f25:: with SMTP id d37mr3051023jaa.142.1590678171651;
        Thu, 28 May 2020 08:02:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w70sm3379101ili.78.2020.05.28.08.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:02:50 -0700 (PDT)
Received: (nullmailer pid 64380 invoked by uid 1000);
        Thu, 28 May 2020 15:02:49 -0000
Date:   Thu, 28 May 2020 09:02:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc:     devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com,
        Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
Subject: Re: [PATCH v3] video: fbdev: ssd1307fb: Added support to Column
 offset
Message-ID: <20200528150249.GA64321@bogus>
References: <1589395691-8762-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589395691-8762-1-git-send-email-alencar.fmce@imbel.gov.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 15:48:11 -0300, Rodrigo Alencar wrote:
> From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
> 
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.
> 
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
>  drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
