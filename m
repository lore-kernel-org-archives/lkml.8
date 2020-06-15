Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474A8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAA92078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592253689;
	bh=I9SCldDCM2F8xO+W1jAhmUVhTeHpIcqek9qX09VqvTw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PFHiw9Stp8tjdb2nPl05WH4tUCMhIuLJkjv7ONoTB+3sxvEDf3+Y5tEdyR7eFQb0y
	 O0CsaDZWaZrPO13bKYfkGCSOXEQzwQMix/fTVbk7BWKgIiqVkZdjVdo6YskgqqFcS4
	 iwCrPvaFGr0ul+xuPXb4rOLKNQSSGCIHTDVE34E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgFOUl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:41:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C247C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:41:27 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id i74so17208226oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lPgdAQg/NNskl95Oiefe23XKClemS/K+1h35+L9Du5I=;
        b=LdXXRuDBhXBHVa25NXlGZX45y07aYSxRNuHnsRNtPTp/38cGoei8ZRxlyLx7OtukKk
         nj3MBjUbs+Scz/0Za2Nlll2+sqWzPZ3jQc2C3hPqGwDE8lDU+knPH6F2EfhqL1Rd/4zr
         XDOuw+IaajPShsPQUkWqA4ZIZl/4T8Euozs68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lPgdAQg/NNskl95Oiefe23XKClemS/K+1h35+L9Du5I=;
        b=ND/kyF8Ag++9SuUQ6ke3oexR2Tf5R61iyc5Pu06HDfoDgf8O9I82cdJtM4J3Z9Yh9T
         VjdiuQgWUVEUi5MRN2i0ac0gwTvtw+ZD1XTlu2cKnnDxnKj+1TL4wTwy5yo6VhkI6nti
         Vm19whUULtJZvKOi/KXcA2W0m4gC4k94AC1oG4yvwVK+QJG2KgDDatruHqBR+rDYN+q/
         g0gPT7TM4nVljqlrBM67MF4Pmt8CXAPIRJxcsIMoqd5UcIgkgjRM16wmmAJrylWuPkNS
         1RAh5bXo7mkzBAmWkvp/mXB0CwgKqUQZs6zNRDvw7503aGobnZoAJV9mHOugBFhS8Qe6
         FocQ==
X-Gm-Message-State: AOAM530RxzYHwTH2zca08jTJ03w8SgGUjd8pgfNL+xo0AldBLvL63glq
        JVk8t0T4wzzEWLhgX1vNyDHI1w==
X-Google-Smtp-Source: ABdhPJzmSXu1BdfeUXoMkxfsXOA/9/3GLK2vWaCzR0NwCyrRHBHgSvkGQ+8AeCXgIdOPi6cWzyXsAQ==
X-Received: by 2002:aca:4e0d:: with SMTP id c13mr984702oib.30.1592253686474;
        Mon, 15 Jun 2020 13:41:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a12sm3526732otl.29.2020.06.15.13.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 13:41:25 -0700 (PDT)
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
 <CAHk-=wjmZzz6b_9iBGp+3Nysb0A6_3VatmUdr_ArgyqHq0KMcA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f5102546-786d-eb63-10c5-97a92c0be311@linuxfoundation.org>
Date:   Mon, 15 Jun 2020 14:41:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjmZzz6b_9iBGp+3Nysb0A6_3VatmUdr_ArgyqHq0KMcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 1:48 PM, Linus Torvalds wrote:
> On Mon, Jun 15, 2020 at 11:48 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> I am seeing the following problem on my system. I haven't started debug
>> yet. Is this a known issue?
>>
>> [    9.791309] BUG: unable to handle page fault for address:
>> ffffb1e78165d000
>> [    9.791328] #PF: supervisor write access in kernel mode
>> [    9.791330] #PF: error_code(0x000b) - reserved bit violation
> 
> Hmm. "reserved bit violation" sounds like the page tables themselves
> are corrupt.
> 
>> [    9.791332] PGD 23dd5c067 P4D 23dd5c067 PUD 23dd5d067 PMD 22ba8e067
>> PTE 80001a3681509163
> 
> PTE low 12 bits 163 is "global", "dirty+accessed" + "kernel
> read-write", so that part looks fine. The top bit is NX. I'm not
> seeing any reserved bits set.
> 
> The page directory bits look sane too (067 is just the normal state
> for page tables).
> 
> The PTE does have bit 44 set. I think that's what triggers the
> problem. This is presumably on a machine with 44 physical address
> bits?
> 
> The faulting code is all in memset, and it's just doing "rep stosq" to
> fill memory with zeroes, and we have
> 
>      RAX: 0000000000000000 (the zero pattern)
>      RCX: 00000000000008a0 (repeat count)
>      RDI: ffffb1e78165d000 (the target address)
> 
> and that target address looks odd. If I read it right, it's at the
> 41TB mark in the direct-mapped area.
> 
> But I am probably mis-reading this.
> 
> Better bring in a few more x86 people. We did have some page table
> work this time around, with both the entry code changes but also the
> vmalloc faulting removal.
> 
> It doesn't _look_ like it's in the vmalloc range, though. But with
> that RCX value, it's certainly doing more than a single page.
> 
>> [    9.791367] Call Trace:
>> [    9.791377]  ? snd_pcm_hw_params+0x3ca/0x440 [snd_pcm]
>> [    9.791383]  snd_pcm_common_ioctl+0x173/0xf20 [snd_pcm]
>> [    9.791389]  ? snd_ctl_ioctl+0x1c5/0x710 [snd]
>> [    9.791394]  snd_pcm_ioctl+0x27/0x40 [snd_pcm]
>> [    9.791398]  ksys_ioctl+0x9d/0xd0
>> [    9.791400]  __x64_sys_ioctl+0x1a/0x20
>> [    9.791404]  do_syscall_64+0x49/0xc0
>> [    9.791406]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Can you re-create it with CONFIG_DEBUG_INFO enabled, and run it
> through scripts/decode_stacktrace.sh to give more details on where it
> happens.
> 

I have CONFIG_DEBUG_INFO enabled. Ran the stack trace through 
scripts/decode_stacktrace.sh

Log below.

-- Shuah

------------------------------------------------------------------------

[   15.341211] BUG: unable to handle page fault for address: 
ffffb1e782ba5000
[   15.341217] #PF: supervisor write access in kernel mode
[   15.341218] #PF: error_code(0x000b) - reserved bit violation
[   15.341220] PGD 23dd5c067 P4D 23dd5c067 PUD 23dd5d067 PMD 1fc3aa067 
PTE 80001a36827a9163
[   15.341225] Oops: 000b [#5] SMP NOPTI
[   15.341229] CPU: 5 PID: 1213 Comm: pulseaudio Tainted: G      D 
     5.8.0-rc1 #1
[   15.341231] Hardware name: LENOVO 10VGCTO1WW/3130, BIOS M1XKT45A 
08/21/2019
[   15.341237] RIP: 0010:__memset (arch/x86/lib/memset_64.S:41)
[ 15.341239] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 
e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 
<f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
All code
========
    0:	cc                   	int3
    1:	cc                   	int3
    2:	cc                   	int3
    3:	cc                   	int3
    4:	cc                   	int3
    5:	cc                   	int3
    6:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b:	49 89 f9             	mov    %rdi,%r9
    e:	48 89 d1             	mov    %rdx,%rcx
   11:	83 e2 07             	and    $0x7,%edx
   14:	48 c1 e9 03          	shr    $0x3,%rcx
   18:	40 0f b6 f6          	movzbl %sil,%esi
   1c:	48 b8 01 01 01 01 01 	movabs $0x101010101010101,%rax
   23:	01 01 01
   26:	48 0f af c6          	imul   %rsi,%rax
   2a:*	f3 48 ab             	rep stos %rax,%es:(%rdi)		<-- trapping 
instruction
   2d:	89 d1                	mov    %edx,%ecx
   2f:	f3 aa                	rep stos %al,%es:(%rdi)
   31:	4c 89 c8             	mov    %r9,%rax
   34:	c3                   	retq
   35:	90                   	nop
   36:	49 89 f9             	mov    %rdi,%r9
   39:	40 88 f0             	mov    %sil,%al
   3c:	48 89 d1             	mov    %rdx,%rcx
   3f:	f3                   	repz

Code starting with the faulting instruction
===========================================
    0:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    3:	89 d1                	mov    %edx,%ecx
    5:	f3 aa                	rep stos %al,%es:(%rdi)
    7:	4c 89 c8             	mov    %r9,%rax
    a:	c3                   	retq
    b:	90                   	nop
    c:	49 89 f9             	mov    %rdi,%r9
    f:	40 88 f0             	mov    %sil,%al
   12:	48 89 d1             	mov    %rdx,%rcx
   15:	f3                   	repz
[   15.341242] RSP: 0018:ffffb1e7827dbdd0 EFLAGS: 00010216
[   15.341244] RAX: 0000000000000000 RBX: ffff97b30e341800 RCX: 
00000000000008a0
[   15.341246] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffffb1e782ba5000
[   15.341247] RBP: ffffb1e7827dbe00 R08: ffffb1e780000000 R09: 
ffffb1e782ba5000
[   15.341249] R10: ffffffffffffffff R11: ffffb1e782ba5000 R12: 
0000000000000000
[   15.341251] R13: ffff97b30e347000 R14: ffffffffc0b48880 R15: 
ffff97b33aa42600
[   15.341253] FS:  00007fcbaebd4ec0(0000) GS:ffff97b33ed40000(0000) 
knlGS:0000000000000000
[   15.341256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.341257] CR2: ffffb1e782ba5000 CR3: 0000000229eb4000 CR4: 
00000000003406e0
[   15.341259] Call Trace:
[   15.341267] ? snd_pcm_hw_params+0x3ca/0x440 snd_pcm
[   15.341272] snd_pcm_common_ioctl+0x173/0xf20 snd_pcm
[   15.341277] ? snd_ctl_ioctl+0x1c5/0x710 snd
[   15.341282] snd_pcm_ioctl+0x27/0x40 snd_pcm
[   15.341285] ksys_ioctl (fs/ioctl.c:49 
/home/shuah/lkml/linux_5.8/fs/ioctl.c:753)
[   15.341288] __x64_sys_ioctl (fs/ioctl.c:760)
[   15.341291] do_syscall_64 (arch/x86/entry/common.c:359)
[   15.341294] entry_SYSCALL_64_after_hwframe 
(arch/x86/entry/entry_64.S:124)
[   15.341296] RIP: 0033:0x7fcbaf56137b
[ 15.341297] Code: Bad RIP value.
objdump: '/tmp/tmp.NDQZh43uz9.o': No such file

Code starting with the faulting instruction
===========================================
[   15.341298] RSP: 002b:00007ffde0397558 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[   15.341300] RAX: ffffffffffffffda RBX: 00007ffde0397760 RCX: 
00007fcbaf56137b
[   15.341301] RDX: 00007ffde0397760 RSI: 00000000c2604111 RDI: 
0000000000000013
[   15.341302] RBP: 0000555aeb4bcc10 R08: 0000000000000000 R09: 
0000000000000000
[   15.341303] R10: 0000000000000004 R11: 0000000000000246 R12: 
0000555aeb4bcb90
[   15.341304] R13: 00007ffde0397594 R14: 0000000000000000 R15: 
00007ffde0397760
[   15.341307] Modules linked in: ccm cmac algif_hash algif_skcipher 
af_alg bnep binfmt_misc nls_iso8859_1 snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel 
snd_usb_audio snd_intel_dspcfg snd_usbmidi_lib snd_hda_codec amdgpu mc 
snd_hda_core snd_hwdep snd_pcm edac_mce_amd iommu_v2 ath10k_pci 
snd_seq_midi gpu_sched snd_seq_midi_event kvm_amd kvm ttm snd_rawmidi 
ath10k_core irqbypass drm_kms_helper snd_seq cec i2c_algo_bit 
fb_sys_fops ath snd_seq_device syscopyarea snd_timer mac80211 
crct10dif_pclmul ghash_clmulni_intel btusb aesni_intel btrtl btbcm 
crypto_simd cryptd btintel serio_raw input_leds sysfillrect glue_helper 
bluetooth efi_pstore k10temp snd pl2303 wmi_bmof ecdh_generic ecc 
snd_pci_acp3x sysimgblt cfg80211 soundcore ccp libarc4 ipmi_devintf 
ipmi_msghandler mac_hid sch_fq_codel parport_pc ppdev lp parport drm 
ip_tables x_tables autofs4 hid_generic usbhid hid crc32_pclmul nvme ahci 
psmouse i2c_piix4 libahci nvme_core r8169 realtek wmi video
[   15.341342] CR2: ffffb1e782ba5000
[   15.341344] ---[ end trace 7b22a028ccaf2e79 ]---
------------------------------------------------------------------------
