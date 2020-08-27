Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A634BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B502084C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DmYlVlPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgH0VvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:51:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58038 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0VvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:51:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RLU6P1160610;
        Thu, 27 Aug 2020 21:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wUV+gI4hcarMpqEbC2to6GF/7WDX4Bx1I5kjkmzQLEM=;
 b=DmYlVlPs7VkLIg1bpyBiALvSK4vQQEdQSp0ef+hXF07hdwCH9zFuISoIDrr8g06l5HVI
 j2ohjopCku7duDBNyxfNt6IOQE6IcA5yFfGAiLDnoBvABdVDaKrI7PsDPGgOaGrIpfX3
 AsKn+NJ+TzaStI0Erdr0H8kWitYq4JQdh1Ner33H3qCtfYf87UQbtyTggRbn+vpUDCUV
 +GFFutiyEwGFvnAf2h7/txJzvLCeqZvhu4/h1rzxwsfXx/w13tT8G/ybZcs2aTP+GIkA
 CufDxA+Ac4BaykI/6/LxSqjjwgW2c9dWWIm3PY43SNAcW08TaixTMVGAifFWQFZNeudh 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 333dbs8x60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 21:51:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RLVeXO034484;
        Thu, 27 Aug 2020 21:51:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 333r9nsuj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 21:51:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RLp27q003885;
        Thu, 27 Aug 2020 21:51:02 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2020 14:51:02 -0700
Subject: Re: [External] Re: [PATCH] mm/hugetlb: Fix a race between hugetlb
 sysctl handlers
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ak@linux.intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200822095328.61306-1-songmuchun@bytedance.com>
 <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org>
 <79800508-54c9-4cda-02de-29b1a6912e75@oracle.com>
 <CAMZfGtXh+FP0O92ccj532Y=K4m2S==eSK8LjYEM+p6cttV0p8Q@mail.gmail.com>
 <231ec1f1-fe7a-c48a-2427-1311360d4b9b@oracle.com>
 <CAMZfGtWj5_Uh2KFAy4DGc0vzrNm4+Nge7rOBDAFQhh2aN7wOqA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <afaa721e-f86c-9b49-acd1-54c9017fb269@oracle.com>
Date:   Thu, 27 Aug 2020 14:51:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWj5_Uh2KFAy4DGc0vzrNm4+Nge7rOBDAFQhh2aN7wOqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 7:47 PM, Muchun Song wrote:
> 
> CPU0:                                     CPU1:
>                                           proc_sys_write
> hugetlb_sysctl_handler                      proc_sys_call_handler
> hugetlb_sysctl_handler_common                 hugetlb_sysctl_handler
>   table->data = &tmp;                           hugetlb_sysctl_handler_common
>                                                   table->data = &tmp;
>     proc_doulongvec_minmax
>       do_proc_doulongvec_minmax             sysctl_head_finish
>         __do_proc_doulongvec_minmax
>           i = table->data;
>           *i = val;     // corrupt CPU1 stack

Thanks Muchun!
Can you please add this to the commit message.

Also, when looking closer at the patch I do not think setting table->maxlen
is necessary in these routines.  maxlen is set when the hugetlb ctl_table
entries are defined and initialized.  This is not something you introduced.
The unnecessary assignments are in the existing code.  However, there is no
need to carry them forward.

-- 
Mike Kravetz
