Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B6C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D092080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgAJJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:49:49 -0500
Received: from foss.arm.com ([217.140.110.172]:41510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgAJJtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:49:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66F851396;
        Fri, 10 Jan 2020 01:49:48 -0800 (PST)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B57803F703;
        Fri, 10 Jan 2020 01:49:41 -0800 (PST)
Subject: Re: [PATCHv8 00/34] kernel: Introduce Time Namespace
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        crml <criu@openvz.org>, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
References: <20191112012724.250792-1-dima@arista.com>
 <20191121180555.GA440967@gmail.com>
 <CAJwJo6ahGVHHgwFsPyjbY1PgmHs+D+A2Cma03ogvQGr+mPqYAw@mail.gmail.com>
 <87y2ug9w1h.fsf@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1f81e2ef-93fb-926e-9953-c529675e6f4b@arm.com>
Date:   Fri, 10 Jan 2020 09:52:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87y2ug9w1h.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 1/9/20 9:09 PM, Thomas Gleixner wrote:
> Dmitry Safonov <0x7f454c46@gmail.com> writes:
> 
>> Gentle ping, in case you have time to look at this.
> 
> I'm looking at it and so far I'm quite happy.
> 
> Andy, Vincenco any opinions?
> 

I started looking at them after the holidays, in general I am happy with what I
have seen till now.

I would like to complete some testing especially on the platforms that are not
touched by this patchset to make sure that there are no side effects on the
unified vDSOs and then I think I am ok with the series.

> Thanks,
> 
>         tglx
> 

-- 
Regards,
Vincenzo
