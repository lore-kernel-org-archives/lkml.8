Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E1CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FE62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NL8BwwnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgIHJQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbgIHJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:16:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD250C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 02:16:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so18247687wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ud5eXq/f7ttiKCnOrCMmEKLBqeYjRnDX92wx0r+MsTE=;
        b=NL8BwwnZ1WalmVarCNmHCHmi2Z2GxeNt502RD2Grxx5Q8hCZYqpCkDDGZRhPCvBLcQ
         alyouZXhFLTlyB45gRH5ouzXxEy4siKvIzUdYc4wxigA+G7X9jDQyB+QoPzJvfSvPgeH
         mUjkfKiGBxhdxtcm4yeH7vxaxB7POtkObrcenqu0Yl/DfIfkFDWmTRNTApASEjzfAEF+
         miXaAmeRuwJQTC440wW3f5z3WfdDDXhYtnKWGFqV0Jw06RZsM2JNSkXgKS9pCs/Ic/xi
         6WPqlsmrDm2s9T9jkIr0bb724V36LfawAluCJ1hhXUAlbRMNbf5rTcwfNMLaMyWV0TPp
         bIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ud5eXq/f7ttiKCnOrCMmEKLBqeYjRnDX92wx0r+MsTE=;
        b=aO/xS8OLBapIjlVRsL8DKE1jtW6/eUKhZeV/Ktdo5zaUfAeRYNfC9F3R3C/FLbUDOu
         ORsZXXbcn9oF8OnmrkG5EJsnfrEuV8mqlgYAiqVmV1ZD+tvw2TiQdo173KI6b1vsrMVS
         0ht5KtZao3QjJjETntzkdHGt/ABA7IGm9olzhTMVO1Wg34cMh5K3ksVcN3S5U6413PVO
         bwyA/KLVY8aOFjJyVrZJkYQCZzL9PZ+en7Q1J3We30+Ccdvvl3ghkXBZfds2P6/n64fM
         2IYnilYoKk5uAne2opBhtvc8LTJtrD8A5gnndXcNA8NvAV5b0tCMv+lpdPgyLYCv6c6a
         cTLw==
X-Gm-Message-State: AOAM530KDidvKBa/M2B+EtwGk3Ztf0uupm3wBe/LFHBWFZdMcz1m2LGZ
        HIsH8mQxbldlQrYUBUd6xl/W+w==
X-Google-Smtp-Source: ABdhPJz4hMxCQOLcaNeIRFj4Tclw30RvSRCtXms6QHrOZSDB7iZvBDH454Qu/p0DHakAosfVDNEPow==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr27312113wrx.164.1599556607196;
        Tue, 08 Sep 2020 02:16:47 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id h6sm30427645wmb.22.2020.09.08.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 02:16:46 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:16:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH] mailbox: sti: fix struct description warnings
Message-ID: <20200908091644.GK4400@dell>
References: <20200831165201.23832-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200831165201.23832-1-avolmat@me.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020, Alain Volmat wrote:

> Fix formating of struct description to avoid warning highlighted
> by W=1 compilation.
> 
> Fixes: 9ef4546cbd7e ("mailbox: Add support for ST's Mailbox IP")

Please remove this tag.

This patch is not a Stable candidate.

> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  drivers/mailbox/mailbox-sti.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
> index 2baf69a0b81c..0f2bc09c364d 100644
> --- a/drivers/mailbox/mailbox-sti.c
> +++ b/drivers/mailbox/mailbox-sti.c
> @@ -36,7 +36,7 @@
>  #define MBOX_BASE(mdev, inst)   ((mdev)->base + ((inst) * 4))
>  
>  /**
> - * STi Mailbox device data
> + * struct sti_mbox_device - STi Mailbox device data
>   *
>   * An IP Mailbox is currently composed of 4 instances
>   * Each instance is currently composed of 32 channels
> @@ -60,7 +60,7 @@ struct sti_mbox_device {
>  };
>  
>  /**
> - * STi Mailbox platform specific configuration
> + * struct sti_mbox_pdata - STi Mailbox platform specific configuration
>   *
>   * @num_inst:	Maximum number of instances in one HW Mailbox
>   * @num_chan:	Maximum number of channel per instance
> @@ -71,7 +71,7 @@ struct sti_mbox_pdata {
>  };
>  
>  /**
> - * STi Mailbox allocated channel information
> + * struct sti_channel - STi Mailbox allocated channel information
>   *
>   * @mdev:	Pointer to parent Mailbox device
>   * @instance:	Instance number channel resides in

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
