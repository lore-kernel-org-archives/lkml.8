Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AA8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC4E20768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFRVWrop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgIHRVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:21:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59584 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbgIHRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:19:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 088HJQcZ002522;
        Tue, 8 Sep 2020 17:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2kRbRbAPcu65GdZfJ3P4R9UbW3b90s932qN7mt8dNJk=;
 b=EFRVWropmMTv7e+hH7AYaeq+75gW3uXiy1/I34rYI3Rh3lsJwZXVbKOPcFVtBWCX+xbq
 06vaqz8FnXlxREM+Oa+NXZxfKxaoBBDDmEZ9/2yBsCOj/1XDomkIM0vxy+Xnb73w4msp
 3jY/K1CTsqWCj4VysZW4I3nWLVTOsFHfB6SWK8NM4HwdCrByDWmy7QrPXobYcuViS8er
 O4Jys2UxvJMVBdR7A5VpFSR8cH7jJR5ewxifJbvy1KvGblkmqTsTNmUTCWh4Y2R0xdDK
 HrRu6Gk6taBY/6yxrslddXCfeziiI/2hBAjdnw/QXgw3hcyzkVWMFhY9aDTTjBVMURZR Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33c23qw1wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Sep 2020 17:19:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 088HGYKU182705;
        Tue, 8 Sep 2020 17:19:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33cmkw7hwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Sep 2020 17:19:36 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 088HJY3G021930;
        Tue, 8 Sep 2020 17:19:36 GMT
Received: from [10.74.106.12] (/10.74.106.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 10:19:34 -0700
Subject: Re: [PATCH 0/3] clk: keystone: some minor fixes
To:     Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org,
        ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
References: <20200907085740.1083-1-t-kristo@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <8a594a9d-8e10-6e01-908c-8e59da1d7fbe@oracle.com>
Date:   Tue, 8 Sep 2020 10:19:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200907085740.1083-1-t-kristo@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009080163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/20 1:57 AM, Tero Kristo wrote:
> Hi Santosh,
> 
> This series contains a few fixes for the TI SCI clock driver.
> - Patch #1 is a clear bug fix, where we missed to parse assigned-clock
>    data properly to detect which clocks are in use on the SoC.
> - Patch #2 is a performance improvement patch which avoids some
>    unnecessary round trips to firmware side while setting clock
>    frequency.
> - Patch #3 fixes some issues with set_rate passed to firmware, where the
>    parameters are too strict; namely, firmware fails to handle some cases
>    properly if min,tgt,max values for a clock rate are exactly the same
>    value. Yeah, the firmware is quite weird here but nothing much else we
>    can do from kernel side other than this....
> 
Looks fine to me Tero.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>


Hi Stephen, Mike,
Can you please pick these fixes via clk tree ?
