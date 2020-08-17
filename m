Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1521720738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1X/n6Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgHQIQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:16:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F275C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:16:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so14004600wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v0v5oAhK9ZVu7ovOwqOvE+wqvWkBm0oVu1Bsq+aOlJ8=;
        b=U1X/n6Y2nOB/AkHYnuRono0OIPa1lG/Ad9wHL9UMl7ZDeL7MlXjj0WQupSbF4F1Orr
         9KBe0QHHmSQKzSWv4rczHjO+sx+LUBChDEI00ECHcWZU99YOh25Uww+6sbhCw6gkv6pS
         HV/nSbSLOCEcuhojJ63oc3/H3cKQVBBC+VKsL5SkIEkusvRZ7C+V46DNqAzmUbaDIPYg
         a0Kq4xxPlX0ChcJ8w3voY6XCREmJUDZTyxZKS6f6wAdw7P9edycL4GBIBTodJiJPt0ZG
         /3QO2ipKPvvcnu1Twa6wtlu8PkCLb/RqVdylG3qmE065qvyqmKMnN/QzKkkgCSwpAwdy
         AOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v0v5oAhK9ZVu7ovOwqOvE+wqvWkBm0oVu1Bsq+aOlJ8=;
        b=NDwWxCtaCadc09k6g0RMKn6S/8f2vCUK1Jr78qPnnpggHr2fuRqDpPn1wAs20DbQaj
         gMPHnZzyolKLtze8L+xMY8F5Hqg01kjXfNmk8VvWOS2V56BsmsIBbl1hK0IWw6nqFg9M
         Kibyitt2IcjRXBKG1L+bYooOxqLxBz6x9Rrp5Pmdgj9GGRzcI53gZsJOAC9/mC6mkBmx
         HHJZaWCYK60nZFrRIW0Oz0i/T3QRnEorVnPESQDOlHejAGWJNewy8Z6MtzWJvIb2Ftu3
         ZgQEG1b5BICO2bLkKy8K04NUcmREmYHUcX9qLzYzocmk22H49IyVB6g3X82IjcVFan73
         BWeA==
X-Gm-Message-State: AOAM533BrzP6+q7hegVE3MESyGs19m10Hii/AjsZTmUm0HEIPACSZS3e
        v4lSoSJ9O76le8PQo+3e16XeUw==
X-Google-Smtp-Source: ABdhPJy/BLnuS3vaKXKzvZ3zU4W6SNGjZlok/pABOU9qDhMciYnLzr/yhSQSUi1OrOkOtS/Ig/+orw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr13989325wrn.110.1597652193175;
        Mon, 17 Aug 2020 01:16:33 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id p25sm28081510wma.39.2020.08.17.01.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:16:32 -0700 (PDT)
Date:   Mon, 17 Aug 2020 09:16:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/30] Rid W=1 warnings in Networking
Message-ID: <20200817081630.GR4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <87eeo88pdr.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eeo88pdr.fsf@tynnyri.adurom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020, Kalle Valo wrote:

> + linux-wireless
> 
> Lee Jones <lee.jones@linaro.org> writes:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> >
> > There are quite a few W=1 warnings in the Networking code.  My
> > plan is to work through all of them over the next few weeks.
> > Hopefully it won't be too long before drivers/net builds clean
> > with W=1 enabled.
> 
> In the future please send wireless patches in a separate patchset and cc
> linux-wireless. That way it's easier for me and Dave.

Oh, I see.  I didn't realise it was maintained as it's own entity.

Will keep the separate in the future, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
