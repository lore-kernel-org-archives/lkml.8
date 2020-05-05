Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA1C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0400206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="noLNRkIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgEEXVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:21:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45782 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgEEXVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:21:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045NHtoc137361;
        Tue, 5 May 2020 23:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=M9UOEBWwmZ184fEobRSilNOjw+98cXkdvmHQbspPnsY=;
 b=noLNRkIA3arLBSV/Gy+JnMlFFFlWcsuRRx/XKm3QnFvmsLdVdtUHAHjKeso6l1oMQetI
 DzL0URLbwldIJlBrg8IXt39smovo+u7nBrwT9iLMi7iIkad0QGba532SVAEX85lSUQks
 caMQq55eR6rAWKVyxa+DB/OFLfLInKdJHShNqyH66ryVMek2Q/UguRgWawg4QTVQ0wnw
 dgEZ5aBW+HY+QcW3wgRTJbsFjPgfxS6p7XWuFM/LK8gpk8XJ0nNOV9LOLYrE8uqE/b2c
 X6tR3BNhTDE5rSUWQKarsOJjBCqfQ52u1GoE6BPus2dwpwBgcACTS2s2dcPcQv/gQdbJ NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30s1gn7bf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 23:21:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045NHiPq009559;
        Tue, 5 May 2020 23:21:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r67h7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 23:21:20 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 045NLJI3030865;
        Tue, 5 May 2020 23:21:19 GMT
Received: from [10.159.154.132] (/10.159.154.132)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 May 2020 16:21:19 -0700
Subject: Re: [PATCH v2 0/2] soc: ti: add k3 platforms chipid module driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
References: <20200505193417.2112-1-grygorii.strashko@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <c091ac42-ac28-477c-90a9-4bbe790d42f7@oracle.com>
Date:   Tue, 5 May 2020 16:21:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200505193417.2112-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/20 12:34 PM, Grygorii Strashko wrote:
> Hi All,
> 
> This series introduces TI K3 Multicore SoC platforms chipid module driver
> which provides identification support of the TI K3 SoCs (family, revision)
> and register this information with the SoC bus. It is available under
> /sys/devices/soc0/ for user space, and can be checked, where needed,
> in Kernel using soc_device_match().
> It is also required for introducing support for new revisions of
> K3 AM65x/J721E SoCs.
> 
> Example J721E:
>    # cat /sys/devices/soc0/{machine,family,revision}
>    Texas Instruments K3 J721E SoC
>    J721E
>    SR1.0
> 
> Example AM65x:
>    # cat /sys/devices/soc0/{machine,family,revision}
>    Texas Instruments AM654 Base Board
>    AM65X
>    SR1.0
> 
> Changes in v2:
>   - pr_debug() replaced with pr_info() to show SoC info on init
>   - minor format change
>   - split series on driver and platform changes
>   - add Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> v1: https://lwn.net/Articles/818577/
> 
> Grygorii Strashko (2):
>    dt-bindings: soc: ti: add binding for k3 platforms chipid module
>    soc: ti: add k3 platforms chipid module driver
> 
Need ack from DT maintainers on bindings.

Regards,
Santosh
