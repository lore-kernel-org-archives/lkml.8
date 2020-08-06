Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0734C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D928B2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWtoBs7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHFWbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:31:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 15:31:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so19833321pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2WAoI/0bdKh4LOALCmxAbARb2bkyr2eggX01YGV/EjA=;
        b=DWtoBs7GnlIkpQun3tPJdELRjb7upOkeJdkQU/y+DTXzrOrqStaLxZ803sjG9+h+nh
         AB9CRD1C1Z5ykRUpEN97ApIJslT+lhvXz3pnI7L84Z2ZdssMNBGb0T6cACOoVBG+PvPW
         ZPGuWCCiefsruoknwJ1qzG/NYaKHEpEpZYmDWFkgypi90pN8VziAxOaVZ93RK9HRYqzb
         ElcsoRTuzMm7gv8M8q/Ysm1SDHRU0noqiYWul0dYsOHZnMibK50xsC5JK3kSE2A0pUNy
         KnAGTSZp/iQmeumSXSxXFsjAtrpzI1cPwIjnqj4Cf/a486Kw+pR87zBUtv0B5zog+IEw
         fB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2WAoI/0bdKh4LOALCmxAbARb2bkyr2eggX01YGV/EjA=;
        b=IMlJcWySX3S2oPNtr335ANJ63V7RsThtTpiULqXfh0pm4gxcWf7D2T36jklbEPn351
         toPM1nQUsKxzy1IC6JiCV2RHtcukomuLdVBUCZ4R48Gm55W0vCQcZ4TAwDfL4PX7VaP+
         bsYP6tUQBS/4MnJyF1k//YplLsFFnfdHLKq2pRMD6RGUredyYW8hJSbD0dGLZPgYVY+h
         q5hbqPtp32IYzFtC5HXDo4Pgo5eY35GpjYEQpyEav+MuMCcCH4IsdvwAg1eDBwg4tHxQ
         MI4EtszGYb/sMnxI+yG4Y2zd6c8UWG/3OJ+quXu5S4d8+O3y0EmMMztpmpd/kXKZ6ro2
         k78A==
X-Gm-Message-State: AOAM5302whtlK4fY4PAXUVv7Nn5e2nAtyMYMlPiOOsDDHPmcri/Lcpdc
        COe3Kl4M+xKUXKymB+KRmsA=
X-Google-Smtp-Source: ABdhPJxB6uwJbNHjHn7s8D0RMWTvIuwBJhDpyHYk9PPmMt8scLRDl+7IZmDHVQRF3QHBTCKnVrsAHQ==
X-Received: by 2002:a63:db18:: with SMTP id e24mr8769763pgg.192.1596753067915;
        Thu, 06 Aug 2020 15:31:07 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id f6sm9227356pje.16.2020.08.06.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 15:31:07 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:31:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Johnny Chuang <johnny.chuang@emc.com.tw>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: drivers/input/touchscreen/elants_i2c.c:859:45: warning: Clarify
 calculation precedence for '&' and
Message-ID: <20200806223105.GJ1665100@dtor-ws>
References: <202008020615.7WF7Tnj9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008020615.7WF7Tnj9%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 06:18:19AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d52daa8620c65960e1ef882adc1f92061326bd7a
> commit: f27ad8932725f8dd0cd1a46763de4a40377b1ae6 Input: elants_i2c - support palm detection
> date:   4 months ago
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck warnings: (new ones prefixed by >>)
> 
> >> drivers/input/touchscreen/elants_i2c.c:859:45: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
>     tool_type = buf[FW_POS_TOOL_TYPE] & BIT(0) ?
>                                                ^

No, there is no need to clarify precedence as it is already clear.

Thanks.

-- 
Dmitry
