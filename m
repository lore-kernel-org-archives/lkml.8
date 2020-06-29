Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996F42078C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Oy3K5Ag6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AdTkpQJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgF2THg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730818AbgF2THc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:07:32 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TF6FTe012597;
        Mon, 29 Jun 2020 08:10:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wf30wEEJDmil7omMqdUJ1gyyCQzgkjmSEHpL2q5VBoE=;
 b=Oy3K5Ag63R6JtAm00nxDrEVjL6h1/Afw3pknoXqL+Y2tubs6Lx2PLr+1ShQlDYVSxjOB
 ZixzxHUd0KnXpvI5jpanGFIm33PC3IWMIlQb1FGDPMWBB7Ad1UtFxmVflnNdPFQdiB1A
 Xque47MMLImEmvt+FGLn4HZ1EiekmMDFS8s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31xpcnmtv7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 08:10:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 08:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE6vaM4UOEvaCKBFJZX27g8OE/9OIcJ+yhzaewuvUW4dIdh1BCC6zfxaaFGSB1uDuGBnXAEA7xpvyPqJc2sXk2xhIVpQc+F81BekSECXqIe6urNB2dUkg5ByUG3GjG5/zdMU03gfZwYUmd+mO29VNB13n3jwVmVdt2Botwnz1VYGxhJQF7SyCE6GcGX+/NM1LAeuVON1xdiwvYZdRecndmQA6a8qiFxZtkjjM3zKvq3yy6jyh1V7QsRiOgBqnvx0qdcai83X/a4lo7fJ0tlRGFp2XG/1KIfdpfqBRKqKe4TtQ+QprwQUIlTCsGihVZ0DDlCm8TSxGeBEgCEKJroqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf30wEEJDmil7omMqdUJ1gyyCQzgkjmSEHpL2q5VBoE=;
 b=f5fkZaeau8R3g1OPyc4g8EvGwCW7IKIEjpWGWtOKb95dRR8ok5jYGctZljKnvxE8eFeUZ8CpBLNDLkSq8CQKLKz70iasAhpWb407IJ5dq2uytJpOTg6cH1EeGFIYFy98rNxQGGH/3+iQzG/NMGbA5Z0izAhkJcKkLexJfAa+skNGnAN7b5COfZ2bSSuIbshoe+vwmpzTehG5LLL7gR6ycM/XNjsq+03tn+mQyAYWRyZN5/XSd8f0I2YO+evhnJQd5E5Dag9qdzkHNtmVA+wnE7tNvxtF5jHTADt8IN3L/ZNTqN3Wi7Ou46uA7SDUQIXFOpsEy+3d4qy7kUxsud2yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf30wEEJDmil7omMqdUJ1gyyCQzgkjmSEHpL2q5VBoE=;
 b=AdTkpQJc3LpicXo+wO9dlBFkZnGH5hGSJ4gTVp9x6uaDxyG+uks6WmWoCKiU7PvGEOo7UmiAaRguntICtJWDpNzlZAGFrvaur0oT8PuBIOilqV+5XPF7iF8a82WpGzrTb38g4NxHBy22PDVxmKZph0xfxmPup/4/y77eAv1Utk4=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3094.namprd15.prod.outlook.com (2603:10b6:a03:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 15:10:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 15:10:52 +0000
Subject: Re: [bpf] af7ec13833: will-it-scale.per_process_ops -2.5% regression
To:     kernel test robot <rong.a.chen@intel.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>
References: <20200628085032.GT5535@shao2-debian>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cb4cab43-8f13-dd2a-5c58-855d93c6e790@fb.com>
Date:   Mon, 29 Jun 2020 08:10:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200628085032.GT5535@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::11fb] (2620:10d:c090:400::5:c5e6) by BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 15:10:51 +0000
X-Originating-IP: [2620:10d:c090:400::5:c5e6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0215cae-6e2f-4cbc-36ab-08d81c3e9cc0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB30948BA2273CA285FEC1DAA1D36E0@BYAPR15MB3094.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4idhr6YpDBdGJYZYJr6/ChqREU+r7dIBIOotAEYjX34ChT8hzURV/qBK/dzUnE5tvMq9J1YPAxlFTYuyeSjM6/JfddOxVajOfsrUiHDGuAR+WzeRyPJZ7WbroMV5zwfoE7iLFUbE2o2GtS/Tza+bedHcozIqnCFq+19vi/47z5+IgGqkXVSJ44CPZGMXoii3cI56BbFLI36R8lzSemHNK/Mxb3a0J5sKRqoPCquO7KmjXr8+8GNvqW3W683SI5p+wp4uLiobY91JEgMI8Avk2+3T3oaYDYPVY3xH/63baWyD0ycPEoujWdpfBaLnLRAzqjyTPhyODpS+36OF2/s5h8m5YUwEHQ7GhBtZ1ssaBYIq9SxgXLJIWj+NHZWrkDFW6p+wcbsjlAy42BvWCPSSobbwsQXhMU+mEFgmiiz3Vbr9BnRzDFWvwBp07kGGoUkYbVmFCCgyM0zrBCP8cGahNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(31696002)(66946007)(66476007)(4326008)(66556008)(31686004)(83380400001)(6916009)(36756003)(966005)(2906002)(86362001)(53546011)(6486002)(316002)(54906003)(52116002)(478600001)(16526019)(186003)(5660300002)(8676002)(2616005)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: l2ciBUzwUQoyvxxj3yZslnBZ9JOGTTowD90drognwG/mMpcTUiTELewpE23RauhoeqMC+/uavEybRabJ45JPHnQP7NApfTwDhE+la1xtYIK+UErsQlE8sx3Gsztuv6/6J93XdfjZcKIkpfStJGYmi5xCuYsQSg/2Z+jtqaudcG8/w1dz8WLBErUR7QGE9wwt77w3RGc50e0tozrv1qH7tgL7JNRVkp2Gqb78XyKgcO9XU+K4G3VvLaK3RCGTJ+Fbr5zAjxmyhejQtGYYF36wUhlm8e96ix6B5omAup8V0uUbUIja2JTBDxriYRy/9OC3E3eEbroufRQz6k4JhooBGLf+rn5uGbSTJ76Y+jc2WB+MOWgX4dCY7zoqDQCWkm2LHESzpgcTrHX4gBT4pUXyiTWCyQlmbAG6HfRg5pEbaGBNMW322STS9FrS/UpPOL3956HXPksvH9b0WwWoODEMBtUhgjshBGjnrKpMGIzyTMruxxqVqcROeEI3PhGC07wcnXzRZi7bCBx8OjLWOwIVZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a0215cae-6e2f-4cbc-36ab-08d81c3e9cc0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 15:10:51.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbtDDIQ4smyxI89AmnuuEPaxF983dU06nbVyXFTAWhvny3lSIb5zcs0XHpq4iWgo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3094
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_15:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 cotscore=-2147483648 suspectscore=0
 priorityscore=1501 mlxlogscore=725 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290103
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/20 1:50 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -2.5% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: af7ec13833619e17f03aa73a785a2f871da6d66b ("bpf: Add bpf_skc_to_tcp6_sock() helper")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

One of previous emails claims that
     commit: 492e639f0c222784e2e0f121966375f641c61b15 ("bpf: Add 
bpf_seq_printf and bpf_seq_write helpers")
is reponsible for 2.5% improvement for will-it-scale.per_process_ops, 
which I believe is false.

This commit should not cause regression.

Probably the variation of performance is caused by test environment 
which you may want to investigate further to reduce false alarming.
Thanks!

> 
> in testcase: will-it-scale
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	nr_task: 16
> 	mode: process
> 	test: mmap1
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> Details are as below:
[...]
