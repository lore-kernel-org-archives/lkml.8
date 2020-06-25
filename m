Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1641E20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIJvDCK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406168AbgFYSnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgFYSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:43:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2685C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:43:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so6920801wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=okeCMJMAf5i5ORVYX06tV8pNa1ecla2GMYVNKIrW6Y0=;
        b=xIJvDCK8GjQrMT/UOE+S1I7giNiOrPpSS7M92GJStBOfj/MmOEmlWBfXjawfjqDdU8
         JjrslXzxzoe2EZuiEH/dA+prZEkwTh+HZfWIHJN6SvxdfLQci1Y1qcRJPr0iqACEC5BT
         vTHBIHxC+kvIaNS1a4jHawsxj2JbUjxnCgf8YlpEs/E1SXRf9kUZHfC3oEzYNOBkBb1m
         03E3ahwOiCqdNx5imqwylKUm1vS8RCQQWMCZYoYJ51GsVBhwqq5KfhjhIuTZji6e8Eyp
         JCdTpfzXNhcV04eJNoMHFs2xQMiHs+zOXl1ZaZvoNtOmqZ0GZu96RtFwW1Pow6MBaWYX
         iz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=okeCMJMAf5i5ORVYX06tV8pNa1ecla2GMYVNKIrW6Y0=;
        b=rBJWrhInqDVsaDDW7jUheRZTREP+gnbNJKdALi25Xyad98gftF6s726L6VG9cQBF7H
         HQCPcLQD/zCv6uckz+TKeiM3cQIkQdCA4fHNtfi4UdQ3LEqdljktY2RvM3Cc5trhdxVI
         Lm48mwx8Ao1V2+P6f4xDrbofYJ8ktcP9KmjNzebl6qQXddVuubOL/MBhvkgLrmz5lIUX
         OZ0A8xdJt8hHtNsdj0NttiCoJjgeso7JqynyHc8DkW14nD3VQRFdeMUeKcpC8HO5VvGn
         SlyJMNp7+StKaW+xO2GZcZrm7wOoP7cp0wS5PR8c34+huHbj+4txwAXo0O84ueOhuggo
         0lrg==
X-Gm-Message-State: AOAM532ls7mWeCLDU2uRkv8T0WAhZ4w+OKlMivG9ND2RyhoOSYXyvw91
        kezKy2VpDAJtg6GTWrDes/XbprxY6zM=
X-Google-Smtp-Source: ABdhPJwWsc9NbSQa7POTH3p18880PvT9PYafSzxoGwbfReyl1fQT7OABqG3cUNCRtHc+walAXOZf+g==
X-Received: by 2002:adf:8b50:: with SMTP id v16mr34995933wra.188.1593110598735;
        Thu, 25 Jun 2020 11:43:18 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l1sm34576828wrb.31.2020.06.25.11.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 11:43:18 -0700 (PDT)
Date:   Thu, 25 Jun 2020 19:43:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] regulator: da9063-regulator: Fix .suspend
 'initialized field overwritten' warnings
Message-ID: <20200625184316.GW954398@dell>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
 <20200625163614.4001403-10-lee.jones@linaro.org>
 <20200625174423.GF5686@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625174423.GF5686@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Mark Brown wrote:

> On Thu, Jun 25, 2020 at 05:36:13PM +0100, Lee Jones wrote:
> > Looks as though 9f75ce666199 ("regulator: da9063: fix suspend") failed
> 
> $ git show 9f75ce666199
> fatal: ambiguous argument '9f75ce666199': unknown revision or path not in the working tree.
> 
> You should probably CC this to the authors of that commit - a similar
> thing applies to several of the other patches here.  You probably don't
> want to CC everyone on everything but OTOH there isn't really any need
> for things to be bundled up in a series anyway.

Sounds fair.  Will Cc important people on individual patches.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
