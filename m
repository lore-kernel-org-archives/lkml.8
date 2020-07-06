Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B91DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED50620715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q5LWiTg0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fmamYTz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgGFPzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:55:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55694 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729348AbgGFPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:55:52 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 066FYsko024965;
        Mon, 6 Jul 2020 08:55:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T+FKTFP3yeDfKZKCikGrwGdTk572RPPpQyxoLx/2E2w=;
 b=Q5LWiTg0D3gL2tCST/P4wGmL09vp0i12y5qJmjgfj7QZNc+SZ5SaX2cPF5U3B1mZGECj
 UjVs0F/u40dO+Fs/qeZpb57OOZU/9Vx098Q+IOe7aF5mI5kAQ5UFk7epS9rj4C6vfzFZ
 SRgpGqJrIWr8GXNTHE0dxrErJDdHbaP1bdU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 322n90fjm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jul 2020 08:55:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 6 Jul 2020 08:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmBmpyUpJyA7NWJYbueG89APGkhkrewPy4oSEb40L0qYJTH9iVPcchKCyopsyNidOy1zMNHy9Z3k2kvmfyE06TQXv3t7y6/Xo5ONuSDT2xj5oKS+FdemHwvIw8GZY6C6i+r/G92qI4LcXPZJaqCHmJJhNwykcFg8Ijpg4yUV1Qep2Znp6hzRnr/6IpkLGTyfdqqZ69gJ5OM5BzTbi2aa/rxgm1a1zOW5j2O75e2JlqbN8BHd54KaR8Z686KFk+D0EOjRU9LGbi7scJX60I2w9GU8omgh1fF3pBY9huuozWQwMlat4Tm4DI2CCgWFaqOPMkCW1iHSv4ijDf6+TEqd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+FKTFP3yeDfKZKCikGrwGdTk572RPPpQyxoLx/2E2w=;
 b=n4LaLawQ9G7GnZ7HfmFN8vwUKdUl9Lo+GRJMVNATu1wxY8Vs5Fmfg7DHwTBUFBSJrXeziCMapRUtuMF2/l8T1ZI578CKMaseaSiJMlj1Jxx6BOKlx4XGFg/B1a1ptGR2c1eqHXXP1JGth92rmaO8RaHJHfHTvPh7Zf3REEQPXlzE7aFMv0NKxUjZNJcwXMmVNwbow+cnPGw2eIaiXAMS5Snr3N3zjwKME4jP6JAXPmNy6+TnOcTTv6jzDuAlY60jqCX6bpC0P1HKP5j0iLDs+ABz0a/wGZVn3ai0NvmLvQC7PXRjm78Bs62DwQb2ndlLrp0L+al6o+Ft8qZZfxtHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+FKTFP3yeDfKZKCikGrwGdTk572RPPpQyxoLx/2E2w=;
 b=fmamYTz4UO4CnlaAgzjsXzI5kmxgfUbqW94XO+B1Imk6iHFvGPAyVX2OC8Y8OYcEEgTXsw9cGYMIfQ1gb8QN6XoBenvCuBx6DURpzKETgKC3GEFqxMa21lKziiUmqVuaTHrQe2gHYveea6zCRuCmsPMfr3Z4zTPILYG2tAhI3Lw=
Authentication-Results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by MN2PR15MB3584.namprd15.prod.outlook.com (2603:10b6:208:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 15:55:23 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::e9ef:ba4c:dd70:b372]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::e9ef:ba4c:dd70:b372%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 15:55:23 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Willy Tarreau <w@1wt.eu>,
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Date:   Mon, 06 Jul 2020 11:55:21 -0400
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <D472FD9A-0229-43A6-86DB-59596C067A61@fb.com>
In-Reply-To: <20200706140636.GA19803@pendragon.ideasonboard.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705045505.GA2962@1wt.eu> <798B0FBF-D7A8-4631-8581-5D199DA50FF9@fb.com>
 <20200706140636.GA19803@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:fc::21) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.232] (172.101.208.204) by MN2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:208:fc::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 15:55:22 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [172.101.208.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8100ea9f-71d1-4dfb-580a-08d821c4fdd3
X-MS-TrafficTypeDiagnostic: MN2PR15MB3584:
X-Microsoft-Antispam-PRVS: <MN2PR15MB3584992411E4437E3D3F0276D3690@MN2PR15MB3584.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Fm0g1zKorJPTUU1nsNEybANApe/txHy2mORvvnzD+YnPibzN/X8+QA6n38Cq2QpGA7nMy6DiBABDB6Ntvga5+G7vusA+6CZxarZhcddEXQHdHWDYKqD2Nh4fNBtG0o18XvtVm+aZktC5WSchJ/d+1iNFMiqXHKtj3s3s4+rGnOSuL1S/1vSqsicmwBewGAGS64ZtImQePQFMay3j3ZlXhytyRvnKSAaJ0+r3mjIlykAYGa6n7LQT/P8BIoK3hU6SakmX8Vfao93Pq+V32oKCSZUw6yrqoBO7AziW+Exmunx16K0DhHft3Hd/TeCWsImL0R+pIWI7RxQP7YxOUDlzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(83380400001)(2616005)(478600001)(54906003)(316002)(956004)(33656002)(8676002)(6486002)(52116002)(16526019)(4326008)(66556008)(66476007)(66946007)(8936002)(36756003)(186003)(16576012)(86362001)(53546011)(2906002)(6916009)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Ict3l2LsncZO6eizjPmYTIjqIGdULBGNHeteschbmuOL+3/NfuJq94BRKn1x83xR5w1EvCiig37jJBlLlWC3jwbtyLgQ8RQnenSazlg1Dl7BNZtNuSsYmm+0BGd564iXVm2L5+1VXQgkjlOZRomIsAwjXM7ZgXls10vi7GaXS8e6lKEXCPRBIgNBMdtllx394pXrrOayiBD+aCFGd/n9QXNk5x3A8Ggo4lkEqeugLVlFAnFBLRtPvBh7cosuPoriGeFvXEpYnVUv2J22t773jNIHP5WI/7t8NsWJDmBicPbLEbOTibbZWdjN2Qrnpfoo5vCftZh7r6+8AoRYnXAtz0QngJ0ySczP80iyePYfeEP3LbgLfHI1tEiT3X+Ko6sR7two4CRunpgixJ6Bu3aFz5FmvMQOUEPsoT3m1dut+7xnIp5VKOudxb3iDaFTEGHQqtTcuUBAOeha9zbbLGLkMuwo2JVHFTCw+mZnOePnBTSV5KKI2dmaHx/2alZNfEjM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8100ea9f-71d1-4dfb-580a-08d821c4fdd3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 15:55:23.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0YnIQ50lmbKNHSs2q6qLLsf7dj103++SR4hD/lRaJILUOCH3FCoosNurxjtcbcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3584
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_12:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060118
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 Jul 2020, at 10:06, Laurent Pinchart wrote:

> Hi Chris,
>
> On Mon, Jul 06, 2020 at 12:45:34PM +0000, Chris Mason via 
> Ksummit-discuss wrote:
>> On 5 Jul 2020, at 0:55, Willy Tarreau wrote:

>>> Maybe instead of providing an explicit list of a few words it should
>>> simply say that terms that take their roots in the non-technical 
>>> world
>>> and whose meaning can only be understood based on history or local
>>> culture ought to be avoided, because *that* actually is the real
>>> root cause of the problem you're trying to address.
>>
>> I’d definitely agree that it’s a good goal to keep out 
>> non-technical
>> terms.  Even though we already try, every subsystem has its own set 
>> of
>> patterns that reflect the most frequent contributors.
>
> That's an interesting point, because to me, it's the exact opposite. 
> One
> of the intellectual rewards I find in working with the kernel is that
> our community is international and multicultural, allowing me to learn
> about other cultures. Aiming for the lowest common denominator seems 
> to
> me to be closer to erasing cultural differences than including them.

I hadn’t thought of it from this angle, but I do agree with you.  I 
think the cultural side comes through more in discussions and in-person 
conferences than it does from the code itself.

I do try to avoid local idioms or culture references unless I’m 
explaining them as part of a discussion or a personal story, mostly 
because I’ve gotten feedback from coworkers who had a hard time 
following my bad (ok, terrible) jokes or sarcasm.  One internal example 
is commands that take —clowntown as an argument.  It’s pretty 
therapeutic to type when you’re grumpy about tooling, but a lot of 
people probably have to look it up before it makes sense.

-chris
