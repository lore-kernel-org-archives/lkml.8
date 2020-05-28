Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6DDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003A32075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7b1Bkhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbgE1PRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404334AbgE1PRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:17:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD6C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:17:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id n15so13687538pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oxRd34Wxun9nW+kBKYd8ek/TIpwGvvJGkUBghSmTo/M=;
        b=E7b1Bkhhlu107mfUeAd/DeHi/NlpmNrFcQyzK/ljKSgNsYZFSAIIGxiM/pZUnGnWPV
         37n89LF/8CdNzNEPy06WjDQuEZHXPfLUIcfgOq2cPgiUd2QhuRyZnfnLM84XCU7TAqbn
         a3y3CZBzDxfqeUUt5zIVIPhhjECLPjEu7A5iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oxRd34Wxun9nW+kBKYd8ek/TIpwGvvJGkUBghSmTo/M=;
        b=TaBTjlWaweo+6EqeNb0CGok+r4magiNdDL4UO+ez0WTkecx8ISLh9UkzHTxEFY/LPL
         DOy3pfTpX0GWzJtXzJJSx1OPDagt+9uS6JiyTtX0yF4JKH8pQZ7iI/RE1GKtQbEcp1KO
         ahJPUjp1f+tfPQrgxtpZb4viFn9pdGBxMPgXw1qMW6E7dvRh883PqedUdPh+mSU2JzfU
         w5nYk67ZytldLpzbqfMyyzyjam2i/Sy1WWIf7HHjFWXAkZ9U2pmxXx8xxWWXbal9dU9u
         Jwp0Jy8MLzDSyXnvm+feghJx0ezQRDxHn6nvlZJYVkOUMJPj4ESJHiaxVl+J/8O0bMkT
         ugpQ==
X-Gm-Message-State: AOAM531ZGPaE4X80/HX/TuRv6q5g9AfmfPv8CwWEeCZJDz3xJDxSsEJl
        s4uDtzL8kLuNrA9EqYEF3xCx2w==
X-Google-Smtp-Source: ABdhPJyxzHAYaJd5Z6GbAf+TezrPlzuSkqSImxvxt7Ed9e478gZdxwkkDr6qOku13suW+nr9oaU/lA==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr3695218pfa.209.1590679023291;
        Thu, 28 May 2020 08:17:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h7sm4642562pgn.60.2020.05.28.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:17:02 -0700 (PDT)
Date:   Thu, 28 May 2020 08:17:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Improve controller ID info log
 level
Message-ID: <20200528151700.GI4525@google.com>
References: <1590663797-16531-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590663797-16531-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 07:03:17PM +0800, Zijun Hu wrote:
> Controller ID info got by VSC EDL_PATCH_GETVER is very
> important, so improve its log level from DEBUG to INFO.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>

Please add the tags from earlier version unless the new patch has
substantial changes.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
