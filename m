Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0728C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A70206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w/Q2lTJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgFBPOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:14:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47068 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgFBPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:14:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052F8RBn067493;
        Tue, 2 Jun 2020 15:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=twSSHzQ0o2SniDDDgsjFjigkpdNI1jvAkB6VRynIq5I=;
 b=w/Q2lTJ6WsVlDYvJ/OSXpdnD2sCZKiktiaiz6dAlQkhXZgGlmjJsrSCes/+cOEaI3tEh
 6mSgi8hGez4c7nSph7jbzt3ZC6cvZU1m0+3Px3Wro5Qr94TJzQsi5XBuuJMaA2ZMLZM4
 od5O4JFYpHURxF6bTpejNZkwt1G/dX48CtzJvRJvGoHNMFgmCjpHmiUub6aCRU5khOaN
 0qKdEqRBxmTvqAaaLQ8o7A+YvXuKgzshoTUvMsOqbHIStrer9yY9EGK9gvZuNg4ATwZa
 WFoZAcm6OHRpaGatTspTy2Nxjx2nM4NvUQRPU2z8A+/JSiug89wMhkJHNvDuwg6+J9Oc eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfem4j1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 15:14:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052FE1Ao009391;
        Tue, 2 Jun 2020 15:14:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31dju1n35e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 15:14:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052FDgOZ016066;
        Tue, 2 Jun 2020 15:13:44 GMT
Received: from [10.74.110.208] (/10.74.110.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 08:13:41 -0700
Subject: Re: [GIT PULL] ARM: Keystone DTS updates for 5.7
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, olof@lixom.net
Cc:     khilman@kernel.org, linux-kernel@vger.kernel.org
References: <1583603819-9651-1-git-send-email-santosh.shilimkar@oracle.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <8750635a-37de-f4d0-08b1-16e904be2de7@oracle.com>
Date:   Tue, 2 Jun 2020 08:13:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1583603819-9651-1-git-send-email-santosh.shilimkar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

On 3/7/20 9:56 AM, Santosh Shilimkar wrote:
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>    Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_5.7
> 
> for you to fetch changes up to 7856488bd83b0182548a84d05c07326321ae6138:
> 
>    ARM: dts: keystone-k2g-evm: add HDMI video support (2020-03-07 09:47:24 -0800)
> 
> ----------------------------------------------------------------
> ARM: Keystone DTS updates for 5.7
> 
> Add display support for K2G EVM Board
> 
> ----------------------------------------------------------------
> Jyri Sarha (2):
>        ARM: dts: keystone-k2g: Add DSS node
>        ARM: dts: keystone-k2g-evm: add HDMI video support
> 
>   arch/arm/boot/dts/keystone-k2g-evm.dts | 101 +++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/keystone-k2g.dtsi    |  22 +++++++
>   2 files changed, 123 insertions(+)
> 
Looks like this pull request wasn't picked. Can you please check
in case am missing something.

Regards,
Santosh
