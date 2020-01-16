Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF627C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA34F20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YHcEB+ZI";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="dJHFMl31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgAPPM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:12:26 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47392 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgAPPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:12:26 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GEtvgS028122;
        Thu, 16 Jan 2020 07:11:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=naRlrgpLaDEcyP0uZRoZ1NlTykfghViynPDxhi2ThGY=;
 b=YHcEB+ZIKp3aBBGEq96c6FW3JknDTZ3OYPdeZ0MDEi/83uvALNL6y2CIEe1yeLLEO1Jq
 VhXjAvBm6XioragXOvX1cHgDarHZYDIx4Vs2LRRNbxbVrTbiKOKftrOZMrsZyyrzVGSN
 Uknab79dzTpMkqGsy6o9iRF9P8x2RpWJ/RXInaCJG/Nfby3TnuNd7TJJBIYdUy7H2jKW
 AS6oWlVY8vM/Bd2vPOzYydojF9PytLEfhEIwR69q3JPg/7RKNZbR9qrltOeYkX5cl7eK
 A8SbCJn5jF943z3hbyuLq/5uVta6jjM3Pf4S0AqT5jNTJeok6xFW5yaUoUACBEfNmk1i aA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xjr1g0jb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 07:11:59 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jan
 2020 07:11:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 16 Jan 2020 07:11:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpYGk9sDYJiXa1iSyrlyU5AZuHfCC4WBLMiLAgBHpb70R3ppJ+aLIIv3FA2L/VELUNwXJk8eze2sgz+fLmUsQUXGZx+/en45v9I3C75V2bT8cd+FJ6rNFsnU/P3NNE16lxEfQT3mQCEP8a8Epde6x5yBLNrqo8q7e2s5OLGOiKAm7DmFt40M67oWUZT6NCFiAaScu443YW0xvutLaN4aHOKLMiH0gZs1lJdGWV5RiKKPY/sRoINa+Zp2+cDcnTp/dZ5mq2nv65/+cEOPOtGpDqCCJbvkIBCFAyepzRjQIQX6+8vYspptPtKRBQbe9AquZ0GKOIzC8Ndf1CrCqYeTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naRlrgpLaDEcyP0uZRoZ1NlTykfghViynPDxhi2ThGY=;
 b=aFS3taK1LKcAo5hU8ZGxPKMVeNSiWYrsluAr8TgF+AlfW6/yH7iQYmWtAT1PP9pK3uzrkmBerZxb2A5pYkzO9Lqk5S2pHcBK8vgxHkvI8D2MEr2xwpdx/Oejk6B8+AqAY47CD8gNYlTavAU/2FpZn99TBNSgf187xo7X9vrveHTsrlnAB2oeuMPQtyd+DQQhFCuw8/CXsHdSnQcAvVtjqOFeyKgBR0QxcbNjCPKB/ZNk4VK+YtK5xIGRMqv3xQSijBSdlZfhnajvHUztWnNr6EQRRQ4WjmF/M024hVFeffEZn5js3M9ey513JnyNjDEmJ1sEfEIWvN1yNCwfLOqcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naRlrgpLaDEcyP0uZRoZ1NlTykfghViynPDxhi2ThGY=;
 b=dJHFMl31VsEYfQerAolvt8iUZ7eE49dTq2Gv1gEdYMu8Vpgf16Qdbk8FBlwvkrGno2OMt9cJuCmClRXHEotBwa7gFD/bQ7pY/dHe3iQo3OM14cF9ipVqrNENLiTHVWg4xS100wsKglthTsS1SxcjnhEIlhfKep72n9w2Njx+0cU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3407.namprd18.prod.outlook.com (10.255.238.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 15:11:55 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 15:11:55 +0000
Received: from rric.localdomain (31.208.96.227) by HE1P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Thu, 16 Jan 2020 15:11:53 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
Thread-Topic: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
Thread-Index: AQHVzH9KOCR5UnUl1Uy0iUEHMxk2CA==
Date:   Thu, 16 Jan 2020 15:11:55 +0000
Message-ID: <20200116151146.wn6ec7igl2bfk4c2@rric.localdomain>
References: <20200103151032.19590-1-longman@redhat.com>
 <87sgkgw3xq.fsf@nanos.tec.linutronix.de>
 <87blr3wrqw.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blr3wrqw.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::31)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b918919-8ca6-4487-7b0a-08d79a966cae
x-ms-traffictypediagnostic: MN2PR18MB3407:
x-microsoft-antispam-prvs: <MN2PR18MB3407B10F8EAD62D07C8A5369D9360@MN2PR18MB3407.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(6916009)(478600001)(66946007)(956004)(66446008)(4326008)(81166006)(8676002)(54906003)(81156014)(64756008)(8936002)(7416002)(66556008)(66476007)(2906002)(86362001)(53546011)(186003)(5660300002)(71200400001)(316002)(7696005)(52116002)(6506007)(26005)(16526019)(1076003)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3407;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DgSWLPIT88gqB/37yPEX9dzwTOh8JJUZ/oZTlu82ygtNuTMRXhrm+AGYqL19bDkYG+VOjHYGmNT4/8Vh6o3gRL2rDup3nzXwn8tHyJJetTTOIzgEdyuDRtAlEeRT4jRdA4lMf/ZmPjsRuwzphBvbTHKlRyXjC8fem6biQ38jwq+Cm3TjSrOVDzYfh58RXmSdsYFORzp3oNLxi0n2jR3Yc0uVRst8IKc2ZLXrx4Pa2prF0hF29mGdxOfpBl/y1SqHe190EFIOBwPilD+lwrv8HWnpSDGzmUY+W0JsCbZ5z9xlqXv+temRSyQbtbagcz7L4ErEpO1AULGSumyBFRCVLyki/8h4soNygc+esfoGbAB3VEZkA/oQ3m8wNzaEkiBcLS/IuPfmL8K5Lr5cy1MZH84o1N7F0Pam/LTOdl2vFYAt73g3kRnEYEnG6q+L10wy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66ED28D1D9D8BC48AE93A2A34564D35F@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b918919-8ca6-4487-7b0a-08d79a966cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 15:11:55.7099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYDf6OuuJjBChyySUmLt42HuMV8PCnzoYFfOcM0wNfwg6GVpDXEm+7/1HmgHE2NQcWhx5N17jGgNlaOV7FzhyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3407
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Thomas for cc'ing me.

On 16.01.20 12:44:07, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>=20
> Added ARM64 and ThunderX folks=20
>=20
> > Waiman Long <longman@redhat.com> writes:
> >> By adding some instrumentation code, it was found that for cpu 14,
> >> watchdog_enable() was called early with a timestamp of 1. That activat=
es
> >> the watchdog time checking logic. It was also found that the monotonic
> >> time measured during the smp_init() phase runs much slower than the
> >> real elapsed time as shown by the below debug printf output:
> >>
> >>   [    1.138522] run_queues, watchdog_timer_fn: now =3D  170000000
> >>   [   25.519391] run_queues, watchdog_timer_fn: now =3D 4170000000
> >>
> >> In this particular case, it took about 24.4s of elapsed time for the
> >> clock to advance 4s which is the soft expiration time that is required
> >> to trigger the calling of watchdog_timer_fn(). That clock slowdown
> >> stopped once the smp_init() call was done and the clock time ran at
> >> the same rate as the elapsed time afterward.
>=20
> And looking at this with a more awake brain, the root cause is pretty
> obvious.
>=20
> sched_clock() advances by 24 seconds, but clock MONOTONIC on which the
> watchdog timer is based does not. As the timestamps you printed have 7
> trailing zeros, it's pretty clear that timekeeping is still jiffies
> based at this point and HZ is set to 100.
>=20
> So while bringing up the non-boot CPUs the boot CPU loses ~2000 timer
> interrupts. That needs to be fixed and not papered over.

I have looked into this back in December and observed the following
soft lockups on cpu #15 to #155 (out of 224):

[   22.697242] watchdog: BUG: soft lockup - CPU#15 stuck for 20s! [swapper/=
15:0]
[   22.990042] watchdog: BUG: soft lockup - CPU#16 stuck for 20s! [swapper/=
16:0]
[   23.139546] watchdog: BUG: soft lockup - CPU#17 stuck for 20s! [swapper/=
17:0]
[   23.280614] watchdog: BUG: soft lockup - CPU#18 stuck for 20s! [swapper/=
18:0]
[   23.431378] watchdog: BUG: soft lockup - CPU#20 stuck for 20s! [swapper/=
20:0]
[   23.431747] watchdog: BUG: soft lockup - CPU#19 stuck for 20s! [swapper/=
19:0]
[   23.722134] watchdog: BUG: soft lockup - CPU#21 stuck for 21s! [swapper/=
21:0]
[   23.723440] watchdog: BUG: soft lockup - CPU#22 stuck for 21s! [swapper/=
22:0]
[   24.010887] watchdog: BUG: soft lockup - CPU#36 stuck for 20s! [swapper/=
36:0]
...
[   25.149322] watchdog: BUG: soft lockup - CPU#150 stuck for 11s! [swapper=
/150:0]
[   25.155822] watchdog: BUG: soft lockup - CPU#151 stuck for 11s! [swapper=
/151:0]
[   25.162345] watchdog: BUG: soft lockup - CPU#152 stuck for 11s! [swapper=
/152:0]
[   25.178463] watchdog: BUG: soft lockup - CPU#153 stuck for 11s! [swapper=
/153:0]
[   25.184929] watchdog: BUG: soft lockup - CPU#154 stuck for 11s! [swapper=
/154:0]
[   25.191382] watchdog: BUG: soft lockup - CPU#155 stuck for 11s! [swapper=
/155:0]

The reason it starts at #15 is that this is the first cpu where the
timer starts at 1 sec, cpus #1 to #14 have a value of 0 which is
handled special (see watchdog_timer_fn(), if (touch_ts =3D=3D 0) ...).
Otherwise those cpus would also show the soft lockup.

The reason it stops after cpu #155 is that the boot process advanced
(25 secs) so that watchdog_touch_ts is now updated properly.

During secondary boot cpu bringup I have seen the hrtimer callback
watchdog_timer_fn() running correctly. get_timestamp() is also
correct. But watchdog_touch_ts is not updated since softlockup_fn() is
not running for more than 23 secs, it still keeps the original time
from watchdog_enable() (e.g. 1 for cpu #15). So the high prio
stop_worker thread which calls softlockup_fn() is not scheduled for
some reason.  But it looks like scheduling starts around the time the
primary cpu has scheduled all secondary cpus to become online
(smp_init()).

[   23.431441] watchdog: __touch_watchdog:277: cpu 20, old: 1, new: 21, fro=
m: softlockup_fn+0x14/0x38, thresh: 5
[   23.877843] CPU223: Booted secondary processor 0x0000011b03 [0x431f0af2]

So your theory the MONOTONIC clock runs differently/wrongly could
explain that (assuming this drives the sched clock). Though, I am
wondering in what state the scheduler is until to the point it is
finally starting to run, idle?

On the other side, could it be that the scheduler starts running only
after the primary cpu finishs smp_init()? Meaning, if that takes
longer than the soft_thresh we will see soft lockups?

Note: We have seen it in a bios change causing longer delays when
executing the onlining of cpus by the fw call.

Thanks,

-Robert
