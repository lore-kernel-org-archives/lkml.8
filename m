Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518EEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8220772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHKJJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:09:13 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58757 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbgHKJJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:09:13 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7CB69206462B4;
        Tue, 11 Aug 2020 11:09:10 +0200 (CEST)
Subject: Re: Start messages in message buffer missing (dmesg)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, it+x86@molgen.mpg.de
References: <264bfbae-122d-9c41-59ea-6413f91bd866@molgen.mpg.de>
 <83254c10-bf5e-8390-c6fa-45bb51bb2f73@molgen.mpg.de>
Message-ID: <23843d61-0b9f-8801-389f-3e9d144c081e@molgen.mpg.de>
Date:   Tue, 11 Aug 2020 11:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <83254c10-bf5e-8390-c6fa-45bb51bb2f73@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Am 11.08.20 um 00:13 schrieb Paul Menzel:
> Am 21.07.20 um 17:20 schrieb Paul Menzel:
> 
>> On two identical Dell PowerEdge T440 with Linux 5.4.39 and systemd 242
>>
>>      00:00.0 Host bridge [0600]: Intel Corporation Sky Lake-E DMI3 Registers [8086:2020] (rev 07)
>>
>> running `dmesg`, it’s truncated despite the buffer not yet filled.
>>
>>> $ sudo dmidecode -t2
>>> # dmidecode 3.0
>>> Getting SMBIOS data from sysfs.
>>> SMBIOS 3.2 present.
>>> # SMBIOS implementations newer than version 3.0 are not
>>> # fully supported by this version of dmidecode.
>>>
>>> Handle 0x0200, DMI type 2, 8 bytes
>>> Base Board Information
>>>     Manufacturer: Dell Inc.
>>>     Product Name: 02KM69
>>>     Version: A04
>>
>> The message cutoffs differ.
>>
>>> @sang:~$ dmesg | head
>>> [    6.362201] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
>>> [    6.369102] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
>>> [    6.376003] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
>>> [    6.376176] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
>>> [    6.376319] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
>>> [    6.376451] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
>>> [    6.383352] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
>>> [    6.390251] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
>>> [    6.397149] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
>>> [    6.404049] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
>>
>>> @mouches:~$ dmesg | head
>>> [    6.623209] pci 0000:00:1c.4: PCI bridge to [bus 02-03]
>>> [    6.628723] pci 0000:00:1c.4:   bridge window [mem 0x92000000-0x928fffff]
>>> [    6.635795] pci 0000:00:1c.4:   bridge window [mem 0x91000000-0x91ffffff 64bit pref]
>>> [    6.644046] pci 0000:04:00.0: BAR 6: assigned [mem 0x90000000-0x9003ffff pref]
>>> [    6.651772] pci 0000:04:00.1: BAR 6: assigned [mem 0x90040000-0x9007ffff pref]
>>> [    6.659494] pci 0000:00:1c.5: PCI bridge to [bus 04]
>>> [    6.664752] pci 0000:00:1c.5:   bridge window [mem 0x90000000-0x900fffff]
>>> [    6.671834] pci 0000:00:1c.5:   bridge window [mem 0x92e00000-0x92efffff 64bit pref]
>>> [    6.680085] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>>> [    6.686566] pci_bus 0000:00: resource 5 [io  0x1000-0x3fff window]
>>
>>> @sang:~$ head /dev/kmsg
>>> 6,862,6362201,-;system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
>>>  SUBSYSTEM=pnp
>>>  DEVICE=+pnp:00:01
>>> 6,863,6369102,-;system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
>>>  SUBSYSTEM=pnp
>>>  DEVICE=+pnp:00:01
>>> 7,864,6376003,-;system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
>>>  SUBSYSTEM=pnp
>>>  DEVICE=+pnp:00:01
>>> 7,865,6376176,-;pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
>>
>>> @sang:~$ cp /dev/kmsg /dev/shm/kmsg
>>> ^C
>>> @sang:~$ ls -lh /dev/shm/kmsg
>>> -rw-r----- 1 pmenzel pmenzel 135K Jul 21 13:53 /dev/shm/kmsg
>>
>> So, the size is smaller than 128 KB + 16 * 4 KB = 192 KB. The systemd 
>> journal contains some earlier messages.
> 
> This seems incorrect. See below.
> 
>>> @sang:~$ sudo journalctl -k | head
>>> -- Logs begin at Wed 2020-06-03 14:31:56 CEST, end at Tue 2020-07-21 
>>> 13:54:38 CEST. --
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel:   Normal zone: 315392 pages used for memmap
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel:   Normal zone: 20185088 pages, LIFO batch:63
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel: Initmem setup node 1 [mem 0x0000001440000000-0x000000203fffffff]
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel: On node 1 totalpages: 12582912
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel:   Normal zone: 196608 pages used for memmap
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel:   Normal zone: 12582912 pages, LIFO batch:63
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel: ACPI: PM-Timer IO Port: 0x508
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel: ACPI: Local APIC address 0xfee00000
>>> Jul 16 18:08:59 sang.molgen.mpg.de kernel: ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
>>>
>>> @sang:~$ sudo journalctl -k > /dev/shm/journalctl-k.txt
>>> @sang:~$ ls -lh /dev/shm/journalctl-k.txt
>>> -rw-rw---- 1 pmenzel pmenzel 191K Jul 21 13:55 /dev/shm/journalctl-k.txt
>>
>> The systemd journal output starts at the same position on both systems.
>>
>> But now, trying to get the full log over serial console, the full log 
>> is now present too on one system, when running `dmesg`. Detaching the 
>> serial console, the behavior stays the same, that means all messages 
>> are there. I am confused, how this could have fixed anything.
>>
>> Is somebody interested into looking into this, or should a just fix 
>> the affected system by plugging in a serial cable too?
> 
> It turns out, that the issue with the serial console seems to have been 
> an exception or maybe a testing error.
> 
> The issue still happens with current Linux master 
> v5.8-11935-g8d3e09b43312 and the attached debug patch on top.
> 
> But first, from `init/Kconfig`:
> 
>>           The increased size means that a new buffer has to be allocated and
>>           the original static one is unused. It makes sense only on systems
>>           with more CPUs. Therefore this value is used only when the sum of
>>           contributions is greater than the half of the default kernel ring
>>           buffer as defined by LOG_BUF_SHIFT. The default values are set
>>           so that more than 64 CPUs are needed to trigger the allocation.
> 
> As the ring buffer size defaults to 2^17 bytes = 128 KB, shouldn’t it be 
> 64 instead instead of 16 CPUs?

I sent a patch to correct that [1].

> Anyway, with the attached debug patch, I can confirm, that only 128 KB 
> are used. That could explain the lost messages. The serial log is attached.

The reason for the different behavior of some of the 16 CPU systems is, 
that these are two socket systems, and the Skylake systems also seem to 
have a lot more PCI devices.

     $ lspci | wc -l
     281

> On other systems, like my laptop with just four CPUs, despite the 128 KB 
> limit, the size of the stored messages is bigger.
> 
>      $ grep BUF_SHIFT /boot/config-5.7.0-2-amd64
>      CONFIG_LOG_BUF_SHIFT=17
>      CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
>      CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> 
> But the size of `/dev/kmsg` is 301393 bytes.

I missesd, that I have `log_buf_len=8M` set on the laptop. (Sorry for 
the noise.)

> So I wonder, what knobs decide, when the buffer is wrapped, and messages 
> are lost. I also wonder, why the systemd journal does not contain all 
> Linux kernel messages.
> 
> Lastly, should the default buffer size be increased from 128 KB to 512 
> KB as today machines should have enough room?

I am going to send a patch for that.


Kind regards,

Paul


[1]: https://lkml.org/lkml/2020/8/11/110
