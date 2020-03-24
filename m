Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC86C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F02720786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzPL8rmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCXK5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:57:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46261 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgCXK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:57:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so17421961wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DOA10CRKFJGu8b5wtBJ2yLDJfOkq/sBVSQmhdUC4ypY=;
        b=XzPL8rmmIVLxiwmtlWoRSXM0V5GpXguC00V1OiwP6D+VNJxQu2ndjNH1DMpUjS28PQ
         95d55nIqF92A5FJDVtQG8Jzb05LrNkZmBvwRk7n8ylcgjn2PXRej0umf85yg4FJtwRIf
         1d6lguSarwuUd5qHDfnSxccZHHNay6tDtznC6eX6gJLk7WG884AyXPo8Re0uFBwUCYRa
         EJvXYkjpEwuOQ+odcen6exRdljEbPs65kh1We93B8zHf7DKnQ9qYQGqCQip3Pr7KLhbt
         MOAHL7oolr6K4tZz9zakUdiOTZZ68VaGyLG81OjlfADYwnOzGldnrkt5IBYVDJai8PZR
         9zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DOA10CRKFJGu8b5wtBJ2yLDJfOkq/sBVSQmhdUC4ypY=;
        b=geLrjkO17iW3LelvGHqqivI5L4ZNd7Kbq85UGU4o0Oc2KqX4IIXHiUxVe6FX7SPs2S
         d+9Cdtu9t8J3b+og8sbDdF6moCVI6EbmzP2SqUXtVDnt5TbRVVPP2tYLXg/WyAAIYVed
         vEVHacZr9rWly7mWhV5a+zk4Y1vERUp4L8FNtb78gIZAJ3GviEyeEhCDCrJ0FBWBzPxX
         FyXcHCIcCWNJhPFQkSe/9/BvAgVvNgn4RaZEyWkBrQbegjtI/wIedCh8fEvfkMR/wxdS
         N1rYrbAJFJWfXaAWRL4huLPzOPUdPbkJCHmqklgnrZVHb0LcI6teKRBxucHivEMF/8YX
         MqLA==
X-Gm-Message-State: ANhLgQ1AxzcEHxC8Hwh3+6YlxtF8HZgNPLaTIR//HizI0SpC75FsE0nM
        QwiIX9njLTmv/NAI8a5XmAk4Pg==
X-Google-Smtp-Source: ADFU+vt2lLYB0Tgp6XRl+Nd0We086rBZL2iX6nYLI5T5X83Rf+H43VbfRkFbjVqQgqGMEydvpBiXPQ==
X-Received: by 2002:adf:ba48:: with SMTP id t8mr36017493wrg.329.1585047466432;
        Tue, 24 Mar 2020 03:57:46 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id c7sm17274309wrn.49.2020.03.24.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:57:45 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:58:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v7 7/7] mfd: rn5t618: cleanup i2c_device_id
Message-ID: <20200324105835.GJ5477@dell>
References: <20200320081105.12026-1-andreas@kemnade.info>
 <20200320081105.12026-8-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320081105.12026-8-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020, Andreas Kemnade wrote:

> That list was just empty, so it can be removed if .probe_new
> instead of .probe is used
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Functional independent from the other patches, but since they are
> touching similar areas, commit/merge conflicts would occur.
>  drivers/mfd/rn5t618.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
