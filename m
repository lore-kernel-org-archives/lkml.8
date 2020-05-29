Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CA1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261F5207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SBFCAXhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgE2TT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:19:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2TTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:19:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TJI2dv053359;
        Fri, 29 May 2020 19:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=otyw0YZ9V4bNP7MKEHhgkJR24Ilms/TAyE06rglTaVw=;
 b=SBFCAXhe5o7UqD1c4n02OJe340CvZKWOODvizoXzF2lwgUE0OdKTGfhspnUPt5yS9oQo
 P3dRdk1e6Sw1BKCx2z/hVtZrbF95ezxGlgng/6RRvOLHadjc7dY9f3ADU9bZXQswms1F
 hOuo3/jSbMsvbnVaFNKi2M0GQDcL0GU/sWR3yGhqZRBoavW1uE6bdwgV+YqEg+jlJnc7
 akAoRD3SIFVpsrKbKILYHnZVtzh5d4v5Nz3IEhDDNQX1wUuMdPr2ezKaKWx2tJT/CklQ
 OktnWWTgVgjAwgmzrNUaTaQn9lL1TMbSls1J4WacU8CtsIAZfMREGh5kIv55xWedt0em og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 318xbkc43q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 19:19:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TJJ1MS123231;
        Fri, 29 May 2020 19:19:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 317ds4qcn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 19:19:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04TJJDQE019992;
        Fri, 29 May 2020 19:19:13 GMT
Received: from [10.74.105.211] (/10.74.105.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 12:19:13 -0700
Subject: Re: [PATCH v4 0/2] soc: ti: add k3 platforms chipid module driver
To:     Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <20200512123449.16517-1-grygorii.strashko@ti.com>
 <a132765e-f4e4-a1e8-fb43-239188fecf1b@ti.com>
 <CAK8P3a31DYOn1TyjxCYM7ebc9nL5EFKsNpSHkq55bG54Bns+MA@mail.gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <cb980673-d3ad-53b8-9351-196ff3f47c45@oracle.com>
Date:   Fri, 29 May 2020 12:19:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a31DYOn1TyjxCYM7ebc9nL5EFKsNpSHkq55bG54Bns+MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005290145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 11:34 AM, Arnd Bergmann wrote:
> On Fri, May 29, 2020 at 8:22 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> On 12/05/2020 15:34, Grygorii Strashko wrote:
> 
>>>    .../bindings/soc/ti/k3-socinfo.yaml           |  40 +++++
>>>    drivers/soc/ti/Kconfig                        |  10 ++
>>>    drivers/soc/ti/Makefile                       |   1 +
>>>    drivers/soc/ti/k3-socinfo.c                   | 152 ++++++++++++++++++
>>>    4 files changed, 203 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
>>>    create mode 100644 drivers/soc/ti/k3-socinfo.c
>>>
>>
>> Any chances you can pick this up?
> 
> I merged a version of this driver from Santosh's pull request into the
> arm/drviers tree yesterday.
> 
> Is there something missing?
> 
Nope. I was going to reply on the thread but missed it.

Regards,
Santosh
