Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0899C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A96B2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ent9lxsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHSILe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgHSIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:11:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3F8C061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:11:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so20588299wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RW+DAA6feyP/FiHoBpI4e2XS7e1awJ4EyauOZLhTca0=;
        b=ent9lxsgR8B25Us1IxxrVoCxUZkujlohpoSFC35rQ5YqhG+sVG52IQm65m2uJyjHdK
         qOpJ/EtShKh8zp3DurcTKs/t03tAt65pQP6U98Sq3tn/AwOEN40ilzWofb2ANh3vXhNC
         Xm58+jUsXFJ5f8AfmQGkaKvkguqtHx+3aicTgS8B1P218+UovGqHC0VqKHGutsj0pBAQ
         ek8KeEtaudqryCXg1ZnIUDUJvmt0IQH1z6oIEa/k8O0Wmb0+otzrdCBKEK2LflqPnUWP
         B4BUxp1SVecYHfqRi3SuQo3i6Yk/hRha8kaMQCecq46eUhJgtt/9kx3foJdTLwgSDHuU
         faLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RW+DAA6feyP/FiHoBpI4e2XS7e1awJ4EyauOZLhTca0=;
        b=Ok51ySYJwYxXlYMf7gGEUhjz4QuwD2Ur/NL3BIIveB5rkjeJN4g6kHVMNlLpiG+mEe
         4cmTVYVdMatcuKF2L0TrDtuDwHP2U4JHLG7MPW6DZV0E/BSs9NxdrpBpUjqBUodYO4/F
         qgBlToB7iMOHrVS5iXsaivWZBhXO0Gc8IzpQekgSLF6gEMIPpaI2s6WXz5nYJBkTGG2+
         kNzc/t7+ey0iuUqypBNDWYorgw5XKb6f2kuq6KuZCK5UJfROGDnC8zspgKj3UpeW8Ve2
         Xc/kolyN3K/fJKDXayAfj7r3LSJSylJ70aN0HNTdSFpvReDN1f0Y4ml3AyzrIFo8bh5x
         w+og==
X-Gm-Message-State: AOAM530KTxu0+bwr0eJAGj6TYqk/VHJGs/CnVYtZRcwvzHpjXsocn8x0
        5ESX8XLkx6hjCrNKC0/xwP/ZINYyVoP0Sg==
X-Google-Smtp-Source: ABdhPJyGdL/sFSIVJskE89ixIODXNR42VHxIMZaaOc18/vGEAYbnYCF6tYdHVzE89lifDbZPksBwwg==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr23384750wrq.11.1597824685187;
        Wed, 19 Aug 2020 01:11:25 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id z8sm3498020wmf.10.2020.08.19.01.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 01:11:24 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:11:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Fix handle of OF disabled MFD cells
Message-ID: <20200819081122.GB4354@dell>
References: <20200801070130.3323112-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200801070130.3323112-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Aug 2020, Icenowy Zheng wrote:

> When rewriting the OF match code of MFD core, addition of cells disabled
> in OF will result in a failure with error -ENODEV. This is an unexpected
> behavior, as the previous behavior is silently ignore the cell. On
> SBCs with AXP20x PMICs, this leads to boot failure if AXP20x PMIC
> support is built-in and some cells (especially power supply ones) are
> disabled.

Thanks for reporting this.

Do you mind if I fix this another way?  I plan to reinstate the old
code that was removed as part of the offending patch.  I will of
course add your Reported-by tag.

> Silently ignore the cell when -ENODEV occurs.
> 
> Fixes: e49aa9a9bd22 ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/mfd/mfd-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index c3ef58a802bee..31b363c64f4b4 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -215,8 +215,13 @@ static int mfd_add_device(struct device *parent, int id,
>  				ret = mfd_match_of_node_to_dev(pdev, np, cell);
>  				if (ret == -EAGAIN)
>  					continue;
> -				if (ret)
> +				if (ret) {
> +					if (ret == -ENODEV) {
> +						/* Ignore disabled devices error free */
> +						ret = 0;
> +					}
>  					goto fail_alias;
> +				}
>  
>  				break;
>  			}

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
