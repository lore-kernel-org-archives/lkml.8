Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1EEF206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RA6swQmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgF3Xnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3Xnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:43:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99125C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:43:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so8243534plm.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KvgIA8jCnR4C6DD9ZJKn5SWEFGMBdmtthc8Oij6QT8I=;
        b=RA6swQmr+S0tysXaQfAHbsokJUg4uLp3g3DLvlvKvo/qX6DdU3SR9RH5I7TKhcYfKC
         ItKCRXpYW3dwc4QDXaGfOYs3+2jB3ntNUIE0Y1Zxrv7Dob7l6+Okrlr313JiDEqdyuco
         Ky53pudV1K74p8kFH6RXb4bdH7vKcXMO4q2R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvgIA8jCnR4C6DD9ZJKn5SWEFGMBdmtthc8Oij6QT8I=;
        b=P9jr4P/beBM6S6hhUBVENfw0XGSbf+OU1o3hge05EWW2hYdDBHvjFKqhq9u6fvhORv
         FtYA+bY5beus2qsycRD9+rGZYGnCplz4CDUdkE31taIRnzMXKikFs/K5KIzI9c2b79p4
         lg9izjMh9HSpQ+IWO8wJ15K3XsuqQhkWN3qNjtCN4geFDsHllppT3JZuUY5FVxYLvj4c
         tI953s5UI6CXMracfXTIYjGIDxfpwqUWslxfRI95Q982xpEda8IixUDQzaAKuTh+4ki+
         A/Km5cnLTxhmJjNUYY0cHBDP9xMo3DiuqwA8M+aywiEzzXEockvwaFKAsx6Nd/+xGWlN
         2Lqg==
X-Gm-Message-State: AOAM532SI2OvX6e4Copa06P/iDHpZ4GFyPJPmyUkxys0uG/VBFu+peXq
        P7Mh4dqdJNkTjmo+pDJjuFEvzto18x4=
X-Google-Smtp-Source: ABdhPJzeWPD1R+nRwY8/J4yLghDQ06DrA4LcyaRFaFiu4UuLTQRflMy0ZlcOLlrct4GUqFnZQRJ++w==
X-Received: by 2002:a17:902:d203:: with SMTP id t3mr20512091ply.168.1593560630171;
        Tue, 30 Jun 2020 16:43:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id n137sm3811575pfd.194.2020.06.30.16.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 16:43:49 -0700 (PDT)
Date:   Tue, 30 Jun 2020 16:43:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: sdm845: Add sdhc opps and power-domains
Message-ID: <20200630234348.GK39073@google.com>
References: <1593506712-24557-1-git-send-email-rnayak@codeaurora.org>
 <1593506712-24557-4-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593506712-24557-4-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:15:11PM +0530, Rajendra Nayak wrote:
> Add the power domain supporting performance state and the corresponding
> OPP tables for the sdhc device on sdm845.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
