Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8895C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DD820825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omrxtA0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgESM3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgESM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:29:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFB3C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:29:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s10so14284729iog.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JW39g620VF1bHJrnnWjeDck8qGa5xf2Z2jMQhGIK+fo=;
        b=omrxtA0s/+KjuQMYFq95kQ0IG5B0oyprCeyuRCYvUKk+ovmWC55kwXR9kBS2J6MtfW
         FBHGYTtnVql17Jy5moSYPg/P95oCWnG3COzItzmkk3p9MoVybHxb+Zo4oloVIM4gdTpa
         vbz6UkpgRAKe3N3D/+kc9aK1S7OlC5CQBLTi69aav+VvbEQdA/MDV79vn2/DDDykVwWr
         VW/eoVYd2SuZnXqccbiMnk0kpb0tn0vvhhrrEDnvGgAyVRKgilzSdA+EiKQqIIqAcLsa
         8od7tBxjf4HpoZjVLYfjqKjM+3wEIDnNV9NYdFcUb4Bym55MH8lIIAxbS4tZPXKrolIA
         XQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JW39g620VF1bHJrnnWjeDck8qGa5xf2Z2jMQhGIK+fo=;
        b=Ga/xuDR7hOK4S6EDGilvA8+xqRzSlexNbOoJEj3vFY9DKvlSwdW4tZVHJXoRPb0EPM
         ly3C88tWRpZ0yqkMbjOdOMNIJx36Dc5GA86UtEd06+r4SpuvkaKqKeVa22HUsuzyJgnW
         vI1j93F7JQi9Upz/vnzVBAzwhlIPHEN5j97LbO8gMWvmX5TbQfrWdHUdxzLJnqANBDsc
         w9TUh6V8nFBblW9vM4qwyx6UFZhqULsr+/WEB/2O11fw9CVet0hEBxzVZHi6ACPeFXwa
         hrvX0OQz+CdFGX1ADU85TNFhuFh6iYP6YXQFVeC+Z/Jljm7RTRFy4OqWTcIMQ3myWUsu
         GCxA==
X-Gm-Message-State: AOAM533Fy/sYoqOjx/OuE/n3mgwpzPh5QjWwo6fq+XikzQvRV09GmedR
        NTb4CXDkSTyinRtwfRJUtiGJI1peUlk=
X-Google-Smtp-Source: ABdhPJzzy9J3x83nT2BRYeABnwvq5cbIn3qbKOZkTAg/uXp38aO1MzfiJityaNd8kKirOq5u+3OwZQ==
X-Received: by 2002:a02:942a:: with SMTP id a39mr10249305jai.50.1589891355383;
        Tue, 19 May 2020 05:29:15 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id p1sm4861155ioh.38.2020.05.19.05.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:29:14 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: enable IPA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20200518214834.9630-1-elder@linaro.org>
 <20200518232402.GM2165@builder.lan>
From:   Alex Elder <elder@linaro.org>
Message-ID: <f739b0de-cfc6-d0c0-df1c-d2ff4b56aeb4@linaro.org>
Date:   Tue, 19 May 2020 07:29:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518232402.GM2165@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/20 6:24 PM, Bjorn Andersson wrote:
> modem-init tells the IPA driver that the modem will load the ipa_fws
> firmware, but the MTP is assumed to run "LA" firmware where it's the
> Linux-side's job to do this.

I didn't see this message until just now, but I remembered that
last night.  I just build my version 2 and will send it shortly.
Sorry about that.

					-Alex
