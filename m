Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72D72070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gm.com header.i=@gm.com header.b="euv3i+Zx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=GeneralMotors.onmicrosoft.com header.i=@GeneralMotors.onmicrosoft.com header.b="K2JA8x6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgG3OOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:14:35 -0400
Received: from dcmxpphesa005.imr.gm.com ([198.208.57.89]:65449 "EHLO
        dcmxpphesa005.imr.gm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgG3OOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:14:34 -0400
IronPort-SDR: b6p8uz6Ndahp+ogXn0G7xUeePFTZjFHpzHp59uuNUm1rc2MkICcW7TD/m5BwXBoem4SpfVcrod
 UeA+er3xU+CA==
X-SKIP-ALL: FALSE
X-LoopCount2: from 148.93.0.27
Received: from dcwipvmdlp018.edc.nam.gm.com (HELO dcmxpphesa005-s.imr.gm.com) ([148.93.0.27])
  by dcmxpphesa005-s.imr.gm.com with ESMTP; 30 Jul 2020 10:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=gm.com; i=@gm.com; q=dns/txt; s=corp; t=1596118469;
  x=1627654469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vYxqcguxG1DazG4Qacyk66LnlTSymNug/T4O6lY1loM=;
  b=euv3i+ZxxcsyxuVmFh8mKn7BnR5DfwTjdOnJeotA8cdfif41v2TgIZ5D
   U/+n53tZ2Bs7RxhcIJicdHuPY9bPMA1h5UoTY9YZprKpKjSJhgJq8zHXE
   /GNs0gWoab1L8I/Sl3qeW2e51jDLeOhD77gQQ3aSe9x7A057Tze2IIlNY
   M=;
IronPort-SDR: A0GOLcIEtJqx8quZqqIAZXpNuTOTtBkpUXC32ooWob9pmRghh1YuM0x/EayQC0t5On1hlz4Lft
 RKFeWz5i/0sQ==
X-SKIP-ALL: FALSE
X-Loop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589256000"; 
   d="scan'208";a="526822887"
Received: from dcwippexcm070.nam.corp.gm.com ([10.120.115.80])
  by dcmxpphesa005-a.imr.gm.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2020 10:14:29 -0400
Received: from DCWIPPEXCM035.nam.corp.gm.com (10.120.115.45) by
 DCWIPPEXCM070.nam.corp.gm.com (10.120.115.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 30 Jul 2020 10:14:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.120.83.36) by
 DCWIPPEXCM035.nam.corp.gm.com (10.120.115.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4
 via Frontend Transport; Thu, 30 Jul 2020 10:14:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW1No9nSItUrmKZ2R5gaDOIWySK1W7vsOA0RzoFSLHpSvLc4Jw7Eue3/kclUPyfEnHLqZ+xX0QM7K/J4yH9zF+TwzfCSNN3IOhBuZ6Q6O/ZP4syGxI/2t5A1aZIXvxq68hG+9Hx/vmmtTwoIW4RHhE83wa3L9wvtsxYJnyJoskevjVxvape3H0id1ZrqqSzfRcw4xCMcd4D+7DGGQCai2FcwSGq4liJGZoKjSnrmoTmQ2/E+NzhUuRVfXRtYOVa0uf8xwv0K/GzHS1WLgG9ZDCNM4k2bLQHY1TJzXA47QTMM88VARBSrbRZxFrrjsuaRlQZpDg2YQlAvvUwIXCj0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo3Yzctc+hpIXWmg4PFEp2Dh/2hoSX5fYiWpG4WPKGQ=;
 b=QCXPtpc3FCtmksIXQtcmOn8joRAOHP6/TVjHMEioY0f1a09KAWy1QtRE3YWdiPEhRnGvbk3dVqqORtn41IDqOf65buVqCvmHhtbSAsTqf7pbiiQaJl6jxstQ5dBM9e94fnF0snKV7ReCD4HAR4gsm4IHG3YTMfIQ3jXFBfD4l0eEcULsJT2U/22wKe94pajQMwK+MSlYtdT9WHZq2m3YgrB37FSUzVHDsNjmLw5+m8mXpZ31K484DulT1es1CRvG6Tqu88c/yqnV33BA+oLYdHQdFMsC1KYf3VH0IGy0p7QD0/IVSl3E4pQX/cLnfqvvNYpSYbjAxYKLzJiE/nsbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gm.com; dmarc=pass action=none header.from=gm.com; dkim=pass
 header.d=gm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=GeneralMotors.onmicrosoft.com; s=selector2-GeneralMotors-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo3Yzctc+hpIXWmg4PFEp2Dh/2hoSX5fYiWpG4WPKGQ=;
 b=K2JA8x6MUxjWrX9ht6R69UJ6K98Ih7HpvGQXMyEY9Oo6Nys/h6xUJH/xL8mwesHXFkQwePVjMWpwGe/0ddkeTW4USn3hkgqMbHb+SWgZZQHYcgaEV649M67GUkiMJwJ/kqjngDYqR1ykOq3ahT/TdMcsZG+dEg5r4I2AUWHbuJQ=
Received: from CH2PR03MB5272.namprd03.prod.outlook.com (2603:10b6:610:a0::22)
 by CH2PR03MB5189.namprd03.prod.outlook.com (2603:10b6:610:a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Thu, 30 Jul
 2020 14:14:14 +0000
Received: from CH2PR03MB5272.namprd03.prod.outlook.com
 ([fe80::c24:b546:15a:9d1d]) by CH2PR03MB5272.namprd03.prod.outlook.com
 ([fe80::c24:b546:15a:9d1d%4]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 14:14:14 +0000
From:   Joseph Feather <joseph.feather@gm.com>
To:     Joseph Feather <joseph.feather@gm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Timothy Heilman" <timothy.heilman@gm.com>,
        Wilfredo Crespo <wilfredo.crespo@gm.com>,
        Michael Barr <michael.1.barr@gm.com>
Subject: Re: kswapd warning at kernel/rcu/tree.c:1358 rcu_advance_cbs_nowake
 causing processes to enter d state
Thread-Topic: kswapd warning at kernel/rcu/tree.c:1358 rcu_advance_cbs_nowake
 causing processes to enter d state
Thread-Index: AQHWZnf5fLpvCYhw8k+cG2cq5/qwoqkgKlaa
Date:   Thu, 30 Jul 2020 14:14:14 +0000
Message-ID: <CH2PR03MB52725FED3C8B4196304EE3BEF3710@CH2PR03MB5272.namprd03.prod.outlook.com>
References: <CH2PR03MB527269774D0B4D6C57B33A16F3710@CH2PR03MB5272.namprd03.prod.outlook.com>
In-Reply-To: <CH2PR03MB527269774D0B4D6C57B33A16F3710@CH2PR03MB5272.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gm.com; dkim=none (message not signed)
 header.d=none;gm.com; dmarc=none action=none header.from=gm.com;
x-originating-ip: [198.208.47.91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 676257c2-1eb1-46c2-896d-08d83492d692
x-ms-traffictypediagnostic: CH2PR03MB5189:
x-ld-processed: 5de110f8-2e0f-4d45-891d-bcf2218e253d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5189F81241BD26693FC55729F3710@CH2PR03MB5189.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fetylryKlvaNNBaNHnYdHFJyW5uq4tVgAeiAxvl+XNj+JoPSLOujgUPVRZc3wfhOCbdksoDHnWi/gZnWcDjl5evvu//Hj3rY3jAupWs20EB9g8A9uym1RQFwl0d7m0sE8rCOJB3NlwLjhNET3wCNCEbqOslZYWJUU1I/+NZn7bBB0Los8/RByQkO/z9HEkLaWYV1sXC6548AniiWmtGSTC52KDKP0n5jotlb3xVYwpQwNJghs+Sda4dH6mu74xusQ9O3guscaqS9vI8kZhQYDCDnrx3K404CqSRwxiOEMW/zBQv8wEqrdUIow9GD33pcM+vzISx3vnNXlzch2jh535C9ooxu0d5RcJ1d3GLMUvKRIoafEhvWPOXPBpgV39pXOb7fECO5v96gFzFO4iwmuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR03MB5272.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39840400004)(366004)(396003)(8936002)(966005)(71200400001)(45080400002)(26005)(2940100002)(8676002)(478600001)(186003)(33656002)(86362001)(7696005)(110136005)(54906003)(4326008)(66556008)(64756008)(66446008)(66476007)(66946007)(2906002)(83380400001)(44832011)(5660300002)(52536014)(6506007)(316002)(9686003)(53546011)(76116006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ab6yKSNH3ZckKOP37UA7b1ikZLo5nH6yPfsxCTQuE9ORydHlxxd0dhIWgHTzxNF28JQuAVOSKXAdN/gwPhx7DVbM//xdetjQttiKhNWFmJsnxpd9tUJGVOdt2ZRNM4biGUBLvAIXOCHInZVlA8pbvL2IvlZKTssUUduz2G3nV1lvHxhYP0S+lBGx7zcUIwJfOd231Ehks5TKbMQoP2i0nWRM7Rez30/uxNq5khIx39LdirhZZcZ937x/AVwWRqYpUnJkCA/lhoWn/701tlXBDx2osu4U75VZmYRCLXYlMsq1nkgNFdSVL6Pk9SKQ1jaZ3sP75f9Qw7ip8mKs1m6LlcQg88XRk17CfSMi0P7BE/MzWdXscU6ZcqFGKeKR9lSBkaFKRUJuJmd0QKCOGsWBjWjECBMNP8R76oJJ+3+0Ed16G2ND5mdEqtK/ouj2OaiwByoFYX/wDqcFOXl9A3hkwZFB8a86N4RMXcz7kzRIID8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR03MB5272.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676257c2-1eb1-46c2-896d-08d83492d692
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 14:14:14.1457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5de110f8-2e0f-4d45-891d-bcf2218e253d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IVMEEmFJmoYJODJJfnb+6htFRqbNjig9k1YxDtNqwVCL5xbpa2o04EBRXM4wRc/6qa2cZNZ9Oi5/GQPMgfhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5189
X-OriginatorOrg: gm.com
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as plaintext.


From: Joseph Feather
Sent: Thursday, July 30, 2020 9:59 AM
To: Paul E. McKenney <paulmck@linux.vnet.ibm.com>; Josh Triplett <josh@josh=
triplett.org>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Timothy He=
ilman <timothy.heilman@gm.com>; Wilfredo Crespo <wilfredo.crespo@gm.com>; M=
ichael Barr <michael.1.barr@gm.com>
Subject: kswapd warning at kernel/rcu/tree.c:1358 rcu_advance_cbs_nowake ca=
using processes to enter d state

All,
After upgrading our systems from 5.3.x to 5.4.51 we started experiencing pr=
oblems where some processes would enter an uninterruptible sleep state.

We do not have a swap enabled or a swap mount point.

We have tried updating to 5.7.10 and still experience the same issue. Downg=
rading to 5.3.x fixes the problem.

Please let me know if you need any other data.  I've also created a ticket =
on bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D208685
Looking through dmesg we found the following error message:
[819876.687024] ------------[ cut here ]------------
[819876.687038] WARNING: CPU: 22 PID: 434 at kernel/rcu/tree.c:1358 rcu_adv=
ance_cbs_nowake+0x53/0x60
[819876.687038] Modules linked in: binfmt_misc(E) intel_rapl_msr(E) dell_sm=
bios(E) wmi_bmof(E) dell_wmi_descriptor(E) sr_mod(E) cdrom(E) dcdbas(E) xt_=
comment(E) xt_multiport(E) ip6t_rpfilter(E) ip6t_RE
JECT(E) nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E) e=
btable_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table=
_security(E) ip6table_raw(E) iptable_nat(E) nf_nat(
E) iptable_mangle(E) iptable_security(E) iptable_raw(E) nf_conntrack(E) nf_=
defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) nfnetlink(E) ebtable_filter(E) e=
btables(E) ip6table_filter(E) ip6_tables(E) iptable
_filter(E) intel_rapl_common(E) vfat(E) fat(E) skx_edac(E) nfit(E) libnvdim=
m(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm(E) irqbypa=
ss(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clm
ulni_intel(E) aesni_intel(E) crypto_simd(E) cryptd(E) glue_helper(E) wdat_w=
dt(E) pcspkr(E) sg(E) i2c_i801(E) lpc_ich(E) mei_me(E) mei(E) ioatdma(E) wm=
i(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E)
[819876.687069]  acpi_power_meter(E) ip_tables(E) xfs(E) libcrc32c(E) sd_mo=
d(E) crc32c_intel(E) megaraid_sas(E) mgag200(E) i40e(E) drm_kms_helper(E) s=
yscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fo
ps(E) igb(E) ptp(E) pps_core(E) drm_vram_helper(E) dca(E) ttm(E) ahci(E) li=
bahci(E) drm(E) i2c_algo_bit(E) libata(E) uas(E) usb_storage(E) dm_mirror(E=
) dm_region_hash(E) dm_log(E) dm_mod(E)
[819876.687087] CPU: 22 PID: 434 Comm: kswapd0 Tainted: G            E     =
5.4.51-1.el7.x86_64 #1
[819876.687087] Hardware name: Dell Inc. PowerEdge R740xd/0YNX56, BIOS 2.2.=
11 06/13/2019
[819876.687090] RIP: 0010:rcu_advance_cbs_nowake+0x53/0x60
[819876.687092] Code: 85 c0 74 f1 48 89 ee 48 89 df e8 68 ff ff ff 84 c0 75=
 17 48 89 df c6 07 00 0f 1f 40 00 5b 5d c3 48 89 f7 e8 1f df ff ff eb c3 <0=
f> 0b eb e5 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 55 53 48 89
[819876.687093] RSP: 0018:ffffaaf58d713a40 EFLAGS: 00010002
[819876.687094] RAX: 0000000000000001 RBX: ffffffff9a2655c0 RCX: 0000000008=
326518
[819876.687095] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff9a=
265140
[819876.687096] RBP: ffff9547a0eeb2c0 R08: ffff95317eefb920 R09: 0000000130=
dae188
[819876.687096] R10: 0000000000000000 R11: 0000000000000001 R12: ffff953c2a=
0c1da8
[819876.687097] R13: 000000000002b2c0 R14: ffffaaf58d713b48 R15: ffff95317e=
efb6d8
[819876.687099] FS:  0000000000000000(0000) GS:ffff9547a0ec0000(0000) knlGS=
:0000000000000000
[819876.687100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[819876.687101] CR2: 00007fc07fe2e300 CR3: 00000005ffe0a001 CR4: 0000000000=
7606e0
[819876.687101] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
[819876.687102] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
[819876.687103] PKRU: 55555554
[819876.687103] Call Trace:
[819876.687114]  ? radix_tree_node_ctor+0x90/0x90
[819876.687115]  __call_rcu+0x2aa/0x4e0
[819876.687120]  xas_free_nodes+0x8b/0xb0
[819876.687122]  xas_store+0x1a4/0x550
[819876.687130]  shadow_lru_isolate+0xed/0x170
[819876.687132]  ? scan_shadow_nodes+0x30/0x30
[819876.687134]  ? workingset_update_node+0x70/0x70
[819876.687136]  __list_lru_walk_one+0x6d/0x170
[819876.687138]  ? workingset_update_node+0x70/0x70
[819876.687140]  list_lru_walk_one_irq+0x4c/0x70
[819876.687145]  do_shrink_slab+0x150/0x310
[819876.687148]  shrink_slab+0x239/0x2d0
[819876.687151]  shrink_node+0xd5/0x450
[819876.687154]  balance_pgdat+0x275/0x560
[819876.687157]  kswapd+0x15a/0x3d0
[819876.687160]  ? remove_wait_queue+0x60/0x60
[819876.687166]  kthread+0xf8/0x130
[819876.687169]  ? balance_pgdat+0x560/0x560
[819876.687170]  ? kthread_bind+0x10/0x10
[819876.687173]  ret_from_fork+0x35/0x40
[819876.687175] ---[ end trace ff791da2812c6a3e ]---

After that message we see our process that is in D state:
[820150.702270] INFO: task python:11885 blocked for more than 122 seconds.
[820150.702315]       Tainted: G        W   E     5.4.51-1.el7.x86_64 #1
[820150.702348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
[820150.702387] python          D    0 11885  11872 0x00000080
[820150.702390] Call Trace:
[820150.702401]  __schedule+0x2d1/0x6c0
[820150.702404]  schedule+0x39/0xa0
[820150.702406]  schedule_timeout+0x1c8/0x290
[820150.702413]  ? rcu_accelerate_cbs+0x61/0x180
[820150.702415]  wait_for_completion+0x123/0x190
[820150.702420]  ? wake_up_q+0x70/0x70
[820150.702422]  __wait_rcu_gp+0xfd/0x130
[820150.702425]  synchronize_rcu+0x4e/0x80
[820150.702427]  ? __call_rcu+0x4e0/0x4e0
[820150.702428]  ? __bpf_trace_rcu_utilization+0x10/0x10
[820150.702432]  packet_release+0x247/0x380
[820150.702437]  __sock_release+0x3d/0xc0
[820150.702439]  sock_close+0x11/0x20
[820150.702442]  __fput+0xbe/0x250
[820150.702446]  task_work_run+0x88/0xa0
[820150.702452]  exit_to_usermode_loop+0x77/0xc7
[820150.702454]  do_syscall_64+0x182/0x1b0
[820150.702457]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[820150.702459] RIP: 0033:0x7fd85ca297a0
[820150.702464] Code: Bad RIP value.
[820150.702465] RSP: 002b:00007ffd05cc66b8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000003
[820150.702466] RAX: 0000000000000000 RBX: 00007fd85d0cba50 RCX: 00007fd85c=
a297a0
[820150.702467] RDX: 0000000000000000 RSI: 00007fd85d06a210 RDI: 0000000000=
000003
[820150.702468] RBP: 0000000000000007 R08: 0000000000000000 R09: 00007fd85d=
0cc1e7
[820150.702469] R10: 0000000000000083 R11: 0000000000000246 R12: 0000000000=
000007
[820150.702470] R13: 00007fd85d06a210 R14: 00007fd85ccd4590 R15: 0000000002=
2750a0

-Joe


Nothing in this message is intended to constitute an electronic signature u=
nless a specific statement to the contrary is included in this message.

Confidentiality Note: This message is intended only for the person or entit=
y to which it is addressed. It may contain confidential and/or privileged m=
aterial. Any review, transmission, dissemination or other use, or taking of=
 any action in reliance upon this message by persons or entities other than=
 the intended recipient is prohibited and may be unlawful. If you received =
this message in error, please contact the sender and delete it from your co=
mputer.
