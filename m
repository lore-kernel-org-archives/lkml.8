Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D89C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4512084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbOcCj9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgG3R1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgG3R1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:27:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080EDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:27:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a14so25667831wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7da/ss4rSG+lgk0T6fOXVE8VXppLRzXndYSSdH0a1Ig=;
        b=DbOcCj9btVmLSdcsTYFGFuRMuQ4whAGpf3Oy2nk02rAdv3w8lY6Q4UM+w4/yEU3+zn
         Gs1AVuPuLsL3AuGl/+18M7Wl+Oeqclt+9gConXknYvzUTXoPKREKaUNdEILcHDISis4Q
         yXVHvp+6CPGX9E1AhXzCSlHnq2u8qrZpjGsbascpQ2dvR2BdM/AFY/2R90+BSWbdZGlF
         Ssq3652XdSXsYGRmgWzxB9D7vK1beGc2BHx4QGsWbwb8Pndo3iGIgpvTksulzh5eMHK8
         b23gNeUSHVR9mILntEq6P7HgvLmhKYVAglaVc8Bm3EomqnJQ5A2lyoc+Iw8KjZ7SY1Y4
         8VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7da/ss4rSG+lgk0T6fOXVE8VXppLRzXndYSSdH0a1Ig=;
        b=NQPPkQ+kDsglh7ZOfgs+05we/pLUkLtl224LEJvNQ65QFyD15nqthFix0w05qqmYu4
         qXYAyjxgqnXtgPlW/uRJVJVvvDbeKkhjkEL1+XgkrRrGrbm+VdBqRM6iCo4qtl1iJ0sB
         cUbtJVWXaY2o5oPYHdCg7s8/nu7xIHGgHx1ezJ7XplECOUkcFKrl/KEwVU4ST/9FOsDk
         2hZRFL2pYtLdjmZF9HD2ptlRR37CJea3ovz/uqJHLQ311LW7qRiaLpOxIxgpZ4kjf4Ct
         Eckp+x27V/tHxx6HzPpOGlP+wyiHVsRNWcTt6RqoR+XOOkeRlH4PGCVBPnS7q/p2PGld
         1tRA==
X-Gm-Message-State: AOAM532Etythsa18SzZfGRvIV75G5/uWxqL97FAOaPmgvEd6DkI7X0rQ
        /XJrmcxd1ESEzFO+FaRBypm9hZidwio5TQ==
X-Google-Smtp-Source: ABdhPJybx/TN/H+nU4/QV7kSyNeL6LaO1WOZASCP03SNCDQRsrM6/PdO+aOLmXzpF+BvBc01QNleNw==
X-Received: by 2002:a5d:618e:: with SMTP id j14mr3863180wru.374.1596130059428;
        Thu, 30 Jul 2020 10:27:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e484:a7d1:6931:9059? ([2a01:e34:ed2f:f020:e484:a7d1:6931:9059])
        by smtp.googlemail.com with ESMTPSA id o2sm10103853wrj.21.2020.07.30.10.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 10:27:38 -0700 (PDT)
Subject: Re: [PATCH] thermal: Update power allocator and devfreq cooling to
 SPDX licensing
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, amitk@kernel.org
References: <20200730165117.13998-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <67c3f5ca-1aed-0a3e-ba0e-586405063dac@linaro.org>
Date:   Thu, 30 Jul 2020 19:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730165117.13998-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2020 18:51, Lukasz Luba wrote:
> Update the license to the SPDX licensing format.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
