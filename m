Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E015C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D242072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFJLwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgFJLwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:52:45 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5EC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:52:44 -0700 (PDT)
Received: from [2a02:fe0:c700:2:5d3:f169:aee7:d2f1] (port=53434)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <Ywe-C4rlyn@I-T-Shed-Studio.eu>)
        id 1jizHd-0004dr-0b
        for linux-kernel@vger.kernel.org; Wed, 10 Jun 2020 13:52:41 +0200
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Ywe_C=c3=a6rlyn?= <Ywe-C4rlyn@I-T-Shed-Studio.eu>
Subject: The ultimate OS conclusion.
Message-ID: <04c1a6b6-1e62-644a-4f34-de050066b673@I-T-Shed-Studio.eu>
Date:   Wed, 10 Jun 2020 13:52:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some remember me from low-jitter testing of Ubuntu Karmic Koala, where I 
got 72.7 fps on the 3-pass (72.7 x 3) engine of Doom 3, using among 
other things 91hz timer.

I further suggested a custom CPU for low jitter, making the single CPU 
probably the best choice for the home computer, with enhanced 
instruction set

A lot of DSP, are clear candidates, a 4pole filter (one input, one 
output), can be combined into a one clock operation aswell. JSR could 
take arguments. And ofcourse commonly used functions. (OISC, Optimized 
Instruction Set Computing.) Even larger things that has just plain 
inputs, and outputs. (Library functions) And this could even be done in 
parallel.

And ultimately an Exo kernel dropping context switches, with optimized 
modular generalized cpu-accelerated library parts.

That should be 1:1 the ultimate OS/Hardware combination!

Cheers,
Ywe Cærlyn.
https://www.youtube.com/watch?v=2gIUbPeQ1ow



