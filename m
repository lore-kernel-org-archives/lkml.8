Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566702072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fh5YU57L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgFJO4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:56:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgFJO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:56:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AEqMPa046210;
        Wed, 10 Jun 2020 14:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+MkVzWy7hSx4wdwuzJRJZjRevMWLr+97rQSWPuRETeI=;
 b=Fh5YU57LjGtgILZhyagxCJiKu4+KGIutZ5E9PylZp1Qo5JxWx2sdx1km+teF5HpB/a6Y
 +v/mQIhiwB70zeeL6scNIb2z8RPcYg5Erj51xoP8eYmicfNMe6rRTMFP8AWdwcFHfWEh
 zUKNKLZSX6N17fHLjKr1Nd1gbAE/HEbmt2OtJogrNBJb82X7D/quTe7U5//urcAo3qs5
 0malmVNVWml0c0tESY9EcRYvcmIGCsKFbMMN0ZrJdWOcD+Zv5Ws+fywrNKaj/F4ubd6G
 eEmoRBXwje+OuAgP6QfwhPM9kHvClr+5A6DodADS3CcKGBw03E/87H91mpCguJbEIIz4 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31g2jravr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 14:53:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AEi0us135392;
        Wed, 10 Jun 2020 14:53:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31gmqqdenw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 14:53:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05AErZYO021813;
        Wed, 10 Jun 2020 14:53:36 GMT
Received: from [10.159.156.250] (/10.159.156.250)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 07:53:34 -0700
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
To:     James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, hch@lst.de
Cc:     sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-kernel@vger.kernel.org
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
 <60df6752-3512-f7a9-b0df-1096b93b8eda@broadcom.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <f93adee4-ebf0-a229-e507-4ef4e4fe812d@oracle.com>
Date:   Wed, 10 Jun 2020 07:53:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <60df6752-3512-f7a9-b0df-1096b93b8eda@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Would you mind apply this one with the Reviewed-by from James and Sagi?

https://lore.kernel.org/linux-nvme/60df6752-3512-f7a9-b0df-1096b93b8eda@broadcom.com/

https://lore.kernel.org/linux-nvme/c4ec2d9e-b08c-19b2-16a5-93520ca13c2e@grimberg.me/

Thank you very much!

Dongli Zhang

On 6/4/20 8:20 AM, James Smart wrote:
> On 5/25/2020 9:21 PM, Dongli Zhang wrote:
>> The nvme host and target verify the wwnn and wwpn format via
>> nvme_fc_parse_traddr(). For instance, it is required that the length of
>> wwnn to be either 21 ("nn-0x") or 19 (nn-).
>>
>> Add this verification to nvme-fcloop so that the input should always be in
>> hex and the length of input should always be 18.
>>
>> Otherwise, the user may use e.g. 0x2 to create fcloop local port, while
>> 0x0000000000000002 is required for nvme host and target. This makes the
>> requirement of format confusing.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>   drivers/nvme/target/fcloop.c | 29 +++++++++++++++++++++++------
>>   1 file changed, 23 insertions(+), 6 deletions(-)
>>
>>
> 
> Reviewed-by: James Smart <james.smart@broadcom.com>
> 
> Looks good. Sorry for the delay.
> 
> -- james
> 
> 
