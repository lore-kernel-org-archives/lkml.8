Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B836AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7550A20768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="C/3sQcTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgIHT4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:56:48 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:62032 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730556AbgIHPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:36:44 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088FWpXv018293;
        Tue, 8 Sep 2020 15:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=u6qAhC3Cydui3ZKe/Igp5U8X/+bI2x8TraPpBr4rc9k=;
 b=C/3sQcTVkBq+FK/auaLoZZiZZqIMBBCfZPNezm17VNHFgZQ9pAhogv6M22ktysqAZTqk
 Y6BqT9gyfaU+iIvimnY0LzAeBXF1vmogW5/lx6HPws1rn3xsJ+Pp3mJ+/Upy5RNWzzhJ
 pjQgNPalRGTOPNF4QyyszY9iWleP7Dy0Aj24EWW0wivXSru6se73Up4Ikvh3ItjXD0WG
 qqI627I529hcG7HAkrA4BHGxSI4EhwHqCE3ax5cjpV49HWibzRhlLWhgUK8Y5CQHJSYN
 1qaljKv4jaOssdcu60+lJS6nvpgzCIXww1JI9P20W7jA/BBKoQdCEBIhn5dsWdpDQxce fA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 33c3b39p7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 15:35:41 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 02E8883;
        Tue,  8 Sep 2020 15:35:40 +0000 (UTC)
Received: from [16.99.146.51] (unknown [16.99.146.51])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 0775E40;
        Tue,  8 Sep 2020 15:35:37 +0000 (UTC)
Subject: Re: [PATCH 04/12] x86/platform/uv: Update UV MMRs for UV5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20200907185430.363197758@hpe.com>
 <20200907185430.782245884@hpe.com> <20200908152314.GD4114051@kroah.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <3e93b858-f74d-8e93-e444-fd85fc5856e4@hpe.com>
Date:   Tue, 8 Sep 2020 08:35:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200908152314.GD4114051@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_08:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=958
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2020 8:23 AM, Greg KH wrote:
> On Mon, Sep 07, 2020 at 01:54:34PM -0500, Mike Travis wrote:
>> --- linux.orig/drivers/misc/sgi-gru/grufile.c
>> +++ linux/drivers/misc/sgi-gru/grufile.c
>> @@ -7,7 +7,8 @@
>>    * This file supports the user system call for file open, close, mmap, etc.
>>    * This also incudes the driver initialization code.
>>    *
>> - *  Copyright (c) 2008-2014 Silicon Graphics, Inc.  All Rights Reserved.
>> + * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
>> + * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
> 
> Please drop all copyright changes from this series, as these do not look
> correct at all, sorry.
> 
> You can send an add-on patch for all of that if it's really necessary,
> and you get legal approval for it :)

I can move them all to a single patch.  The HPE one is straight from 
their guidance on Copyrights.  The older SGI one is also from SGI's 
guidance though I'm not sure if I can find it anymore.  I also wasn't 
sure if it should be retained since the HPE one didn't take effect until 
SGI was legally part of HPE (circa 2018).  2017/18 was also the last 
time we did this big a change (for the UV4A).

> 
> thanks,
> 
> greg k-h
> 
