Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F17C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358D721556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="TjAcZG2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgIJTnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:43:47 -0400
Received: from ale.deltatee.com ([204.191.154.188]:51902 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgIJTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mqZbVzmsfKWj+lMVqAxv2xawhMKrKccNVp1uKsRqjkw=; b=TjAcZG2gF/Q1/jjmaq90Alc/I3
        mZTNHNbU6Uvc+ezNAGA5tyY/7o70CEaui6bsQSt9iRJV5B8sePe1Gq7l4SMHCyOkVnPwIfGbkRAfu
        ub/1C78cV/p98zRpNUXcqR0o4KODwDpcEtD4pfwOTuRDG1QuZV6qQdXwpfPj3080BoP2XHik7d6+a
        JTdG0EbN2YtJKwiamWzIDWkyIWUsLkorN5+anb/28I8v6/SXO9i09iptjCtHdvCeR4XvtKmW0w1UJ
        roT/yNvWXeIK0nut7oNm/5cg3ub9nzHpVEUy2AqIRjEsahlb0I84HAWrMfdE/12bEEyD7JtVuIM/3
        kL2b3vZA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kGSSd-0006rV-LR; Thu, 10 Sep 2020 13:42:25 -0600
To:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c0ba7077-7977-0155-d7be-d4133ebaee5c@deltatee.com>
Date:   Thu, 10 Sep 2020 13:42:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jpoimboe@redhat.com, bp@alien8.de, naresh.kamboju@linaro.org, luto@kernel.org, mingo@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: WARNING: Kernel stack regs has bad 'bp' value
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of times now, I've hit a very rare kernel warning (see below)
while doing IO to an NVMe drive. I do not have a reliable way to
reproduce this bug but it seems to have started very roughly around v5.8.

I've found someone else (Naresh Kamboju) has reported a very similar
issue here[1] though there were no responses and I can't find the email
anywhere else but through that link. Naresh mentions a method to
reproduce the bug which I have not tried.

After some research on similar occurrences of this warning[2], it seems
to be caused by assembly code making use of the %rbp register and an
interrupt calling unwind_stack_frame() at just the wrong time (this
happens more frequently with KASAN enabled, which is the case on my
setup). When this happens, the offending function is seen in the stack dump.

One such function, which is common in all the stack dumps, is
asm_call_on_stack(). This was introduced in v5.8 and pushes and replaces
%rbp.

931b94145981 ("x86/entry: Provide helpers for executing on the irqstack")

I'm not sure if this is the cause of the bug but it seems worth looking
at. A comment in the code suggests that %rbp is saved for the ORC
unwinder, but perhaps this doesn't play nicely with the Frame Pointer
unwinder which is printing this warning.

Thanks,

Logan

[1] https://lkml.org/lkml/2020/7/9/22
[2]
https://groups.google.com/g/syzkaller-bugs/c/neRdimVvOA8/m/uz5cYgYpAgAJ?pli=1

--

[  124.402584] WARNING: kernel stack regs at 000000005bac7112 in sh:1014
has bad 'bp' value 0000000000000000
[  124.402587] unwind stack type:0 next_sp:0000000000000000 mask:0x6
graph_idx:0
[  124.402595] 000000003b6db269: ffff8881e9f899b0 (0xffff8881e9f899b0)
[  124.402611] 000000003e6136a5: ffffffffa3e72d7c
(arch_stack_walk+0x8c/0xf0)
[  124.402615] 000000007cc29951: 0000000000000000 ...
[  124.402617] 00000000f5dbb94b: ffff88812fdb0000 (0xffff88812fdb0000)
[  124.402620] 00000000a37858df: ffff88812fdb8000 (0xffff88812fdb8000)
[  124.402622] 000000004be8517c: 0000000000000000 ...
[  124.402624] 00000000f5ecfa27: 0000000000000006 (0x6)
[  124.402627] 000000000df4dd4c: ffff8881423d8000 (0xffff8881423d8000)
[  124.402629] 0000000031ab0079: 0000010100000000 (0x10100000000)
[  124.402631] 0000000085ccd551: 0000000000000000 ...
[  124.402633] 0000000088313210: ffff8881e9f89918 (0xffff8881e9f89918)
[  124.402639] 00000000a6ea20b3: ffffffffa3e05b08 (ret_from_fork+0x8/0x30)
[  124.402640] 0000000016b267e0: 0000000000000000 ...
[  124.402643] 000000009a3d4e72: ffff88812fdb7ea8 (0xffff88812fdb7ea8)
[  124.402645] 000000008a2cd333: 5e4f0f5150fb6200 (0x5e4f0f5150fb6200)
[  124.402648] 0000000074c5c44e: ffffed103d3f1338 (0xffffed103d3f1338)
[  124.402650] 00000000e9bb3815: 0000000000000800 (0x800)
[  124.402653] 0000000063ceba14: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.402664] 000000006a28199d: ffff8881e7412080 (0xffff8881e7412080)
[  124.402666] 000000009fc7a04d: ffff8881e9f89a48 (0xffff8881e9f89a48)
[  124.402672] 00000000c2f8622b: ffffffffa404b814
(stack_trace_save+0x94/0xc0)
[  124.402676] 00000000963d8698: 0000000041b58ab3 (0x41b58ab3)
[  124.402681] 000000006d8baeae: ffffffffa62fc25c (.LC18+0x26f2/0x15ffa)
[  124.402685] 000000005b32ec45: ffffffffa404b780
(stack_trace_consume_entry+0x90/0x90)
[  124.402687] 0000000037047949: ffff8881423d8c68 (0xffff8881423d8c68)
[  124.402690] 000000005f7b8e96: ffff8881e9f89a58 (0xffff8881e9f89a58)
[  124.402692] 00000000fb3e92b6: 0000000000000040 (0x40)
[  124.402694] 000000000d0cb721: 0000000000000015 (0x15)
[  124.402697] 000000009f34cccb: ffff8881423d8c90 (0xffff8881423d8c90)
[  124.402700] 00000000a183747b: ffff8881fffffffe (0xffff8881fffffffe)
[  124.402702] 000000001a9ac2f9: ffff8881ffffffff (0xffff8881ffffffff)
[  124.402705] 00000000c8b1d2bb: ffff8881423d8c98 (0xffff8881423d8c98)
[  124.402707] 000000008ff55cd4: 1ffff110ffffffff (0x1ffff110ffffffff)
[  124.402710] 000000005f9d4537: ffff8881423d8c78 (0xffff8881423d8c78)
[  124.402712] 00000000298dd3b4: 1ffff1103d3f134c (0x1ffff1103d3f134c)
[  124.402715] 000000008fb223b2: ffff8881423d8c70 (0xffff8881423d8c70)
[  124.402717] 00000000a46e311a: 5e4f0f5150fb6200 (0x5e4f0f5150fb6200)
[  124.402720] 000000001a204be0: 0000000000000001 (0x1)
[  124.402722] 000000007febcdb3: ffff8881e9f89c60 (0xffff8881e9f89c60)
[  124.402727] 00000000fff9f4db: ffffffffa431ad63 (save_stack+0x23/0x50)
[  124.402732] 0000000016822218: ffffffffa431ad63 (save_stack+0x23/0x50)
[  124.402735] 00000000dbdf7e7e: ffffffffa431aec7
(__kasan_slab_free+0x137/0x180)
[  124.402739] 00000000ea475544: ffffffffa431b55e (kasan_slab_free+0xe/0x10)
[  124.402742] 00000000e4333ff5: ffffffffa43187df
(kmem_cache_free+0x14f/0x3d0)
[  124.402745] 00000000f85761c8: ffffffffa421d2e7
(mempool_free_slab+0x17/0x20)
[  124.402748] 000000001e41078f: ffffffffa421d1c5 (mempool_free+0x65/0x170)
[  124.402753] 00000000d8dc0c7b: ffffffffa499253e (bio_free+0x7e/0xa0)
[  124.402756] 0000000086bbb0cd: ffffffffa49925c1 (bio_put+0x61/0x70)
[  124.402760] 000000002e5473e1: ffffffffa43fb754
(end_bio_bh_io_sync+0x64/0x80)
[  124.402763] 000000008c623a14: ffffffffa49927c2 (bio_endio+0x1f2/0x300)
[  124.402767] 00000000a717bc20: ffffffffa499cf4f
(blk_update_request+0x3bf/0x6c0)
[  124.402772] 0000000038f3d4d5: ffffffffa49b1ed5
(blk_mq_end_request+0x35/0x220)
[  124.402777] 00000000dc0bacc5: ffffffffa4d83c8e
(lo_complete_rq+0xde/0x130)
[  124.402781] 00000000b23627b4: ffffffffa49ad621
(blk_done_softirq+0x181/0x1d0)
[  124.402786] 000000008564b1f3: ffffffffa580011d (__do_softirq+0x11d/0x562)
[  124.402789] 000000003ff22fb1: ffffffffa5601042
(asm_call_on_stack+0x12/0x20)
[  124.402794] 00000000771e58bc: ffffffffa3e5999c
(do_softirq_own_stack+0xac/0xc0)
[  124.402798] 00000000140ed89b: ffffffffa3f48975 (irq_exit_rcu+0x105/0x110)
[  124.402802] 00000000ab571b98: ffffffffa5564467
(sysvec_call_function_single+0x57/0xf0)
[  124.402806] 00000000cfd0ee0e: ffffffffa5600d62
(asm_sysvec_call_function_single+0x12/0x20)
[  124.402809] 0000000098195c80: ffffffffa3e05b08 (ret_from_fork+0x8/0x30)
[  124.402812] 00000000fcc5fd5d: ffff8881423d8000 (0xffff8881423d8000)
[  124.402814] 00000000e8688105: ffff8881e9f89c28 (0xffff8881e9f89c28)
[  124.402818] 000000009a588430: ffffffffa3ffc961 (lock_acquire+0x171/0x4f0)
[  124.402824] 00000000f5077d55: 0000000000000000 ...
[  124.402827] 00000000a00afaf1: ffff8881e9f89b58 (0xffff8881e9f89b58)
[  124.402830] 000000009f118dd3: ffffffffa3ff224e (find_held_lock+0x8e/0xa0)
[  124.402833] 000000007f45e429: ffff8881e9f89c08 (0xffff8881e9f89c08)
[  124.402836] 0000000009d528e5: ffff8881e9f89b70 (0xffff8881e9f89b70)
[  124.402839] 00000000bc11b7c6: ffffffffa3ff8088
(mark_held_locks+0x28/0xa0)
[  124.402842] 0000000057e9242c: ffffffffffffffff (0xffffffffffffffff)
[  124.402845] 000000005a139f54: ffff8881423d8000 (0xffff8881423d8000)
[  124.402847] 00000000ffe59e14: 0000000000000220 (0x220)
[  124.402852] 000000005c46fdc4: ffffffffa4360ab3 (put_object+0x53/0x70)
[  124.402855] 000000002d6cdfbe: ffff8881e9fb6668 (0xffff8881e9fb6668)
[  124.402857] 00000000fc217232: 0000000000000046 (0x46)
[  124.402860] 000000007daedb21: ffff8881e9f89b98 (0xffff8881e9f89b98)
[  124.402863] 000000002036a048: ffffffffa5564c11
(lockdep_hardirqs_on+0x71/0xf0)
[  124.402865] 000000000a7e74c6: ffff888194d1a8f0 (0xffff888194d1a8f0)
[  124.402870] 0000000068f91b53: ffffffffa403adbe (call_rcu+0x1fe/0x370)
[  124.402872] 00000000fb00ae85: ffff8881e9f89bd0 (0xffff8881e9f89bd0)
[  124.402877] 00000000edfea3ef: ffffffffa4134e3d
(trace_hardirqs_on+0x2d/0x120)
[  124.402879] 00000000d6c5cee6: ffff888194d1a8f0 (0xffff888194d1a8f0)
[  124.402882] 000000008942523e: ffff8881e9fb65c0 (0xffff8881e9fb65c0)
[  124.402884] 0000000055942616: 0000000000000220 (0x220)
[  124.402887] 0000000045c14307: ffff8881e9fb6658 (0xffff8881e9fb6658)
[  124.402890] 000000004d840d49: ffff8881e9fb6668 (0xffff8881e9fb6668)
[  124.402893] 0000000096955ff9: ffff8881e9f89c38 (0xffff8881e9f89c38)
[  124.402895] 00000000acc737ac: 0000000000000246 (0x246)
[  124.402897] 00000000cbd0e5cf: 0000000000000000 ...
[  124.402899] 00000000990b1acf: 000000000000021f (0x21f)
[  124.402901] 0000000012de0506: 0000000000004e20 (0x4e20)
[  124.402904] 00000000db11b594: ffff8881e9fb6610 (0xffff8881e9fb6610)
[  124.402906] 00000000e87f1030: 0000000000000246 (0x246)
[  124.402909] 000000008147f3ef: ffff8881e9f89c40 (0xffff8881e9f89c40)
[  124.402912] 000000005f213a0f: ffffffffa3ff8088
(mark_held_locks+0x28/0xa0)
[  124.402914] 000000008199e37a: ffffffffffffffff (0xffffffffffffffff)
[  124.402917] 00000000b71a7b5a: ffff8881423d8000 (0xffff8881423d8000)
[  124.402919] 000000000d32172a: 0000000000000282 (0x282)
[  124.402922] 000000006f39c5e3: ffffffffa421d2e7
(mempool_free_slab+0x17/0x20)
[  124.402924] 00000000db1131ac: ffff8881e7412080 (0xffff8881e7412080)
[  124.402927] 000000002d7d288a: 0000000000000046 (0x46)
[  124.402929] 000000003b7a39e4: ffff8881e9f89c68 (0xffff8881e9f89c68)
[  124.402932] 00000000eb38c35d: ffffffffa5564c11
(lockdep_hardirqs_on+0x71/0xf0)
[  124.402935] 00000000dee18de8: ffff8881e01dfdb8 (0xffff8881e01dfdb8)
[  124.402937] 0000000006a625e6: ffff8881e9f89c90 (0xffff8881e9f89c90)
[  124.402941] 000000000837f13c: ffffffffa431aec7
(__kasan_slab_free+0x137/0x180)
[  124.402945] 00000000e17e1fd4: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.402947] 000000002f60a253: ffffea00078077c0 (0xffffea00078077c0)
[  124.402949] 00000000311346c1: 0000000000000282 (0x282)
[  124.402952] 00000000ae214c25: ffffffffa421d2e7
(mempool_free_slab+0x17/0x20)
[  124.402955] 000000005097a136: ffff8881e9f89ca0 (0xffff8881e9f89ca0)
[  124.402958] 000000008c43c07d: ffffffffa431b55e (kasan_slab_free+0xe/0x10)
[  124.402961] 000000002c1039ee: ffff8881e9f89cd8 (0xffff8881e9f89cd8)
[  124.402964] 00000000d4f0e73e: ffffffffa43187df
(kmem_cache_free+0x14f/0x3d0)
[  124.402973] 0000000076ca853c: ffffffffa88f0f10 (fs_bio_set+0x10/0x3c0)
[  124.402975] 000000009f825c64: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.402978] 000000005db3aab5: ffffffffa421d2d0 (mempool_free+0x170/0x170)
[  124.402981] 0000000045a8bdf1: ffffffffa88f0f50 (fs_bio_set+0x50/0x3c0)
[  124.402983] 000000002a994e77: 0000000000000002 (0x2)
[  124.402985] 00000000a63a17ab: ffff8881e9f89ce8 (0xffff8881e9f89ce8)
[  124.402988] 00000000b51eed98: ffffffffa421d2e7
(mempool_free_slab+0x17/0x20)
[  124.402991] 00000000cefa2baf: ffff8881e9f89d28 (0xffff8881e9f89d28)
[  124.402993] 000000009b85f3a2: ffffffffa421d1c5 (mempool_free+0x65/0x170)
[  124.402996] 0000000025fab153: ffff8881e9f89d28 (0xffff8881e9f89d28)
[  124.402998] 0000000057731934: ffffffffa88f0f00 (bio_slabs+0x40/0x40)
[  124.403001] 000000009d98b696: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.403003] 000000009e0b9a4d: 0000000000000000 ...
[  124.403005] 000000006a958e09: ffff8881e01dfd08 (0xffff8881e01dfd08)
[  124.403008] 00000000156a9f4b: ffff8881e01dfd38 (0xffff8881e01dfd38)
[  124.403010] 00000000fb51c703: ffff8881e9f89d50 (0xffff8881e9f89d50)
[  124.403013] 00000000433b98d3: ffffffffa499253e (bio_free+0x7e/0xa0)
[  124.403016] 000000005e939a41: ffffffffa43fbee0
(attach_nobh_buffers+0x290/0x290)
[  124.403019] 00000000da4d52ee: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.403021] 00000000f20dc499: ffff88815d617bc8 (0xffff88815d617bc8)
[  124.403024] 000000000919e5cc: ffff8881e9f89d70 (0xffff8881e9f89d70)
[  124.403027] 000000009405b026: ffffffffa49925c1 (bio_put+0x61/0x70)
[  124.403030] 00000000971d3955: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.403032] 0000000036b9fe9c: ffff88815d617bc8 (0xffff88815d617bc8)
[  124.403035] 000000004c3cf131: ffff8881e9f89d98 (0xffff8881e9f89d98)
[  124.403038] 00000000737016cc: ffffffffa43fb754
(end_bio_bh_io_sync+0x64/0x80)
[  124.403040] 0000000078e0e976: ffff8881e204a000 (0xffff8881e204a000)
[  124.403043] 00000000dbfecf9e: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.403045] 000000009db6333b: ffff8881e01dfd14 (0xffff8881e01dfd14)
[  124.403048] 000000006ff397da: ffff8881e9f89dd8 (0xffff8881e9f89dd8)
[  124.403051] 00000000faa82fdf: ffffffffa49927c2 (bio_endio+0x1f2/0x300)
[  124.403053] 00000000f1962ff8: 000000000000006e (0x6e)
[  124.403056] 0000000078108815: ffff8881e2068880 (0xffff8881e2068880)
[  124.403058] 00000000fcb904a2: 0000000000001000 (0x1000)
[  124.403060] 000000002512142a: 0000000000001000 (0x1000)
[  124.403063] 0000000076428861: ffff8881e01dfd28 (0xffff8881e01dfd28)
[  124.403065] 00000000e905316f: ffff8881e01dfd00 (0xffff8881e01dfd00)
[  124.403068] 00000000837a5855: ffff8881e9f89e50 (0xffff8881e9f89e50)
[  124.403071] 00000000b8909ed5: ffffffffa499cf4f
(blk_update_request+0x3bf/0x6c0)
[  124.403074] 0000000072cf19ba: ffff8881e20686c0 (0xffff8881e20686c0)
[  124.403076] 00000000c157d1b2: ffff8881e2068790 (0xffff8881e2068790)
[  124.403079] 000000001bb0b967: ffff8881e20688b0 (0xffff8881e20688b0)
[  124.403081] 000000000acabab7: ffff8881e2068898 (0xffff8881e2068898)
[  124.403084] 00000000b53ac7b8: ffff1a00e9f89e50 (0xffff1a00e9f89e50)
[  124.403086] 000000005e23b575: ffff8881e20688b8 (0xffff8881e20688b8)
[  124.403089] 0000000064260595: ffff8881e206889c (0xffff8881e206889c)
[  124.403092] 000000008e1398eb: ffff880000000000 (0xffff880000000000)
[  124.403093] 000000008c1bcba3: 0000000000000000 ...
[  124.403095] 00000000d1e4b1f9: ffff8881e2068880 (0xffff8881e2068880)
[  124.403097] 000000006b093848: 0000000000000000 ...
[  124.403099] 0000000048636579: ffff8881e2068880 (0xffff8881e2068880)
[  124.403102] 00000000d06d27f1: ffff8881e9f89e88 (0xffff8881e9f89e88)
[  124.403105] 00000000b793e6ce: ffffffffa49b1ed5
(blk_mq_end_request+0x35/0x220)
[  124.403106] 000000003c362de1: 0000000000000000 ...
[  124.403109] 0000000027a88894: ffff8881e2068880 (0xffff8881e2068880)
[  124.403111] 00000000c217f7c0: ffff8881e20689c0 (0xffff8881e20689c0)
[  124.403113] 00000000dfe0e168: 0000000000000000 ...
[  124.403115] 00000000c64c0629: ffff8881e2068880 (0xffff8881e2068880)
[  124.403118] 000000007659ed74: ffff8881e9f89eb8 (0xffff8881e9f89eb8)
[  124.403121] 000000008cbd6a63: ffffffffa4d83c8e
(lo_complete_rq+0xde/0x130)
[  124.403126] 00000000510eb702: ffffffffa5e2bee0
(loop_ctl_fops+0x120/0x120)
[  124.403129] 00000000c13a17c4: ffff8881e9f89ef8 (0xffff8881e9f89ef8)
[  124.403131] 000000002a2b65d7: ffff8881e9f89ef8 (0xffff8881e9f89ef8)
[  124.403134] 0000000081d7bbf2: ffff8881e20688e0 (0xffff8881e20688e0)
[  124.403136] 00000000b47c1910: ffff8881e9f89f60 (0xffff8881e9f89f60)
[  124.403139] 0000000018ab9c70: ffffffffa49ad621
(blk_done_softirq+0x181/0x1d0)
[  124.403142] 0000000079fd3e48: 1ffff1103d3f13db (0x1ffff1103d3f13db)
[  124.403144] 0000000013d79446: ffff8881e9f89ef8 (0xffff8881e9f89ef8)
[  124.403147] 0000000012ffdf92: 0000000041b58ab3 (0x41b58ab3)
[  124.403150] 000000006ae78286: ffffffffa635c6d9 (.LC0+0x46649/0x4a053)
[  124.403155] 00000000b40e07db: ffffffffa49ad4a0
(blk_softirq_cpu_dead+0xf0/0xf0)
[  124.403158] 00000000d86066a1: ffffffffa40313d5
(rcu_read_lock_sched_held+0xa5/0xc0)
[  124.403161] 00000000b2e196b0: ffff8881e9f89ef8 (0xffff8881e9f89ef8)
[  124.403163] 000000002caa8031: ffff8881e9f89ef8 (0xffff8881e9f89ef8)
[  124.403166] 00000000869f933a: ffffffffa4031330
(rcu_read_lock_bh_held+0xc0/0xc0)
[  124.403169] 00000000f737dc6e: ffffffffa5564c11
(lockdep_hardirqs_on+0x71/0xf0)
[  124.403172] 00000000f8c511cf: ffff8881423d8000 (0xffff8881423d8000)
[  124.403175] 00000000c69a9f37: ffffffffa58000e1 (__do_softirq+0xe1/0x562)
[  124.403178] 000000006f2013a0: ffff8881e9f89f60 (0xffff8881e9f89f60)
[  124.403180] 0000000028012d55: 5e4f0f5150fb6200 (0x5e4f0f5150fb6200)
[  124.403191] 00000000a8c9e427: ffffffffa66090e0 (softirq_vec+0x20/0x80)
[  124.403194] 000000009b55ab6c: 0000000000000004 (0x4)
[  124.403196] 000000003f5d9dc0: 0000000000000003 (0x3)
[  124.403198] 000000005a857afd: 0000000000000004 (0x4)
[  124.403200] 00000000662ce10c: 0000000000000004 (0x4)
[  124.403204] 00000000c0231116: ffff8881e9f89fe8 (0xffff8881e9f89fe8)
[  124.403208] 00000000535c8721: ffffffffa580011d (__do_softirq+0x11d/0x562)
[  124.403211] 000000005b08be59: ffffffffa4031330
(rcu_read_lock_bh_held+0xc0/0xc0)
[  124.403214] 00000000bf1d81ee: 01ffffff00404040 (0x1ffffff00404040)
[  124.403216] 00000000d8a409de: ffff8881423d8000 (0xffff8881423d8000)
[  124.403219] 00000000b3dccb43: 00000000ffff5387 (0xffff5387)
[  124.403221] 00000000e1699ac9: ffff8881423d8000 (0xffff8881423d8000)
[  124.403224] 00000000494a0ed0: 0000000000000004 (0x4)
[  124.403226] 000000000dc72f20: 0000000000000028 (0x28)
[  124.403228] 00000000ad7cdb37: 000001000000000a (0x1000000000a)
[  124.403232] 00000000137f797f: ffffffffa66090c0 (tasklist_lock+0x40/0x40)
[  124.403234] 00000000cc1b7b68: 0000001000000005 (0x1000000005)
[  124.403237] 00000000e6695420: ffff8881423d8000 (0xffff8881423d8000)
[  124.403240] 000000004493fe9a: ffff88812fdb7ea8 (0xffff88812fdb7ea8)
[  124.403242] 0000000017697a25: ffff8881e9f8a000 (0xffff8881e9f8a000)
[  124.403243] 0000000055078b84: 0000000000000000 ...
[  124.403246] 00000000a2496b43: ffff88812fdb7e38 (0xffff88812fdb7e38)
[  124.403249] 0000000062b5d445: ffffffffa5601042
(asm_call_on_stack+0x12/0x20)
[  124.403252] 0000000061d2c607: ffff88812fdb7e38 (0xffff88812fdb7e38)
[  124.403254] 00000000f74076a8: ffff88812fdb7e50 (0xffff88812fdb7e50)
[  124.403258] 00000000d320829d: ffffffffa3e5999c
(do_softirq_own_stack+0xac/0xc0)
[  124.403261] 00000000120c1c29: 0000000000000000 ...
[  124.403264] 000000007602d328: ffff88812fdb7e70 (0xffff88812fdb7e70)
[  124.403266] 0000000053d16ce4: ffffffffa3f48975 (irq_exit_rcu+0x105/0x110)
[  124.403268] 00000000e5945d11: 0000000000000000 ...
[  124.403270] 0000000065b175c0: ffff88812fdb7ea8 (0xffff88812fdb7ea8)
[  124.403273] 00000000b3a7cac5: ffff88812fdb7e98 (0xffff88812fdb7e98)
[  124.403276] 00000000794db6da: ffffffffa5564467
(sysvec_call_function_single+0x57/0xf0)
[  124.403277] 00000000cf1d6e59: 0000000000000000 ...
[  124.403280] 000000007d7a85ef: ffff88812fdb7ea9 (0xffff88812fdb7ea9)
[  124.403283] 00000000e47b2db2: ffffffffa5600d62
(asm_sysvec_call_function_single+0x12/0x20)
[  124.403285] 000000005bac7112: 0000000000000000 ...
[  124.403287] 00000000a71c73f4: 0000000000000001 (0x1)
[  124.403289] 00000000eb60ec71: 0000000000000000 ...
[  124.403291] 0000000096dab270: 0000000000000009 (0x9)
[  124.403293] 000000006fa64552: dffffc0000000000 (0xdffffc0000000000)
[  124.403295] 000000002e24c91d: 0000000000000000 ...
[  124.403298] 000000002c57bf88: ffffffffa557feb8
(_raw_spin_unlock_irq+0x28/0x40)
[  124.403301] 000000009019fa3c: ffffffffffffffff (0xffffffffffffffff)
[  124.403304] 00000000f0d708fb: ffffffffa3e05b08 (ret_from_fork+0x8/0x30)
[  124.403306] 00000000cb5b70e3: 0000000000000010 (0x10)
[  124.403309] 0000000004a6f42c: 0000000000000206 (0x206)
[  124.403311] 00000000141cb95a: ffff88812fdb7f58 (0xffff88812fdb7f58)
[  124.403313] 00000000f7f0df42: 0000000000000018 (0x18)
[  124.403317] 00000000a3a51698: ffffffffa3e05b08 (ret_from_fork+0x8/0x30)
[  124.403319] 0000000020376914: 0000564f97500d88 (0x564f97500d88)
[  124.403322] 00000000d7bd5a8f: 00007fff212b2720 (0x7fff212b2720)
[  124.403326] 00000000f8a5f9e4: 0000564f97500d88 (0x564f97500d88)
[  124.403327] 00000000cc4b8e7a: 0000000000000000 ...
[  124.403329] 000000000d9f002b: 0000000000000246 (0x246)
[  124.403332] 00000000a05f3aec: 00007f9dec893850 (0x7f9dec893850)
[  124.403334] 000000007d17233b: 00007f9dec893580 (0x7f9dec893580)
[  124.403336] 00000000b50c015e: 0000000000000000 ...
[  124.403338] 00000000ede0d9a6: 00007f9dec785f2f (0x7f9dec785f2f)
[  124.403339] 0000000007eba58d: 0000000000000000 ...
[  124.403342] 000000009b3d752c: 0000000001200011 (0x1200011)
[  124.403344] 00000000ce30f017: 0000000000000038 (0x38)
[  124.403347] 000000009c5f4391: 00007f9dec785f2f (0x7f9dec785f2f)
[  124.403349] 00000000822fdf7b: 0000000000000033 (0x33)
[  124.403351] 00000000d06ba420: 0000000000000246 (0x246)
[  124.403353] 000000005d61674b: 00007fff212b26c0 (0x7fff212b26c0)
[  124.403356] 000000004a9e6b23: 000000000000002b (0x2b)
