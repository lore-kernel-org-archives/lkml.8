Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D703BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AD72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyJkv03r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgD0Fke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbgD0Fke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:40:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693CC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 22:40:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so6382476pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=22T1fi9hCZYd16gPcEsO2HumG8BRGMGET2lEOhIEL10=;
        b=AyJkv03rxnWCaBzdAH5twsD9kYcFCs4wXARJ3xX27DJhspQD783axyG9yWI6oKX8Hn
         WqLMKCdno8670wi5hqobVmFSvs6h2h3Ap5h1Vunq/Ithw0kzdNq5RBAd8JOH8mYIBhwZ
         4EhT/0kj503nGbUXkckWvsPA2YMfOHM5JWriTedy0ZDTz173mxKGmgtDCOkH+7edLyjp
         X8YLtKgWTXq5gFQZJdzT0hecoSpiinhbJQ4M8j+acwHRGT6ACdAz6oUUNwu76E9aEMAY
         D2ZWTJEXX13ZkfHscUEYLxwsJp3rBfJKJo74m2+ePncqCkcm5KZXyUcPZcD/7p4MR0FR
         7bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=22T1fi9hCZYd16gPcEsO2HumG8BRGMGET2lEOhIEL10=;
        b=H9xKXDzlpsR3Ah4+u+ur4Ghycp1olCyVo5++6tZdP4RsbOLHEPmJaBea10N5iWEWuG
         Jp8THvgg3jUM6241SSYZtMKuHX5ppyxWfUQInzeDnzjnZXiyYf8TWuK1pVCMxk/Y5Hpe
         vp1cyBsQIsigOs8DhFn/lwqDVJdThsrz/u4MKGv04OG2AHiGEuBIlnU1uy7ly3b0zTQJ
         amz+CmP6ZDfi/Sd3MpaY3OH7Hv+d9MND4ObhiLZO5DIT7L2HyBXhB7zJQzgqQhpyJjPR
         ffza3YPSebWV/IXuJz/YUJjSsuXAQGSxqrulz9gXL+FRHPG6qevw+ZJX2kXzC/qU0H/Y
         UMAA==
X-Gm-Message-State: AGi0PuZSYL5inBYGXjELarkNPCHSckEY4LGH1KZZV4pLXdN1bSZn29A7
        TvOpIjG8pbDkuMa0H01i4MqZUXe+Cg==
X-Google-Smtp-Source: APiQypLU+w8iopyaIUxj6f7frOXFqJA7R7fUgSTRUGPKn1R4131TNHAPvUBHF5UzJVeSaVns4RLjSw==
X-Received: by 2002:a17:90a:ae12:: with SMTP id t18mr15259427pjq.26.1587966033683;
        Sun, 26 Apr 2020 22:40:33 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:996:8534:8d2a:cf91:2e3d:2746])
        by smtp.gmail.com with ESMTPSA id o21sm9959514pjr.37.2020.04.26.22.40.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 22:40:33 -0700 (PDT)
Date:   Mon, 27 Apr 2020 11:10:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chris Lew <clew@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 2/3] net: qrtr: Add MHI transport layer
Message-ID: <20200427054023.GA3311@Mani-XPS-13-9360>
References: <85591553-f1f2-a7c9-9c5a-58f74ebeaf38@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85591553-f1f2-a7c9-9c5a-58f74ebeaf38@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 03:45:41PM +0200, Markus Elfring wrote:
> > Hence, this commit adds MHI transport layer support to QRTR for
> > transferring the QMI messages over IPC Router.
> 
> I suggest to reconsider software development consequences around
> another implementation detail.
> 
> 
> …
> > +static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
> > +{
> …
> > +	rc = mhi_queue_skb(qdev->mhi_dev, DMA_TO_DEVICE, skb, skb->len,
> > +			   MHI_EOT);
> > +	if (rc) {
> > +		kfree_skb(skb);
> > +		return rc;
> > +	}
> …
> > +}
> 
> I propose again to add a jump target so that a bit of exception handling code
> can be better reused at the end of this function implementation.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=b2768df24ec400dd4f7fa79542f797e904812053#n450
> 

Matter of taste! goto's are really useful if there are multiple exit paths
available. But in this case there is only one and I don't think we may add
anymore in future. So I'll keep it as it is.

Thanks,
Mani

> +	if (rc)
> +		goto free_skb;
> …
> +	return rc;
> +
> +free_skb:
> +	kfree_skb(skb);
> +	return rc;
> +}
> 
> 
> Regards,
> Markus
