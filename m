Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB1DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBA7205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHKJor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:44:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:38100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgHKJoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:44:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D691ACA7;
        Tue, 11 Aug 2020 09:45:05 +0000 (UTC)
Date:   Tue, 11 Aug 2020 11:44:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200811094413.GA12903@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-11 12:40:22, Orson Zhai wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Timestamps printed in kernel log are retrieved by local_clock which reads
> jiffies as a referrence clock source.
> But it is diffcult to be synchronized with logs generated out of kernel,
> say some remote processors (Modem) in the Soc of mobile phones. 
> Jiffies will be unchanged when system is in suspend mode but Modem will
> not.
> 
> So timestamps are required to be compensated with suspend time in some
> complecated scenarios especially for Android system. As an initial
> implementation was rejected by Linus, Thomas made this patch [1] 2 yeas
> ago to replace ts_nsec with a struct ts that consists 3 types of time:
> mono, boot and real.
> 
> This is an updated version which comes from patch [1] written by Thomas
> and suggestion [2] about VMCORE_INFO given by Linus.
> 
> It provides the prerequisite code to print kernel logs with boot or real
> timestamp in the future.
>
> This patch has been tested in qemu-x86-system. One problem is the timestamp
> in kernel log will be printed [    0.000000] for longer time than before. 

This would be a regression. People put huge effort into having early boot
timestamps, see
https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin@oracle.com/
Adding some active people from this patchset into CC.

I wonder if we could have these early timestamps also in the mono clock.

> 1 [    0.000000] microcode: microcode updated early to revision 0x28, date = 2019-11-12 
> 2 [    0.000000] Linux version 5.8.0+ (root@spreadtrum) (gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #2 SMP Fri Aug 7 21:30:51 CST 2020
> 3 [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.8.0+ root=UUID=4d889bca-be18-433d-9b86-c1c1714cc293 ro quiet splash vt.handoff=1
> 4 [    0.000000] KERNEL supported cpus: 
> 5 [    0.000000]   Intel GenuineIntel
> ....
> 223 [    0.000000]  Tracing variant of Tasks RCU enabled. 
> 224 [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies. 
> 225 [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4 
> 226 [    0.000000] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16 
> 227 [    0.059662] random: crng done (trusting CPU's manufacturer) 
>          ^^^^^^^^
> 228 [    0.059662] Console: colour dummy device 80x25 
> 229 [    0.059662] printk: console [tty0] enabled 
> 230 [    0.059662] ACPI: Core revision 20200528 
> 
> compared to old log:
> 
> 69 [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000021fdfffff] usable
> 70 [    0.000000] efi: EFI v2.31 by American Megatrends
> 71 [    0.000000] efi: ESRT=0xdbf69818 ACPI=0xdaef8000 ACPI 2.0=0xdaef8000 SMBIOS=0xf0480
> 72 [    0.000000] SMBIOS 2.8 present.
> 73 [    0.000000] DMI: LENOVO ThinkCentre M4500t-N000/, BIOS FCKT58AUS 09/17/2014
> 74 [    0.000000] tsc: Fast TSC calibration using PIT
> 75 [    0.000000] tsc: Detected 3292.477 MHz processor
> 76 [    0.000503] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>         ^^^^^^^^
> 77 [    0.000504] e820: remove [mem 0x000a0000-0x000fffff] usable
> 78 [    0.000510] last_pfn = 0x21fe00 max_arch_pfn = 0x400000000
> 79 [    0.000513] MTRR default type: uncachable

[...]

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -366,7 +366,8 @@ enum log_flags {
>  };
>  
>  struct printk_log {
> -	u64 ts_nsec;		/* timestamp in nanoseconds */
> +	/* Timestamps in nanoseconds */
> +	struct timestamps ts;
>  	u16 len;		/* length of entire record */
>  	u16 text_len;		/* length of text buffer */
>  	u16 dict_len;		/* length of dictionary buffer */
> @@ -1090,7 +1091,9 @@ void log_buf_vmcoreinfo_setup(void)
>  	 * parse it and detect any changes to structure down the line.
>  	 */
>  	VMCOREINFO_STRUCT_SIZE(printk_log);
> -	VMCOREINFO_OFFSET(printk_log, ts_nsec);
> +	/* ts.mono used to be called "ts_nsec" */
> +	VMCOREINFO_FIELD_OFFSET(printk_log, ts_nsec, ts.mono);
> +	VMCOREINFO_OFFSET(printk_log, ts);
>  	VMCOREINFO_OFFSET(printk_log, len);
>  	VMCOREINFO_OFFSET(printk_log, text_len);
>  	VMCOREINFO_OFFSET(printk_log, dict_len);

At least "crash" tool would need an update anyway. AFAIK, it checks
the size of struct printk_log and refuses to read it when it changes.

It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
needed because we would need to update the crashdump-related tools anyway.

Well, the timing is good. We are about to switch the printk ring
buffer into a lockless one. It requires updating the crashdump tools
as well. We could do this at the same time. The lockless ring buffer
already is in linux-next. It is aimed for 5.10 or 5.11. We are still
discussion handling of continuous lines that might need another change
in the internal structures, see
https://lore.kernel.org/r/20200717234818.8622-1-john.ogness@linutronix.de

It would be great to synchronize all these changes changes of the
printk log buffer structures.

Best Regards,
Petr
