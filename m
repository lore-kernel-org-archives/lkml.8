Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1472C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F4E206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ioB6S3hj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fi/wSoPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgG2HJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:09:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgG2HJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:09:47 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06T71p4H031929;
        Wed, 29 Jul 2020 00:09:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GQ9p+7CKJq4s86DzvdOsdjyYjz4YWKx35qdNo3Dm7oo=;
 b=ioB6S3hjt6dUzVlMbZ6NUdSnbdVAs00uXlAGO3V3TF7PcoJ+uEovmX5bUkSwLb9AhAxF
 ScLwjF2IJ2CvXna5j5ecd6esp+PeOjjANpLLQ2hU1SQn/NCln/jOxl4tLaGLA8tebkHX
 cqqtZ/7JW9rbg8xZ0Iq4gtCPvBNd7OB/AOo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32jk9d4dcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Jul 2020 00:09:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 29 Jul 2020 00:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaKDTvOwKo8aKA7suf84pfZd1ruUpNreHeDTDgkpKuGyxUuZnso02N35MSYUfBqgZbzkzk2GhIugUxoBVWWsnRg1bRpuUBg84gHs/MmWAFEXgSS3MdGQrZmgn8LWi5Q+Z+I4IRuA53ON/aQDFWsE4jPLgdw5/DkCN46xm2gf6gCWwMT1qNZqXiATNrGPi1y46+WP2eHYcI/xXGAF0TlkTgaSICdwb40FXqGogrdUQVF5zuD+87+jTa+EMPTWZduaxHxKnVYJBAjtvhP7T7Jag6IYonPoX37aAYEbvXjTwgwCsaKP6lTdZmtWvpsMrhWFQLzYpWMwNAHihh/lGEmzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQ9p+7CKJq4s86DzvdOsdjyYjz4YWKx35qdNo3Dm7oo=;
 b=ijQZp1/LmSKtSgD1WQa4WboSlGnA8pnetTCM11XqFubS8mhqc1wdzBmMqgaTsjWIR+V4uB3OoTz/MVD/aCWzPC8K7Zwcl/4ZNgesblpbFxJLBLz2RrRvdRaZK0atHy0/2OIyWaMPkV07wqVoNAGUNt68O54FeU/4YpRuz4PKhCsnUAaD2TLA9Q2gyL+/dkIdC0CfTjkYzBaFsYi5MyNl2v1fJs+dPDk6IXL1YGhy1c5os/IHjP52GZHZ+95kdvUPa3jGv3RYWuEAL7X2+mN4OnO0f4unmj1vfrr2W4wifrRkJnaesYopprCz4Pzyk00OThcuwnxv3v8oZo+I/xBmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQ9p+7CKJq4s86DzvdOsdjyYjz4YWKx35qdNo3Dm7oo=;
 b=fi/wSoPmPHf53fpxZhR27Gny8dWxHt5wW2XFOQjoe4en1XDFZOMOWyv2OUHFXYp5FiYpfPNuMN96yWo3SnRr9EJaHX02fmK93HX9nISHlVEIDll6ktdQbbPJDTeUFcN3+hpUloTH0UJxPb0nPv7NivWb7fjZS45EpfE+WIEHVFY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3205.namprd15.prod.outlook.com (2603:10b6:a03:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 07:09:42 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 07:09:42 +0000
Subject: Re: BTF_KIND_FWD enums
To:     Giuliano Procida <gprocida@google.com>
CC:     <linux-kernel@vger.kernel.org>
References: <CAGvU0H=AAPt0wSTh1dyb-aTnG9zeUY6U2uBkmi6K9Bvpuc9YAA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9d9a48e0-844d-8ba4-b839-92cb1af622ee@fb.com>
Date:   Wed, 29 Jul 2020 00:09:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
In-Reply-To: <CAGvU0H=AAPt0wSTh1dyb-aTnG9zeUY6U2uBkmi6K9Bvpuc9YAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1215] (2620:10d:c090:400::5:df59) by BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 07:09:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:df59]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66520013-0b11-4f15-b31f-08d8338e5d58
X-MS-TrafficTypeDiagnostic: BYAPR15MB3205:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3205AA492CCA16DB98C97F63D3700@BYAPR15MB3205.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mlz+4MaFWd4J51CNHhc95Scrlc+B6iufSrUcK5+ToUznKdT+NttmyTeAZfWvB8ESnjfK9nFCfnjon/PhAgtDFnTL3+hlsgvmQC0okaiINC6hPL1P41FOtjkp8d0dOmMEm3+GGvLUw3E7FUOJbP1nwvq0PIwjideZrqKs5uH1mICKLazb/zWM+BwNlC8RnI/GsR04IZ22j/xKb+JrqGQMuj1e/2XQau+ykBsq+QrlM+rzCNSCFiHS07N4S/rKzmSF+jF2H0Eoqu2lbCmE0kKnD3d8SGdo2sy2fnxoitG9KABpsLyr6AeZOvxKL987S6W75nF36vYSqzuwBwrVsQg7jltPZf2bLQst0ZJtffRR/4GPw8V3A5euit8DFy5P6DfVnGrhElYrXsJwlLx9LUKbxdCA6D0I0q1AFXfJfB3dF5Cb0uDqxjgK3D4vEY0NJL355esoWcnKuXEvt8NcdBer5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(376002)(396003)(39860400002)(36756003)(2616005)(5660300002)(6916009)(316002)(31696002)(7116003)(52116002)(86362001)(966005)(6486002)(53546011)(478600001)(31686004)(2906002)(186003)(16526019)(83380400001)(8676002)(66946007)(66556008)(66476007)(4326008)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6/j+GaoV3/VdmSJpzhoT5/NjWfsbK4cUNsibGYdOOpIOhIKhjdAT2AIWr6NQ1Dvien7IdxPv8+6Nz3ECkVYfRKRc2tB0/YCdumUU3AnO+0JDiaS85BgGSg8EYefqe5ZddRza0u9WLxLpNjZRShRbQ04jUdBosnqHluqshHythnqYxi0BLpwkU+b1RgYbaO2W+JTT3xaEXCcQu2THsUtPJVEN3xAqiuCofCW9Sn97afMqPW/FrMsdCRFBWFHCiF8dhs10ob/kLMYrThhtab64HfZlRgvpojcpT4PN9r+rwQ6bdIDnWnJItcz3P2FxWUkTUmqkUARICVmIWJnbfnG2K1x6ua/NLcRQu9/AhYD3+qMY56hTj5wiDUwiZfkMNYo4OVtEiAtcx6/vijsWBqQqPS+ZeYT+fKZIHvIkaDDWF30uPFU0Rft8Mtn8hqgyIRA21l1bLDUJTrgCTv6BQkpgMqunlgauXXASJIWbKHyet+HYlZQjlACsYkHz0J3Y/jK8OTONV1l502J3vign1+GCvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66520013-0b11-4f15-b31f-08d8338e5d58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 07:09:42.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAOxUjX7cpBiojIe1exbNz1K3vCqVCvgtnIdeOidJadc9RwXB0bOp4/8do4CpHKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3205
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_03:2020-07-28,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290046
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/20 1:56 PM, Giuliano Procida wrote:
> Hi.
> 
> Re: https://github.com/torvalds/linux/commit/9d5f9f701b1891466fb3dbb1806ad97716f95cc3
> 
> Both GCC and LLVM support forward-declared (a.k.a. incomplete) enums
> as a language extension -
> https://gcc.gnu.org/onlinedocs/gcc/Incomplete-Enums.html.
> 
> (C++11 has a different notion of incomplete enum type - opaque enum
> declaration - storage size is known but enumerators are not)
> 
> Forward-declared enums feature in various places in kernel code and
> allow the usual things to be done (passing around pointers to such).
> I'm curious as to if and how they are they are handled by BTF and
> whether a further change to btf_type is needed:
> 
> 1. Use BTF_KIND_FWD, with another spare bit to allow up to 4 kinds of
> forward-declaration; or
> 2. use BTF_KIND_ENUM, kind_flag 0 and vlen 0 (as empty enums are
> currently illegal C); or

#2 above is the current way.
-bash-4.4$ cat t.c
enum H;
enum H * func(enum H *arg) { return arg; }
-bash-4.4$ clang -target bpf -S -g -O2 t.c 

-bash-4.4$

The generated BTF enum type:

         .long   1                               # BTF_KIND_ENUM(id = 2)
         .long   100663296                       # 0x6000000
         .long   0

So vlen = 0 here indicates it is a forward declaration.

> 3. use BTF_KIND_ENUM, kind_flag 1 and vlen 0.
> 
> If I had a working pahole -J, I'd test this myself. :-)
> 
> $ cat /tmp/en.c
> enum H;
> enum H * fun(enum H * x) { return x; }
> $ clang -Wall -Wextra -ggdb -c /tmp/en.c
> $ build/pahole -J /tmp/en.o
> Segmentation fault
> $ build/pahole -J /dev/null
> btf_elf__new: cannot get elf header.
> ctf__new: cannot get elf header.
> Segmentation fault

-bash-4.4$ cat t.c
enum H;
enum H * func(enum H *arg) { return arg; }
-bash-4.4$ ~/work/pahole/build/pahole --version
v1.17
-bash-4.4$ clang -Wall -Wextra -ggdb -c t.c 

-bash-4.4$ ~/work/pahole/build/pahole -JV t.o
File t.o:
[1] PTR (anon) type_id=2
[2] ENUM H size=4 vlen=0
[3] INT (anon) size=4 bit_offset=0 nr_bits=32 encoding=(none)
[4] FUNC_PROTO (anon) return=1 args=(1 arg)
[5] FUNC func type_id=4

pahole also generates vlen=0 ENUM type to indicate it is a
forward declaration.

Maybe your pahole is too old?

> 
> My interest here is that I helped add support for incomplete enums to
> libabigail which we're using to monitor kernel ABIs.
> 
> Regards,
> Giuliano.
> 
> (resend due to email address typo)
> 
