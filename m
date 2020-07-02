Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E5E2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMI02/fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgGBGgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGBGgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:36:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464FBC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:36:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so26653348wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SOKqOe4L7TMyuElLZWsmgBtZwav1eGG59T+nolvpwkw=;
        b=JMI02/fsxLotFjWL3uyt16s/4THlU6WMPFpX9H+6IutigtdGcrj61TQkOSgyiMnw0S
         E0wnZ0QEw76P44VUBFbG54XMGl5uGaAHCPNdExh2A55yMxwzS4B36pxJ8VrALTiKhqCW
         UP68v0FdCJ1BmksGnpC3eXPDwixeWOuSKJ+86jibdJsrutXrN9DKNps0ODWYiU9MTlHL
         ip29cO94djYVghdW6MelQHt7HM6D+oT3AbdPqcpTiOGzCRG+z5dG//y+YWxBQgkMCi3q
         wcNtMJS+gBi4bsVuXSze5YmHsJGKbs9AQLAABBIwHh9zamrZQ87lpriGh45J+91287M3
         +ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SOKqOe4L7TMyuElLZWsmgBtZwav1eGG59T+nolvpwkw=;
        b=CRokZZ32c3EmHqweOYu5BLk8PYj6Y73Yc6PgMl/o4HRdSWxTWKF2TUFH/9VDui3mG2
         thGJyhT811SHNV2CW8WjNYKRsbV0gbzhUJt3qzRWFOSON7mREGzXiuJDsFQE7f0vvy/u
         5ybJ7fZ1gDBOkaO9wAHW3f2PuBFQgXwKrHVE+ie+lzWgF0BvUt5rvoHOOwEey5bb/pYX
         Y/ap7mQ2ajETI/7iNVPQGi70ImJzuhrETydUf9pfOPDcWVxCzMG2Ff3edKrdXvv7QYnX
         8Wpb58TlzKonTH4+g0HqVdoo6cGsSEbR0Vkc8lHtj03hDp+dR/OgX2N2alJpOB43y7y/
         tOrQ==
X-Gm-Message-State: AOAM530mUT3yXTjbKCIm+ODt8bFE9ChyMsj1vaTi6/74cmcgRV6YSqYl
        wz1m8Bp7BSWF9gple/bdriuGPA==
X-Google-Smtp-Source: ABdhPJxnBWWH4RISuQvb3jhaqkaVlD9sZGwI4WlnfQJngaPXvUWW/LS69/28os21aHQO2hXiHny4pg==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr29641330wrm.169.1593671802062;
        Wed, 01 Jul 2020 23:36:42 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u186sm9670755wmu.10.2020.07.01.23.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 23:36:41 -0700 (PDT)
Date:   Thu, 2 Jul 2020 07:36:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 02/10] mfd: mfd-core: Complete kerneldoc header for
 devm_mfd_add_devices()
Message-ID: <20200702063640.GN1179328@dell>
References: <20200625064619.2775707-3-lee.jones@linaro.org>
 <20200701193313.81C9F20760@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701193313.81C9F20760@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020, Sasha Levin wrote:

> Hi
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.7.6, v5.4.49, v4.19.130, v4.14.186, v4.9.228, v4.4.228.
> 
> v5.7.6: Build OK!
> v5.4.49: Build OK!
> v4.19.130: Build OK!
> v4.14.186: Build OK!
> v4.9.228: Build OK!
> v4.4.228: Failed to apply! Possible dependencies:
>     a8f447be8056d ("mfd: Add resource managed APIs for mfd_add_devices")
> 
> 
> NOTE: The patch will not be queued to stable trees until it is upstream.
> 
> How should we proceed with this patch?

Please drop it.

Greg indicated that these should not be bound for Stable.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
