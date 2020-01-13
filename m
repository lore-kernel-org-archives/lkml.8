Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434EAC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217392080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMKDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:03:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgAMKDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:03:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00D9oxdv120638;
        Mon, 13 Jan 2020 05:03:27 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvrhpa4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 05:03:26 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00DA2xq8018518;
        Mon, 13 Jan 2020 10:03:25 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 2xf74xwcyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 10:03:25 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DA3OUa35389860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 10:03:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5E0112061;
        Mon, 13 Jan 2020 10:03:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E076112066;
        Mon, 13 Jan 2020 10:03:22 +0000 (GMT)
Received: from [9.152.98.246] (unknown [9.152.98.246])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Jan 2020 10:03:22 +0000 (GMT)
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200107143058.GU3929@twin.jikos.cz>
 <20200108105103.29028-1-zaslonko@linux.ibm.com>
 <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
 <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
 <20200109011025.GM3929@suse.cz>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <62a53ff3-a515-8801-d58b-b518dbe0c55c@linux.ibm.com>
Date:   Mon, 13 Jan 2020 11:03:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109011025.GM3929@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_02:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 09.01.2020 02:10, David Sterba wrote:
> On Wed, Jan 08, 2020 at 07:48:31PM +0100, Zaslonko Mikhail wrote:
>>>> +        } else if (workspace->strm.avail_out == 0) {
>>>> +            /* get another page for the stream end */
>>>> +            kunmap(out_page);
>>>> +            if (nr_pages == nr_dest_pages) {
>>>> +                out_page = NULL;
>>>> +                ret = -E2BIG;
>>>> +                goto out;
>>>> +            }
>>>> +            out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>>>> +            if (out_page == NULL) {
>>>> +                ret = -ENOMEM;
>>>> +                goto out;
>>>> +            }
>>>
>>> Do we need zlib_deflateEnd() for the above error cases?  Thanks,
>>
>> The original btrfs code did not call zlib_deflateEnd() for -E2BIG and 
>> -ENOMEM cases, so I stick to the same logic.
>> Unlike userspace zlib where deflateEnd() frees all dynamically allocated 
>> memory, in the kernel it doesn't do much apart from setting the return 
>> code (since all the memory allocations for kernel zlib are performed in advance).
> 
> Agreed, deflateEnd is not necessary in the error cases.

Can I consider this as 'Acked-by' from your side?
Are there any unanswered questions left on this patch?

> 

Thanks,
Mikhail
