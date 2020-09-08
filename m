Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1B6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B405B206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kTOMUG7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbgIHQ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:28:30 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:16156 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731134AbgIHQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:33 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088GG5mh022056;
        Tue, 8 Sep 2020 16:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=tMzsGA8Qsfilm7iuAmNGJ37dDR1+5ZAtErbHf/+z2bI=;
 b=kTOMUG7W1W0Af0WlSM5Pmh3zNT5sbdo7XdT/c1L3nW8eJyPY958dn+JwgnGdPE0vonbD
 6xpg76ZFZXqZlJ5SgXk63K7toFLoPYzE6+/kNao55uUkBSKb5VGEJcQ6Q8f/McPHCe9Z
 Lkn0CYgLISahyfSGzjiL3XEOvWdJZW4GZRaTsFAAayH87hVmpn/X49uPCSvNxTXYfUrj
 o8RArwgiITu5WjorijdGvkfv5wNRdhL2rSU3fgQ49eU7uZQEwW74yBbZ8sDRCCgfOpgp
 veHXu6RMElKSoPsb9z9cbqPJBI2dwTmmDINvJtyXve/UYEpMxqvd2oAjo4Bu9KTAp6Lx Zw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 33c3yqss2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 16:20:19 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D3E0A4F;
        Tue,  8 Sep 2020 16:20:17 +0000 (UTC)
Received: from [16.99.146.51] (unknown [16.99.146.51])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 89AAD48;
        Tue,  8 Sep 2020 16:20:14 +0000 (UTC)
Subject: Re: [PATCH 04/12] x86/platform/uv: Update UV MMRs for UV5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
 <3e93b858-f74d-8e93-e444-fd85fc5856e4@hpe.com>
 <20200908154430.GA4171853@kroah.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <35d4ce27-7a93-c3d5-3c0d-99fff06229c2@hpe.com>
Date:   Tue, 8 Sep 2020 09:20:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200908154430.GA4171853@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_08:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2020 8:44 AM, Greg KH wrote:
> On Tue, Sep 08, 2020 at 08:35:37AM -0700, Mike Travis wrote:
>>
>>
>> On 9/8/2020 8:23 AM, Greg KH wrote:
>>> On Mon, Sep 07, 2020 at 01:54:34PM -0500, Mike Travis wrote:
>>>> --- linux.orig/drivers/misc/sgi-gru/grufile.c
>>>> +++ linux/drivers/misc/sgi-gru/grufile.c
>>>> @@ -7,7 +7,8 @@
>>>>     * This file supports the user system call for file open, close, mmap, etc.
>>>>     * This also incudes the driver initialization code.
>>>>     *
>>>> - *  Copyright (c) 2008-2014 Silicon Graphics, Inc.  All Rights Reserved.
>>>> + * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
>>>> + * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
>>>
>>> Please drop all copyright changes from this series, as these do not look
>>> correct at all, sorry.
>>>
>>> You can send an add-on patch for all of that if it's really necessary,
>>> and you get legal approval for it :)
>>
>> I can move them all to a single patch.  The HPE one is straight from their
>> guidance on Copyrights.  The older SGI one is also from SGI's guidance
>> though I'm not sure if I can find it anymore.  I also wasn't sure if it
>> should be retained since the HPE one didn't take effect until SGI was
>> legally part of HPE (circa 2018).  2017/18 was also the last time we did
>> this big a change (for the UV4A).
> 
> If you haven't touched a file in a year, you don't get to claim
> copyright on that year.  If you wish to disagree on this, great, I'll
> gladly take a patch that modifies the lines that has a signed-off-by
> from one of your lawyers for it :)

I skipped over that part.  But I'm moving all changes to a single patch 
and I will look more closely at HPE's documents.  Heaven knows they have 
plenty of lawyers, so many it's hard to ask a simple question... like 
when does a copyright take effect.  When you change it internally, or 
when it gets published?  Sounds like you lean towards the second?

Thanks,
Mike

> 
> thanks,
> 
> greg k-h
> 
