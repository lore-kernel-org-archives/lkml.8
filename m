Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94149C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C4C21556
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L7/St8Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgIIMa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:30:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:37945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbgIIMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599654215;
        bh=ZmcmNuf+aCLdbzvgwCLFB50F3JeTe0WOU1Tla4FEgEE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=L7/St8Ehsamzs+K36NlG+lTO4is8qf4OBUSDXaLFh3I60mOvP5ukTeZh45ER0vXlq
         fA+idFVCv4x+9GT2ZY6ZQ7Pd2e+r5V1eekflq+Lrigg6aTgXCmJlOyi3JCmcYdMlwl
         M//OLcr2YaT5ciwBCQm1qqfT41NtaeUj9pw6aJn4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1kZcZ506iu-016P6D; Wed, 09
 Sep 2020 14:23:35 +0200
Message-ID: <1ea7646a7c641b9c7495d21a5e00b903cac307dc.camel@gmx.de>
Subject: nouveau: BUG: Invalid wait context
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Wed, 09 Sep 2020 14:23:34 +0200
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NIRTQgXfMuNJ2jYLTGIbJxUPRKSrucq8G3eVHDSVCOlZtpZgbcW
 tJo4YWQdMHC6lG3YezC9mE/rT7alv7bDPfTspRQ8FfXC7PsixmzeK5gWxCsWLFcdw8RWJ1g
 kS8wFJEzQazmIjIehC72GHsN0XC1JdenwXoDcwqK8RQdVknLWly7B27gS2ayd5uz2MqMdz6
 7mLCYwl8Gt+iidmOmPmBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R3+ExrLnxyI=:oWNycaQCZx4dvSJuIBJRw+
 sT2NyOQP8+gPFBb4VFlFvhGHEoVQnCLesy95+pYgLDYQJM5ow22dlk8E4x+jOoZvPUIuGTh/T
 Vj7iI1VXI0YsC4bvFdmJdKSnTvx0qL6bJPb4AJO9ThlDURE5iJAsp7DapFlrfu0DWEUYK0wqR
 m8F2Dl7fUwNSnpTzC+FKJ4XwRHqPRniwscyDOBSKd8f0grdB03rorc0ocwKnjpSp2AwFa2Xos
 ysVP2F1eCnPEibnVBuiGA0J052gHxKAJUUuwEr/8LeZXeryNsQp9QthHR0B7fUJ8+EnIgFjoZ
 1utr4OIHpA9gFW6wJ3qjiTRgcpNxhVrjhA2V/V+WiV3r3Bigvv5dUpqf19WcGSLzRJKfOBMwQ
 33A/+6pQxp2yHWl0AkSPdN+zy769i8swbOAewwVKMWc7apodnYvY9uwRBVLDcLLDeXtX85ld3
 0yYSw4mHWNXtrPEbFEbmYBexJw8Mwk7CJldMsE312jFJCPVfhksJrJ2rlqoCfjCk039cVpY5l
 EohrPBs40sV/sJHmKf+0VHDIgvy2GoDY8fqm8pEPScRtUOc/pPU0zVlaoY7oELj+l5hvwniCA
 7o0/yXhid/X8z1mnKDc/zvzrkxUxix2BnfmHo5kFB06L8hNBEnyEDh9mI1UC1rdcOe3QXU5Nn
 lX266z21cpkVA9gCpptXRQuyKpX7JUQggSxMy42+9+S4Sz5Q/21fWflkSlUDDTW8KZ5NLYADe
 eRQrPXw97gz55eGd9xe29/uSKmG8So27UndqNwqTPzu89c2fCOdkzMEIKUHLNsJysfect0dYd
 fizMFlaOwmoDrMjd/hS8OFFSRWxO97IkLLbEnQ0MZM8k576u9AeldyI3oKAHV+XLX5i1Xx/4X
 +nm8ksb3fR4r4t6kSl0OHnI0VxuCo2/PO1BsWj/4NYFjN6dIs3F20aBZG5fwZz4KlIF8J4izA
 aRCMb5Q4VSHGwo9G5f5FsZwpo98pFY89xPewDjnFkrKHxiKGJoDQ070lGGZ/8aYd+xzkgWyW8
 IahEp9sey+zT/0wSGxc0GB0vcqkeXG0TXiH8SHtxexo0D/VrH5rfm85ATVepqmhsmwHALWGkr
 SJPcsfHa0s/P3fyaTWue+IGH4sAJTZSUIPedMjjqci5QAVeRwhmSJfoZImzRibKnnLQJUgZm0
 987W1SeQLOtTxSZrZZCyQfVGgRVeJ8OvOUHafPB2glOPIb+a4OIkgvYRqfpQF8st1S8lalOxS
 6PAOH7Xkuiu7EbR+h
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Box is an aging generic i4790 + GTX-980 desktop.

[ 1143.133663] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1143.133666] [ BUG: Invalid wait context ]
[ 1143.133671] 5.9.0.g34d4ddd-preempt #2 Tainted: G S          E
[ 1143.133675] -----------------------------
[ 1143.133678] X/2015 is trying to lock:
[ 1143.133682] ffff8d3e9efd63d8 (&zone->lock){..-.}-{3:3}, at: get_page_fr=
om_freelist+0x6ed/0x1e10
[ 1143.133694] other info that might help us debug this:
[ 1143.133697] context-{5:5}
[ 1143.133700] 4 locks held by X/2015:
[ 1143.133703]  #0: ffff8d3e562d30c0 (&cli->mutex){+.+.}-{4:4}, at: nouvea=
u_abi16_get+0x2c/0x60 [nouveau]
[ 1143.133756]  #1: ffffa9a6c0c57d30 (reservation_ww_class_acquire){+.+.}-=
{0:0}, at: drm_ioctl_kernel+0x91/0xe0 [drm]
[ 1143.133785]  #2: ffff8d3e3dcef1a0 (reservation_ww_class_mutex){+.+.}-{4=
:4}, at: nouveau_gem_ioctl_pushbuf+0x63b/0x1cb0 [nouveau]
[ 1143.133834]  #3: ffff8d3e9ec9ea10 (krc.lock){-.-.}-{2:2}, at: kvfree_ca=
ll_rcu+0x65/0x210
[ 1143.133845] stack backtrace:
[ 1143.133850] CPU: 2 PID: 2015 Comm: X Kdump: loaded Tainted: G S        =
  E     5.9.0.g34d4ddd-preempt #2
[ 1143.133856] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[ 1143.133862] Call Trace:
[ 1143.133872]  dump_stack+0x77/0x9b
[ 1143.133879]  __lock_acquire+0x629/0xbd0
[ 1143.133887]  ? try_to_wake_up+0x250/0x860
[ 1143.133894]  lock_acquire+0x92/0x390
[ 1143.133900]  ? get_page_from_freelist+0x6ed/0x1e10
[ 1143.133908]  ? __mutex_unlock_slowpath+0x124/0x280
[ 1143.133915]  _raw_spin_lock+0x2f/0x40
[ 1143.133921]  ? get_page_from_freelist+0x6ed/0x1e10
[ 1143.133927]  get_page_from_freelist+0x6ed/0x1e10
[ 1143.133937]  ? lock_acquire+0x92/0x390
[ 1143.133943]  ? kvfree_call_rcu+0x65/0x210
[ 1143.133949]  __alloc_pages_nodemask+0x173/0x3e0
[ 1143.133957]  __get_free_pages+0xd/0x40
[ 1143.133962]  kvfree_call_rcu+0x135/0x210
[ 1143.134002]  nouveau_fence_unref+0x36/0x50 [nouveau]
[ 1143.134045]  validate_fini_no_ticket.isra.8+0x138/0x240 [nouveau]
[ 1143.134090]  nouveau_gem_ioctl_pushbuf+0x10c8/0x1cb0 [nouveau]
[ 1143.134136]  ? nouveau_gem_ioctl_new+0xc0/0xc0 [nouveau]
[ 1143.134159]  ? drm_ioctl_kernel+0x91/0xe0 [drm]
[ 1143.134170]  drm_ioctl_kernel+0x91/0xe0 [drm]
[ 1143.134182]  drm_ioctl+0x2db/0x380 [drm]
[ 1143.134211]  ? nouveau_gem_ioctl_new+0xc0/0xc0 [nouveau]
[ 1143.134217]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[ 1143.134222]  ? lockdep_hardirqs_on+0x78/0x100
[ 1143.134226]  ? _raw_spin_unlock_irqrestore+0x34/0x60
[ 1143.134257]  nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[ 1143.134263]  __x64_sys_ioctl+0x8e/0xd0
[ 1143.134267]  ? lockdep_hardirqs_on+0x78/0x100
[ 1143.134271]  do_syscall_64+0x33/0x40
[ 1143.134276]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1143.134280] RIP: 0033:0x7f02e2a84ac7
[ 1143.134284] Code: b3 66 90 48 8b 05 d1 13 2c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 13 2c 00 f7 d8 64 89 01 48
[ 1143.134293] RSP: 002b:00007ffe2c2739e8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
[ 1143.134298] RAX: ffffffffffffffda RBX: 0000560c3f86ec08 RCX: 00007f02e2=
a84ac7
[ 1143.134302] RDX: 00007ffe2c273a50 RSI: 00000000c0406481 RDI: 0000000000=
00000e
[ 1143.134306] RBP: 00007ffe2c273a50 R08: 0000560c3f846820 R09: 0000560c3f=
87fc08
[ 1143.134310] R10: 0000560c401dbb38 R11: 0000000000000246 R12: 00000000c0=
406481
[ 1143.134314] R13: 000000000000000e R14: 0000560c3f846820 R15: 0000560c3f=
84a010

