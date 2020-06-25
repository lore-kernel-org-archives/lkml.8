Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7723CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4924020702
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l92CtjAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405176AbgFYNkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404987AbgFYNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:40:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC64C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:40:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so5620399wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KPWXGDbVQkcDm1gGHkW48BVFm+ibUkH1wIn5/D/7Wjw=;
        b=l92CtjAeRejXi4p9e8J1taigZfp2hQA/FKh+fglRAsnmePoIJhKVKbiiHMRp7jpz4w
         +35mUyqjtiWC7qhChsQw1Aios1TudPBym8FQ5YspoDiYzoR4mwqeRukFJN8gfoE7w/pz
         LM6s9sCSSxWqxru9bI3ysv19/aIDITs+Z9ZEsR1BvJUAQVmt8naO0PZm2PzT/tm+tH1u
         pc7CKw7yYQSqnoAGRAG2y3+EYyvkWxrj/JKgtFS1fiGZqwgnWL6H2wzClsnlGqMcUaYS
         sxygTIpFQ1qRNRvmb2ONuSS6eXWuMFxvuVy0X8ZozoEFlaU/izN+pnlJSt+ZAvinRMmK
         AC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KPWXGDbVQkcDm1gGHkW48BVFm+ibUkH1wIn5/D/7Wjw=;
        b=EgctyFPHlp/z2b1BGtngqaHdWalsNutkJVaueG4VhLtV0d53Y741Rf1bFpBoUeOGJs
         p5JWWpijIBqOsPDTBi97GRpHG1kwfBmhxFO6gVZpUM4jiUtlQ3g0XybkghVUISRAjnyq
         daw+ZA+g87+isPQU5o/VmtZgmWWCs4z1RsIU8143E1E2WYeG1OOM8gkYub4vOBpFTHnP
         2zG9QAcs4kJPOIoFgJvzXTIXBWf/mWHUH+ay4EVk6lYmTqXD93/epL8/sanxT73DZYf+
         9N1S1wur5+F8OdYS4tP/XvqkHUL/lC2aYbiBNpjvfBDYLt+e7x6hTFcKV0KMUePrsdxU
         rTGg==
X-Gm-Message-State: AOAM533B+jXkl4BH1BGypkH3TnP+tQN+wITwMHFGKTnpX5MFIpC+l0u5
        Sawt+H6hxI8ck/ShG0O+kHtT/gy5lGc=
X-Google-Smtp-Source: ABdhPJwbt3oGnIvJg+7dsWBfkM+Sv08Ufbpvz0SvKOt0mmUORc2CbQ0bpG+HQRPUwtyXsZaxmYGgVg==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr3379927wmb.122.1593092419322;
        Thu, 25 Jun 2020 06:40:19 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id y17sm32972273wrd.58.2020.06.25.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:40:18 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:40:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Tiger Lake PCH-H PCI IDs
Message-ID: <20200625134017.GR954398@dell>
References: <20200625131036.43953-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625131036.43953-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Andy Shevchenko wrote:

> Intel Tiger Lake PCH-H has the same LPSS than Intel Broxton.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
