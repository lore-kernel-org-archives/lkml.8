Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE8C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32FA20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mve6xxIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406901AbgDOQRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410348AbgDOQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:17:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B0C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:17:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so175144plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qF0LUXdpindc5vOiwqFLokJsFdLR0vgnOBjxtQzWbs=;
        b=Mve6xxIT004adgNzucM9jYaZUdUKPTbB4pwhTsIrjJyXfWIjwyitHsnToKZ2/j7tXo
         VmFkPLz3yqdaiwSASSLGOvK7JOu8Kl0d2dIICLPS6AGnBQif9AGJeXnHs9V8by/mtclL
         qAsawvXA5/aCflai5s1gmEy5wct8dOm+XAOZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qF0LUXdpindc5vOiwqFLokJsFdLR0vgnOBjxtQzWbs=;
        b=lv1qZnMedOT3ESwCT0nHxU2co5KpmCNf6WfrtG+ojc76Tsv6wtXbYFMWOCDLPZp3C5
         Z5Wh6ECH9YaoWG+fu3E3nEXpHtpgUTiGJE00TT91r9yrqY+eV2FB82vVAcp2xzMTjrj/
         MNq2PeqMG53J9k0/0VJbTZ6mUNxR4NaBgQTdxWBaXMwz9MlMn+ccT6bfj2Fe1cgvxPTc
         z/BtPcpboF4KKqKqlUSVodPL43scH+47l3MV5SHgRWpERSY9I/zSFRCVYw590Kiv4EZ9
         5XuSY7JARQIJcqWHeU/eCbo1B/8EPLhHyF82zVBnvFGVmOA8mdMDOUQ8/aXkjDV8zGTI
         Pwng==
X-Gm-Message-State: AGi0PuZwM1CUfskrXAYfVMiAposTQgKvYn+iG79Cg6Dtl430Q3oGSx18
        k4SnLihiGhklzUJV+aSVPZKk7Q==
X-Google-Smtp-Source: APiQypLZs4xoFWXwCC6ACEShStmRbLORywovCATnaoYdHfDs8I1rBSwFVXIOkj5TOo8wqWByixut/Q==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr5828336plq.304.1586967440145;
        Wed, 15 Apr 2020 09:17:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15sm13106471pgj.34.2020.04.15.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:17:19 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:17:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     shuah@kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v5 0/5] kselftest: add fixture parameters
Message-ID: <202004150916.3A452C9@keescook>
References: <20200318010153.40797-1-kuba@kernel.org>
 <20200410172326.3ad05290@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410172326.3ad05290@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 05:23:26PM -0700, Jakub Kicinski wrote:
> On Tue, 17 Mar 2020 18:01:48 -0700 Jakub Kicinski wrote:
> > Hi!
> > 
> > Shuah please consider applying to the kselftest tree.
> > 
> > This set is an attempt to make running tests for different
> > sets of data easier. The direct motivation is the tls
> > test which we'd like to run for TLS 1.2 and TLS 1.3,
> > but currently there is no easy way to invoke the same
> > tests with different parameters.
> > 
> > Tested all users of kselftest_harness.h.
> 
> Hi Shuah!
> 
> Were these applied anywhere? I'm happy to take them via 
> the networking tree if that's easier.

Shuah, with -rc1 out the door, would now be a good time to take this
series?

Thanks!

-Kees

-- 
Kees Cook
