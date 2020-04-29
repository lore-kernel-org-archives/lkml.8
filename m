Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A5EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03C820BED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rRMR+/Jh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ErSb8bFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD2UpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:45:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23578 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgD2UpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:45:18 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TKe58s025947;
        Wed, 29 Apr 2020 13:45:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Aq0cidT1z41JegIfOn1G+lXKdzuEOZW1RociJ12fyMI=;
 b=rRMR+/Jh0Pa9PWejncSGbwgdRm0lwDUUNifnTGdFPQyDRzcwEtxJYdI3B60zKyx2663g
 lK3ZbZmX2USFMo8k3LjfVptcxKTO4wiOTBa8UTCoNv2GCh7VRsjzezhEnwCdiG2rwzW4
 ueOXVQc29AeLKm2D/ln9r26SOQ1eTbncx+8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30qd20hj7e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Apr 2020 13:45:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 29 Apr 2020 13:44:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVi3qzgwpAgxAYuD438gTNylBcUzG+nJ8EJYWdbja+ikk5WKZk+0NfIF8zxZ+e2nusqbEfGw8SHHKVaAyGGyQvgGgOustvXOArotpRsgF9BKmo8DZ3LS3eh/JzgYWPi6bZexruT6iMv0uH57kcYiU1wIwfPbwU8G7bOoBp6sMPKBL/4KUecHLfsZHFQnuF+QzM9OEqOKwjOYJnLYp3d3PcZeow61WedXoaOQeE5lzH0uVZkHXkdbPRw2f9eG34GLTMHdUXgiumgtMDYLM/2A/CJpPb6R/ytv1VSUEhTcsf0hWuvobalrS8ZKLvQqNq3nTvwOS5/J0mOYFdic9e0nwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq0cidT1z41JegIfOn1G+lXKdzuEOZW1RociJ12fyMI=;
 b=a0ET3SOw8q7i0+0mhLi1QR0cPJa3Z6FF6NxVBe6y4LyylirbT/zKsftfeX9p4O9Y+dgTu+jNtL/djxG/JYmkJDh/oxwYpfjX84npAk6fR9mdysaprRvDR75GmJiBwaJCFArduFwSf9NKW/4WmU4Bd9RCsN9oj6AzDbTDQpSZ8/52dUUQ82k4nAJ+ZFNj2zijzXben64aNzPHPklwzcbOlHorWccqmiB7DQNh/9Sl87fOXBabzRJDZLb6xmXa5ZNoEznHRkShEzrnW6FkbqR8Y/l/8tXnK0RWtkL81pPjDPrFdxuo5BVDTr8OICwQ2h9vLQu0ZsxKGLuCOEsw4cHHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq0cidT1z41JegIfOn1G+lXKdzuEOZW1RociJ12fyMI=;
 b=ErSb8bFoKukSCapvgjPkxWBmDaXeQ5vADo3kocVZdfxvEfb2F50OXUCAd97qYrAQhLh2tjnqJtu16OFU6Hx2dWVKYmjHga1lF1PevPc+mcNFJGxuoF3VKpGggHSxzTwzNKWM8rpJqEkPgvVVJfwt4t/kCe2iglS5qtFfZj40Yws=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 20:44:54 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.2937.026; Wed, 29 Apr 2020
 20:44:54 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        "kernel test robot" <rong.a.chen@intel.com>
Subject: Re: [PATCH v12] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v12] perf: Sharing PMU counters across compatible events
Thread-Index: AQHWBzHW5dF+e/R99EaK1PXwCxhLFqiCwbOAgA39+wA=
Date:   Wed, 29 Apr 2020 20:44:54 +0000
Message-ID: <F6DBB30D-B883-4C85-AFB8-8B85F356BA54@fb.com>
References: <20200331075533.2347393-1-songliubraving@fb.com>
 <20200420230429.GT2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200420230429.GT2483@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:a135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 453268ad-13f9-4ea2-e3ee-08d7ec7e2c1f
x-ms-traffictypediagnostic: BYAPR15MB2999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB299924BFF77B7C0B56E3EE50B3AD0@BYAPR15MB2999.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(91956017)(2616005)(8676002)(66446008)(66556008)(8936002)(6512007)(6916009)(86362001)(66946007)(33656002)(64756008)(54906003)(5660300002)(76116006)(478600001)(71200400001)(66476007)(316002)(4326008)(36756003)(186003)(6486002)(2906002)(6506007)(53546011)(4744005)(87944003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: guUHIUVECJgo5w/AEE2sHqUspsNydZcGgDWSfrBmTsYQV3j+d4VYxBh48g9OC10WUuDXDHkmjQ1ouwuNwNQtkeCW+XQCHH8uGNJjUZxZ8/BLK5Pr6ofjZ+J+p/Ky23PMObbRT+YUae+B0YoflvNJmF4a8heM8byGkVseUNefjGxQsSXCqP0WYq91YdyKsQAuTYSKO2dLSrXPA6b52ma0oqkCqKIBa8cugfJEee3xwbUqjXx6IOIG49LWMlWWKdbiSb0o4sYSbcqmxQ0X75ETarM0OFA6RUigRaxQX5/8OVG0qA1FRZ3XGYTBiEkt8Ndq4GYP5r+9NR57TxgSN6272XUUKC41piO9ezpDIRrpgsSjFEmKsiQCtdcTcm/EqBKhbrkowWVaYZXHnTxdKgmEd9SOYiqDKIbAxsNqcOsjU7enqPz9r6HzFhK59yyZzvyREnhHzWXOo8GpeErYJ74E0JFAzNizRWEtr5CkuVruh2fkXDAMzB2mtDC19RX72cqJ
x-ms-exchange-antispam-messagedata: XaWrwlwhdGu/vBUCS4TmzAa6UNLR/+N+qWfA0iQML7xSwjo0RwyqjpEKBpzgTjs3VrwOVO7WMpYi84uwNcXh9mUP0RZomUwYsENPgn/wQf8qmQjmoCKITpDo2IRvOkSobuhjpCoGFWErhWcGx8Su3Tf/D0/8d23S9of1E4zuC65CgDXvAo9acKJJH5u/RqPcHdVmVOAd/U+GyQyLu/Xtam2HF4rDj8psuDTXi8aIDzt6DePt1DAbGXthnTjTB0zABafD1zbNhjtSJ/Pcx78EPd5nnff/kctFYabjW6cRAUSNCnwbpo4iejdOf1DkwWFO97nQurXwkz0nCx58BGGp3NYThZphKGlOszgP0Ncn2M3yqjUAJy/q8lDKrxLrXEUM4osjKbYxkfwIKwdQsgzD6kFfuI25EZZQRv3a9eS93yKdKsYG1AGZzyH6iC/LgFo9GhKnR0WICDZJmUJI/+47ttClq+T40RjuhKLpCiJ1hBYnNu0weegjtKpMGEjwUYFREI0P6BYi3wMQIdzIZzEP95L6arQb1yJZwzOoGJwrLfq5oeREO5Z9gVx1eF5+0ssU92C50eWwR8xeYnoeHSe1dlCf7DwcpDll3vzZs1I371ewbf1DcUGJlEhMgjE9IEmxGYEH/02F70qXg2YQH2gCUxZOC5ztpABjr/TKS5VOz4r7IJ0flYajgk8lufujTxVzpmqKpKW3/Cf0iBn9WtmDk6FBdipqXD4fbiakEcud/hZz9cSSXOw7fS+ACi9KdUxD4PMRBJ3ivq2EQAg/ZKc+VimCTU274ptPgLXwxIpJjgqpDupVhjJ4xfOIEyrfH+BN4KaTZhCOBWBsxPzZNo+/MQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3DCBA7E2F6F7E4797593E912B488FED@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 453268ad-13f9-4ea2-e3ee-08d7ec7e2c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 20:44:54.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCeRd2L36qk+pI/+KvqKIOvRH3c7D4fFouwD+9s0Spv5miRhfPT57q0l1rZW1QhKSPMsKV3abGVvAZ3QcYRQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2999
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_10:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 20, 2020, at 4:04 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>=20
>> static inline u64 perf_event_count(struct perf_event *event)
>> {
>> -	return local64_read(&event->count) + atomic64_read(&event->child_count=
);
>> +	u64 count;
>> +
>> +	if (likely(event->dup_master !=3D event))
>> +		count =3D local64_read(&event->count);
>> +	else
>> +		count =3D local64_read(&event->master_count);
>> +
>> +	return count + atomic64_read(&event->child_count);
>> }
>=20
> So lsat time I said something about SMP ordering here. Where did that
> go?

I am not quite sure about this one. I guess the following is sufficient.=20
Could you please help me double check?=20

Thanks,
Song


static inline u64 perf_event_count(struct perf_event *event)
{
        struct perf_event *master;
        u64 count;

again:
        master =3D READ_ONCE(event->dup_master);
        if (master =3D=3D EVENT_TOMBSTONE)
                goto again;

        if (likely(master !=3D event))
                count =3D local64_read(&event->count);
        else
                count =3D local64_read(&event->master_count);

        return count + atomic64_read(&event->child_count);
}

