Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F345C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B80121556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yM5N1/J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIJWlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:41:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56116 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgIJWlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:41:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AMeAnq158188;
        Thu, 10 Sep 2020 22:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BYAf4AQrHYdjFsNM20uZvb1ii4hwHzWLj/pZXbS8seo=;
 b=yM5N1/J5ypSXRnjSs5ix8I6y0bfkt06pYNszFkkTWle14zWdSHFsyhMDjxcZUd5tV/r9
 a8+NKO5beItgjRDjDuwziFsNEVsR/9arCllDfW5Xn/EiirbSdBik6kzbblFTXY/NHbef
 K8zdpDJZq2YNieLS2AodJl+d9MS1a4LXvERYU3UAXY+ZZ6RqHMNe1ll7shKzf7aDVZN+
 x+E2ZMq+L3R1tOAfah7N19+DJV2Il+rSJsXUCefct4e/ld/VlM1mORShxsOIEkyet/mt
 fgeGVXPOoFwbSr1Wdxb7sC/D8jC9sZ7hIK25IufEe6fsqxBc4s4xZSAFrlPYlid6SaRu 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3anawkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 22:41:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AMZ9s1119344;
        Thu, 10 Sep 2020 22:41:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33cmkay96t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 22:41:11 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08AMfARM012484;
        Thu, 10 Sep 2020 22:41:10 GMT
Received: from [10.98.138.194] (/10.98.138.194)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Sep 2020 15:41:10 -0700
Subject: Re: [PATCH 0/3] clk: keystone: some minor fixes
To:     Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, ssantosh@kernel.org
References: <20200907085740.1083-1-t-kristo@ti.com>
 <8a594a9d-8e10-6e01-908c-8e59da1d7fbe@oracle.com>
 <159977335346.2295844.11165311759086345858@swboyd.mtv.corp.google.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <a017be90-4538-ecbd-64dd-a988ec8f80ce@oracle.com>
Date:   Thu, 10 Sep 2020 15:41:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159977335346.2295844.11165311759086345858@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/20 2:29 PM, Stephen Boyd wrote:
> Quoting santosh.shilimkar@oracle.com (2020-09-08 10:19:32)
>>
>>
>> On 9/7/20 1:57 AM, Tero Kristo wrote:
>>> Hi Santosh,
>>>
>>> This series contains a few fixes for the TI SCI clock driver.
>>> - Patch #1 is a clear bug fix, where we missed to parse assigned-clock
>>>     data properly to detect which clocks are in use on the SoC.
>>> - Patch #2 is a performance improvement patch which avoids some
>>>     unnecessary round trips to firmware side while setting clock
>>>     frequency.
>>> - Patch #3 fixes some issues with set_rate passed to firmware, where the
>>>     parameters are too strict; namely, firmware fails to handle some cases
>>>     properly if min,tgt,max values for a clock rate are exactly the same
>>>     value. Yeah, the firmware is quite weird here but nothing much else we
>>>     can do from kernel side other than this....
>>>
>> Looks fine to me Tero.
>>
>> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
>>
>>
>> Hi Stephen, Mike,
>> Can you please pick these fixes via clk tree ?
> 
> Sure. I assume this is -next material and not critical fixes.
> 
Yep.
