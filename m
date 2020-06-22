Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F51C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7F20707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uU1JG+eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgFVQxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgFVQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:53:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E105C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:53:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so255738wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=th3lOsqDiHTH7KvlF9nPRZ/8Hlg8cxvCjLNOEG5r3bs=;
        b=uU1JG+eR6ofMtuoeMIi/sf0qt8/r0mBgInTU0iC8ITHEYCEERu2/q9EBHvKhJbQloP
         49FNfT2YYnKkQ8ZH1s0MPZh1F2jI3Is/YciZfujF7PvXd3CxzK1sP01LwBxraZ6py3cb
         kPl/t164CPCS7kUsBMbB3okFfUD+at8msoQ2wPOtXlGmwPlV5hdMhrfaHxGHQKZ27GnX
         tJUMUNszS1Ilh7YM5jO6d/fmpcBLogLNDiNv0kQ9vKrkys3NXX8E0mwbVzvDQXItk+pw
         aXCT5dYUDlqfmMclsEuj8aRMdXxqhHZfbShHpv48N8PQpaczV667N3VnVsvH8yGt9Ma8
         3wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=th3lOsqDiHTH7KvlF9nPRZ/8Hlg8cxvCjLNOEG5r3bs=;
        b=nIdqqjawmJPCl+kAF3n42b8W2Sf4zwtqm7sMxzSuqpBNywsDA2/j4ytlXEzssthIOw
         yBDIv2MjatcFEaRNrdDdQJYurxKF+3tCJ9ucmpa/n28vvVZQw6ZCREXSHLvk2W+FD1PO
         T36SzPKXcP+W9c1UoTAWcYuUTEipkMkzOejfVS0z3TU2SGjJ5kFYGLaF4mvoZDjUs0o9
         /LVO9lZ1wiVzVHrkHxEw/LcOC01lxwe2wtI450pd6DY6g0M9DKSogjOChxKBNbEeSQ/Y
         0pnzURnmXQou+rnDm4H47LCEBF4ZPwchEzZB3kGNqtVllcCUVZUhuFbHLkS3Rygj7NlS
         Z0bw==
X-Gm-Message-State: AOAM5339ymSbGH2S/wzX8mXnBdcY+Pm6M2lPIJZ4r50NJRUwfphhickr
        DpYh2CJ1VZp3eMMIeA+HA9Xnqg==
X-Google-Smtp-Source: ABdhPJxwa0Ioz5FfzQXXRp6pE0iPbXc1PmYUIeyfWbTDyhfVioMLjm8JsSgGCV+8f8yDwG4bwN2E9A==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr19134419wmi.58.1592844801763;
        Mon, 22 Jun 2020 09:53:21 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x14sm18737824wrt.60.2020.06.22.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:53:21 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:53:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200622165319.GX954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <20200622080913.GO954398@dell>
 <3aa3c8ad-4e6a-9b9b-be58-bd9da5a0fb0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aa3c8ad-4e6a-9b9b-be58-bd9da5a0fb0a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020, Frank Rowand wrote:

> On 2020-06-22 03:09, Lee Jones wrote:
> > On Thu, 11 Jun 2020, Lee Jones wrote:
> > 
> >> Currently, when a child platform device (sometimes referred to as a
> >> sub-device) is registered via the Multi-Functional Device (MFD) API,
> >> the framework attempts to match the newly registered platform device
> >> with its associated Device Tree (OF) node.  Until now, the device has
> >> been allocated the first node found with an identical OF compatible
> >> string.  Unfortunately, if there are, say for example '3' devices
> >> which are to be handled by the same driver and therefore have the same
> >> compatible string, each of them will be allocated a pointer to the
> >> *first* node.
> > 
> > Any more reviews/comments before I apply this?
> > 
> 
> Yes, outstanding issues, so please do not apply.
> 
> Shortly after you sent this email, you sent a reply to one of my
> earlier emails in this thread.  I have replied to that email,
> so we still have an ongoing conversation where we are trying
> to resolve my understanding of the problem and whether the
> solution is appropriate.

Happy to discuss whatever issues you're having.

Looks like the ball is in your court. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
