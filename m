Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEBBC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1242B20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="NOhO54DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGJMPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJMPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:15:11 -0400
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890DC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
        s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
        References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=OhiI8yraeH7GEOlj0APWEU84wEkFnnBv6aI7P/byAxY=; b=NOhO54DIuLsEzeueneXvLLgTCv
        09iAWKjCpZyCO8HsPQ5525LXfDNkQ/60YWuMdf/5+oBMB+wvQuk0hPjSSdHaGLGJFo+08Gg8b2Y/p
        2fOiGxX4RSpD61H81VYi6KF4mZslEWJuTRxnfbfComn80MMmzkIG07/F+TQJVOrdSyhQ=;
Received: from [10.8.11.2] (helo=work)
        by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <puleglot@puleglot.ru>)
        id 1jtrvm-00085e-1A; Fri, 10 Jul 2020 15:15:06 +0300
Message-ID: <98b1ba96fca2c6e1a90ce4120b3f3201a3cefd43.camel@tsoy.me>
Subject: Re: Beginning 5.8rc1 kernel USB headsets (ASUS ROG Delta and HyperX
 Cloud Orbit S) play sound as if in slow-motion.
From:   Alexander Tsoy <alexander@tsoy.me>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Date:   Fri, 10 Jul 2020 15:15:04 +0300
In-Reply-To: <CABXGCsN2-TTemU8JOnh3YErxe2GH7xtG+EZrF9gn_JWLmMxRag@mail.gmail.com>
References: <CABXGCsN2-TTemU8JOnh3YErxe2GH7xtG+EZrF9gn_JWLmMxRag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

В Пт, 10/07/2020 в 10:46 +0500, Mikhail Gavrilov пишет:
> Beginning 5.8rc1 (git 69119673bd50) kernel USB headsets (ASUS ROG
> Delta and HyperX Cloud Orbit S) play sound as if in slow-motion.
> 
> And in 5.8rc4 (git dcde237b9b0e) this still not fixed yet.
> The bisecting is problematic because rc1 also has another issue
> https://lkml.org/lkml/2020/6/22/21 which completely breaks the sound
> subsystem.
> If anyone said how to fix https://lkml.org/lkml/2020/6/22/21 I can
> bisect this issue.

You've probably hit this bug:
https://bugzilla.kernel.org/show_bug.cgi?id=208353

