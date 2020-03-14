Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F0C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D128206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L6fKCEN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgCOHPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 03:15:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgCOHPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=phGgUD/C0rx6Tdcw5DJKLr+6MasVhZ3Np5rvjUD+KGQ=; b=L6fKCEN+SX+sDYWAE3hu1v7BrN
        yxWyAdL/8FZkLpimZv5pSIA+EXhNg6NaP+rlPS/HXpwSg2m7FHGLRBqabyNOJE1DDGO6ZUvlZDExL
        NUnku2vDlAl5+Niizloee7lEGEFU/tNbazBuJmO4ccHFIVFhWWrb7uIZx44yinfRstX+lWUMDFbWt
        lXFO/nyoJsX8fDkA6f69ok7Mep/WlWyfw5/Cjo9+YgHm40Rerndgoa9JhaiLgk8W+CfFYSaf8Fv0n
        5JO0xMVslkyjXv+0qJqmpAHFOzlk5rm8Nys59Pz2kUFLfme9NBX1YnBt2cZCE4SDOdvq56C9A9NpV
        nO41PclA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDEAq-0002wG-If; Sat, 14 Mar 2020 21:18:24 +0000
Subject: Re: [PATCH] panic: Add sysctl/cmdline to dump all CPUs backtraces on
 oops event
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, akpm@linux-foundation.org, kernel@gpiccoli.net
References: <20200310163700.19186-1-gpiccoli@canonical.com>
 <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
 <20200314142820.GQ22433@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43c0e375-6ed1-6a4e-1d61-c0255bf94f26@infradead.org>
Date:   Sat, 14 Mar 2020 14:18:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314142820.GQ22433@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/20 7:28 AM, Matthew Wilcox wrote:
> On Tue, Mar 10, 2020 at 01:59:15PM -0700, Randy Dunlap wrote:
>>> +oops_all_cpu_backtrace:
>>> +================
>>> +
>>> +Determines if kernel should NMI all CPUs to dump their backtraces when
>>
>> I would much prefer that to be written without using NMI as a verb.
> 
> Concrete suggestion: "If this option is set, the kernel will send an NMI to
> all CPUs to dump ..."
> 

Ack.  Thanks for that.

-- 
~Randy

