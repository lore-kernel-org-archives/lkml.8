Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13D7C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742072080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k6UcJN6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCTVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:21:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:21:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013J8Nt8062474;
        Mon, 3 Feb 2020 19:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=42PnVMUCUUF2AUd5X4IjIG+YZrkroHrBto7UIqcdm7I=;
 b=k6UcJN6a9fj4bVBT2A+mewOERMrwluhFGS6TO46yiEjVlW/GQbem70esh85lKKCJAfeb
 NB0IZJAI5aL1C+PYERInCLic3pNuhCjaCDvpKpydWBSX0dJ3u+7iEGI57xEz0k02EyfO
 xgktd4o+vZfbcLCtjGlDpiQa6U9+nZFbqYkqcYi1h/pMPVTzQrfpelBtraaxyoAVYS6J
 6P4ICg0TQHIaWDBSaGYBkX1H4Q9K86SUdcZwn+H83R6vx6PFSceBuIyNjFNS5YK3ytBh
 LDB9zNGxbvP/P/iiKxYwAVb+SsR5vaHQC3dUIqWqEt8lLobBTLJchFCK01JFof884cHG qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xw0ru1yp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 19:21:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013J95eT071854;
        Mon, 3 Feb 2020 19:21:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xwkfu7bd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 19:21:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 013JLbC1001799;
        Mon, 3 Feb 2020 19:21:37 GMT
Received: from [10.209.227.41] (/10.209.227.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 11:21:37 -0800
Subject: Re: [PATCH] firmware: ti_sci: Correct the timeout type in
 ti_sci_do_xfer()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, ssantosh@kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, nm@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lokeshvutla@ti.com
References: <20200122104009.15622-1-peter.ujfalusi@ti.com>
 <a63c23ec-d468-fc9b-3990-becd7c120df6@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <639ea3ea-ba16-ab23-2390-241bec6fab06@oracle.com>
Date:   Mon, 3 Feb 2020 11:21:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a63c23ec-d468-fc9b-3990-becd7c120df6@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/3/20 12:38 AM, Tero Kristo wrote:
> On 22/01/2020 12:40, Peter Ujfalusi wrote:
>> msecs_to_jiffies() returns 'unsigned long' and the timeout parameter for
>> wait_for_completion_timeout() is also 'unsigned long'
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Reviewed-by: Tero Kristo <t-kristo@ti.com>
> 
Can you collate all 3 patches in a series and repost
with Tero's ack ? I will add that to next merge window
queue.

Regards,
Santosh
