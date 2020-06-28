Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F59C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8838D21D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JomaXjQp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RAAgeZVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgF1GHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:07:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgF1GHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:07:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05S633sV023834;
        Sat, 27 Jun 2020 23:07:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/1qpm+NUSwsTYKA2j6NWw8k2sIlfIoPjjqYQU2RwnJk=;
 b=JomaXjQp61WBHEjsxi+zAxl+xcLquCoeF3h9Faq8CaB0/Vsz2EgIqmgVssZdpfVFLLX2
 XGerLIAqM/lJjP8BL+Rb3hOcB/QIA1B61phwK3ywv58smwySY1hsnX7BLXlNxpjUcMZT
 wgDC+F2tXThSQH9nFxJtmMyvvlboEdAEvjw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31x3taah6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 27 Jun 2020 23:07:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 27 Jun 2020 23:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvv29fyACxa5muHoUaNbP861TuzupSO/xAYdcKoO2R8q74G/extabZpOi+O0su6PUcS3vrxoVTaPaLgLSHlDSiX0yM6Xt2HL+s4n1+tDBDZn8RrdLveWZEOehT6VUo/EmRe/qky1SWEinDzcxja1EZyWWosbiygJR4ZPFIyjOQQpB14YnAA+HPSYc8d8A+DatnT5pdSWIt6wn44H4GzitoAw13jHQdmMyRviCALrjwX8Mf95Q82mKEHEMuG94AVChLi7MWf6Vy7viAHrV02c6FORkyu/KF6VC4R90ZQNR463baVfSnr+t7JcpBVLO0LU1tRB2ZE2SDEP28ebLGucEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1qpm+NUSwsTYKA2j6NWw8k2sIlfIoPjjqYQU2RwnJk=;
 b=aBM5g64e78FOpXzZy7mlvwgC7FCUXnFGaw4Xc1O9D+pvm41DdwiOiaCZi0TMXEp+fhxixqT/cE2r7JiIN9oLzWkT8vPGlq0n7ZqOHkjuMwxZqH7fZ9Q4dG+hQSwBbauXI2qojaCmkBmCaBpG4WbzwnHA5jrdCqdMAoWtxxcYIlfRiI4a14HqgNWZERsRdiE0vspI+q9kGsChlJqxgwLwsYp8qAgc68n2B3SRGQAOffOG03zhMA5rm+HLxDTvALHphagcEBor7+AXJjJYJ8bh0LSS6pSLPODSBeYti00TTL0AEp260egqCqMHnGpRoZh/+WWxzbWFWAcHhFrByqYsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1qpm+NUSwsTYKA2j6NWw8k2sIlfIoPjjqYQU2RwnJk=;
 b=RAAgeZVMnGuIfs0V+TSmacIQ9knABANqOBtjZe9VbAhctWbgKH/buYCbd0V/NFyQByZAK+xjc3rE4kaSz2F7AYqfeqLW9wpXrJmnA1Bo5Fc5/QwWcQVBRdD+sf+fno9q+96ZzNfwVyKeoZi9WykPjWU8I3QIkW8jfrse9XkJ0AQ=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Sun, 28 Jun
 2020 06:06:54 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 06:06:54 +0000
Subject: Re: [bpf] will-it-scale.per_thread_ops 2.6% improvement
To:     kernel test robot <rong.a.chen@intel.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>
References: <20200627082222.GG5535@shao2-debian>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8b8e0e02-0f2c-17ca-9d1d-3601a9520da2@fb.com>
Date:   Sat, 27 Jun 2020 23:06:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200627082222.GG5535@shao2-debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::11b0] (2620:10d:c090:400::5:dc05) by BY3PR10CA0016.namprd10.prod.outlook.com (2603:10b6:a03:255::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Sun, 28 Jun 2020 06:06:53 +0000
X-Originating-IP: [2620:10d:c090:400::5:dc05]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75074408-ebe5-4d45-eb4b-08d81b2974b9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2822AF929E8D2A0D10C2F687D3910@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0448A97BF2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huUhDfixeFpKT+H+Vj59Z9tMyHSFHMlaNxVM4vWF+7DXdze7uCqetn+dNRBM4v5RbQDFP85FSTL8lZHOUBGdVb4sgf6+xbztcsRV/Ms0lZP5wTzrGWUIkIIEyAASEsLB/7qnN5scSnTn9el3lyZA7se2CnAdOz+czaexInGFxXcWrd/HhKq2dW3NLk4Av44Z2vQtXB0hDFLUEBP2P3peyjBquT82zd8H9jN3rMPzzDEhWMKoqB2x2AFTBIvnvM4RBcUXEYF5dVKalraVZ0s9zakNyJHT9F9Lio9Eza5p3Pr9bFTKqw3Q5Vh03DsDbYK7WhAtPqOcBc3pCuxeLLTRSAnxYg363DZGKs1KiKJEZKmOm9lLovKbffo0qJzqjOaskfPvyI+IYkv3jxpgEkOIhu7n5L+dj57syQtlOp7OvIt+yLlOfeQUSguaVsrWESasy92+8x56docGUiBbBI0NkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(31696002)(2616005)(36756003)(86362001)(5660300002)(31686004)(52116002)(4326008)(83380400001)(53546011)(2906002)(6916009)(8676002)(478600001)(66476007)(66556008)(8936002)(6486002)(316002)(16526019)(966005)(66946007)(186003)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1NPgHkTYdsgeZsFYaAdZ1B13ZLfjgKikAidxDNJ4UpAQv4YB9f/WxNi039fCDT8HG+UGs6uh9HI0IYBXv3mbE4kD6ydtsGK+/wPLjmLCsI2YeqM0prtFEIzw9h8WFW1OssScY0Ja80+ECOnDLHtDvOYzFolRMy7vHu/KwALnKHfks9YpsDWiUmjG45rldTrRsEcPUjHPNrswPIdYbL+c7ffUxuOoa28763q/uAV7L21PgadG4UQFChsL6NWBf9hap6LK+wbuofErm4gK5lQnq8Ad28YMlPbMEmx2XOGAlGFifFp2unr5vCuEbEfSd6FpV0zd6UiLcGZiVh5xtOJVlsfhXZEUcTrHiFRMGXU9U5hBXMBbataNFCOoBRkwY74SfrIhExHo3kNhYsmGJ4s12Ya63vuDSnYy0jba2MNM8DXd7onwxAcR+98oUo7fscW//e6eHeJVU3wVh+L9mhzKVFdj6riW2J4Yn82uO9BaMQPZYn7B5L5eBQk7xDqKUtvVMXAzn5R7nfBz7/+J47claQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75074408-ebe5-4d45-eb4b-08d81b2974b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2020 06:06:54.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUtPiUoMbBmZwymRDo+cYbf/dLv6gNMbrEYePCeno77TKmcpiILYPg6fwW9R1Dnj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-28_02:2020-06-26,2020-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006280046
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/20 1:22 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 2.6% improvement of will-it-scale.per_thread_ops due to commit:

Thanks. The improvement is always good although I do not know
what will-it-scale.per_thread_ops exactly running.

But I think the commit
    492e639f0c222784e2e0f121966375f641c61b15 ("bpf: Add bpf_seq_printf 
and bpf_seq_write helpers")
probably not the reason for the improvement. This patch just add bpf 
helpers and they should not be called in normal user codes.

If you want to identify which commit is responsible for the improvement,
you probably want to double check.

> 
> 
> commit: 492e639f0c222784e2e0f121966375f641c61b15 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: thread
> 	test: pthread_mutex2
> 	cpufreq_governor: performance
> 	ucode: 0x11
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+----------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 2.5% improvement        |
> | test machine     | 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory |
> | test parameters  | cpufreq_governor=performance                                         |
> |                  | mode=process                                                         |
> |                  | nr_task=100%                                                         |
> |                  | test=malloc2                                                         |
> |                  | ucode=0x11                                                           |
> +------------------+----------------------------------------------------------------------+
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>    gcc-7/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-knm01/pthread_mutex2/will-it-scale/0x11
> 
> commit:
>    b121b341e5 ("bpf: Add PTR_TO_BTF_ID_OR_NULL support")
>    492e639f0c ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
> 
> b121b341e5983bdc 492e639f0c222784e2e0f121966
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>     6105969            +2.6%    6265564        will-it-scale.per_thread_ops
>        9855         +1196.5%     127775 ± 92%  will-it-scale.time.maximum_resident_set_size
>   1.759e+09            +2.6%  1.804e+09        will-it-scale.workload
[...]
> 
> 
> ***************************************************************************************************
> lkp-knm01: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-knm01/context_switch1/will-it-scale/0x11
> 
> commit:
>    b121b341e5 ("bpf: Add PTR_TO_BTF_ID_OR_NULL support")
>    492e639f0c ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
> 
> b121b341e5983bdc 492e639f0c222784e2e0f121966
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>            2:2         -100%            :2     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
>            2:2         -100%            :2     dmesg.WARNING:stack_recursion
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Rong Chen
> 
