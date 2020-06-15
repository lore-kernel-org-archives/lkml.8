Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7507C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30F0207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0mA6JzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgFORcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbgFORcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:32:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F58C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:32:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so8096045pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXiTVmySLinwx/ohTb+qSbZFWKUCXVmO5le+pblRvB4=;
        b=G0mA6JzChysz4vfhRHU6jq7QE/eHCQELey0LnpzfKSltZnUX4xJrQcsFvDqNuuzn/B
         FQxQmO1cTFK2rwGfPExYUmB1UGc+D0FhPK1IWgrpsi9Tnelh53bMnIAGxe548hlLCDgz
         K8Qxo955RfvfEP5VJzZbZ6z34BV7rZNu9ZAzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXiTVmySLinwx/ohTb+qSbZFWKUCXVmO5le+pblRvB4=;
        b=fYFClOqCmvty5fUYq9fFyZ8tcNIJtkmXHInEPyl2ye+WfSbHnIpuyVaMm49v1oncDi
         /m34IXilngPmpca/timdxGtGZhEyVFXFpmzV5nysZ7qUoQZ+HYOznHfc1w7gwSUq3r7t
         Aq7s+qiU/Jwu6hXB0nhyRfcOqLpBGO5HJp76cf1hJEiNmm25UWrwT+tZGuRJQLqn3ggL
         qoSlDpUWfvgeoSU5vLK4hCU3ZELmQOcC5yJlHfOTnDoGI9WJ03/ypUJaqCIN2/a57+LI
         4zYAajC1/lD5+17X08o4fZiZ8+I845YX/cYYCY6dkVJXg0S9iudddS4cFmXNvBrwRhyY
         4uBQ==
X-Gm-Message-State: AOAM533dEm/EQo0aT85MWFay0BKkcIoYnnJOqSBSMrxEnRzYAXDeOmB9
        UPem2lUNFmrPkFUntatqkWqrkA==
X-Google-Smtp-Source: ABdhPJwx4PYvnCYX2JxTXMHgP55Wrhu8eXLVeZVNpAxBLT0KLVHVOQYT0WO997vdvPGw+oFzo0eXRg==
X-Received: by 2002:a62:194d:: with SMTP id 74mr25149159pfz.21.1592242370263;
        Mon, 15 Jun 2020 10:32:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id f3sm115586pjw.57.2020.06.15.10.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 10:32:49 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:32:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 5/5] cpufreq: qcom: Disable fast switch when scaling
 DDR/L3
Message-ID: <20200615173248.GV4525@google.com>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-6-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605213332.609-6-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 03:03:32AM +0530, Sibi Sankar wrote:
> Disable fast switch when the opp-tables required for scaling DDR/L3
> are populated.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

not sure a separate patch is needed for this, but anyway:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
