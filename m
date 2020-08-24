Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206F7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE26920706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="THxbsg3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHXMdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:33:24 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:55434 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgHXMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:33:18 -0400
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2020 08:33:18 EDT
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6509364199;
        Mon, 24 Aug 2020 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598270592;
        bh=R9IScWyNs4lPY4Z8ddlg61zAztZ+6/6ZpKkRLqtxyXM=; h=From:To:Date;
        b=THxbsg3b1/F0BjucccZIQ84GnzQwrbsiSaiyO2YAD7leDrjdAamJ8vhahx056phm1
         aF6IRGhf4SuLEEZRRzABmjptPh8P3Pg69J2ZG/b6KW/m6By49AXKI7rt34NjC5qo1q
         MvbvjD640LCK+ZRqyA+Ic2stM+wZbAPL7cbWmz+k=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56C4C64195;
        Mon, 24 Aug 2020 05:03:01 -0700 (PDT)
Received: from SJDC-EXNABU01.us.trendnet.org (unknown [10.45.175.97])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Mon, 24 Aug 2020 05:03:01 -0700 (PDT)
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 SJDC-EXNABU01.us.trendnet.org (10.45.175.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 24 Aug 2020 05:03:00 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 24 Aug 2020 12:02:58 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913%18]) with mapi id
 15.01.1979.003; Mon, 24 Aug 2020 12:02:58 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: x86/kprobes: kretprobe fails to triggered if kprobe at function entry
 is not optimized (trigger by int3 breakpoint)
Thread-Topic: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Index: AdZ5/y9ucVi7Kf0NSwa8vnc6Q/ol0w==
Date:   Mon, 24 Aug 2020 12:02:58 +0000
Message-ID: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25622.007
X-TM-AS-Result: No--18.667-5.0-31-10
X-TMASE-MatchedRID: eC/X7EZaaiDK0Nzuhn6kKIlSWYvdSPSYN5dqZcIK7Vjg91xayX4L88ij
        F4UeOUZTuLbD9VM61s9EFcYZxWcTrqK/Gf0Lby3YAoNa2r+Edw04eGohd7gjNgd2elVmK++cCJ0
        g0s0TVzMmSkTqvL07q4tf4U6NBdD36PfSBINxuyESEYfcJF0pRT4H4hoqLeJJkY8eITaSJPhuNR
        GoPKGTofoN8+l3dEUSbe9EjMnITTu2eGGESuJjB0hwlOfYeSqxjZAiVOzXtXMcNByoSo036YR4R
        LK5G1ihwqWABcHTG0Dz3VBAZIuFAjWYHgPBpNXWJNzc11O35nrLRD51bz5RZBtVRURjpT+vffsK
        pZh0PPcZ1Cg3RHnUdjtCUTQMBxXLeJcau6RQVFEDWfzDlgii++RswBJPCCuIpdltGKiWi0VrUzp
        lS40g+eILL7qwzFI4jko/E9gxKEYoxElBqT5s9k2rn9j60W9bUb4EdIZGxuDFA/NpkBJRLa6S3t
        quNZSWoAVqb/W4frzle28aUBqR0dnvO7Z5jadZLIrMljt3adsyMSm+IFrbLo5B87s1dZQE6uIqc
        KPp5BNVgyF0BGNPATKHYLsR4q0LQ6tklRJO9igWeMpVNhsMwMRB0bsfrpPI6T/LTDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.667400-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25622.007
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-SNTS-SMTP: 61E137EF05805AC6F955E339B3D411C9C9E2BDDB4DFA5D89F2D9ACA97CEAEACF2000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--18.667-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

Starting from kernel 5.8 (x86_64), kretprobe handler will always missed if =
corresponding kprobe on function entry is not optimized (using break point =
instead).
Step to reproduce this:
1) Build the kretprobe example module (CONFIG_SAMPLE_KRETPROBES=3Dm)
2) Disable jump optimization (`sysctl debug.kprobes-optimization=3D0` or re=
gister any kprobe.post_handler at same location)
3) Insert the kretprobe_example module
4) Launch some process to trigger _do_fork
5) Remove kretprobe_example module
6) dmesg shows that all probing instances are missed

Example output:
# sysctl debug.kprobes-optimization=3D0
debug.kprobes-optimization =3D 0
# insmod samples/kprobes/kretprobe_example.ko
# ls > /dev/null
# rmmod kretprobe_example
# dmesg
[48555.067295] Planted return probe at _do_fork: 0000000038ae0211
[48560.229459] kretprobe at 0000000038ae0211 unregistered
[48560.229460] Missed probing 3 instances of _do_fork

After bisecting, I found this behavior seems to introduce by this commit: (=
5.8-rc1)
0d00449c7a28a1514595630735df383dec606812 x86: Replace ist_enter() with nmi_=
enter()
This make kprobe_int3_handler() effectively running as NMI context, which p=
re_handler_kretprobe() explicitly checked to prevent recursion.

(in_nmi() check appears from v3.17)
f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hit in NMI=
 context to avoid deadlock

To make kretprobe work again with int3 breakpoint, I think we can replace t=
he in_nmi() check with in_nmi() =3D=3D (1 << NMI_SHIFT) at kprobe_int3_hand=
ler() and skip kretprobe if nested NMI.
Did a quick test on 5.9-rc2 and it seems to be working.
I'm not sure if it is the best way to do since it may also require change t=
o other architecture as well, any thought?


TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>
