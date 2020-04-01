Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301B8C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E9E20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgDAJB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:01:27 -0400
Received: from foss.arm.com ([217.140.110.172]:46406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDAJB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:01:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A3131B;
        Wed,  1 Apr 2020 02:01:27 -0700 (PDT)
Received: from [10.37.12.142] (unknown [10.37.12.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C3A3F52E;
        Wed,  1 Apr 2020 02:01:25 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] arm64: add the time namespace support
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200401065005.GA413115@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <205b9e13-cb5f-8b65-1945-0b93e873942f@arm.com>
Date:   Wed, 1 Apr 2020 10:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200401065005.GA413115@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 4/1/20 7:50 AM, Andrei Vagin wrote:
> Hi Vincenzo,
> 
> Have you had a chance to look at this series? Let me know if I need to
> rebase this patch set and resend it again.
> 

Sorry I still did not get the chance to have a look at your v2.
I will try to do it by the end of this week, beginning of next.

> Thanks,
> Andrei
> 

-- 
Regards,
Vincenzo
