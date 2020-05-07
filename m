Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF83C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07812078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax450Ekk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGH3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:29:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588836592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqHWm03cdWE9AeodDX2gtE5xAzgCwXmdJaTKNX0BlUA=;
        b=Ax450Ekkhxjw3HIF0k9YGXt940OU6l2lhi0ByRmwYnBQkaqCNp8Nw3T0bog9R6MXAvynGJ
        O236bGmwuhtpjVZ/t2HA1lbWl33weRnRWYnOy7zkb57dPX3irByluF0b0I9a3h5W/T0afc
        8MUjPmT9ehUwB11RwiR35x6Ai9Asmus=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-jR_VSg5vNEKVsvrrGvfeMw-1; Thu, 07 May 2020 03:29:35 -0400
X-MC-Unique: jR_VSg5vNEKVsvrrGvfeMw-1
Received: by mail-wm1-f70.google.com with SMTP id u11so2033100wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqHWm03cdWE9AeodDX2gtE5xAzgCwXmdJaTKNX0BlUA=;
        b=CQMilcP49JDBs1CE69vjOwuVE4oaqf/rVjewSjmevUMMvaTVKQVflga0LrJlnx1AQR
         x2bMuKhOibFIyp1/smSDAcE3fdMu4U9fSaaCRjqSyRHN8lDqfJuqpcz7b4C84NLq933U
         hAhkvUS6GJ8qdo0lKFprmAqIbIN9lXlIkfbx9dXInqQkCw7lGFqaSKeBeP5argZOl28A
         QOihn2EXYgAxlAVy4R9mWSFuUdL50ToxQPIihJfZSR9dFHlQ7eqUDyXnZB4xuu1cSzei
         4baYbndTp5lzSbBk9jmxVdnoWfg5DkAzWzgehKtcrv5LZre6QfZ53Rt+m/wlYHpjibqx
         x8+Q==
X-Gm-Message-State: AGi0Pua9iRDZ2wAySBa/e2xIKX30GKzsZnDf/+Xh3KU1lF3yj65DyxDV
        tbHN6eHJZYnPy+RBv0WLNe0UfoHbo2X9IIXU7SKEcqpjIe/F8MmpO65VkbievR2F1jKd3txjWVk
        WAWajS0Xbp6orWrd9b+nHeUr5
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr13722772wrs.91.1588836574145;
        Thu, 07 May 2020 00:29:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKW/afKgcN6Ys3SlaqvJeC2tMA76ui4ITX8WaKt12BBr/x/h/A/RJ6Rv71x5W9jITqlLYoytg==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr13722718wrs.91.1588836573396;
        Thu, 07 May 2020 00:29:33 -0700 (PDT)
Received: from localhost.localdomain ([151.29.188.60])
        by smtp.gmail.com with ESMTPSA id z11sm6487512wro.48.2020.05.07.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 00:29:32 -0700 (PDT)
Date:   Thu, 7 May 2020 09:29:30 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20200507072930.GM17381@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2019
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 

Quick reminder that OSPM-summit IV edition is happening next week!

Not in Pisa (for obvious reasons :-/), but online, kindly hosted on LWN
BigBlueButton server. Thanks a lot to Jon and LWN for this opportunity.

> .:: FOCUS
> 
> The IV edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Pisa
> (Italy) on May 11-13, 2020.
> 
> Although scheduler techniques for reducing energy consumption while
> meeting performance and latency requirements are the prime interest of
> the summit, we welcome anybody interested in having discussions on the
> broader scope of real-time systems, real-time and non-real-time
> scheduling, tooling, debugging and tracing.
> 
> Feel free to have a look at what happened previous years:
> 
>  I   edition - https://lwn.net/Articles/721573/
>  II  edition - https://lwn.net/Articles/754923/
>  III edition - https://lwn.net/Articles/793281/

[...]

> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!). Registrations open on February 24th, 2020.
> 
> To register fill in the registration form available at
> https://forms.gle/7LfFY8oNyRxV1wuQ7

Since we don't have real rooms constraints, registration is still open.
Everybody is more then welcome to join us. Please use the form above to
register. Details about how to join will be provided after registration
completes. You can also reach out to me directly.

Schedule (still subject to small changes) is available at
https://bit.ly/2WAtsjy (CEST tz).

> .:: ORGANIZERS (in alphabetical order)
> 
> Luca Abeni (SSSA)
> Tommaso Cucinotta (SSSA)
> Dietmar Eggemann (Arm)
> Sudeep Holla (Arm)
> Juri Lelli (Red Hat)
> Lorenzo Pieralisi (Arm)
> Morten Rasmussen (Arm)
> Claudio Scordino (Evidence SRL)

Thanks also a lot to Scuola Superiore Sant'Anna of Pisa, Arm and
Evidence for helping put this together for the 4th consecutive year.

Looking forward to meet you all soon.. virtually. :-)

Best,

Juri

