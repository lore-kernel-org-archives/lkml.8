Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4470DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADF3207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my5eY2yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLQBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:01:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE1C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:01:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k1so3814671pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8arUOApLiXDRUGCMIRF3WITWesa059DBqowSaJoP3kg=;
        b=my5eY2ycooXFvDMr0LtDM+kEGSVSJON/nRXck6cJWtWaIvr79zLH9d5AaK9o2wxpjG
         R0+znBSCLwP73h9oARXj0WqD2Z2JyPWOUqIuW2K67Dx0xEFL40Nq3/cTS2U6leGwAVeS
         wg3TtmCvTNn84lFYU1JH7E8HUps+G7lLxw93BgFo9DY9xpTdQLS6HWpbhY2Dahe8xFvG
         uFIvsGL0xoAGUzG8/xpt/1dUj/W8qYiCfz/kZaqv77dkNoBIeuIoRj4H+4iLL87M/X/Z
         8T8BwdULYyr3fhtNVYHMhLbOJ5II+7xWeUK7ESCoRhhPs2r+lEFAaX+HLvY+vne1WGDA
         JKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8arUOApLiXDRUGCMIRF3WITWesa059DBqowSaJoP3kg=;
        b=MiCUmOyRdo7GtSfXdGNK3P0c5ULi1qiPEYbn+O30qS6sXHS111wy0PWjuUpnDFQjrS
         NbxvRcgcf2Hwq6OPkymtk5s9y8hv5/InAq7ttXVdMcky7bhd+hlpEVCM9p1d/bRiFdof
         oPN6WlPNXjgigZKIiVcxPSK6tEd3+nHiKo0auY8QMdMlsyTXo/RHtnWM5RA/ct1YRkEh
         6+Ze009tZ5a4c0id4AYQWC56y2/Pufcu6NhRCbYc8guc8XihANUh+2DFzugorT7seQiY
         7EX1OfSgyQIBK0GF1HQZxTosfEfmPKgh74wGz/z0wZqQSFjM2ko9FJLhclpn0AlqrodQ
         eOxg==
X-Gm-Message-State: AOAM533OCr3BQa+hnKt5+Qq1SqyAsrbnMPFR/IM8rOFZpg9PLsPcSzCc
        tUjzKl/4I+WegIW2alkz1fY=
X-Google-Smtp-Source: ABdhPJwP1eHttivf0/PWqEs9M6GPvKgYt8tIyp75MZaGCIFg/3sT6iI0wPkeT3MKAFbjn+gEQjSAVA==
X-Received: by 2002:a17:90a:266f:: with SMTP id l102mr14542976pje.190.1591977675395;
        Fri, 12 Jun 2020 09:01:15 -0700 (PDT)
Received: from localhost ([49.205.221.68])
        by smtp.gmail.com with ESMTPSA id u4sm6473576pfl.102.2020.06.12.09.01.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 09:01:14 -0700 (PDT)
Date:   Fri, 12 Jun 2020 21:31:12 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/3] ARM: copy_{from,to}_user() for vmsplit 4g/4g
Message-ID: <20200612160112.GA27659@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <nycvar.YSQ.7.77.849.2006121117250.3341460@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.77.849.2006121117250.3341460@knanqh.ubzr>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 11:19:23AM -0400, Nicolas Pitre wrote:
> On Fri, 12 Jun 2020, afzal mohammed wrote:

> > Performance wise, results are not encouraging, 'dd' on tmpfs results,

> Could you compare with CONFIG_UACCESS_WITH_MEMCPY as well?

                 512     1K      4K     16K     32K     64K     1M
 
normal           30      46      89     95      90      85      65

uaccess_w_memcpy 28.5    45      85     92      91      85      65

w/ series        22      36      72     79      78      75      61

There are variations in the range +/-2 in some readings when repeated,
not put above, to keep comparison simple.

Regards
afzal
