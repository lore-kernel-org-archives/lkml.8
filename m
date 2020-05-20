Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFF207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm+g9qu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETKui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:50:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B706C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:50:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so2377137wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8Oq4CuyGODMZalNGbQihwsuOFCJQY7iyN6Q8vmNMuCI=;
        b=Wm+g9qu7mMMbm4AI3CPwBPlG+M+XtRWGu5AulK7aoqvOnn3N+ir6cBZ0Lk+cE+Z7yg
         4CA/kaXo5YKCqANp8F31LBq6XoH/vcuFUhY8UjSZtv1H8U7o6Q3PzkgNK+HSLargmNZm
         Y6ib1tGvIbVbyBVskkLvv0FgAkPq8AxEFsEViutCS2xNyMCiRR9MFCB9kopTWDDrlMIB
         hz3cDhhchfZQqqYyxZx9pLRpIdg/QDQJQhtAh/Zsb3yXK3WjbILAvX/mtBridNiVCwMU
         wgycbl9T04ThmYPoLeFUYqeYGihYSvfENojqP9X3bdjYZFUU/xZ0tL1jwjl/haHdllj1
         b/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8Oq4CuyGODMZalNGbQihwsuOFCJQY7iyN6Q8vmNMuCI=;
        b=O5NY27nnKvHf5PIOXb2GHyTiVb9E5hL0QD/jT5xtrIu3eBek2/yPxcy3DDJv65Soup
         6bkOZpiBOge0DkxyP7xa0ATkH4tqI9fjT/BrXTmhyHAHu34jeQTcvGNTkj4XMt7Na+j3
         poX7FVjf1qPRzABIAz7qPp8oyAbYjrNV3Sq6hDnnBZ6UG43CVj5GnII2CqVtz9L/t37z
         cgIJH8JAWIX0KfuioyF2uelack2Z9+4fFCgjnFb5cD1GPRm/LkY22F8qA2GyW+lBDbU5
         cUJ/lb1gqe9XN1Iqe2qolF601eLwcaRj7HO888kkFkBpMw8uH2Ctm2KsDdmtYwoA03SJ
         Ik9Q==
X-Gm-Message-State: AOAM532h+m5bKy4ITPhLt1GEEwxD2e5aVjoE2Auj21xr5hTlfqHC4xFJ
        FQKrPSStju3CkgsgWr9LU6jVOK0d6Uk=
X-Google-Smtp-Source: ABdhPJwhfeJVhdpUeV/21/Kaw8o1Dkx0tThqzQfh5suqHabh/uTfBwWVUYVFOu2vB3oqECpfqLLlVQ==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr4350650wmj.40.1589971835371;
        Wed, 20 May 2020 03:50:35 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id j4sm641266wrx.24.2020.05.20.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 03:50:34 -0700 (PDT)
Date:   Wed, 20 May 2020 11:50:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: constify properties in mfd_cell
Message-ID: <20200520105033.GK271301@dell>
References: <20200516110609.22013-1-tomas.winkler@intel.com>
 <20200516110609.22013-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200516110609.22013-2-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020, Tomas Winkler wrote:

> Constify 'struct property_entry *properties' in
> mfd_cell It is always passed
> around as a pointer const struct.

Apart from the odd commit log formatting ...

> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  include/linux/mfd/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

... patch seems fine.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
