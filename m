Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B49CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0502080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QFMYJRX1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PS2e0B2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732182AbgFRRZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:25:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732163AbgFRRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:25:42 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IHPHG3005655;
        Thu, 18 Jun 2020 10:25:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Wy3N2xIDNU6MA6DmeSrFJ1zcP/kA9dsIrHc10NWe4JA=;
 b=QFMYJRX110WBS0bcVpSMk+mrtKKhAoVxxHm+YPflZurCppe8J+YCdKslA0UnJfddTR/o
 QmXwCv6WLyUxYkijQpYKJF+pKaPvISwALb0G9bfdjl5QbJgdgIyl2ydw+rvkXPl8+9TQ
 /KcO70uj8Bm66RSPU59cv9ZZv32FWhHvX+U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31r092bdgf-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 10:25:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 10:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6UMpta93sxm40EzZKZuaMwYjQH6q5q//v4bCKNE2rC6DJ4+EIUxqTm1c94KikHKssR8wOUvZ7IQfp/JOHafX02JDQAqx2VRWg/3o/gNUVWUTrRqHVMElhEFNBPlu7UPKnlc13qyyEROcD17BUn4/FIlC18XvAoGOwbWOZNBn+lahiuRLBfjs4lVbRpBtKVHKsrdCAywtP52+GIUmoRxqmumgtiPIzxBjCcJ9WByQoh6s4jDUOTcaRkq0fWEG9q+wLok56EBgxBiEbIMNpP4wzkf5dIH1Vd0fIluBZPGfbwqsP091kNsuMgBP02IdSl6pYo7bOQIQDROtjNbf+tBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy3N2xIDNU6MA6DmeSrFJ1zcP/kA9dsIrHc10NWe4JA=;
 b=XVkbZ5f0TiRZ2mZF4SB079ATNAKhZIYDoLucs7urOX69rcJQ81xTIBUtaOoETSa6F3GCivkQ+nDXooymJX42jVFiGNQSifqeuo7VEzx6EXeKv2/SefiBTZ7hCzY5rXuv0+Mfgy6v26vrfzDHHw0rCyrY/Dgtmjd+XpI1FFrv5kWlrqucoHnbTFgWMwwqQkP75DKcYuQk2fuBQYxj5aXsudXzUfBD7l0QW4DU3dEhrYzg5IsrSaQ3n5BnqiCRP8nmnTJ8NP/rM8VsmxTDRFP0Dse7b3krhrhCP4Id2ZvsIP18HHK8AJ82KWl/kM2xFd0gVRfakkRnJl4WJ/4UTHcOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy3N2xIDNU6MA6DmeSrFJ1zcP/kA9dsIrHc10NWe4JA=;
 b=PS2e0B2JJBdXL/ZwWVSPS3IHzKAMOqAJDZcv9pDWB3MI0zF/BYTQiDXDCYxEpHNtg9X3iit7WhAPF+7V2E7A/udI6Y5ywG+H2CpckDaZ57Om9OZ0cig2rJqc/om8EHBx2nT6cKavJT8mLdq7vgXZjcPHUgQFlMvA66LpOm07svc=
Received: from BN8PR15MB2995.namprd15.prod.outlook.com (2603:10b6:408:8a::16)
 by BN6PR15MB1812.namprd15.prod.outlook.com (2603:10b6:405:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 17:25:24 +0000
Received: from BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2]) by BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 17:25:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Tejun Heo <tj@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Francis Ricci <fjricci@fb.com>
Subject: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Thread-Topic: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Thread-Index: AQHWRZVztoBjf64Qn0aj0Fb3E2rJ+Q==
Date:   Thu, 18 Jun 2020 17:25:24 +0000
Message-ID: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:95be]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b183ffd-eda4-40c3-35f4-08d813ac9638
x-ms-traffictypediagnostic: BN6PR15MB1812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR15MB1812FC36633DE1E9D4EECA23B39B0@BN6PR15MB1812.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlCykR9/FgqfyVkHnSZ/VrquMATE9DvVrrykMw7ge2FFnPuexonVez3qs461LIFgBKz1yJ4vPgRClAOXG0MUUd84ott7nWUUS5Kv+cAbDRNn5ZYIUpM/V/uDYsJPJbcmM/N4PrsBhgHMGA6R/9U+2e4fzE31JXdbn2g+U9zNtf6KVWBvZeEjOZ9n6VlmB9QAiJmw5euSPzRGNhOdF6YHDCYwYHY/3zouuiv+A6ZNQmub2K8Q5acadbT2D+gpRafJLbHmRThoo4GRcM4V+fWXB7rLJG8e3sOUUqcRpNk1cMHQug5ZfN2HIML2z8EbbT8rzMZD9l8N5dmx3tl2j51Qkg6X7qQ4mNAbcMxKBjn7UscPrvonROVlg8WYhdsTnfZj5IrfRvZDunt888MyeuouUiTCtWrOD3E/ZDjmQCUTANXCOtUDexOza9DlukknJEib//LsH2PGhwzFgwHTSzlUww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2995.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(8676002)(33656002)(4326008)(71200400001)(2906002)(186003)(54906003)(8936002)(36756003)(2616005)(966005)(110136005)(66946007)(478600001)(6512007)(83380400001)(91956017)(76116006)(5660300002)(6486002)(86362001)(316002)(66556008)(64756008)(6506007)(66446008)(66476007)(58493002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sqhlxqZ4aGDM4vJHj4qq3Yt26nquMTRHGvHa7iJ6/r8OmvYFL1lyWtIZxA3wjhnNdVSU9KTP8dYYWVGLyQN+0OBMSRPIOk+6O8s5x1aFJGYh1p9ZK/cMMjvM9XCsNk8QJrgXapJH3IIBnrzB73hBUv7twmCePtMwHFr3VWEZ1c7hCMKVQm/M1tGQ1NGrcYLWr4piOZU+WrwPlY8O1Z2wIwbnQZpA1qV1G2pzvHqNNo9KB+fcqfDMqlNhOTjSBCUyeOUAgoqIMqkjVvbZnvN6N99g3xPWJ7wMjZ098LIZNvDn0tgderdQKpQuBn5nBoG6QzyZhceNz03nXEisBLenWDssP9SjEoO/QmvXpSW6T/F/BdcoWtE/+ticsPpDJW/cSAtOMWQpk4z6CiBPPMY68kmBgrubmhOe4R8AKOLcK6yu0PXirJ2uCUEahIhtCGEHhr2uWjo2StBwY+gbpzTU7vFJRM1RPEUrzaZnzsE3Y/LFeePC6dN9apzsrJYO0jug2FMJzSwaOyi3l/Tv8Z1RBg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B0B1BD5C0BE794CA970D06B9FFE8123@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b183ffd-eda4-40c3-35f4-08d813ac9638
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 17:25:24.6845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSXQ9jHQWZWyr57Kjloexf+/rN+HLXbpeVu7ERDTndIOUzBR+C7ZA9TYP0pKqHY9+D+DnffQWUu+uIn/9fyWCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1812
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180133
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

We are debugging some WARNING with LBR, precise_ip=3D2 and bpf_get_stackid(=
), like:

[36000.334284] WARNING: stack recursion on stack type 1
[36000.334288] WARNING: can't access registers at syscall_return_via_sysret=
+0x12/0x7f


This happens when we attach BPF program to perf_event with:

        struct perf_event_attr attr =3D {
                .type =3D PERF_TYPE_HARDWARE,
                .config =3D PERF_COUNT_HW_CPU_CYCLES,
                .precise_ip =3D 2,
                .sample_type =3D PERF_SAMPLE_IP | PERF_SAMPLE_BRANCH_STACK,
                .branch_sample_type =3D PERF_SAMPLE_BRANCH_USER |
                        PERF_SAMPLE_BRANCH_NO_FLAGS |
                        PERF_SAMPLE_BRANCH_NO_CYCLES |
                        PERF_SAMPLE_BRANCH_CALL_STACK,
                .sample_period =3D 500000,
                .size =3D sizeof(struct perf_event_attr),
        };

and calls bpf_get_stackid() from the BPF program. I pushed a reproducer to=
=20

  https://git.kernel.org/pub/scm/linux/kernel/git/song/linux.git/log/?h=3Dl=
br_issue

under tools/bpf/ministrobe/. It requires latest CLANG to build. I also incl=
uded=20
the binary that should just run on CentOS 7.=20


This warning is usually harmless, but it may also cause double fault #DF. H=
ere are=20
some analysis from Tejun:

"""
The exact pathway is still under investigation but it triggered a sanity wa=
rning in=20
the kernel backtrace acquisition code looking like the following:
[ 2051.040745] WARNING: stack recursion on stack type 1
This is from `arch/x86/kernel/dumpstack_64.c::get_stack_info()` and is warn=
ing that
 while walking the stack to obtain backtrace it encountered the same type o=
f stack=20
more than once. The warning in itself isn't critical. It's a sanity check a=
nd when=20
the check fails, it just stops walking the stack and it is likely that the =
warning=20
is being triggered spuriously given that more machines which trigger these =
warnings=20
continue to run fine than not, which is unlikely with actual stack corrupti=
ons. A=20
possibility is that stack acquisition is happening from a context that the =
code=20
can't handle.
However, on some machines, this caused #DF (double fault) and thus immediat=
e crash.=20
Backtracing a DF'd kernel is a bit cumbersome, so the following contains sp=
urious=20
entries, but it does show what happened:

PID: 80430  TASK: ffff888d92c62a80  CPU: 24  COMMAND: "25_scheduler"
#0 [fffffe00004cfd88] machine_kexec at ffffffff8104a646
#1 [fffffe00004cfdd8] __crash_kexec at ffffffff8114a82f
#2 [fffffe00004cfea0] panic at ffffffff810ba99c
#3 [fffffe00004cff20] df_debug at ffffffff8104e21d
#4 [fffffe00004cff30] do_double_fault at ffffffff8101c9b4
#5 [fffffe00004cff50] double_fault at ffffffff81c00b3e
[exception RIP: vsnprintf+14]
RIP: ffffffff81a3ee6e  RSP: fffffe00004d0ff8  RFLAGS: 00010082
RAX: fffffe00004d1070  RBX: fffffe00004d1101  RCX: fffffe00004d1050
RDX: ffffffff822c42f5  RSI: 000000007fffffff  RDI: fffffe00004d111a
RBP: fffffe00004d10a0   R8: 0000000000000067   R9: ffffffff82209d05
R10: ffffffff822a5fd0  R11: ffffffff822a6358  R12: 0000000000000019
R13: 0000000000000001  R14: 0000000000000019  R15: ffffffff822b5fd6
ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <DOUBLEFAULT exception stack> ---
#6 [fffffe00004d0ff8] vsnprintf at ffffffff81a3ee6e
bt: cannot transition from exception stack to current process stack:
exception stack pointer: fffffe00004cfd88
process stack pointer: fffffe00004d1048
current stack base: ffffc900241a0000

0xfffffe00004d1040 kallsyms_token_index
0xfffffe00004d1048 sprintf
0xfffffe00004d1078 kallsyms_lookup
0xfffffe00004d1098 kallsyms_names
0xfffffe00004d10a8 __sprint_symbol
0xfffffe00004d10d8 textbuf.47672
0xfffffe00004d10e0 always_kmsg_dump
0xfffffe00004d10f8 symbol_string
0xfffffe00004d11c0 textbuf.47672
0xfffffe00004d11e8 textbuf.47672
0xfffffe00004d11f8 textbuf.47672
0xfffffe00004d1200 always_kmsg_dump
0xfffffe00004d1210 kallsyms_token_index
0xfffffe00004d1218 vsnprintf
0xfffffe00004d1220 textbuf.47672
0xfffffe00004d1258 kallsyms_token_index
0xfffffe00004d1270 vscnprintf
0xfffffe00004d1280 vprintk_store
0xfffffe00004d1290 wake_up_klogd
0xfffffe00004d12b0 kallsyms_token_index
0xfffffe00004d12c8 vprintk_emit
0xfffffe00004d1300 entry_SYSCALL_64
0xfffffe00004d1318 vprintk_deferred
0xfffffe00004d1328 printk_deferred
0xfffffe00004d1360 entry_SYSCALL_64
0xfffffe00004d1380 __start_orc_unwind
0xfffffe00004d1388 unwind_next_frame.cold.7
0xfffffe00004d13c8 perf_callchain_kernel
0xfffffe00004d1418 entry_SYSCALL_64
0xfffffe00004d1450 get_perf_callchain
0xfffffe00004d14b0 bpf_get_stack
0xfffffe00004d1730 bpf_overflow_handler
0xfffffe00004d1788 __perf_event_overflow
0xfffffe00004d17a0 x86_pmu
0xfffffe00004d17b8 __intel_pmu_pebs_event
0xfffffe00004d17e0 setup_pebs_fixed_sample_data
0xfffffe00004d1890 entry_SYSCALL_64
0xfffffe00004d1ab8 intel_pmu_drain_pebs_nhm
0xfffffe00004d1ac0 setup_pebs_fixed_sample_data
0xfffffe00004d1bb8 handle_pmi_common
0xfffffe00004d1d00 insn_get_sib.part.5
0xfffffe00004d1d10 insn_get_displacement.part.6
0xfffffe00004d1d20 insn_get_immediate.part.7
0xfffffe00004d1d38 __set_pte_vaddr
0xfffffe00004d1d78 __native_set_fixmap
0xfffffe00004d1d80 ghes_copy_tofrom_phys
0xfffffe00004d1e08 intel_pmu_handle_irq
0xfffffe00004d1e48 perf_event_nmi_handler
0xfffffe00004d1e50 perf_event_nmi_handler_na.47078
0xfffffe00004d1e58 nmi_reason_lock
0xfffffe00004d1e60 nmi_handle
0xfffffe00004d1e70 nmi_desc
0xfffffe00004d1e90 nmi_reason_lock
0xfffffe00004d1eb8 default_do_nmi
0xfffffe00004d1ed8 do_nmi
0xfffffe00004d1ef0 nmi
0xfffffe00004d1f78 entry_SYSCALL_64
0xfffffe00004d1fa0 entry_SYSCALL_64
0xfffffe00004d1fd8 entry_SYSCALL_64

The kernel is running the normal NMI path and triggers the above mentioned =
warnings,=20
which calls into string formatting path for the warning messages. However, =
NMIs run=20
off of its dedicated exception stack which is 4k in size, which is too smal=
l for the=20
full string formatting path to run, so it ends up overflowing the stack whi=
le running=20
NMI and the machine enters an unrecoverable state.
"""

We found the issue in multiple versions of kernel, from 4.16 to 5.8-rc1. Th=
e exact=20
WARNING message varies among different versions. Latest kernel put these wa=
rnings=20
under WARN_ONCE(), so they are not flushing dmesg.=20

We noticed that this only happens with precise_ip >=3D 2. This is caused by=
=20
setup_pebs_fixed_sample_data() using pens->real_ip:

	set_linear_ip(regs, pebs->real_ip);

For our use case, we do need precise_ip=3D2. So we would like suggestions t=
o fix the
warning and/or to avoid double fault.=20

Please share your thoughts on this.=20

Thanks in advance!
Song


