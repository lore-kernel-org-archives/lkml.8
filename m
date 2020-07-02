Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ED9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453E420760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGBTqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:46:06 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DCEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:46:06 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1jr59k-0001eK-Uq; Thu, 02 Jul 2020 15:46:00 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 9F0DE56011F; Thu,  2 Jul 2020 15:46:00 -0400 (EDT)
Date:   Thu, 2 Jul 2020 15:46:00 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200702194600.GA28941@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200702171548.GA11813@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702171548.GA11813@codemonkey.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:15:48PM -0400, Dave Jones wrote:
 > When I upgraded my firewall to 5.7-rc2 I noticed that on a mostly
 > idle machine (that usually sees loadavg hover in the 0.xx range)
 > that it was consistently above 1.00 even when there was nothing running.
 > All that perf showed was the kernel was spending time in the idle loop
 > (and running perf).

Unfortunate typo there, I meant 5.8-rc2, and just confirmed the bug persists in
5.8-rc3.

	Dave
