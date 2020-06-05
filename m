Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2EC206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jljVjzdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFESsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgFESsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:48:13 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33DC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 11:48:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so4075099plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LlPTaCMTDjaP3D5Ttaehm6of7nisGH1SZJjGSU5Pa14=;
        b=jljVjzdLvtQD8XdaUvu7gCQO40v4TC3pH/Xhhs70/5HoH5J0r9pMGIRTp0qzuN0n5g
         SrSmxIvZZiLj0Bj7O2dB2/hpNsGgH65nS8yaZ/DBtHIPwNH25c4hsRKtB8Ae2nkyZpar
         N1JgFLAFdbAgNYTk63nVs6A/IqKxu3ngw9ots=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlPTaCMTDjaP3D5Ttaehm6of7nisGH1SZJjGSU5Pa14=;
        b=scL41MUxd9VAVskl4Kz552DIEyV4ttDJ0iMCLfNFL2vzqq5zKhKbhvGUch8aKF5Skp
         gThYLFXMzBQkPsPxd0oOgc2sdnCj5RKLmExkuPtK6j77cRX4sG3nYNN58gdG7t0C5zGM
         lana60NySUvscYjq1AVOhOPSjU62XORcpObXUft77rnPLhLBBoFVxlzCUZof59xgMbwF
         rVymsAki/5qyHwNlEthkNEinUpl7XmMr4L7H/Sglg6xReb5PkL/wrXx6zK/0J7xZEvLq
         449sWQ0ogVL52zVSLnenyftMwTRIUlKra8uyyCl00Kfz1GNRCelfl1KzCudhKWIT4GTL
         OsQw==
X-Gm-Message-State: AOAM530jzXUUrAWwon4Gb90Qbp2QGhfLQIvySNs3IX0MhusB1a+vq4tS
        2RLlZ3md/v5vIdRz3VTLlGP3rQ==
X-Google-Smtp-Source: ABdhPJy3QQpxdT7ktA/fK9/JbbotJP4vdGRn60+gSCWoWJfkMJBDt/UrLMaBy7+oWWZxVn/ixV+Ebw==
X-Received: by 2002:a17:90a:e60d:: with SMTP id j13mr4674180pjy.127.1591382892770;
        Fri, 05 Jun 2020 11:48:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u14sm281538pfk.211.2020.06.05.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:48:12 -0700 (PDT)
Date:   Fri, 5 Jun 2020 11:48:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Add test for possible misuse of IS_ENABLED()
 without CONFIG_
Message-ID: <202006051148.DA853DA@keescook>
References: <202006050718.9D4FCFC2E@keescook>
 <e7fda760b91b769ba82844ba282d432c0d26d709.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7fda760b91b769ba82844ba282d432c0d26d709.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:24:43AM -0700, Joe Perches wrote:
> IS_ENABLED is almost always used with CONFIG_<FOO> defines.
> 
> Add a test to verify that the #define being tested starts with CONFIG_.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
