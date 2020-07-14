Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58E8C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE630223AB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eU49U8Qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgGNQaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:30:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:30:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EGGwk0131212;
        Tue, 14 Jul 2020 16:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4zHQ+qbqhXQr0oeHM5WRqgkfmxqCrBYvMylcuFCv2s8=;
 b=eU49U8Qv6hRHePqo9ugiHPg5XtBHsq1FFXXc/aWFAreRwSc7EHDfPKyqTpKNQG7Ns/Sg
 1SsvyqdxJNc9CAuoDUFRxqhzXRDqfX4AUhy4gOSdfBeW4wiGB++0aETihp2FIA2jr5v2
 /WNS4wr8tol3aWEt2syUVMT4dBGAcbPBrhRShlygxJHkdxc06SxaQfh3IalT2TZpqkOU
 gU6xUt1EVYdU6uj8Yv4p4aHCT2BHN/2OY3ewqFABDbLn1PCIwMRPDu0THAiZNXtuzoPW
 XVX+W/nTABjAj+2BKIJulHfRn/nHH2TiPmHn5psWrZyCWRuS+z6t/H+jk06sHzcWXQbX 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3275cm6ee6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 16:30:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EGHbOY095955;
        Tue, 14 Jul 2020 16:30:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 327q0pj5dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 16:30:01 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06EGU09I020069;
        Tue, 14 Jul 2020 16:30:00 GMT
Received: from dhcp-10-159-135-64.vpn.oracle.com (/10.159.135.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 09:30:00 -0700
Subject: Re: [PATCH] md: fix deadlock causing by sysfs_notify
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200709233545.67954-1-junxiao.bi@oracle.com>
 <CAPhsuW7seCUnt3zt6A_fjTS2diB7qiTE+SZkM6Vh=G26hdwGtg@mail.gmail.com>
 <de97a2c1-fba0-5276-7748-f0155088ad0d@oracle.com>
 <CAPhsuW4GQK7hS4AOpJJ1mEE8gbFgo+n+XCQ2fvW94QnZhA6ivQ@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <23a115e4-0d48-9186-c606-89d526649372@oracle.com>
Date:   Tue, 14 Jul 2020 09:29:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4GQK7hS4AOpJJ1mEE8gbFgo+n+XCQ2fvW94QnZhA6ivQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 9:18 AM, Song Liu wrote:

> On Mon, Jul 13, 2020 at 11:41 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> On 7/13/20 11:17 PM, Song Liu wrote:
>>
>>> On Thu, Jul 9, 2020 at 4:36 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>>>> The following deadlock was captured. The first process is holding 'kernfs_mutex'
>>>> and hung by io. The io was staging in 'r1conf.pending_bio_list' of raid1 device,
>>>> this pending bio list would be flushed by second process 'md127_raid1', but
>>>> it was hung by 'kernfs_mutex'. Using sysfs_notify_dirent_safe() to replace
>>>> sysfs_notify() can fix it. There were other sysfs_notify() invoked from io
>>>> path, removed all of them.
>>>>
>>> [...]
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>>> Thanks for the patch. It looks good in general. One question though, do we
>>> need the same change the following line in md.c:level_store()?
>>>
>>>       sysfs_notify(&mddev->kobj, NULL, "level");
>> Thanks for the review. This one is not in io path, looks it's safe. I
>> can change it if you want to align it with others.
> This one is the only leftover. Let's also change it.

Sure, i will send a v2.

Thanks,

Junxiao.

>
> Thanks,
> Song
