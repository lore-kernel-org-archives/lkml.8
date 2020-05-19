Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE898C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C720B204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgESNpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgESNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:45:34 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBFFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:45:33 -0700 (PDT)
Received: from [2a02:fe0:c700:2:984c:ac0d:3200:67f3] (port=63315)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <Ywe.C4rlyn@I-T-Shed-Studio.eu>)
        id 1jb2Yl-00085M-Be
        for linux-kernel@vger.kernel.org; Tue, 19 May 2020 15:45:31 +0200
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Ywe_C=c3=a6rlyn?= <Ywe.C4rlyn@I-T-Shed-Studio.eu>
Subject: 0.33 ms latency performance bottlenecks
Message-ID: <138dae9d-a90f-7e67-959d-eaacc9f02699@I-T-Shed-Studio.eu>
Date:   Tue, 19 May 2020 15:45:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried Renoise, a good tracker app with 0.33 ms latency. It was really 
good. Tech Trance in the 90s was all about tracking.

( a little playlist here for interested 
https://www.youtube.com/playlist?list=PLpA7__w8yeJ0g6cF0m_y_h-HWjzCNTuWm )

Latency on the amiga at that time was very low. More like 0.33 ms 
latency, or even 0.2.

We want this kind of latency again. Also having in mind a few samples 
for clocking the D/A well if necessary.

D/A could be a 1bit converter with few analogue components on the 
output, maybe simply a 1 pole diode filter, if possible. This could work 
well on a bitstream shifted up in frequency.

It seems to use almost a whole cpu just at this latency. It works well 
though.

One might want to look into performance bottlenecks here, hardware aid, 
or cpu instruction set enhancements. Inner loop optimization beyond HZ 
timer etc, which is at 91 here.

Serene Greetings,
Ywe Cærlyn
I-T Shed Studio.



