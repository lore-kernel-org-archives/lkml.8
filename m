Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CB1C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C29C205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0e1sqnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgG0LKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgG0LKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:10:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:10:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so14439442wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4QlGeWxo0Xv8FxeXIA+s7ap15MeXV/R9+qJZyp1gslE=;
        b=a0e1sqnjEvJJORN4Xt4p1chaxgO+8UTCbaEZtPivfyVTRm/BD2AtWWyrbAjhsb0is7
         jIZnBzh2A1JG99q/LTWvmgg1ODeedNoZsi84jGOu/I/2x+N7hINg2ZifvhO65QL5kSdv
         IidVugE6wafCJwvTp4qjX14ZtqeQIauED5daNKf2W6H0p/zNTiJGXxYH7zRc7ZzxQI3c
         t5olUi+mCkxi3XK4FTPWRd7vZFVCdoDPj34l2ANcAdPILsdkSREawsvk1dyG1iKAD+o/
         BScu2NjSPMTJf/4XHkNnjetgo8JZpXi9yvwIdFw7CPD1utz5GUD6255ef7i57sovUTxp
         DjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4QlGeWxo0Xv8FxeXIA+s7ap15MeXV/R9+qJZyp1gslE=;
        b=rf8VAMA8Ybi8QaHBUrBWkFIqqn0MIm7rkGtD25pOupJnzCNZTlS6+fsx12AJf4bdxO
         dsExMefpzX61e7XnQ8oHP6oOdolQA2nIhm0SxxSbPUvt4x2WfGMmbSBjpQznfYzlmSx7
         BJgTbe1QK/Po7V2FC24zo8lBjH1NMeEPMwOhD/vniRmMNkBfUWh7jr6lFaBuQ4EdLxMa
         dOjTzJPcLPUhjxgvtNITXUcqIsSMyQQo/bCrKZ3TBHc5pgC1aO0j4JJHn6FXQGyETsvK
         i0E8UVbxo0O6Mm1mGPGwTsMvkB42GEuIt6TTfQDoKdeoP1ZlYb5BW9AZiPwi9P++QWBO
         yQkQ==
X-Gm-Message-State: AOAM533QxHhHm/KdyIdkbBXw1Kjh8Ax06r6rVd8pr6AOmgyLbEBgZOFV
        /8V7sGdNMj5gy6AezSmiLR3cnA==
X-Google-Smtp-Source: ABdhPJwZjwfADIDphEzPbM6Si87VVr3zoeXBhJhW9mBSSpU58kEItPZXRD4ItNtxV8lX2P5ghRqvxA==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr22122029wrn.60.1595848201221;
        Mon, 27 Jul 2020 04:10:01 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id 130sm13039446wme.26.2020.07.27.04.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:10:00 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:09:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 2/9] mfd: mt6360: Remove redundant brackets around raw
 numbers
Message-ID: <20200727110958.GI1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-3-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-3-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Remove redundant brackets around raw numbers.

They're not doing any harm, but I guess it's okay.

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c  | 172 +++++++++----------
>  include/linux/mfd/mt6360.h | 410 ++++++++++++++++++++++-----------------------
>  2 files changed, 291 insertions(+), 291 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
