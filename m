Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C32C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B53207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NP92OmHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgIJFEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:03:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C5C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:03:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so3575315pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZqFRgh97zYu+FiBtzR+Vdczm0u9Myix9WNoAZc4j270=;
        b=NP92OmHMm5OYxrBJAvqsBp+an2H6o2R6aDzTTLrZxaTjAhfBtVUlOpAqSqFbbQqo6X
         54MpqdxDG5zhecLsL02YcQw0qjGWRhq29kn94o2vBOUHWjJLAhLlE9Q6QFMWHrfg7SIu
         3jguHE2y4BA0rFUbFTU/uigpnhhX81BnzQg7PFFvryc+rgdzn40GDqRTXJdOjy4EC0qB
         R8hDzcEbs0y+bmKHuQgBY0dusah5bwmCME3Cb2mEIejaldbh2YLxj2W5sW+fcyt9Npjd
         8s3CpiqA43jZnXxhvbznexwo5RNsychyE1Xg0/d80mOb7KHQ1eGQRtk5a52fQdTRVu5A
         79qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZqFRgh97zYu+FiBtzR+Vdczm0u9Myix9WNoAZc4j270=;
        b=S9B4FXaXDPpSohpmUwpjI6IQdZvRR+jH86sluprDxkm6nt+tTuNae+mxLjgjOagUx0
         5acHWJujfnH2yyPsrfVO4REAIARCRyXgPc/JeLR3Tv+hoj8l5Edj+QLXpCbqola+Szth
         dL20vQCoDBXpgJp6Dq2AkGRblwbp2kG0xIXXkEmMibi/y5yQyjvuvbn5v0614jgpDho+
         jui6ixyiiLYpbbHO0UTo2W4OV1mvT+tlSAxxjTM+6lwkoHzSC9Kj8yGpbUCeks0zYvML
         XmvxxVZohR1hxzcGB2+j5DeqneD2YU8I9T4oWoIBhgtG5erBin7St8SzrQduS931rtgh
         IP1g==
X-Gm-Message-State: AOAM530YP+sPJaiaWlBIMv+fUqu4w5lMl1AtLemWjb6oL5ZXxOEqQuKW
        YCaGvXOh/j2wLhiBwPZrVHcO+g==
X-Google-Smtp-Source: ABdhPJwH/JmaRVcMaXXgABEcKfk5wgZ5e88Hcz2jgqPwYhGXAf90BF9F/3AHEnm7w8Xe2lIp1WsRbA==
X-Received: by 2002:a65:5bcf:: with SMTP id o15mr3080223pgr.126.1599714229100;
        Wed, 09 Sep 2020 22:03:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id gb19sm707678pjb.38.2020.09.09.22.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 22:03:48 -0700 (PDT)
Date:   Thu, 10 Sep 2020 10:33:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v7] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200910050341.pgyieq3q7ijitosn@vireshk-i7>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-09-20, 12:31, Hector Yuan wrote:
> The CPUfreq HW present in some Mediatek chipsets offloads the steps necessary for changing the frequency of CPUs. 
> The driver implements the cpufreq driver interface for this hardware engine. 
> 
> This patch depends on the MT6779 DTS patch submitted by Hanks Chen
>  https://lkml.org/lkml/2020/8/4/1094

Thanks for hanging there. Looks good to me. I will apply it once Rob
Ack's the binding patch.

-- 
viresh
