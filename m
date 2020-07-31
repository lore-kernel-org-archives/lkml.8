Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E512F20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAwbNNoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgGaJnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbgGaJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:43:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A235C061575
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:43:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r2so22312272wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=694M5ptZ+qGWMshyD+vmBo/LA7n/eegguVd13epfDvA=;
        b=SAwbNNoAA8841pE3OBKjYWLumeq2s4edh4sB10E2fUgUQEBOPYCI2n2hlj9vXE7fnH
         otmhH6LVm91/1roUdWxSOXIN49cYyMgG5HOxsI7QzZOU7ufXUxM6aVkATEGS8O0cnkxh
         r80Aayj4H2cLf3ZRRc85BxnfY/i4X924CksCJWYsPNH35+oeylrXggb4G782X5bbKY6m
         ldDQ4Br/Kg54cbV43e/xhPQHoubZ1OvbDuAqB0LtLLanQ1rf6k0A//+xMpHIwHpWrDzV
         I6PVSXxxt2P7fgJRtsUUqbUBUzeXdaoe2Sy83msQwXM6txMQye3MmUhvQIqyjuwHCWgo
         Tb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=694M5ptZ+qGWMshyD+vmBo/LA7n/eegguVd13epfDvA=;
        b=NOR/pmkYqQNAxFW9YvokFqCPPY2xWfNNQBrW7PFFG8cERgykZ08znv5DooDeYqduCy
         EwQWZ2gK0RuLrbyN7XvPnUxm1QBgvj4Mb7vpwJADa5I7Tf7aqkiWhtdFUoTLfE5c2ci8
         sEAjzkRRHqcjmTRg9Dax+Sv+ErBA6iaJ1vZx/BN3tzNCaTZbVcabijDBh/HKDTF3vBKD
         SQOBFdDvZlEIB8+qj7iMdjkg6RGWoTlGXkNhxuB9V/wNzHb2+Z3AUZrPbE3D8fJkpSHa
         YITqa3IWLp18lGMq8WzWdj4PG1nidJrEf9m8YhdBweFrVxUjrdKW2RsJjkLz2vqj7vHe
         Lh9A==
X-Gm-Message-State: AOAM530DKjrHs2kdxSzBDeOMdP62ZPiRi9E5f+q2MQTnGsQRZLuC0ewR
        GpdNUs+j4hciXQ5cnr/TkuL3FaF4i9sp/g==
X-Google-Smtp-Source: ABdhPJz+8iqI7pblUB3VDCSn0j1SVfeJn1pDiDhaTyr/Cn9Rwt5f+GnLAtypovQLVALrAd4Ukhjfjg==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr2700654wru.21.1596188609717;
        Fri, 31 Jul 2020 02:43:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e484:a7d1:6931:9059? ([2a01:e34:ed2f:f020:e484:a7d1:6931:9059])
        by smtp.googlemail.com with ESMTPSA id r206sm12629178wma.6.2020.07.31.02.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 02:43:29 -0700 (PDT)
Subject: Re: [PATCH] thermal: intel: intel_pch_thermal: Add Cannon Lake Low
 Power PCH support
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rui.zhang@intel.com,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1596097503-27924-1-git-send-email-sumeet.r.pawnikar@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f5d88ddc-100f-35f8-5f38-f7f4811e6713@linaro.org>
Date:   Fri, 31 Jul 2020 11:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596097503-27924-1-git-send-email-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2020 10:25, Sumeet Pawnikar wrote:
> Add LP (Low Power) PCH id for Cannon Lake (CNL) based platforms.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
