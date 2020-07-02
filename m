Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D1AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1152E2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/hkodre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGBKAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:00:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43527 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726805AbgGBKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593684005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tM/fslsYjSATVPc+KX5EjKGbYr2vpOKma6Zf3gqwxnA=;
        b=P/hkodreQidT2q7ezzInFYBF/1SQljcSMuo+AB82pM/iIDfm32ymNRUWxQzyehvb8JB5XR
        EBvEvlissY5zoHP4t4w+IGuPFGWzin6nVsx71634FsBg2rf2/XBucVOWG05+R1actimgV+
        pcEAwS5QdaZeKg72wHqT80lSm1hvVzc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-d8Wugrz7NKSn_OD0tpSOmQ-1; Thu, 02 Jul 2020 06:00:03 -0400
X-MC-Unique: d8Wugrz7NKSn_OD0tpSOmQ-1
Received: by mail-wr1-f70.google.com with SMTP id f5so24504247wrv.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tM/fslsYjSATVPc+KX5EjKGbYr2vpOKma6Zf3gqwxnA=;
        b=J9jpOciY6sR55sPUC4d6hSYm2lZZrJwOYsKlHxkwUI2MF6CO4FWcGO9ADRhKINLoGW
         1xpaWOqdVoLUdNfOY+3JodIWh+qvyYW1MoBFqIfrWRh07zw90eTV3AzZk4alFuVVT11K
         c7Sq44vVHPTATARylCeEuKd2tEirTE2/RGEPt/E+kntWgUdxCW0xlym/91+pUZBXDucE
         vgjsUMyJ0gtj9bR8snUdVmjPzR+vjzfxzpSQI94jft7dzWpwPXsVT58nl+mfGF00lGdX
         Gq7BT4kYVLmwsHlIceDHOFUbiI1u8QIeCRsyNV1fjw8ojgoixOT2q+sheqhronwGEawZ
         XqmA==
X-Gm-Message-State: AOAM53291LULDmQg6KYl8e0wOH6LVH0gmAc5tm3O4Uahu8hAGtQJS+z2
        ZyWRwuA+G11Zz82Zx4hoipMab0s1NAuDrzFlXTJ/lndwHD6KvT+N7Niq8o/40PdDs9ji5rCL8yT
        4R84yyXPUuWvL5Uxfny2MmDIr
X-Received: by 2002:adf:e944:: with SMTP id m4mr31306998wrn.252.1593684002178;
        Thu, 02 Jul 2020 03:00:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjF1T2RFbxeupQGAY5r4yBNcdmIMapo8hnGDc8X2vrztxm8jq9q1paGT9KEjR1Ip758lCwhw==
X-Received: by 2002:adf:e944:: with SMTP id m4mr31306970wrn.252.1593684001938;
        Thu, 02 Jul 2020 03:00:01 -0700 (PDT)
Received: from localhost.localdomain ([151.29.8.241])
        by smtp.gmail.com with ESMTPSA id o29sm11129215wra.5.2020.07.02.03.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:00:01 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:59:59 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
Message-ID: <20200702095959.GG9670@localhost.localdomain>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-2-frederic@kernel.org>
 <20200701163504.GD9670@localhost.localdomain>
 <20200701232045.GA17670@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701232045.GA17670@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/20 01:20, Frederic Weisbecker wrote:
> On Wed, Jul 01, 2020 at 06:35:04PM +0200, Juri Lelli wrote:
> > Guess you might be faster to understand what I'm missing. :-)
> 
> So, did you port only this patch or the whole set in order to
> trigger this?
> 
> If it was the whole set, can you try this patch alone?

Whole set. And I can't reproduce if I try with this patch alone.

