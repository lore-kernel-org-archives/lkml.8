Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F58C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAAD206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqPfDDwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD1LzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgD1LzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:55:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71060C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:55:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so24249141wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ARhS0rwZ8Alb5Jm0pWQp/cHnoFN2jrQ1u7lV5uPkaIQ=;
        b=yqPfDDwKZw7djhVzl5OuNoaqC8fFv5dibuLQEe4/NGADPAlpc7ia3b3xNCHs277nOD
         wobBmC1791F6rWiuwhRrV7BlcpsOZmcc0G0/Ghtu/3/pHzPjOyjq1H7u6J/lXXj6OFle
         v3jZNOLjPoTZfcyPMGwk0cOi0XLAIE5RWhhAyJ3mmMvFXr+lnUjTDaIK508DjlYcZrqU
         xhMFB1SFDD1sXHMgx2smoIRPKC00GOPr+XD2nD5FtI8p0M1eUq1Qswzttk87OJ7/aE3x
         RMU6ytLyZs3AMfJ/nP0lKwosL0Lnsy2a3A7C6RD8BQ+DDqvtGR7diSF28B6etB0H1pXZ
         i5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ARhS0rwZ8Alb5Jm0pWQp/cHnoFN2jrQ1u7lV5uPkaIQ=;
        b=LLAl0FAcX4pUc8Wo1sYIEwspgKNtFQKR6AsOmwr2ta1D+Fy4M7Sn7Dg0dmYJbAdijq
         utBjq0UGgx4HnEOtRLZARe0TPIG68i/grWpYWLCX+SuCuG2CB2ggZvLcwRAQhWU1jk5C
         uE7EmE+RLE6cx3OB8s3dzqvv7SJ4pcQtIotFBZid80COS5kLMVumdNStcChewZ2vh8I1
         C8qWqaKj1fwaBUgR9349mp77mxIlTuQWdmM+7otvJFm4iV0gka0EIIWKekY5d47IvpoY
         77UsgY/NQxNon/zUiIy46FmlHQKU2T8YSWAPWmL8154w6PKPab1n5WNv7CEfQLzKUnJN
         n6iw==
X-Gm-Message-State: AGi0Pubd/yVZdgCPZTy6af05decwxJqc1V0z4OTkuqgj6HQhJqlBeZVY
        vI8hJBb5NRQAD/Wwx9kqnMheenwcSpU=
X-Google-Smtp-Source: APiQypLd2NSu0mYIXkv6YI6YC6iYQ4qBfQuvzN3jUInvrcXe/1U8kye3GPBhq/k3JVYMUwXYHLtPPQ==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr35097664wrv.77.1588074907763;
        Tue, 28 Apr 2020 04:55:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r2sm3091066wmg.2.2020.04.28.04.55.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:55:07 -0700 (PDT)
Subject: Re: [PATCH] nvmem: ensure sysfs writes handle write-protect pin
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Khouloud Touil <ktouil@baylibre.com>, linux-kernel@vger.kernel.org
References: <20200427183914.333587-1-michael.auchter@ni.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4fa69067-8993-1819-abb5-3ce718e17d36@linaro.org>
Date:   Tue, 28 Apr 2020 12:55:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200427183914.333587-1-michael.auchter@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2020 19:39, Michael Auchter wrote:
> Commit 2a127da461a9d8d97782d6e82b227041393eb4d2 added support for
> handling write-protect pins to the nvmem core, and commit
> 1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f retrofitted the at24 driver to
> use this support.
> 
> These changes broke write() on the nvmem sysfs attribute for eeproms
> which utilize a write-protect pin, as the write callback invokes the
> nvmem device's reg_write callback directly which no longer handles
> changing the state of the write-protect pin.
> 
> Change the read and write callbacks for the sysfs attribute to invoke
> nvmme_reg_read/nvmem_reg_write helpers which handle this, rather than
> calling reg_read/reg_write directly.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>   drivers/nvmem/core.c | 52 ++++++++++++++++++++++----------------------
>   1 file changed, 26 insertions(+), 26 deletions(-)
> 

Applied fixes tag:
  Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")


--srini
