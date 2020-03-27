Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C3C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED552082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0MkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:40:01 -0400
Received: from belmont94srvr.owm.bell.net ([184.150.200.94]:48927 "EHLO
        mtlfep04.bell.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0MkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:40:00 -0400
X-Greylist: delayed 690 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 08:39:59 EDT
Received: from bell.net mtlfep02 184.150.200.30 by mtlfep02.bell.net
          with ESMTP
          id <20200327122828.BFVD9274.mtlfep02.bell.net@mtlspm01.bell.net>;
          Fri, 27 Mar 2020 08:28:28 -0400
Received: from [192.168.2.49] (really [70.53.53.104]) by mtlspm01.bell.net
          with ESMTP
          id <20200327122828.NPLT130487.mtlspm01.bell.net@[192.168.2.49]>;
          Fri, 27 Mar 2020 08:28:28 -0400
Subject: Re: [PATCH] parisc: Regenerate parisc defconfigs
To:     Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200326202006.GA160630@roeck-us.net>
 <20200326221921.GA20495@ls3530.fritz.box>
 <d83868cb-12cd-054e-db85-bcbb9121683a@roeck-us.net>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <bcfc4d29-7b21-a3f3-8659-ee8ed369dfff@bell.net>
Date:   Fri, 27 Mar 2020 08:28:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d83868cb-12cd-054e-db85-bcbb9121683a@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-Analysis: v=2.3 cv=I5Mbu+og c=1 sm=1 tr=0 a=htCe9XT+XAlGhzqgweArVg==:117 a=htCe9XT+XAlGhzqgweArVg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=SS2py6AdgQ4A:10 a=FBHGMhGWAAAA:8 a=MhJ-TvlPdR1EieP45akA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4wfEXklPdkaVn5cLmqM7xAr9+Fnjxyrz8ODyWz7yakgNxuiI91IbhlIgG2KjgasC9qoLfd8HKU8KV2JG+dBnwfOz3lC35YA+hRMI54vEId9ZqCy1cJgdK0 2ry5czbrNp8dhIZOfCcXP6/aTOSgJg2XNTqsoowXHeUqVbQRWDTx9i1rujgHTlk5wjgKqChgEqH6+3NOQxG6yZ3V0waEt/z1znXMbmwA9fvjBt/uSwFgxZna
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-27 2:43 a.m., Guenter Roeck wrote:
> It would be nice if there was a better way to select 32-bit
> vs. 64-bit defconfigs (for example based on the compiler,
> or with ARCH={parisc,parisc64}). However, that never worked
> for parisc, so I guess we can't expect it to magically work
> now, and much less so for a bug fix.
LP64 is defined when using the 64-bit compiler.

Dave

-- 
John David Anglin  dave.anglin@bell.net

