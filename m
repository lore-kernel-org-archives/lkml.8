Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3B4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA37206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+faLBac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGYNaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 09:30:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727079AbgGYNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 09:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595683800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4a6saAc2T3vjUNyvSZ0iHlnUkwh1tHjNnDE13PD7ChM=;
        b=i+faLBacDoKVWx6sO3TeDJILullgCVbJDAXnu5m53GO+sPXH1I2FGaHavYjOhKBeoiai3f
        IdB+A5dSX6BjeDLMUq667O+rBDEaynKIoVAKC1h0t3YE2OqxWzFaO1qm5n7FCGDZ0AGoY0
        65cz5jq/nIGJ/lUC1aXqMzBR2ptsV5U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-H0lpa2_hO-O3lU6DqwmKzg-1; Sat, 25 Jul 2020 09:29:58 -0400
X-MC-Unique: H0lpa2_hO-O3lU6DqwmKzg-1
Received: by mail-qv1-f71.google.com with SMTP id j8so5327212qvu.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 06:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4a6saAc2T3vjUNyvSZ0iHlnUkwh1tHjNnDE13PD7ChM=;
        b=UlqZ70kQs5dhZIeXApGQ8kysEfqXtLZciT9SJxNUHdGymEzADbcSceiqZVMu4/Q+qK
         d8IZqGdFN42uw2C4z8kYsaHwsS3UVvh4TtEH9LvKdf3SWEmou+7bZ0yWbBgSRpPNl1ej
         MwUkiTPcOewvzxI+XIIhta+VEvZl6JzwDzB09tNUA2eCS0rTXpMrNknVjYB0tb2Uwqq3
         Mu6d7wY8sCfPQg1mh5foC5xkpQGbcvHFgiCq6jH1J6BM16UWR8RtJVuYvQ2kGIjIYDpH
         NTvEg5Nanbz1NBL0oMQVO1B8ljdX10r2rekc4kDlwmNNA2aA2NO4pAP3wvWp5dwmLzBC
         4tfg==
X-Gm-Message-State: AOAM532+lAbebYHIIA/vy7pl8nLiSGIpV721flo5g2LA7NEokyqUau1J
        tNGVtRcrEhBHzbjqYISMoDcVnePD2DtaT8tZhsUqc/ozG4S2tIk8mtPJK30ZSaLXn40/KxiyVXU
        5m81Jt4Hj6jSXqkX3xcV9rpda
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr14744085qve.66.1595683797896;
        Sat, 25 Jul 2020 06:29:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFmYa5HHP7PA+v6Ib9cPmMuTsmOO7MWKjGaDcNQrgAMIyuuqm+P8ouhyOp8outxf748BBVOQ==
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr14744068qve.66.1595683797671;
        Sat, 25 Jul 2020 06:29:57 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 65sm6287845qkn.103.2020.07.25.06.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 06:29:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] fpga: dfl: change data type of feature id to u16
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
Date:   Sat, 25 Jul 2020 06:29:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be good if the variable or element for the feature id had a consistent name.


> @@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
>   * @id: unique dfl private feature id.
>   */
>  struct dfl_feature_id {
> -	u64 id;
> +	u16 id;
>  };

Is this structure needed ?

Here is how it could be changed to 

struct dfl_feature_driver {

-    const dfl_feature_id *

+    const u16 *id_table;

...

Tom


>  
>  /**
> @@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
>   */
>  struct dfl_feature {
>  	struct platform_device *dev;
> -	u64 id;
> +	u16 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -371,7 +371,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
>  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
>  
>  static inline
> -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> +struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>  	struct dfl_feature *feature;
> @@ -384,7 +384,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
>  }
>  
>  static inline
> -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> +void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
>  
> @@ -395,7 +395,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
>  	return NULL;
>  }
>  
> -static inline bool is_dfl_feature_present(struct device *dev, u64 id)
> +static inline bool is_dfl_feature_present(struct device *dev, u16 id)
>  {
>  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
>  }

