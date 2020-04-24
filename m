Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620A4C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCD820724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgDXIYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:24:41 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56783 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbgDXIYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:24:41 -0400
Received: from [192.168.0.4] (ip5f5af075.dynamic.kabel-deutschland.de [95.90.240.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C355F2002EE1A;
        Fri, 24 Apr 2020 10:24:37 +0200 (CEST)
Subject: Re: some questions about uploading a Linux kernel driver FusionRAID
To:     Xiaosong Ma <xma@qf.org.qa>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     ty-jiang18@mails.tsinghua.edu.cn,
        Guangyan Zhang <gyzh@tsinghua.edu.cn>,
        wei-jy19@mails.tsinghua.edu.cn, LKML <linux-kernel@vger.kernel.org>
References: <6a7c0aba219642de8b3f1cc680d53d85@AM0P193MB0754.EURP193.PROD.OUTLOOK.COM>
 <CAKm37QWKVcPkF0fXKk2499CsYXfU3aMuMWgwa8Nk9HFzVxG7CA@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <eb742f1b-fbc2-a47f-dd1b-eec20463fa21@molgen.mpg.de>
Date:   Fri, 24 Apr 2020 10:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKm37QWKVcPkF0fXKk2499CsYXfU3aMuMWgwa8Nk9HFzVxG7CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Xiaosong, dear Tsinghua,


Am 22.04.20 um 14:26 schrieb Xiaosong Ma:

> This is Xiaosong Ma from Qatar Computing Research Institute. I am
> writing to follow up with the questions posed by a co-author from
> Tsinghua U, regarding upstreaming our alternative md implementation
> that is designed to significantly reduce SSD RAID latency (both median
> and tail) for large SSD pools (such as 20-disk or more).

Sorry for the late reply, and thank you for wanting to upstream the driver.

> We read the Linux kernel upstreaming instructions, and believe that
> our implementation has excellent separability from the current code
> base (as a plug-and-play module with identical interfaces as md).

Is there a chance to integrate it into the current driver, and then 
choose it, when creating the RAID?

> Meanwhile, we wonder whether there are standard test cases or
> preferred applications that we should test our system with, before
> doing code cleaning up. Your guidance is much appreciated.

[…]
> I am Tianyang JIANG, a PhD student from Tsinghua U. We finish a study
> which focuses on achieving consistent low latency for SSD arrays,
> especially timing tail latency in RAID level. We implement a Linux
> kernel driver called FusionRAID and we are interested in uploading
> codes to Linux upstream.
> I notice that I should separate my changes and style-check my codes
> before submitting. Are there any other issues I need to be aware of?
> Thank you for your time.

Is your code in some public git branch to be looked at already?

Otherwise, I believe just posting the patch train with `git send-email` 
and a cover letter, might be the best first step, so the developers can 
comment early before you put too much time into refactoring.

Some easy to reproduce test scripts to verify the performance benefits 
would indeed be nice, but I do not know, if that can be integrated into 
some Linux kernel test infrastructure already.


Kind regards,

Paul
