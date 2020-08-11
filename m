Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F57DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8962076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qiivl9DP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgHKRMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgHKRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:12:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781F2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:12:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so7959363pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EsxvtyjzAtXg5sUDRqzZVjThz8mBMWSIwRhZo+xufo4=;
        b=Qiivl9DPtHJleh/lzS440/NKVhFXk3Yy1tWl92a2XnuJBOWGpKkpkGQl+QJmRmUPp0
         sDzsmRLVz2R37jURWM0y4P3pazpzreDvZkb2OLaFUJlIpyR1cLyi7GqnTtnXBM0bio0o
         bcboHwDwhb+GNzKUDQCnK2Y9fT3vbSkutIvV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EsxvtyjzAtXg5sUDRqzZVjThz8mBMWSIwRhZo+xufo4=;
        b=RChRewIoQVuJSjZO3O/FQcVOqan2rHh/ARmwCiLU2mgmB8Y387+x9L+VSN1D2qIfhm
         Wt4om2sMbzVsB8IBv16DJPsN5hYSMGWTREFq7O0T8kj8Tv31t0kWSn5QJNu7yJ3QCp0Y
         83/L/2xkm2xJfwMx02q4kfhj0sxGjHvXssXI5GFEYeuFGUKH5kDiNbLHKzNXuxUX3N+D
         n66t/qYKtkX47sE/mfesBgwxDtSbSxgutwqqNPdIMj+wsLKfE65p5LAAErvFFjk5U8/z
         q5DeRWBXasoLLinHv2vi2CvXQTW0FeEGTCFSuFYdOOGu7mtRw116mj8y9+/0F6WZEUFi
         A5YQ==
X-Gm-Message-State: AOAM5335CjQGQxk7AGyjDHxKbcM30KkVuYts4ay68qsCXGP/XaxUsAGj
        bVb5iefltx3hbq9M+fZSr7HYjQ==
X-Google-Smtp-Source: ABdhPJwCvHLKBQO7DAmqBUXQnYRCHWLQK/g0UXohIgdSsjGgJ0tacFUZGTDws11zC3WzqMh1Mwhn1Q==
X-Received: by 2002:a63:ea41:: with SMTP id l1mr1644202pgk.419.1597165970845;
        Tue, 11 Aug 2020 10:12:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id mp1sm3589375pjb.27.2020.08.11.10.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 10:12:50 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:12:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] opp: Fix dev_pm_opp_set_rate() to not return early
Message-ID: <20200811171249.GL3191083@google.com>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:36:19PM +0530, Rajendra Nayak wrote:
> dev_pm_opp_set_rate() can now be called with freq = 0 inorder
> to either drop performance or bandwidth votes or to disable
> regulators on platforms which support them.
> In such cases, a subsequent call to dev_pm_opp_set_rate() with
> the same frequency ends up returning early because 'old_freq == freq'
> Instead make it fall through and put back the dropped performance
> and bandwidth votes and/or enable back the regulators.
> 
> Fixes: cd7ea582 ("opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes")
> Reported-by: Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>

Originally-reported-by: Matthias Kaehlcke <mka@chromium.org>
  https://patchwork.kernel.org/patch/11675369/#23514895 :P
