Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C72C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D0D20774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/CADpbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMSyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgHMSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597344879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nX812eap8wQ1i6sEnvVEpbnnCtYgTczi2reeBOgzpdw=;
        b=J/CADpbAlEXwUasyRXb4nzp8UhK6zjEEAeWyDLeduavH8ROJolbdcTGX7onciu41MZZoBQ
        3wUQ2t7XYbUOQTNZWaa+BgD7z52tl8918XSR1N9peuiHyYEHN7/Sq8IAZQlQw0KXAhQCGK
        7igcx907QizVnnQEoI06TVsSpYJfx3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-NpGpaVmBMwmOXtihqYWkzg-1; Thu, 13 Aug 2020 14:54:35 -0400
X-MC-Unique: NpGpaVmBMwmOXtihqYWkzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB776A299;
        Thu, 13 Aug 2020 18:54:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FE585D9E2;
        Thu, 13 Aug 2020 18:54:33 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5393A1826D29;
        Thu, 13 Aug 2020 18:54:33 +0000 (UTC)
Date:   Thu, 13 Aug 2020 14:54:33 -0400 (EDT)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>, Paolo <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Message-ID: <741687682.7102456.1597344873115.JavaMail.zimbra@redhat.com>
In-Reply-To: <7D5E2A5D-DD5B-4774-AB9B-B16FBA4E2962@redhat.com>
References: <20200811003347.GH1538@shao2-debian> <7D5E2A5D-DD5B-4774-AB9B-B16FBA4E2962@redhat.com>
Subject: Re: [net] a65878d6f0: Oops:#[##]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.112.25, 10.4.195.24]
Thread-Topic: a65878d6f0: Oops:#[##]
Thread-Index: y32GDIz2VKqRTm95nT/DZG5U06T1ai3hq7QE
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for sending this again, as my phone did not want to sent it as plain =
text :(

----- Original Message -----
> From: "Eelco Chaudron" <echaudro@redhat.com>
> To: "kernel test robot" <lkp@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>, "Paolo" <pabeni@redhat.com>,=
 "LKML" <linux-kernel@vger.kernel.org>,
> lkp@lists.01.org
> Sent: Thursday, August 13, 2020 4:05:17 PM
> Subject: Re: [net] a65878d6f0: Oops:#[##]
>=20
>=20
> Hi All,
>=20
> Sorry for the late response but I'm on PTO and only noticed this email
> yesterday. I only have a slow and long latency internet connection at the
> moment and I tried to debug this using a terminal on my phone :(
>=20
> I'm able to see the issue when installing the tools and the commit mentio=
ned
> in the original email. I played with it a bit and even with the following
> diff it still fails:
>=20
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index 6b6822f82f70..d169e015b69d 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -2342,19 +2342,8 @@ static int ovs_vport_cmd_dump(struct sk_buff *skb,
> struct netlink_callback *cb)
>=20
> static void ovs_dp_masks_rebalance(struct work_struct *work)
> {
> -       struct ovs_net *ovs_net =3D container_of(work, struct ovs_net,
> -                                              masks_rebalance.work);
> -       struct datapath *dp;
> -
> -       ovs_lock();
> -
> -       list_for_each_entry(dp, &ovs_net->dps, list_node)
> -               ovs_flow_masks_rebalance(&dp->table);
> -
> -       ovs_unlock();
> -
> -       schedule_delayed_work(&ovs_net->masks_rebalance,
> -                             msecs_to_jiffies(DP_MASKS_REBALANCE_INTERVA=
L));
> +       panic("EC_DEBUG: TIMER\n");
> +       return;
> }
>=20
> static const struct nla_policy vport_policy[OVS_VPORT_ATTR_MAX + 1] =3D {
> @@ -2451,6 +2440,7 @@ static int __net_init ovs_init_net(struct net *net)
>=20
>        INIT_LIST_HEAD(&ovs_net->dps);
>        INIT_WORK(&ovs_net->dp_notify_work, ovs_dp_notify_wq);
> +       pr_err("EC_DEBUG: INIT\n");
>        INIT_DELAYED_WORK(&ovs_net->masks_rebalance, ovs_dp_masks_rebalanc=
e);
>        schedule_delayed_work(&ovs_net->masks_rebalance,
>                              msecs_to_jiffies(DP_MASKS_REBALANCE_INTERVAL=
));
> @@ -2488,6 +2478,8 @@ static void __net_exit ovs_exit_net(struct net *dne=
t)
>        struct net *net;
>        LIST_HEAD(head);
>=20
> +       panic("EC_DEBUG: DESTROY\n");
> +
>        ovs_lock();
>=20
>        ovs_ct_exit(dnet);
>=20
> Adding the panic()'s to confirm it's already failing before calling the
> destroy or actual callback function. When not adding the
> schedule_delayed_work() it works fine ;) Anyone any idea? The various err=
ors
> seem to happen around the time the delayed work is about ot be scheduled.
>=20
> I'll continue to debug this once I get home after the weekend and have pr=
oper
> system access.
>=20
> Here is one of the failures with the diff above in case anyone is interes=
ted:
>=20
> [   14.100870] INFO: trying to register non-static key.
> [   14.101429] the code is fine but needs lockdep annotation.
> [   14.102075] turning off the locking correctness validator.
> [   14.102827] CPU: 1 PID: 144 Comm: rcu_torture_rea Tainted: G S
> 5.8.0-rc4-01973-ga65878d6f00b-dirty #21
> [   14.103996] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> 1.13.0-2.fc32 04/01/2014
> [   14.104930] Call Trace:
> [   14.105269]  <SOFTIRQ>
> [   14.105602]  dump_stack+0x73/0x9e
> [   14.106045]  register_lock_class+0x5d5/0x5e0
> [   14.106571]  ? kvm_clock_read+0x3f/0x80
> [   14.107036]  __lock_acquire+0x48/0x6a0
> [   14.107481]  ? pvclock_clocksource_read+0xc0/0x1a0
> [   14.108058]  lock_acquire+0x72/0x200
> [   14.108517]  ? trace_timer_expire_entry+0x180/0x180
> [   14.109113]  ? sched_clock+0x8/0x20
> [   14.109553]  ? lock_acquire+0x72/0x200
> [   14.110011]  ? find_held_lock+0x22/0xa0
> [   14.110454]  call_timer_fn+0x52/0x160
> [   14.110901]  ? trace_timer_expire_entry+0x180/0x180
> [   14.111411]  __run_timers+0x155/0x1c0
> [   14.111830]  run_timer_softirq+0x14/0x40
> [   14.112422]  __do_softirq+0xd1/0x2ba
> [   14.112917]  ? __entry_text_end+0x3/0x3
> [   14.113362]  do_softirq_own_stack+0x1d/0x40
> [   14.113809]  </SOFTIRQ>
> [   14.114106]  irq_exit_rcu+0xb4/0x100
> [   14.114508]  sysvec_apic_timer_interrupt+0x66/0x120
> [   14.115019]  ? sysvec_call_function_single+0x120/0x120
> [   14.115518]  handle_exception+0x135/0x135
> [   14.115933] EIP: rcu_read_delay+0x68/0x1a0
> [   14.116337] Code: ff ff 7f 0f 84 c9 00 00 00 8d 65 f4 5b 5e 5f 5d c3 9=
0 89
> d8 e8 49 63 0f 00 69 0d 94 ab 98 c4 c0 27 09 00 ba 00 00 00 00 f7 f1 <85>=
 d2
> 75 aa a1 5c a0 98 c4 ff 50 18 89 45 f0 e8 c4 d6 06 00 85 d2
> [   14.118109] EAX: 00001b33 EBX: f23e9f4c ECX: 000927c0 EDX: 0002b43f
> [   14.118682] ESI: 00000010 EDI: f23e9e84 EBP: f23e9df8 ESP: f23e9de4
> [   14.119315] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000=
206
> [   14.120020]  ? add_chain_cache+0x25b/0x400
> [   14.120622]  ? irq_affinity_list_proc_write+0x18/0x20
> [   14.121339]  ? sysvec_call_function_single+0x120/0x120
> [   14.121950]  ? irq_affinity_list_proc_write+0x18/0x20
> [   14.122491]  ? sysvec_call_function_single+0x120/0x120
> [   14.123177]  ? rcu_read_delay+0x68/0x1a0
> [   14.123737]  rcutorture_one_extend+0x35f/0x660
> [   14.124228]  ? rcutorture_extend_mask_max+0x43/0x80
> [   14.124785]  rcutorture_loop_extend+0xb0/0xe0
> [   14.125315]  rcu_torture_one_read+0xe4/0x440
> [   14.125865]  ? rcu_torture_one_read+0x440/0x440
> [   14.126431]  rcu_torture_reader+0x7b/0x180
> [   14.126939]  ? rcu_torture_reader+0x180/0x180
> [   14.127368]  kthread+0x188/0x1c0
> [   14.127814]  ? rcu_torture_one_read+0x440/0x440
> [   14.128498]  ? kthread_insert_work_sanity_check+0x140/0x140
> [   14.129150]  ret_from_fork+0x19/0x30
> [   14.129579] BUG: kernel NULL pointer dereference, address: 00000000
> [   14.130173] #PF: supervisor read access in kernel mode
> [   14.130651] #PF: error_code(0x0000) - not-present page
> [   14.131249] *pde =3D 00000000
> [   14.131625] Oops: 0000 [#1] PREEMPT SMP
> [   14.132012] CPU: 1 PID: 144 Comm: rcu_torture_rea Tainted: G S
> 5.8.0-rc4-01973-ga65878d6f00b-dirty #21
> [   14.133033] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> 1.13.0-2.fc32 04/01/2014
> [   14.133981] EIP: 0x0
> [   14.134257] Code: Bad RIP value.
> [   14.134608] EAX: f0ce1960 EBX: 00000101 ECX: 00000000 EDX: 00000000
> [   14.135198] ESI: f0ce1960 EDI: 00000000 EBP: f3cd7f74 ESP: f3cd7f2c
> [   14.135849] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010=
246
> [   14.136889] CR0: 80050033 CR2: ffffffd6 CR3: 30381000 CR4: 00000690
> [   14.137592] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   14.138315] DR6: fffe0ff0 DR7: 00000400
> [   14.138755] Call Trace:
> [   14.139065]  <SOFTIRQ>
> [   14.139380]  call_timer_fn+0x66/0x160
> [   14.139800]  ? trace_timer_expire_entry+0x180/0x180
> [   14.140337]  __run_timers+0x155/0x1c0
> [   14.140763]  run_timer_softirq+0x14/0x40
> [   14.141222]  __do_softirq+0xd1/0x2ba
> [   14.141635]  ? __entry_text_end+0x3/0x3
> [   14.142072]  do_softirq_own_stack+0x1d/0x40
> [   14.142556]  </SOFTIRQ>
> [   14.142869]  irq_exit_rcu+0xb4/0x100
> [   14.143291]  sysvec_apic_timer_interrupt+0x66/0x120
> [   14.143843]  ? sysvec_call_function_single+0x120/0x120
> [   14.144458]  handle_exception+0x135/0x135
> [   14.144976] EIP: rcu_read_delay+0x68/0x1a0
> [   14.145496] Code: ff ff 7f 0f 84 c9 00 00 00 8d 65 f4 5b 5e 5f 5d c3 9=
0 89
> d8 e8 49 63 0f 00 69 0d 94 ab 98 c4 c0 27 09 00 ba 00 00 00 00 f7 f1 <85>=
 d2
> 75 aa a1 5c a0 98 c4 ff 50 18 89 45 f0 e8 c4 d6 06 00 85 d2
> [   14.147469] EAX: 00001b33 EBX: f23e9f4c ECX: 000927c0 EDX: 0002b43f
> [   14.148159] ESI: 00000010 EDI: f23e9e84 EBP: f23e9df8 ESP: f23e9de4
> [   14.148839] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000=
206
> [   14.149650]  ? add_chain_cache+0x25b/0x400
> [   14.150063]  ? irq_affinity_list_proc_write+0x18/0x20
> [   14.150557]  ? sysvec_call_function_single+0x120/0x120
> [   14.151057]  ? irq_affinity_list_proc_write+0x18/0x20
> [   14.151559]  ? sysvec_call_function_single+0x120/0x120
> [   14.152060]  ? rcu_read_delay+0x68/0x1a0
> [   14.152468]  rcutorture_one_extend+0x35f/0x660
> [   14.152905]  ? rcutorture_extend_mask_max+0x43/0x80
> [   14.153414]  rcutorture_loop_extend+0xb0/0xe0
> [   14.153961]  rcu_torture_one_read+0xe4/0x440
> [   14.154517]  ? rcu_torture_one_read+0x440/0x440
> [   14.155049]  rcu_torture_reader+0x7b/0x180
> [   14.155474]  ? rcu_torture_reader+0x180/0x180
> [   14.155918]  kthread+0x188/0x1c0
> [   14.156273]  ? rcu_torture_one_read+0x440/0x440
> [   14.156727]  ? kthread_insert_work_sanity_check+0x140/0x140
> [   14.157326]  ret_from_fork+0x19/0x30
> [   14.157746] Modules linked in:
> [   14.158098] CR2: 0000000000000000
> [   14.158469] ---[ end trace 17b918cae5b7ca5c ]---
> [   14.159075] EIP: 0x0
> [   14.159424] Code: Bad RIP value.
> [   14.159865] EAX: f0ce1960 EBX: 00000101 ECX: 00000000 EDX: 00000000
> [   14.160581] ESI: f0ce1960 EDI: 00000000 EBP: f3cd7f74 ESP: f3cd7f2c
> [   14.162619] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010=
246
> [   14.163278] CR0: 80050033 CR2: ffffffd6 CR3: 30381000 CR4: 00000690
> [   14.163874] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   14.164437] DR6: fffe0ff0 DR7: 00000400
> [   14.164833] Kernel panic - not syncing: Fatal exception in interrupt
> [   14.165526] Kernel Offset: disabled
>=20
> Cheers,
>=20
> Eelco
>=20
> Send from my phone
>=20
> > Op 11 aug. 2020 om 03:03 heeft kernel test robot <lkp@intel.com> het
> > volgende geschreven:
> >=20
> > =EF=BB=BFGreeting,
> >=20
> > FYI, we noticed the following commit (built with gcc-9):
> >=20
> > commit: a65878d6f00bb2d791348ae90dcc2ede1dbe2b91 ("net: openvswitch: fi=
xes
> > potential deadlock in dp cleanup code")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >=20
> >=20
> > in testcase: boot
> >=20
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -=
m
> > 16G
> >=20
> > caused below changes (please refer to attached dmesg/kmsg for entire
> > log/backtrace):
> >=20
> >=20
> > +-------------------------------------------------------+------------+-=
-----------+
> > |                                                       | dfd3d5266d |
> > |                                                       | a65878d6f0 |
> > +-------------------------------------------------------+------------+-=
-----------+
> > | boot_successes                                        | 147        | =
0
> > | |
> > | boot_failures                                         | 1          | =
148
> > | |
> > | BUG:kernel_hang_in_test_stage                         | 1          |
> > | |
> > | BUG:kernel_NULL_pointer_dereference,address           | 0          | =
134
> > | |
> > | Oops:#[##]                                            | 0          | =
142
> > | |
> > | EIP:_raw_spin_unlock_irqrestore                       | 0          | =
5
> > | |
> > | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | =
147
> > | |
> > | EIP:ring_buffer_event_data                            | 0          | =
1
> > | |
> > | EIP:__rb_reserve_next                                 | 0          | =
5
> > | |
> > | EIP:ring_buffer_consume                               | 0          | =
21
> > | |
> > | EIP:sched_clock                                       | 0          | =
1
> > | |
> > | EIP:trace_preempt_off                                 | 0          | =
1
> > | |
> > | EIP:__slab_alloc                                      | 0          | =
6
> > | |
> > | EIP:ftrace_likely_update                              | 0          | =
9
> > | |
> > | BUG:workqueue_lockup-pool                             | 0          | =
1
> > | |
> > | INFO:trying_to_register_non-static_key                | 0          | =
20
> > | |
> > | EIP:ring_buffer_unlock_commit                         | 0          | =
4
> > | |
> > | PANIC:double_fault                                    | 0          | =
1
> > | |
> > | double_fault:#[##]                                    | 0          | =
1
> > | |
> > | EIP:fib_info_devhash                                  | 0          | =
1
> > | |
> > | EIP:ring_buffer_lock_reserve                          | 0          | =
9
> > | |
> > | EIP:preempt_schedule_irq                              | 0          | =
2
> > | |
> > | EIP:rcutorture_one_extend                             | 0          | =
8
> > | |
> > | EIP:rb_commit                                         | 0          | =
3
> > | |
> > | EIP:lock_acquire                                      | 0          | =
5
> > | |
> > | EIP:default_idle                                      | 0          | =
7
> > | |
> > | EIP:tracer_preempt_on                                 | 0          | =
2
> > | |
> > | EIP:rb_move_tail                                      | 0          | =
1
> > | |
> > | EIP:debug_check_no_locks_freed                        | 0          | =
1
> > | |
> > | EIP:lock_release                                      | 0          | =
1
> > | |
> > | BUG:unable_to_handle_page_fault_for_address           | 0          | =
7
> > | |
> > | EIP:run_timer_softirq                                 | 0          | =
2
> > | |
> > | EIP:__local_bh_enable_ip                              | 0          | =
2
> > | |
> > | EIP:lock_is_held_type                                 | 0          | =
2
> > | |
> > | EIP:___might_sleep                                    | 0          | =
1
> > | |
> > | EIP:ring_buffer_consumer                              | 0          | =
2
> > | |
> > | EIP:kvm_sched_clock_read                              | 0          | =
1
> > | |
> > | EIP:rcutorture_extend_mask_max                        | 0          | =
1
> > | |
> > | EIP:__mutex_lock                                      | 0          | =
1
> > | |
> > | EIP:delay_tsc                                         | 0          | =
6
> > | |
> > | EIP:preempt_count_add                                 | 0          | =
1
> > | |
> > | EIP:__func                                            | 0          | =
3
> > | |
> > | EIP:rcutorture_extend_mask                            | 0          | =
1
> > | |
> > | EIP:__up_read                                         | 0          | =
1
> > | |
> > | EIP:preempt_count_sub                                 | 0          | =
1
> > | |
> > | EIP:pvclock_clocksource_read                          | 0          | =
1
> > | |
> > | invalid_opcode:#[##]                                  | 0          | =
2
> > | |
> > | EIP:security_file_permission                          | 0          | =
1
> > | |
> > | EIP:trace_preempt_on                                  | 0          | =
1
> > | |
> > | EIP:schedule                                          | 0          | =
1
> > | |
> > +-------------------------------------------------------+------------+-=
-----------+
> >=20
> >=20
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <lkp@intel.com>
> >=20
> >=20
> > LKP: HOSTNAME vm-snb-i386-97, MAC 52:54:00:12:34:56, kernel
> > 5.8.0-rc4-01973-ga65878d6f00bb 1, serial console /dev/ttyS0
> > Poky (Yocto Project Reference Distro) 2.7+snapshot vm-snb-i386-97
> > /dev/ttyS0
> > [   18.202172] #PF: supervisor read access in kernel mode
> > [   18.203388] #PF: error_code(0x0000) - not-present page
> > [   18.204682] *pde =3D 00000000
> > [   18.205509] Oops: 0000 [#1] PREEMPT SMP
> > [   18.206528] CPU: 1 PID: 150 Comm: rb_consumer Tainted: G S
> > 5.8.0-rc4-01973-ga65878d6f00bb #1
> > [   18.208725] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS
> > 1.12.0-1 04/01/2014
> > [   18.210554] EIP: 0xf3421ccc
> > [   18.211343] Code: 42 f3 68 1c 42 f3 d0 c2 e0 c4 40 97 69 c4 00 00 00=
 00
> > 8e f1 9f c3 00 00 03 00 01 00 00 00 56 48 cc c1 00 00 00 00 00 00 00 00
> > <ad> 4e ad de ff ff ff ff ff ff ff ff 68 42 e0 c4 40 65 69 c4 00 00
> > [   18.215301] EAX: f0a4f960 EBX: 00000101 ECX: 00000000 EDX: 00000000
> > [   18.216751] ESI: 00000000 EDI: f3421cc8 EBP: f38d7f74 ESP: f38d7f38
> > [   18.218188] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS:
> > 00010086
> > [   18.225566] CR0: 80050033 CR2: 00000000 CR3: 2f670000 CR4: 00040690
> > [   18.226822] Call Trace:
> > [   18.227402]  <SOFTIRQ>
> > [   18.227972]  ? call_timer_fn+0x99/0x440
> > [   18.228782]  run_timer_softirq+0x109/0x680
> > [   18.229752]  __do_softirq+0xac/0x5b4
> > [   18.230601]  ? __entry_text_end+0x3/0x3
> > [   18.231565]  do_softirq_own_stack+0x1d/0x40
> > [   18.232587]  </SOFTIRQ>
> > [   18.233253]  irq_exit_rcu+0xcd/0xe0
> > [   18.234141]  sysvec_apic_timer_interrupt+0x66/0x120
> > [   18.235185]  ? sysvec_call_function_single+0x120/0x120
> > [   18.236297]  handle_exception+0x135/0x135
> > [   18.237231] EIP: ring_buffer_consume+0x151/0x1e0
> > [   18.238336] Code: 08 ec c3 b9 01 00 00 00 e8 6c 6f 01 00 5a 89 f8 e8=
 44
> > 8a c1 01 8b 45 f0 f6 c4 02 0f 84 e8 fe ff ff e8 73 41 01 00 ff 75 f0 9d
> > <e9> e1 fe ff ff 66 90 8d 65 f4 89 f0 5b 5e 5f 5d c3 8d b6 00 00 00
> > [   18.258562] EAX: 0055ff2d EBX: f260e200 ECX: 00000000 EDX: 00000000
> > [   18.260031] ESI: 00000000 EDI: f260e210 EBP: f15bdf48 ESP: f15bdf24
> > [   18.261478] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS:
> > 00000247
> > [   18.262930]  ? sysvec_call_function_single+0x120/0x120
> > [   18.264142]  ? sysvec_call_function_single+0x120/0x120
> > [   18.265348]  ? ring_buffer_consume+0x151/0x1e0
> > [   18.266378]  ring_buffer_consumer+0x44/0x580
> > [   18.267409]  ? ring_buffer_consumer+0x580/0x580
> > [   18.268544]  ring_buffer_consumer_thread+0xb7/0x140
> > [   18.269683]  kthread+0x188/0x1c0
> > [   18.270519]  ? ring_buffer_consumer+0x580/0x580
> > [   18.271647]  ? kthread_create_worker_on_cpu+0x20/0x20
> > [   18.272782]  ret_from_fork+0x19/0x30
> > [   18.277955] Modules linked in:
> > [   18.278690] CR2: 0000000000000000
> > [   18.279490] ---[ end trace 02ab0044d3923ac9 ]---
> > [   18.280665] EIP: 0xf3421ccc
> > [   18.281431] Code: 42 f3 68 1c 42 f3 d0 c2 e0 c4 40 97 69 c4 00 00 00=
 00
> > 8e f1 9f c3 00 00 03 00 01 00 00 00 56 48 cc c1 00 00 00 00 00 00 00 00
> > <ad> 4e ad de ff ff ff ff ff ff ff ff 68 42 e0 c4 40 65 69 c4 00 00
> > [   18.290358] EAX: f0a4f960 EBX: 00000101 ECX: 00000000 EDX: 00000000
> > [   18.291605] ESI: 00000000 EDI: f3421cc8 EBP: f38d7f74 ESP: f38d7f38
> > [   18.292810] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS:
> > 00010086
> > [   18.294077] CR0: 80050033 CR2: 00000000 CR3: 2f670000 CR4: 00040690
> > [   18.295259] Kernel panic - not syncing: Fatal exception in interrupt
> > [   18.296516] Kernel Offset: disabled
> >=20
> > Elapsed time: 60
> >=20
> > qemu-img create -f qcow2 disk-vm-snb-i386-97-0 256G
> >=20
> >=20
> > To reproduce:
> >=20
> >        # build kernel
> >    cd linux
> >    cp config-5.8.0-rc4-01973-ga65878d6f00bb .config
> >    make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Di386 olddefconfig prepare
> >    modules_prepare bzImage
> >=20
> >        git clone https://github.com/intel/lkp-tests.git
> >        cd lkp-tests
> >        bin/lkp qemu -k <bzImage> job-script # job-script is attached in
> >        this email
> >=20
> >=20
> >=20
> > Thanks,
> > lkp
> >=20
> > <config-5.8.0-rc4-01973-ga65878d6f00bb>
> > <job-script>
> > <dmesg.xz>
>=20

