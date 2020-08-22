Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE5E20720
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598097613;
	bh=3ypmi0qUMEIrlt/O92KkV5e04xRnvSyenkQ1DMhjfGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FQivrIezsbSSDapqIpVwEiJMHWKlo1uYAaKSSUSHC1y2h5D1KNuKT252Zi0eimfzH
	 p4m0BNbXEG3wLkZNp+QfxIp2aohGoo14ctGirBOucdk4aBDi9AU8ytlWwT3rpwOBV6
	 AfHjXAC12O8Bqp2vKtMG8dyXon7bcRv7wDEljwzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgHVL4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 07:56:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37588 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgHVL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 07:56:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id x9so233806wmi.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 04:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hvbjMBf8wiATslO6Ak2k4c/lPw2aiLp5EPMz+Nzt5l0=;
        b=C7GXAC3zSsCooawrM6IFNpgo8gqtYuqmRXf3hHwAO3mHFxLQ0TDHdEmHcsv9DTvADj
         tRDdSD88nqxOUDSeexVPGPTAY2lrEu+ldNwetcBG573URhrklI4rOgFQ+T06fnABF3HF
         7CPlpo0gFNDbI8G7L6zcV4TV31RjodpgA48bSdPNZy7LFi+6Ffr1VkXdrmbGSRAbnC2/
         Esci67f1tVynmE4kQnNVBn1VIL+5IlGRgChyQg30N2Vbn8I4HEyf/yht0YJfbREs2h4o
         w5JRGHs0Vj/YUVWNvkocsHI6abHDZ6kLv1NiBh8ecBaHNSfISEOhaFA5IGmhHvVswhNR
         l9tQ==
X-Gm-Message-State: AOAM531w2/acLzASENFSpm6M0Xr8mAnXXo864v4YBZmjgm5VBigocGEy
        Jd6OPK+WMrcVUPEA6+95yGg=
X-Google-Smtp-Source: ABdhPJwDh3nTnOl0xu5tFSjniSyxEVyd29s+HNxPR6jSSloTXuvrIa4AxAjUxTWQbtNs0cHSZarczQ==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr7483728wmh.56.1598097398629;
        Sat, 22 Aug 2020 04:56:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id 145sm13188159wma.20.2020.08.22.04.56.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 04:56:38 -0700 (PDT)
Date:   Sat, 22 Aug 2020 13:56:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Markus Mayer <markus.mayer@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
Message-ID: <20200822115636.GA19975@kozik-lap>
References: <20200821165221.32267-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821165221.32267-1-mmayer@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
> We would overrun the error_text array if we hit a TIMEOUT condition,
> because we were using the error code "ETIMEDOUT" (which is 110) as an
> array index.
> 
> We fix the problem by correcting the array index and by providing a
> function to retrieve error messages rather than accessing the array
> directly. The function includes a bounds check that prevents the array
> from being overrun.
> 
> This patch was prepared in response to
>     https://lkml.org/lkml/2020/8/18/505.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Your Signed-off-by does not match From field. Please run
scripts/checkpatch on every patch you send.

I fixed it up, assuming markus.mayer@broadcom.com is the valid email
address.

> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> 
> Changes since v1:
>     - Added link of the coverity report to the commit message.
>     - Added Florian's ack.
>     - Removed second "const" from get_error_text() return type

Florian was so kind to provide you with necessary tags - Fixes and
Reported-by. Always include them on resubmit of patches.

Thanks, applied.

Best regards,
Krzysztof

