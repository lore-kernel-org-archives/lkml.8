Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726C52073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WEiBnoCN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DyXiDMc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCZXOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:14:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgCZXOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:14:00 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02QN9tgE027382;
        Thu, 26 Mar 2020 16:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ekwswEg4+f4vMPzy943usC870lUNQQehmK6AK0mQc6s=;
 b=WEiBnoCNJrQzrAktFV7FerIvDkDvA1qoP5EHyVNXnd37uv6ju2AU5O5VbI+vICutVua6
 rVSGrhSO2getgBmWNxKS0jSAlYgmVgGBDCe152rY27qFRMVbx574QYmcOSqU7wBUMGM9
 mLwbKSNZtfzqTsi4LkPCg8sCXdjZv1xnGwc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2yywfkwrad-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Mar 2020 16:13:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 26 Mar 2020 16:13:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5P+DmFa7MaDRWBxF6J/5rP5TPZX3AvknfeAsp0k98PwlKChVYkccTY86WJ1+iQhKA9BMsJ32l1E3jdu9mF5W6eZ6KtCecr4woUxNeJ5gPPjlSxnlZE4Ru+eIwOuBjM2WnmbROhCqETD3qzvYbMfLt3BCtX5EZxLSE167aAaSu0P3vGMML+sBkeDW9a6qfSeqUKXDXP4H6gw2VgodX+WnRBWjT55tTYv2T6uy8qenKWYJXnbK04cZYCB0SWliiEMb+QpvaT8NhygV+4eh/9jJquqyaQdr/KzcB4r2pfmuddy3VjkRXUy8MgRtWxtJnAtTemrHru9If5qpr5cGDqWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekwswEg4+f4vMPzy943usC870lUNQQehmK6AK0mQc6s=;
 b=cM05UiAcfuJafd/JtIlQN12H3Ro6nLuTX4qq7gVquF8aNrTMWbdpaAbczNWqP/QMiAQaKBaXPgSmva1X/eOQszZuC42R2P0pY9TBGveENNl2lvXfxcz5LD4ryukrG19E0yz5spIAg4VXynnHJMiiP0nhEbEFkCIIL7Z9CmxqWgUxsNGiljz9mHBIGKH/ZjdyUQHysggbpoFfCvQ3yVH3e8JAEfmGXMAk6kz5reF/PAiJpfhOoa4lqtF/VVXwM8DF5X19cLrwA+v0OpuseqaPju6iRUa9qeKSbpnmsmtQbE4D8nyATtsW/AV84Q6JJTe3tDyF31oR+hHKH0spN2S2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekwswEg4+f4vMPzy943usC870lUNQQehmK6AK0mQc6s=;
 b=DyXiDMc3uzWbOOtbEITggS3UmPJ02J0Mi6bkG7a7Q9znfPaWdJ4GjcgIHvzIU8KcawC/ktfwHyXlI0Fl9glDS0yyujmCOe+mDswtPmVLh3NCfWjpsTIWD4ke5wECVz41O74C3sPlPXswan1X2Ic5zu/+UcDVqGfV0g9RK8QjipA=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3865.namprd15.prod.outlook.com (2603:10b6:303:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 23:13:41 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 23:13:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Alexey Budankov" <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        LKP <lkp@lists.01.org>
Subject: Re: [perf] 64a7f64478: perf-event-tests.check_reset_mpx.failed
Thread-Topic: [perf] 64a7f64478: perf-event-tests.check_reset_mpx.failed
Thread-Index: AQHV/SO+Xc26BotAJ0eeSTSekp60Z6hbjhcA
Date:   Thu, 26 Mar 2020 23:13:41 +0000
Message-ID: <87B78E5B-655C-4B01-B98C-C2EC3D20C8C6@fb.com>
References: <20200318124933.GM11705@shao2-debian>
In-Reply-To: <20200318124933.GM11705@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:8d01]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2403a26-d050-4c24-091f-08d7d1db52ac
x-ms-traffictypediagnostic: MW3PR15MB3865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB38652D19255EC5901E1F8F6DB3CF0@MW3PR15MB3865.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(186003)(4326008)(86362001)(53546011)(6486002)(76116006)(8936002)(71200400001)(478600001)(81156014)(66476007)(64756008)(66446008)(6512007)(66946007)(66556008)(110136005)(36756003)(54906003)(316002)(7416002)(8676002)(6506007)(2906002)(2616005)(81166006)(5660300002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3865;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtT+fjBA35TgDE3QkuXqcnq/Pbs+tpKCU6djTFfIo27Z4wc6Ag6s4ZB5MThXlIHINIv4w9OfOd8ph0Gjax9NrVNeu8IV8WQW0ilvK2ToyzuZzfyAm6D+pBi4dwvb4Sir9UZWdz+fAqXx200xVef5lADPYDiG4CC23BIdfhQNQOP3ak2dQrBwUMA6kCPBrqZZ1NOKrLphAUMD4+EtkV2TmbCWQij40UlQY+SNK/ghOxTqrbrOX/xOVDme5mxF7PqOiHRtNfH9KoJBo8ewcT7YEJxb7LP8UjACAa6QyshrKh9TQNAyuZLdB5/Tg2AlUWlCLRcbAU2Awx9AwAc4FErFNvG8AAXuBKWqdqm0j8fGsms0M5ipmCJ259llvax235oIWchQFcVqD0Z2ya33svstQYLjqtZDaQE1E/dTwvwkEJ5iCaudeDoygn5qtT5y7/4z
x-ms-exchange-antispam-messagedata: RGzaQBw/ADwFUYeglhy+ZvqsUdsmJnFCrGzRNenkl9V3gVd1iAV2xf5vjBqPLVUge4RSkaNk7mUiVDq4+dsGh7WPI8Oa8+9LjuMBrPTtIWAzgrMeoh8hbAUc1YbdLt5nZ5/9LJAq1cqMY7kjNchNSUh9k9tdXkneQoqGMAKy3SXTFJJo2199MwshlH/de8It
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EBCFB03BFD69F47B723FAA0557E0C00@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b2403a26-d050-4c24-091f-08d7d1db52ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 23:13:41.0487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNGRxYAhQgDvpQJHpOGhsuI7uu9l+XrEow61bT/ZZewgYbFE2essfU7mg74brZj21hWakmhOAAzw2o2ve+WfWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3865
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_14:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report.=20

> On Mar 18, 2020, at 5:49 AM, kernel test robot <rong.a.chen@intel.com> wr=
ote:

[...]

>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>=20
>=20
> * Checking for corner-cases in the ABI (not necessarily bugs)
>  + tests/corner_cases/multiple_active
>    Testing multiple simultaneous measurements...              PASSED
>  + tests/corner_cases/max_num_events
>    Testing max events that can be created...                  PASSED
>  + tests/corner_cases/max_multiplex
>    Testing limit of multiplexing...                           PASSED
>  + tests/corner_cases/reset_leader
>    Testing reset on group leader...                           PASSED
>  + tests/corner_cases/check_reset_mpx
>    Testing if reset clears multiplex fields...                FAILED

This is an easy fix.=20

>  + tests/corner_cases/huge_events_start
>    Testing start of max events...                             PASSED
>  + tests/corner_cases/huge_group_start
>    Testing start of max event group...                        PASSED
>  + tests/corner_cases/signal_after_close
>    Testing signal after close...                              PASSED
>=20
> * Checking for fast RDPMC support
>  + tests/rdpmc/rdpmc_support
>    Testing if userspace rdpmc reads are supported...          PASSED
>  + tests/rdpmc/rdpmc_validation
>    Testing if userspace rdpmc reads give expected results...  PASSED
>  + tests/rdpmc/rdpmc_multiplexing
>    Testing if userspace rdpmc multiplexing works...           PASSED
>  + tests/rdpmc/rdpmc_reset
>    Testing if resetting while using rdpmc works...            FAILED
>  + tests/rdpmc/rdpmc_group
>    Testing if rdpmc works with event groups...                FAILED
>  + tests/rdpmc/rdpmc_attach
>    Testing if rdpmc attach works...                           PASSED
>  + tests/rdpmc/rdpmc_attach_cpu
>    Testing if rdpmc behavior on attach CPU...                 FAILED
>  + tests/rdpmc/rdpmc_attach_global_cpu
>    Running on CPU 4
> Testing if rdpmc behavior on attach all procs on other CPU... FAILED
>  + tests/rdpmc/rdpmc_attach_other_cpu
>    Testing if rdpmc behavior on attach other CPU...           FAILED
>  + tests/rdpmc/rdpmc_multiattach
>    Testing if rdpmc multi-attach works...                     PASSED
>  + tests/rdpmc/rdpmc_multiattach_papi
>    Testing if rdpmc papi-multi-attach works...                PASSED
>  + tests/rdpmc/rdpmc_pthreads
>    Testing if rdpmc with pthreads works...                    PASSED
>  + tests/rdpmc/rdpmc_pthreads_group
>    Testing if rdpmc with pthreads works...                    PASSED
>  + tests/rdpmc/rdpmc_attach_multi_enable
>    Testing if minimized rdpmc papi-multi-attach works...      PASSED
>  + tests/rdpmc/rdpmc_exec
>    Testing if we can rdpmc in execed process...               PASSED
>  + tests/rdpmc/rdpmc_exec_papi
>    Testing if we can rdpmc in execed process (PAPI) ...       PASSED

The RDPMC break is trickier.=20

IIUC, there is a critical call of perf_event_update_userpage() from=20
x86_pmu_enable(), which is not easy to fix.

Peter, do you have suggestions on how to fix this?=20

Thanks,
Song=
