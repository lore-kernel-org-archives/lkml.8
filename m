Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0971DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D30208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="T2UjdX/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGUEqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGUEqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:46:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D37C0619D6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:46:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so11349148pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZihfE8PdTkcmFog/NE9+3wOqDTSKN/yPTD5RUiTCo78=;
        b=T2UjdX/aBACNNI7AsLQjD7SodT7yMVIiZtg+gM7ReuX0a9g3/anzmj5Sy0T7rk7aTL
         TWJYwrxOPJ7WxwdJJ4Ez+FxDL++sED71D1PI+CaLd4FnofQovWaciZtcwQ07Ak9b+lCr
         e6jjHDCkxPu/Awzud68wB04RT50d/YR9p6cUTD0uV3IVxvF0dVp0L+JDS4hbcs8gVtLK
         uULi+DH4czQJlXGMesPcjetG+xIZZ2vl7/pK6qMquqOkqMNL+mu2W6QjGe70JjD0I97W
         qu+ZEyZ1I3D3Zhqhi3Py/gK3lk6vTVeWNA7OR44LLWz5O3oYVe50gTHzT3mEDLvCELCl
         9oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZihfE8PdTkcmFog/NE9+3wOqDTSKN/yPTD5RUiTCo78=;
        b=BZRtheih79/sUML1SPAzCaWzl/+f5OQOf/MPKy9pcS0+usYN3/N9rYvj0nmglbk1UA
         jg1Q8dUAaYRb/JjwsXC0FobN9LpT4cEMcG/9A+wJ0nxQexZJ9x3L/+SPQqDd6BwtqIRq
         UlG3K8DBB318zCnoeRTnV4cWnME8suWPAw6ny4A4xNBoOnbCkSHjsss0ER5wTWU9Unnh
         tqRg5EyAopT0s7CNqK0cuIaTcOzjhnJrBexJSilRjoWQAot47Hzlqh9/9BmP9c3A0yA5
         kU+J8TL6guoOqwtgquGSLThqBMbHLPnIwLTG526J8qbd/7w+bTKWJqWRh76wnH+I878Q
         0ewA==
X-Gm-Message-State: AOAM531xcJ4j6CutFrov8DgRfEvPU86W96IB4uXpSHCp7PF4SV2I5uw0
        YD1qKAvb6j7DBYHg3+gylk5tAA==
X-Google-Smtp-Source: ABdhPJwm2qswv0JrvcxvuPN29Q+VgK3II5mFgk6NQFlyvIyjJF4VYRoa8ZwPvXLjjp84ys9bffTTLQ==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr22555654pfi.233.1595306766376;
        Mon, 20 Jul 2020 21:46:06 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id az13sm1270078pjb.34.2020.07.20.21.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:46:06 -0700 (PDT)
Date:   Mon, 20 Jul 2020 21:45:57 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Chi Song <Song.Chi@microsoft.com>
Cc:     David Miller <davem@davemloft.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next] net: hyperv: Add attributes to show TX
 indirection table
Message-ID: <20200720214557.0b711a3c@hermes.lan>
In-Reply-To: <HK0P153MB0275B7FFBA43843CC7B1EABB98780@HK0P153MB0275.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0275B7FFBA43843CC7B1EABB98780@HK0P153MB0275.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 03:50:00 +0000
Chi Song <Song.Chi@microsoft.com> wrote:

> +static void netvsc_attrs_init(void)
> +{
> +	char buffer[4];
> +	int i;
> +
> +	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++) {
> +		sprintf(buffer, "%02u", i);
> +		dev_attr_netvsc_dev_attrs[i].attr.name =
> +			kstrdup(buffer, GFP_KERNEL);
> +		dev_attr_netvsc_dev_attrs[i].attr.mode = 0444;
> +		sysfs_attr_init(&dev_attr_netvsc_dev_attrs[i].attr);
> +
> +		dev_attr_netvsc_dev_attrs[i].show = tx_indirection_show;
> +		dev_attr_netvsc_dev_attrs[i].store = NULL;
> +		netvsc_dev_attrs[i] = &dev_attr_netvsc_dev_attrs[i].attr;
> +	}
> +	netvsc_dev_attrs[VRSS_SEND_TAB_SIZE] = NULL;
You know that last line is unnecessary. The variable is static and 
starts out as all zero.

Overall looks good.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
