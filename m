Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E646C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671AC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwC4OoWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFQBI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQBIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:08:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B875DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:08:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h10so423994pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wk2msqn1yrMOJAsun48ohMNZ78tQdb/SpUXLjd1X3f8=;
        b=RwC4OoWnsiCxUnYf+dhHP4N4SlpOoIOwjfDf4SDo5kCk1S9Wisq3ODhtxkIemgfg1A
         L/pzDHq+SenNrGKwPgnGDhr3uxkWM1tkIK5aPr77+yz+n7yNVmTyiHdgtqflRm1Edcew
         rKZ1hAMNNI3W+AG2NP281/R13rtSCCcKYW/G3c+HsI1erOHm421VDtvomqs+gKp0RzKp
         XCClpnhwQrhp6+DIPXuOKiK5zkruIAVGbTz3fr6gytQ6OusD/HBlkrP/feIPnAo4V4Fp
         LlxukgjjZVhnt9ubUEmD1CLezkmXr62LYqInHq1w785bX/600pmmWodGkm7hYQtUkhVG
         OveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wk2msqn1yrMOJAsun48ohMNZ78tQdb/SpUXLjd1X3f8=;
        b=QbCLxYY1ZM9FpuKjDRXvrjI40q07uoX1TNu7gleKy2fSt3p+jHxTDcAqiqbm7ejRKU
         MRVwZWVPMGuAWEorG8/illbYN9mM+9Yw+ij/CvbQ0ZYfl8IXmjLW9qt+1iGecWG/Qlbo
         0H5nC7UpFooHR8PyY6/hlBra/V0wPlxbCCiDGfAfer1XNHOjK+2s49eYn9fCmprvV/D3
         5kIRuSnH46oSBUfp7UpkpbkO9f7orSqfK0HW0+HF2mE8qAWlOE9RYsAP0DWereGJ1JaT
         hjlmeH1lgGnWzpV6i/fuWOU/HNdn5yGNhZZWdNAv6rVJ8bRaqNTmlqkCdk0kVq+7JALo
         desQ==
X-Gm-Message-State: AOAM530yEi9Q67QLtcozTOGOLAYKmoeXOORSQu3heySErSF7LLjuKDmb
        fF04jWWjG/XZzWkWRet8YxE=
X-Google-Smtp-Source: ABdhPJxkt9bONbo+sbVoqdYYhSEnY9iKl7kaDlxs9Z84TvDWSh8GD51obiJs+YbXnhysaaX+obMcpg==
X-Received: by 2002:a63:368c:: with SMTP id d134mr4186312pga.393.1592356102613;
        Tue, 16 Jun 2020 18:08:22 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id gp4sm3561962pjb.26.2020.06.16.18.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:08:21 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 17 Jun 2020 10:08:19 +0900
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v1] ARM: bcm2835: Fix integer overflow in
 rpi_firmware_print_firmware_revision()
Message-ID: <20200617010819.GA1004177@jagdpanzerIV.localdomain>
References: <20200616163139.4229-1-andriy.shevchenko@linux.intel.com>
 <1e504c53d632b4f175f69782d1e38f0030dc9055.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e504c53d632b4f175f69782d1e38f0030dc9055.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/16 18:42), Nicolas Saenz Julienne wrote:
> On Tue, 2020-06-16 at 19:31 +0300, Andy Shevchenko wrote:
> > time64_t is 64-bit width type, we are not supposed to supply lesser ones
> > as in the case of rpi_firmware_print_firmware_revision() after the commit
> > 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT"). Use temporary variable
> > of time64_t type to correctly handle lesser types.
> > 
> > Fixes: 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT")
[..]
>
> If this doesn't fit the printk tree I don't mind taking it trough the rpi soc
> tree.

I think, for this patch, SoC tree might be a better fit
than printk tree, thanks.

	-ss
