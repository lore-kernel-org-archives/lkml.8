Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B0C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B4C206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441204AbgDPINc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440969AbgDPIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:05:10 -0400
X-Greylist: delayed 55119 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Apr 2020 01:05:09 PDT
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAEC061A0C;
        Thu, 16 Apr 2020 01:05:09 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOzWE-0000MZ-3H; Thu, 16 Apr 2020 10:05:06 +0200
Date:   Thu, 16 Apr 2020 10:05:05 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Matt Fleming <matt@codeblueprint.co.uk>, linux-rt@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT] signal: Prevent double-free of user struct
Message-ID: <20200416080505.ec4m4yifgyfti4kf@linutronix.de>
References: <20200407095413.30039-1-matt@codeblueprint.co.uk>
 <20200415164628.2dgrj4ghvtev45sy@linutronix.de>
 <f8152ef5-f71d-b8b6-fe9e-6a8678930775@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f8152ef5-f71d-b8b6-fe9e-6a8678930775@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-15 21:05:14 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
Hi Daniel,

> This can be triggered by running sigwaittest.
> 
>  # sigwaittest -t -a -p 98
> 
> a few seconds should be enough to get the splat.

thank you.

> > This is v5.6 only, correct?
> 
> I've seen this also with a frankstein version of 5.2-rt...v5-4-rt :)

…

> Thanks,
> Daniel

Sebastian
