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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB61C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75537221ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yM4jU+AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGNGlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:41:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58458 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNGlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:41:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06E6b1PL146825;
        Tue, 14 Jul 2020 06:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ak+CP9sohLwcvRV9w+VKGu2q0XtK0+QjZnyqP+BZehg=;
 b=yM4jU+AW1UWWzNIkaK3+4cvTRxFGHlACB4sOeVmbSIZnbbCEoWQsl4jfMauDHqjplEdh
 SBgsaTpmvdj1058Ai3i0Pgpz4afAtcn0PkIlIpUDST+BGQnHoHiydHyOoqqk7z71b4iD
 D4SJTB37nDLabzbCthlk+lG/6r5qUxYc/vPtdi6jJ2hFtMMBulNwhnJL6OgufAOOEqHN
 X0215WANxRtd2ghCNye3yWF9OH7pWBJAJ5NBKH3jeA/15/D3QkdZc34e3wzHs4J3IsQ0
 nFsD3ENKdcP2T5VxCUwIO5sJWSoITdSAQz2TUf1nlY7+c0Xybxtwn1lm7TiJ0FTUqoLQ 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32762nb5vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 06:41:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06E6bZ0C067207;
        Tue, 14 Jul 2020 06:41:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 327q6rhn5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 06:41:32 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06E6fVbi001674;
        Tue, 14 Jul 2020 06:41:31 GMT
Received: from Junxiaos-MacBook-Pro.local (/73.231.9.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 23:41:31 -0700
Subject: Re: [PATCH] md: fix deadlock causing by sysfs_notify
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200709233545.67954-1-junxiao.bi@oracle.com>
 <CAPhsuW7seCUnt3zt6A_fjTS2diB7qiTE+SZkM6Vh=G26hdwGtg@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <de97a2c1-fba0-5276-7748-f0155088ad0d@oracle.com>
Date:   Mon, 13 Jul 2020 23:41:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7seCUnt3zt6A_fjTS2diB7qiTE+SZkM6Vh=G26hdwGtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 11:17 PM, Song Liu wrote:

> On Thu, Jul 9, 2020 at 4:36 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> The following deadlock was captured. The first process is holding 'kernfs_mutex'
>> and hung by io. The io was staging in 'r1conf.pending_bio_list' of raid1 device,
>> this pending bio list would be flushed by second process 'md127_raid1', but
>> it was hung by 'kernfs_mutex'. Using sysfs_notify_dirent_safe() to replace
>> sysfs_notify() can fix it. There were other sysfs_notify() invoked from io
>> path, removed all of them.
>>
> [...]
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> Thanks for the patch. It looks good in general. One question though, do we
> need the same change the following line in md.c:level_store()?
>
>      sysfs_notify(&mddev->kobj, NULL, "level");

Thanks for the review. This one is not in io path, looks it's safe. I 
can change it if you want to align it with others.

Thanks,

Junxiao.

>
> Thanks,
> Song
>
> [...]
