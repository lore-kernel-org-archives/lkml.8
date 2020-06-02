Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A992072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AHutea8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFBUEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:04:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:03:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052JuRST168397;
        Tue, 2 Jun 2020 20:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RbXyOEzE6zM8uxomZsRMQBNr7Puu7c5FQsKqs0NUrkg=;
 b=AHutea8/u/8YUuoXhLNd6eGd4ymUEwdDSkWmJxgBV2ShLXEKBymxveywJUuaG+UwFI4I
 ZUATkMYeARyGmDnFOWaqS41aKB5QwoMNkHlOd4ZQyEPpAvOMWLXQZuXFfuuQN3j2M6Ep
 6HNyJz63SDjn5z7j7yP/9zOBWHqlYWV1YOzRyvZbSIFl7unY3wIcCGAvdv9J2624rtIQ
 1ip4xblLkxOz9Z2zMtiPo+it3/ywjMFL1dRd9imUzB+fZssRF3ehbt4musq8Qs1D9bOX
 T5OxntrzpYCFwrhjPltNeI20pnWzq/IZUom8lJFPyOAqpirhdkIFTf5jdBFNwQPEKDVu MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfem5txn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 20:03:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052Jvw5e065137;
        Tue, 2 Jun 2020 20:03:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25pvhyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 20:03:50 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052K3moi020846;
        Tue, 2 Jun 2020 20:03:49 GMT
Received: from [10.74.110.208] (/10.74.110.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 13:03:48 -0700
Subject: Re: [GIT PULL] ARM: Keystone DTS updates for 5.7
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1583603819-9651-1-git-send-email-santosh.shilimkar@oracle.com>
 <8750635a-37de-f4d0-08b1-16e904be2de7@oracle.com>
 <CAK8P3a1v7V=980HasrQ8t96mLG3wHWW1SXwbXDL5o=F1oFd-Fg@mail.gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <0853f89a-4a47-f0c3-9a60-6e3bc2ca3323@oracle.com>
Date:   Tue, 2 Jun 2020 13:03:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1v7V=980HasrQ8t96mLG3wHWW1SXwbXDL5o=F1oFd-Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 1:00 PM, Arnd Bergmann wrote:
> On Tue, Jun 2, 2020 at 5:14 PM <santosh.shilimkar@oracle.com> wrote:
>>
>> Hi Arnd, Olof,
>>
>> On 3/7/20 9:56 AM, Santosh Shilimkar wrote:
>>> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
>>>
>>>     Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_5.7
>>>
>>> for you to fetch changes up to 7856488bd83b0182548a84d05c07326321ae6138:
>>>
>>>     ARM: dts: keystone-k2g-evm: add HDMI video support (2020-03-07 09:47:24 -0800)
>>>
>>> ----------------------------------------------------------------
>>> ARM: Keystone DTS updates for 5.7
>>>
>>> Add display support for K2G EVM Board
>>>
>>> ----------------------------------------------------------------
>>> Jyri Sarha (2):
>>>         ARM: dts: keystone-k2g: Add DSS node
>>>         ARM: dts: keystone-k2g-evm: add HDMI video support
>>>
>>>    arch/arm/boot/dts/keystone-k2g-evm.dts | 101 +++++++++++++++++++++++++++++++++
>>>    arch/arm/boot/dts/keystone-k2g.dtsi    |  22 +++++++
>>>    2 files changed, 123 insertions(+)
>>>
>> Looks like this pull request wasn't picked. Can you please check
>> in case am missing something.
> 
> I pulled it now, thanks for double-checking!
> 
> The problem here was that the soc@kernel.org address was not on Cc, so
> the pull request did not end up in patchwork. I try to also look for other
> pull requests sent to the arm@kernel.org address, but it's much less reliable.
> 
Thanks Arnd. I started copying soc@kernel.org as well for pull request
after Olof's suggestion. This one was sent before that.

Regards,
Santosh


