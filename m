Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4BDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEC120753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RNNWKzzj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jySjD80P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDIUkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:40:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbgDIUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:40:39 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 039Kc7EZ007245;
        Thu, 9 Apr 2020 13:40:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5gtFpV967e88E9WRcDvmoL70hSMhzoPc+rauaC7gh34=;
 b=RNNWKzzj3SfGtyyaPHdokoFHLfnMiPqd5xH+Lwrg+7hHKe8kikBMFwkpepEOkIWtj+n4
 bWJ4ttaNYMWSi//B07S3tdjcvWXNiItCXNpzPtDcvP7osWFlrFkJknUf+r/FwUFSGB1d
 MS7d0+1E+XW5vn7yKShS/yKkqDEqPmKD7OQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30a4b7tc1d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Apr 2020 13:40:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 9 Apr 2020 13:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXbcMR8JpKgWDIYm7zciGuyXCC+aW9ksG2NQf44Rpv0mhtMXYUmX+Te94QOEFEx9sGFsuIGjNQec0iv7I/aNsjn3wl3B14UMd5leAsNuXplgaB5oMHU7HkDxCnLP7v7z/X5rUZYGQX0Tvy7K0czSurzOEIyjPs8Xl+VR272RcNRo6DEuSHZ+ARKqeT6ugIq7lsruzvhGdUkNDIs+fbgJayy6J0mgvKnNAJSs+6VqzhphIkPcARcHqbciYXRpyCHEW5UVulzJpt2huNzspbJA6vvLZ2e0oYKFzhMez+NoGk1Xtqsvm5qc1D1mUuzz9IcQwdtK/b4z87gcqvyvTV7erA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gtFpV967e88E9WRcDvmoL70hSMhzoPc+rauaC7gh34=;
 b=GlYVstR/5ycMrJyWQ1I/clJqrGfDWOvdHTa3APzBiqOq8XijFb2QUofm3VhppddlQeQctiTDgtgskXF4pok7pQhrcln7r6/hDiImIwt/zD1PUWtKrOrvta9wNMaLhGCJ5xzG4x2z5IzV/s0lCER3d1KoA8n8CsL3ym16Nsw2c0I4THyFn0zoiUfZD5VbhQCINCfy79FnrVyQI2BrN3yBo9X5xtOvqqd14FJ+tgxLF6NIgSQcG1HHK9DZwa0KbzMBK8LFQSA2ng8eJkS+/Mz2wPK8a4+Gck1CWKzImO/WGS3bCQxyW3jk14AP4G3fpbjbYcEa6rFifKmX296OpO1JMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gtFpV967e88E9WRcDvmoL70hSMhzoPc+rauaC7gh34=;
 b=jySjD80PtCaT9UEgr3uO8npLQAg1cak2fN42FhyECVuRirHzZEk7eRV9YUSaxfZ2PGHEn1RgyRhbWGcRN1gC1QBsQzx6X/BLAiLlkoqrnd8ToeEfHnAmKgjiWduKuUZypmUiRGvBR8r09xYNUEUcqsXZql/rQE0u2qC0QZ86o+E=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3804.namprd15.prod.outlook.com (2603:10b6:303:49::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Thu, 9 Apr
 2020 20:40:25 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 20:40:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Tejun Heo" <tj@kernel.org>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v12] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v12] perf: Sharing PMU counters across compatible events
Thread-Index: AQHWBzHW5dF+e/R99EaK1PXwCxhLFqhxT8wA
Date:   Thu, 9 Apr 2020 20:40:25 +0000
Message-ID: <47BDB3EA-2DF6-4FB1-AF06-F63A342861DF@fb.com>
References: <20200331075533.2347393-1-songliubraving@fb.com>
In-Reply-To: <20200331075533.2347393-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:dd4a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5868ee0a-5beb-421e-525b-08d7dcc63b4c
x-ms-traffictypediagnostic: MW3PR15MB3804:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB38049CAAC52F3600CC01C850B3C10@MW3PR15MB3804.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3882.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(8676002)(66476007)(33656002)(316002)(86362001)(66446008)(64756008)(81156014)(5660300002)(66946007)(66556008)(2616005)(81166007)(76116006)(54906003)(53546011)(71200400001)(6512007)(6486002)(186003)(8936002)(110136005)(6506007)(36756003)(4326008)(478600001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjVge/OozAOp1AzNfFDSwputNbNeQUj8jjBI3OOK/TIjCBHcf2MZqYpM2R31tuGzKUEpCAJxIxc5wPHFyzbDoJ3K2rdDR6WbLwn2yfvgKidXEQDu5ng83sLDgyDRbIVjrwZBxeGl3FOpXqTEAH4M9fFbre+kN138hOZ2otGQl3sEOpnOhZluT2g2Nna+8NhwVz4rV6lYSop6r4t0LqYTvjgkokUZRWYPq+wN0Tmd3p7UXG0ZJjkRrAKON2yh3D+u2ZI8rJ8RihAz0mcPhqu1VHJH/y2gVsEPw7gzFz74Tnk7jpnlqzww9JC5KktW9nrbXc+KUt8+E+iKrm6YXneBZApJPiM7jNmJPZ6R0Zu+dJLPNQyD8L5xyqkrIJODNnG8cpHMy3mfZkp9E3TtD19ciUZprSaldgwQTo/f4fWhGo9js1rEqoLPVu+kMxWSkKPv
x-ms-exchange-antispam-messagedata: Ut+m5D8nmszRnRmCM5ARNTunlVa9lZzijGIWeL8FIdUEScuWZ1X1XWr7sWcoXaEHYelt0xOlSMTRZDGWuxu7kxIyeVj840YVIxQE558uVT1/mxS15tAI/vT3Ngi49tIAft8JFjbeeXxAyP/1A+X0skRLTtsaxcexWFMhLWSSIMjMGI4bCYN3uaImQ/mWCMCU
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78FAB02D15DA034B8D88D7870AE29AA0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5868ee0a-5beb-421e-525b-08d7dcc63b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 20:40:25.1403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +z0cYGwN2iDTwWnrj4/7GLhhA0FaC/QWM0F/wEDVwIvxrlpsjw8hf+pyjichHyIb9bFffDYG30A7dJzYOo7C/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3804
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_08:2020-04-07,2020-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004090145
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peter,

> On Mar 31, 2020, at 12:55 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch tries to enable PMU sharing. When multiple perf_events are
> counting the same metric, they can share the hardware PMU counter. We
> call these events as "compatible events".
>=20
> The PMU sharing are limited to events within the same perf_event_context
> (ctx). When a event is installed or enabled, search the ctx for compatibl=
e
> events. This is implemented in perf_event_setup_dup(). One of these
> compatible events are picked as the master (stored in event->dup_master).
> Similarly, when the event is removed or disabled, perf_event_remove_dup()
> is used to clean up sharing.
>=20
> If the master event is a cgroup event or a event in a group, it is
> possible that some slave events are ACTIVE, but the master event is not.
> To handle this scenario, we introduced PERF_EVENT_STATE_ENABLED. Also,
> since PMU drivers write into event->count, master event needs another
> variable (master_count) for the reading of this event.
>=20
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Could you please share your comments on this version?=20

Thanks,
Song
