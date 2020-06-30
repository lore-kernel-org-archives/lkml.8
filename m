Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF7D20723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="VER2Btoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390170AbgF3RQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390143AbgF3RQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:16:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:16:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so4695258pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCoSlvYpwE4xm9GGAZDoA+vu8+wYaZp5AwN6JLLP7E0=;
        b=VER2Btoh3kFyWbOJUwuHhFAoku5RHQcrAHEgHlOk2KpdI1XvAIM5WmdjrU0AqDlWqV
         cXRVRGgot1W90G6PZMfN5BDxuSIDQl8MTqI/8+dMZQsCcorEhBUz6nRzZGQ2w+668kLj
         CJ5s+9A2ezgfmv8iVqwPSynrgjvnMFrooa8jq2GiXiYP4E5FaFn9rygxFAc15MSEFtit
         UBjZ2UPOlDuvEZuD8Fo7fbwMCABJ5xvPRmOK3i3a+SBFILX4ESV1RRqyIuz8Y9tQ2kVu
         P/mUcdGRxs7hqpTOX2H96AyTfgHEZaApf+8zBn2tFCoxE8GToE0Yay1O3vIV6hOLRh7m
         fY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCoSlvYpwE4xm9GGAZDoA+vu8+wYaZp5AwN6JLLP7E0=;
        b=GD76kBZigzLBn1+xBJL3BJpYOK2/WcB35EaNoC0SmuZsIzwOmy/2+wSqdKRiLRsR95
         Zftl1MKOlchNyAjlDlxl/CRdBPYTmzLvo0ClRIsfBgXFjMvIoB0TbVD/gNCZVG7laMCi
         Jc1V9PXbb2iieGtWVe3B+LEh5NFGh6eBhAd/TQRkSGUaoF8N3ezDsqgBALvi6x081Tv0
         NcgVf1j8/s9PRotZlnGLC5VYlaLNdSgr3lGKAa4N4F1IW1rj3Q3VE2mROXbAL9XBNakR
         1ajSLOq6NetA8InTUV1hlV4cjeO8fG8WJlY6YA3PfgFlhkwfmFQS1UdTHmqwINo0KE0W
         G49w==
X-Gm-Message-State: AOAM533G0Kh2SslGUV6pwuDrwQGq7dnu0ianchmmlvrVxeU+Crxa6a/Y
        mV1DBx/hbF6/XoHm+YEgXGcUGw==
X-Google-Smtp-Source: ABdhPJwTQKG+yNabwbiBqTlw7Ts5bhbBBqIBDsA+fvfKLo/ggAj6ZDNQuOqsHxH+g9mLpbTcyYOwgw==
X-Received: by 2002:a17:90b:11c9:: with SMTP id gv9mr6903719pjb.177.1593537391735;
        Tue, 30 Jun 2020 10:16:31 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id q39sm2885094pja.30.2020.06.30.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:16:31 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:16:21 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Andres Beltran <lkmlabelt@gmail.com>
Cc:     t-mabelt@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        skarade@microsoft.com, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 0/3] Drivers: hv: vmbus: vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200630101621.0f4d9dba@hermes.lan>
In-Reply-To: <20200630153200.1537105-1-lkmlabelt@gmail.com>
References: <20200630153200.1537105-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 11:31:57 -0400
Andres Beltran <lkmlabelt@gmail.com> wrote:

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
> Tested-by: Andrea Parri <parri.andrea@gmail.com>
> 
> Cc: linux-scsi@vger.kernel.org
> Cc: netdev@vger.kernel.org
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
>  drivers/hv/channel.c              | 154 ++++++++++++++++++++++++++++++
>  drivers/net/hyperv/hyperv_net.h   |  13 +++
>  drivers/net/hyperv/netvsc.c       |  79 ++++++++++++---
>  drivers/net/hyperv/rndis_filter.c |   1 +
>  drivers/scsi/storvsc_drv.c        |  85 ++++++++++++++---
>  include/linux/hyperv.h            |  22 +++++
>  6 files changed, 329 insertions(+), 25 deletions(-)
> 

How does this interact with use of the vmbus in usermode by DPDK through hv_uio_generic?
Will it still work?
