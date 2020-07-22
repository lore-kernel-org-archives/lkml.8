Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB7CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A8C20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="MQp8z9MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbgGVSko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVSko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:40:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D0C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:40:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so1749948pgg.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9NmDFLAg+S5lUz7K2pvf1RhE94Cz0luh7cCv2JHKXA=;
        b=MQp8z9MQbjNzSSgYFwXVflDMZXY4DvuxHtdAXlCmLFxx0hOtegVLhCBZUQ9TLduLz5
         ahZ3TrUoGAUsC1cMno4k0/T8sWa/5T9W9ohDh5NvhVKcAtDnl1MQ/kJKKgKgorwYvdMH
         IgJukohrmjsI1i8pALKgQ2CCs+bl75yZzQseWKIAQ2u0itey7ajZ2NsPdWB528iAEyNN
         9i9gQ+MK49i5GAVGKtTrWlcFURx/zBexDaIR5Bkow+ASqjSS1QvNtQsT0PewqGa4UHoC
         KUWrDiFfrrigWke+quMV9W7DkPWApb7WxckAiF9APlR49Q9UnuT4d01yBiFAknTR8HC6
         yX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9NmDFLAg+S5lUz7K2pvf1RhE94Cz0luh7cCv2JHKXA=;
        b=fUiuVLif+eUcs0/k89a6s2T/3mDGDYN+OKVFXC4v5HB67bAZzSI6FbVQ676ZWMQD+B
         OkNZmdDcMI5V33+FEWNq/9aoZWdHb2FnN7TpX9ecSooI+6HcBY4ojJWJ/gcqriEd+ZKR
         l6CHbSDWrEDq/Dq3jSAs7yfYQZ1aBL15KGgG6YX+ep6ptUWEJYGCWgQNstPYpG2O4nix
         E7xAd36ANyfgQbTVZDL1Z7UMPgQBmI9JmDCteo4ednRIKMs3/kAK3T3RAiQP4TuhXR1D
         e7RQSAe9A/lO589VG3r6aR01CnM2TsBHT1W9UTllFa72Z+uQ/jhov+2uEP0OnXy5HmMy
         fGZg==
X-Gm-Message-State: AOAM532Ugb1Kz7TOBsY+jNt+ZAo/xmw3U1GwzZkBPjZGC+rXyhacRins
        czjrLw8Eyf2D2q1mXHfO673jrg==
X-Google-Smtp-Source: ABdhPJxio2fC0vpPrfbEyyEzIA8d296ammbTqFH+Pc8D13bMlX4ePTOLEEh2mfXOOZ3yAf9ENDEjwA==
X-Received: by 2002:a63:c58:: with SMTP id 24mr963125pgm.343.1595443243660;
        Wed, 22 Jul 2020 11:40:43 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r70sm324144pfc.109.2020.07.22.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:40:43 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:40:34 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Andres Beltran" <lkmlabelt@gmail.com>
Cc:     "Andres Beltran" <t-mabelt@microsoft.com>,
        "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Michael Kelley" <mikelley@microsoft.com>,
        <parri.andrea@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 0/3] Drivers: hv: vmbus: vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200722114034.443f5af2@hermes.lan>
In-Reply-To: <20200722181051.2688-1-lkmlabelt@gmail.com>
References: <20200722181051.2688-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 11:10:48 -0700
"Andres Beltran" <lkmlabelt@gmail.com> wrote:

> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
> 
> The first patch creates the definitions for the data structure, provides
> helper methods to generate new IDs and retrieve data, and
> allocates/frees the memory needed for vmbus_requestor.
> 
> The second and third patches make use of vmbus_requestor to send request
> IDs to Hyper-V in storvsc and netvsc respectively.
> 
> Thanks.
> Andres Beltran
> 
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: David S. Miller <davem@davemloft.net>
> 
> Andres Beltran (3):
>   Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus
>     hardening
>   scsi: storvsc: Use vmbus_requestor to generate transaction IDs for
>     VMBus hardening
>   hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus
>     hardening
> 
>  drivers/hv/channel.c              | 175 ++++++++++++++++++++++++++++++
>  drivers/net/hyperv/hyperv_net.h   |  13 +++
>  drivers/net/hyperv/netvsc.c       |  79 +++++++++++---
>  drivers/net/hyperv/rndis_filter.c |   1 +
>  drivers/scsi/storvsc_drv.c        |  85 +++++++++++++--
>  include/linux/hyperv.h            |  22 ++++
>  6 files changed, 350 insertions(+), 25 deletions(-)
> 


What is the performance impact of this?
It means keeping a global (bookkeeping) structure which should have
noticeable impact on mult-queue performance.
