Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A1520855
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzhO9ncA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHUDPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHUDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:15:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09100C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 20:15:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 74so360522pfx.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 20:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NPD3616XB57t/FVPSE1MIPb/6y5Q2Omn2vwPwfWflGw=;
        b=PzhO9ncA3sVmo/DQCK1yFnnYfDC7EbLbawG+X1QPtp2igY86iA2PCijq7b6hg24fQU
         X4UshXapNgU3Y0hn5qREYZiSrjYT1DpCMJfN3c2TKC0Kl5fqle8Nq20IWQtWvefmjZcL
         GXLVBL2HZ/unl/Bvp3mJ1d99c2I7hTRS4Ugnpa31FfYUGSiCQVf3lRVMIHii8Gu1y1H9
         jhMpv66AVsR6txh2IuGwhBG3Oj2N0oxdwWb8kBj1RCefly/HpcW065uT3Tcm+z6nnSe+
         Qhe71oaoH7VKo0AQLpeKPAuN204RFCv2L7dMFufyGApdd4OuiiLgMDaYcIeCc89qqGul
         79Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NPD3616XB57t/FVPSE1MIPb/6y5Q2Omn2vwPwfWflGw=;
        b=GOSHbZwazNUjcS4RhBubveWDxJ04t9nIJkKfvgkbPeJLU4gFqCvY/V3yWaM4NGwQ6k
         Vdn5TuXh61Ax1+OenOBwsvlvL50eT3kVsI5XWkZC+hhhHjWKRZusjKSx79MlUQSl7gFM
         E8iPzow7Q73WKBjffxLfSy8DmKaAI8dZQXGB1WtitJYlV55mNYza/PHaB0zL+2BPNHs0
         Vt421PNu5dhLw7VzR5YvM9JoVHfZvrvzPLTstkMNLZnyGNNqPEL62c1fXAAZ6lUEcbr9
         Z/8SFZakl9woAPTMuPazAbQ+sQ+2YwrSIUkI4D+/qAFDeroc6zyMyYhPthTLWoJ4UfiX
         OG7w==
X-Gm-Message-State: AOAM532EO0NLqyLDmwTUu2Ffy5KlIoG+N3MKZPO8xUyVAHBRgLSpxpkp
        tiGJpBso/mOkKxUIdpeBAf86e2RqN60=
X-Google-Smtp-Source: ABdhPJzwxoK8aECaFkebpyovlwtH8h65ggA6AIq6kt36C8WFi4Wrgwhxa0TksOa+8GzYY7IbpFb1ng==
X-Received: by 2002:a62:8c89:: with SMTP id m131mr784317pfd.288.1597979706054;
        Thu, 20 Aug 2020 20:15:06 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id r186sm579432pfr.162.2020.08.20.20.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 20:15:05 -0700 (PDT)
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix array index out of bounds
To:     Markus Mayer <markus.mayer@broadcom.com>,
        Colin Ian King <colin.king@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20200821010333.20436-1-mmayer@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <66ec2e07-fbdb-fd8b-9c1e-5f7dc343c9fd@gmail.com>
Date:   Thu, 20 Aug 2020 20:15:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200821010333.20436-1-mmayer@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 6:03 PM, Markus Mayer wrote:
> We would overrun the error_text array if we hit a TIMEOUT condition,
> because we were using the error code "ETIMEDOUT" (which is 110) as an
> array index.
> 
> We fix the problem by correcting the array index and by providing a
> function to retrieve error messages rather than accessing the array
> directly. The function includes a bounds check that prevents the array
> from being overrun.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
Reported-by: Colin Ian King <colin.king@canonical.com>

(Colin, was there a specific coverity ID you wanted to use?)
-- 
Florian
