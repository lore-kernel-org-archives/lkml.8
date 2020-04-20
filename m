Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE51C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9636F206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bc3Vkmcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgDTQRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbgDTQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:17:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C3C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:17:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so12894786wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lPlsXqCGHYagVYmxec3j/xxnK3oND8ckDanm4J5g6+s=;
        b=Bc3VkmccqsOZmy8SzqwTXHtw4ju1n3q+E8tqpZL08g24yfYOc29x2qPJOm5bPv7VMv
         IEz+3ozJmMWTBd04ErA+L4wk/0PjyHp2gejrFY5Hp1yD2/uez5UT5BiJtnb2iaKP2/vs
         SMSQ9qo0pSxEIrRcKZjgoiC7AmF9J9UhdaxfOXmCw9U+Z7w4klykH6tQCy/7+4as4UVZ
         6dwxlkXGI1NYgtaY7Zu976/NOzffZXZNDeuwtcNtImP4kZT+274B4qypkT0Y1nH8llDD
         JsBWFcA+GtHbhUA2Dcnw5yiEJEg8239BHg+veY10eVi55Nn6heaw7SXMjo2wxSsUe+mj
         guyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPlsXqCGHYagVYmxec3j/xxnK3oND8ckDanm4J5g6+s=;
        b=hF11qNYGfnWI1TrisbYrHb1f5oNrXuXXAN20INP+66fAydemluMMPlAq3ByBv8nbW+
         0gbpI/Td0crDCKoUS1vCwyyvir3qNFJVyr8iJ//Bbx3SqWKWgfPAYGBJFK3JRXsIMzgU
         4ikO0yxOtdrGFo4hTN0UX+I4LiP0GeUNQZaswX14Xoe+Ja8srSVZrD3i4MN/BbPQ3jVy
         5PYRK1uhvP9nm1y7mNnxHhNKCcX1wUG8cQdoiIsG+Zz0tnn8GaVVt0C3Bj2A8piXhUe3
         8YV53BJMHuSb+GXXHKoCzLe/sItl3CyusK/l9M8bVgTtLLrVOP7/Sc/iq2pC0B6SpOUM
         ATqA==
X-Gm-Message-State: AGi0PuZr+6ZkvFhrhRJiAFVZaRqw/ERK01U1uJbtTzz6w76oSPg4nytX
        zvskDt1x74wkToCGwbA6rEsDLA==
X-Google-Smtp-Source: APiQypKrkeOBy7c9A/9ySH8hmTQpSPXDqk6tEE5oq0yFe5+sxi9L2pzoxp9Luyj6lNrqui3ig6qFsw==
X-Received: by 2002:adf:800e:: with SMTP id 14mr18882781wrk.369.1587399443572;
        Mon, 20 Apr 2020 09:17:23 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s9sm1946164wrg.27.2020.04.20.09.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:17:22 -0700 (PDT)
Date:   Mon, 20 Apr 2020 17:17:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH V5 2/4] backlight: qcom-wled: Add callback functions
Message-ID: <20200420161720.cuxponga4vxitrwi@holly.lan>
References: <1586274430-28402-1-git-send-email-kgunda@codeaurora.org>
 <1586274430-28402-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586274430-28402-3-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:17:08PM +0530, Kiran Gunda wrote:
> Add wled_cabc_config, wled_sync_toggle, wled_ovp_fault_status
> and wled_ovp_delay and wled_auto_detection_required callback
> functions to prepare the driver for adding WLED5 support.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
