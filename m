Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC4BCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C52220661
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgEMJTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:19:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgEMJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:19:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D93N7S159001;
        Wed, 13 May 2020 05:19:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31016s4rwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 05:19:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04D9FPmH021730;
        Wed, 13 May 2020 09:19:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3100ub984p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 09:19:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04D9Hu2346662132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 09:17:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D0DDA404D;
        Wed, 13 May 2020 09:19:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC609A4053;
        Wed, 13 May 2020 09:19:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 13 May 2020 09:19:06 +0000 (GMT)
Date:   Wed, 13 May 2020 11:19:06 +0200
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [tracing] 06e0a548ba:
 WARNING:at_kernel/trace/ring_buffer.c:#ring_buffer_iter_peek
Message-ID: <20200513091906.GA12720@tuxmaker.boeblingen.de.ibm.com>
References: <20200429090508.GG5770@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429090508.GG5770@shao2-debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_03:2020-05-11,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 impostorscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Apr 29, 2020 at 05:05:09PM +0800, kernel test robot wrote:
> 
> kern  :warn  : [  886.763510] WARNING: CPU: 70 PID: 22584 at kernel/trace/ring_buffer.c:4067 ring_buffer_iter_peek+0x13c/0x1d0
> kern  :warn  : [  886.776216] Modules linked in: test_firmware intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm btrfs x86_pkg_temp_thermal intel_powerclamp blake2b_generic xor zstd_decompress zstd_compress coretemp ast kvm_intel kvm raid6_pq drm_vram_helper drm_ttm_helper libcrc32c irqbypass ttm crct10dif_pclmul crc32_pclmul drm_kms_helper snd_pcm crc32c_intel ghash_clmulni_intel ahci snd_timer syscopyarea libahci aesni_intel ipmi_ssif sysfillrect snd crypto_simd sysimgblt cryptd nvme fb_sys_fops mei_me soundcore ipmi_si glue_helper pcspkr drm nvme_core ioatdma ipmi_devintf t10_pi libata mei i2c_i801 joydev lpc_ich dca ipmi_msghandler wmi acpi_pad acpi_power_meter ip_tables
> kern  :warn  : [  886.838112] CPU: 70 PID: 22584 Comm: cat Not tainted 5.6.0-rc4-00017-g06e0a548bad0f #1
> kern  :warn  : [  886.846573] RIP: 0010:ring_buffer_iter_peek+0x13c/0x1d0
> kern  :warn  : [  886.852355] Code: 41 5e 41 5f c3 83 38 1d 0f 85 98 00 00 00 48 89 df e8 78 cb ff ff e9 32 ff ff ff 80 3c 24 00 75 c8 49 8b 44 24 10 f0 ff 40 08 <0f> 0b 4c 89 f6 4c 89 ef e8 37 8c 8f 00 48 83 c4 08 31 c0 5b 5d 41
> kern  :warn  : [  886.872239] RSP: 0018:ffffc900213e7d78 EFLAGS: 00010002
> kern  :warn  : [  886.878030] RAX: ffff889883ea7740 RBX: ffff88a3fbd93720 RCX: ffff88a42101b700
> kern  :warn  : [  886.885731] RDX: ffff88a415c02e00 RSI: ffff88a42101b440 RDI: ffff88a3fbd93720
> kern  :warn  : [  886.893432] RBP: 0000000000000000 R08: 000000ce959ae6ab R09: ffff88a42101bb80
> kern  :warn  : [  886.901129] R10: ffff88a3e99e2300 R11: 0000000000000178 R12: ffff88a415c02e00
> kern  :warn  : [  886.908831] R13: ffff88a415c02e18 R14: 0000000000000296 R15: ffffc900213e7df8
> kern  :warn  : [  886.916521] FS:  00007f12d51d2640(0000) GS:ffff88a44f780000(0000) knlGS:0000000000000000
> kern  :warn  : [  886.925179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kern  :warn  : [  886.931495] CR2: 00007f12d4e36000 CR3: 00000023e901e006 CR4: 00000000007606e0
> kern  :warn  : [  886.939194] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kern  :warn  : [  886.946896] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> kern  :warn  : [  886.954588] PKRU: 55555554
> kern  :warn  : [  886.957858] Call Trace:
> kern  :warn  : [  886.960866]  peek_next_entry+0x22/0x70
> kern  :warn  : [  886.965165]  __find_next_entry+0xaf/0x180
> kern  :warn  : [  886.969714]  trace_find_next_entry_inc+0x1e/0x80
> kern  :warn  : [  886.974863]  s_next+0x49/0x70
> kern  :warn  : [  886.978355]  seq_read+0x23f/0x400
> kern  :warn  : [  886.982193]  vfs_read+0x9b/0x160
> kern  :warn  : [  886.985937]  ksys_read+0xa1/0xe0
> kern  :warn  : [  886.989677]  do_syscall_64+0x5b/0x1f0
> kern  :warn  : [  886.993853]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kern  :warn  : [  886.999408] RIP: 0033:0x7f12d50f559e
> kern  :warn  : [  887.003479] Code: c0 e9 c6 fe ff ff 50 48 8d 3d 36 fc 09 00 e8 e9 e7 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> kern  :warn  : [  887.023260] RSP: 002b:00007ffdab31acd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> kern  :warn  : [  887.031350] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f12d50f559e
> kern  :warn  : [  887.039006] RDX: 0000000000020000 RSI: 00007f12d4e36000 RDI: 0000000000000005
> kern  :warn  : [  887.046657] RBP: 00007f12d4e36000 R08: 00007f12d4e35010 R09: 0000000000000000
> kern  :warn  : [  887.054305] R10: fffffffffffffc4d R11: 0000000000000246 R12: 00007f12d4e36000
> kern  :warn  : [  887.061958] R13: 0000000000000005 R14: 0000000000020000 R15: 0000000000000f93
> kern  :warn  : [  887.069608] ---[ end trace 507492ef8332a5b4 ]---
> 

Did you had a chance to look into this? I can easily reproduce this both on x86
and s390 by doing:

cd /sys/kernel/tracing
cat /dev/zero >/dev/null & # generate some load
echo function >current_tracer
# wait a few seconds to fill the buffer
cat trace

Usually it will print the warn after a few seconds.

I haven't digged through all the ring buffer code yet, so i thought i might ask
whether you have an idea what's going on.

Thanks
Sven
