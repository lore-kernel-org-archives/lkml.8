Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F7F20658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGZGAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 02:00:24 -0400
Received: from cmta19.telus.net ([209.171.16.92]:33594 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgGZGAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 02:00:24 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jul 2020 02:00:22 EDT
Received: from montezuma.home ([154.5.226.127])
        by cmsmtp with SMTP
        id zZZxjw2ECpULuzZZyj4CWk; Sat, 25 Jul 2020 23:52:11 -0600
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=T9TysMCQ c=1 sm=1 tr=0
 a=f8b3WT/FcTuUJCJtQO1udw==:117 a=f8b3WT/FcTuUJCJtQO1udw==:17
 a=kj9zAlcOel0A:10 a=Br9LfDWDAAAA:8 a=UApgNeDKAAAA:8 a=Gwl-mn86xv-tTlo55B0A:9
 a=zLANoASCfEsYl41K:21 a=56Rf4ndOQ8NywRZd:21 a=GV-Okhsh7d87ayjz:21
 a=CjuIK1q_8ugA:10 a=TRW-o2S9CEoA:10 a=1V_mi3lkkEMA:10 a=Bg5cootq7XEA:10
 a=gR_RJRYUad_6_ruzA8cR:22 a=fasyu4nNmrhVRyehPdzp:22
Date:   Sat, 25 Jul 2020 22:52:08 -0700 (PDT)
From:   Zwane Mwaikambo <zwane@yosper.io>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix USB Type C hub crash in typec_altmode_update_active
Message-ID: <alpine.DEB.2.21.2007252222310.11533@montezuma.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfFPxr8l/iSWYkzCLtLBvByd9gimBTJQiswfFQdlvOs/MGCLXltSnHgdEcElUle0Lo7vsCgMjt7d/Sd932pwgPMeZfQvyA0Vvy5r/bCBpaXCVgrCcuh1A
 lw1RfnoBiX9qUsv5+HPc+5iq4qi+h00gbr/1jgSBKPLE4IQ4ov2WRTkHWG+tpw7X9Gw6oKT7TdZJqMlkwZkDMgJb969Isz3NnRA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following crash occurs whilst plugging in a Thinkpad USB type C dock 
and appears to be affecting other users as seen below;

https://bbs.archlinux.org/viewtopic.php?id=256404
https://forums.linuxmint.com/viewtopic.php?p=1826251

My specific crash is;

[  565.427757] input: USBPS2 as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.1/1-2.1.4/1-2.1.4:1.0/0003:0D3D:0001.0006/input/input31
[  565.452023] BUG: kernel NULL pointer dereference, address: 00000000000002fe
[  565.452025] #PF: supervisor read access in kernel mode
[  565.452026] #PF: error_code(0x0000) - not-present page
[  565.452026] PGD 0 P4D 0 
[  565.452028] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  565.452030] CPU: 0 PID: 502 Comm: kworker/0:3 Not tainted 5.8.0-rc3+ #1
[  565.452031] Hardware name: LENOVO 20RD002VUS/20RD002VUS, BIOS R16ET25W (1.11 ) 04/21/2020
[  565.452034] Workqueue: events ucsi_handle_connector_change [typec_ucsi]
[  565.452039] RIP: 0010:typec_altmode_update_active+0x1f/0x100 [typec]
[  565.452040] Code: 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 55 48 
89 e5 41 54 53 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 45 e8 31 c0 
<0f> b6 87 fc 02 00 00 83 e0 01 40 38 f0 0f 84 95 00 00 00 48 8b 47
[  565.452041] RSP: 0018:ffffb729c066bdb0 EFLAGS: 00010246
[  565.452042] RAX: 0000000000000000 RBX: ffffa067c3e64a70 RCX: 0000000000000000
[  565.452043] RDX: ffffb729c066bd20 RSI: 0000000000000000 RDI: 0000000000000002
[  565.452044] RBP: ffffb729c066bdd0 R08: 00000083a7910a4f R09: 0000000000000000
[  565.452044] R10: ffffffffa106a220 R11: 0000000000000000 R12: 0000000000000000
[  565.452045] R13: ffffa067c3e64a98 R14: ffffa067c3e64810 R15: ffffa067c3e64800
[  565.452046] FS:  0000000000000000(0000) GS:ffffa067d1400000(0000) knlGS:0000000000000000
[  565.452047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  565.452048] CR2: 00000000000002fe CR3: 00000001b060a003 CR4: 00000000003606f0
[  565.452048] Call Trace:
[  565.452052]  ucsi_altmode_update_active+0x83/0xd0 [typec_ucsi]
[  565.452054]  ucsi_handle_connector_change+0x1dc/0x320 [typec_ucsi]
[  565.452057]  process_one_work+0x1df/0x3d0
[  565.452059]  worker_thread+0x4d/0x3d0
[  565.452060]  ? process_one_work+0x3d0/0x3d0
[  565.452062]  kthread+0x127/0x170
[  565.452063]  ? kthread_park+0x90/0x90
[  565.452065]  ret_from_fork+0x1f/0x30

The failing instruction is;

0x0000000000000380 <+0>:     callq  0x385 <typec_altmode_update_active+5>
0x0000000000000385 <+5>:     push   %rbp
0x0000000000000386 <+6>:     mov    %rsp,%rbp
0x0000000000000389 <+9>:     push   %r12
0x000000000000038b <+11>:    push   %rbx
0x000000000000038c <+12>:    sub    $0x10,%rsp
0x0000000000000390 <+16>:    mov    %gs:0x28,%rax
0x0000000000000399 <+25>:    mov    %rax,-0x18(%rbp)
0x000000000000039d <+29>:    xor    %eax,%eax
0x000000000000039f <+31>:    movzbl 0x2fc(%rdi),%eax <======
0x00000000000003a6 <+38>:    and    $0x1,%eax

(gdb) list  *typec_altmode_update_active+0x1f
0x39f is in typec_altmode_update_active (drivers/usb/typec/class.c:221).
216      */
217     void typec_altmode_update_active(struct typec_altmode *adev, bool active)
218     {
219             char dir[6];
220
221             if (adev->active == active)
222                     return;
223
224             if (!is_typec_port(adev->dev.parent) && adev->dev.driver) {
225                     if (!active)

(gdb) list *ucsi_altmode_update_active+0x83
0x12a3 is in ucsi_altmode_update_active (drivers/usb/typec/ucsi/ucsi.c:221).
216             }
217
218             if (cur < UCSI_MAX_ALTMODES)
219                     altmode = typec_altmode_get_partner(con->port_altmode[cur]);
220
221             for (i = 0; con->partner_altmode[i]; i++)
222                     typec_altmode_update_active(con->partner_altmode[i],
223                                                con->partner_altmode[i] == altmode);
224     }

con->partner_altmode[i] ends up with the value 0x2 in the call and it's 
because the array has been accessed out of bounds.

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index d0c63afaf..30d0857e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -218,9 +218,12 @@ void ucsi_altmode_update_active(struct ucsi_connector *con)
 	if (cur < UCSI_MAX_ALTMODES)
 		altmode = typec_altmode_get_partner(con->port_altmode[cur]);
 
-	for (i = 0; con->partner_altmode[i]; i++)
-		typec_altmode_update_active(con->partner_altmode[i],
-					    con->partner_altmode[i] == altmode);
+	for (i = 0; i < UCSI_MAX_ALTMODES; i++) {
+        if (con->partner_altmode[i]) {
+		    typec_altmode_update_active(con->partner_altmode[i],
+			                            con->partner_altmode[i] == altmode);
+        }
+    }
 }
 
 static u8 ucsi_altmode_next_mode(struct typec_altmode **alt, u16 svid)
