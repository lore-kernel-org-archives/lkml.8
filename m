Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,TRACKER_ID,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2CD208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kqqSiqku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgGaQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgGaQIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:08:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=E8OutGXDvinZ9nc9PDwwcZ7dYyARjf7spI4x4vTTasM=; b=kqqSiqkuAu9N4FwMiyAgZ0tMmM
        MUTqJHCeUkgh3SYpV5meNlSkEty4qznhTVEIRwhgBrptGdWzC6FYQN8foxhu2vSFam5vUYEluQhvC
        IDaNLEGo9vlGaehDKHXDVikGJBOw8NAWtasBG4skcLfCf9bhHx2vJtoFP0LURtY7dp9EdGPXJs8sc
        wLDlV1O4dRq/4bFYx12EbOZpoWsKyp0T4maeM7stV7EW7lTFnRgAUpyJ0UuMusTGqAT20HmOIALTO
        WIHjBFDSukk7YPcnw1KH5ZN+YFsGudyy/ECjTOG0WItWGURejmU7V12BoP2ySnGZM8/EbvUbo04QC
        OTqGI0cA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1XZv-0004Ss-Gu; Fri, 31 Jul 2020 16:08:16 +0000
Subject: Re: upstream boot error: BUG: soft lockup in __do_softirq
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <00000000000060adcb05abb71eb6@google.com>
 <CACT4Y+ZnHF_b6hKQ_npjJ2fW7atZ7sP8WeGh-TDhu9UB0dcnPQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e93543a-ff0c-2433-7bed-4053da59d5c2@infradead.org>
Date:   Fri, 31 Jul 2020 09:08:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZnHF_b6hKQ_npjJ2fW7atZ7sP8WeGh-TDhu9UB0dcnPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 11:50 PM, Dmitry Vyukov wrote:
> On Fri, Jul 31, 2020 at 8:44 AM syzbot
> <syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    92ed3019 Linux 5.8-rc7
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10e84cdf100000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b45e47f6d958ae82
>> dashboard link: https://syzkaller.appspot.com/bug?extid=8472ea265fe32cc3bf78
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com
> 
> This is a qemu-kvm instance killing the host kernel somehow, the host
> kernel itself running qemu's is full of rcu stalls. I think this is
> not a bug in the tested kernel.
> We change rcu stall timeout to 120 seconds from the default 21s, but
> this happens only after boot using sysctls. I did not find any way to
> change the rcu timeout via cmdline/config (would be useful).

(adding Paul)


Documentation/RCU/stallwarn.rst says there is a Kconfig:

CONFIG_RCU_CPU_STALL_TIMEOUT

	This kernel configuration parameter defines the period of time
	that RCU will wait from the beginning of a grace period until it
	issues an RCU CPU stall warning.  This time period is normally
	21 seconds.

and Documentation/admin-guide/kernel-parameters.txt has 2 RCU stall timeouts,
one for CPU and one for tasks:

	rcupdate.rcu_cpu_stall_timeout= [KNL]
			Set timeout for RCU CPU stall warning messages.

	rcupdate.rcu_task_stall_timeout= [KNL]
			Set timeout in jiffies for RCU task stall warning
			messages.  Disable with a value less than or equal
			to zero.


-- 
~Randy

