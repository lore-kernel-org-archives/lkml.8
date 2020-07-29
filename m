Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A252075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UCQzA7Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgG2Sue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:50:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Sue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:50:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TIlhar043557;
        Wed, 29 Jul 2020 18:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=5pqUXLI9sT2GfPJj/0gDGYdazPV0/n0K5ZbRuWHt4O0=;
 b=UCQzA7Vj+cN0M1HmyaDgb43umApye7cbjLQO/LseyNWq2WhsCyxY3A5uhngykpNl9myd
 oc4vQakBmZZZ7pAcKELSI1q4DM2vAkZgbIkEVwTwQAMe5nRgn39/FjjKNdLYH2VrUHD0
 v3c5PhGpXo87KQ0wCSkaDSKybz5qhJCld+uG3nZs8zi7AnNpDvxMOmuk+MMllNsU5+tv
 UaIid7SiMtOZ0QP8lvElS8kRWKAD/9QlYJCVSwWQqPbV/eV+twU7HNTPjJIZqqwKHF1i
 r+zTnoAYgk2hHPu8byHG8pjJgKZy41W+Xr3/FE3LygpPHsYdZe69FAQyC5l1V/WDx1Sk Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jqdre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 18:50:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TImokS101027;
        Wed, 29 Jul 2020 18:50:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32hu5w7533-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 18:50:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06TIoOrT008547;
        Wed, 29 Jul 2020 18:50:24 GMT
Received: from [10.39.233.151] (/10.39.233.151)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 11:50:24 -0700
Subject: Re: [PATCH 1/1] vt_ioctl: prevent VT_RESIZEX font height change from
 causing potential out-of-bounds access
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, ebiggers@google.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, dhaval.giani@oracle.com
References: <1596026381-5013-1-git-send-email-george.kennedy@oracle.com>
 <20200729125311.GA2912372@kroah.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <2a64913e-517e-5f2d-f96e-6bc10104adbe@oracle.com>
Date:   Wed, 29 Jul 2020 14:50:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729125311.GA2912372@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I will re-work this patch based on comments from Dan.

Thank you,
George

On 7/29/2020 8:53 AM, Greg KH wrote:
> On Wed, Jul 29, 2020 at 08:39:41AM -0400, George Kennedy wrote:
>> Add a VT_RESIZEX check to ensure that changing the font height will not
>> cause a potential out-of-bounds access. The candidate font height contained
>> in "v_clin", though below the max, could still result in accesses beyond
>> the allocated font data size.
>>
>> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
>> Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
> Did syzbot also test this that it fixes the reported issue?
>
> What commit does this fix?  Should it go back farther to stable releases
> too?
>
> thanks,
>
> greg k-h

