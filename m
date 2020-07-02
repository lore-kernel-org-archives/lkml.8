Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB9A2089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YS392JwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgGBPBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:01:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52132 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgGBPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:01:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EvRwS018136;
        Thu, 2 Jul 2020 15:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=EovBjL/VDEJMxYfhQUs2tcfenMAKo6Sk/T/23Jbbdlc=;
 b=YS392JwJ/K+bmWg4R2XF6a0CNZCiwJgA9p8aSAD6auJtb0SaSbKMQBCeqKYZDofftZ/3
 NE7Mvus2/HD90se7QKJYIiJ9QhX/Ob8biOhwHlO6FD28ELUo5EkDMHLFrSQnQNoO3roN
 nkK11EgJebSEomRiILOo2hPmwHB539A0sszif7H4qMk2LWN2bYQ+ns8SJg9Dr2G/aY4N
 VUoZ2kW2KoQuchO1e4UGlLcwTETQ0NyNHPLUCVPGs3zzO02U75COx5S9R2wmfpxPpikx
 BAsOu1HQloDAtl4kNakVCnXFZw98XYQUQ8Vb+aJlPGmk6u4GKfmSpbfvXn9f9QxeqlRI nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31ywrby6cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:01:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062Ewpe0090264;
        Thu, 2 Jul 2020 15:01:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31xg19ggjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:01:04 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062F0xVD010335;
        Thu, 2 Jul 2020 15:00:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:00:58 +0000
Date:   Thu, 2 Jul 2020 18:00:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 02/14] irqchip/csky-apb-intc: Fix potential resource
 leaks
Message-ID: <20200702150051.GR2549@kadam>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-3-git-send-email-yangtiezhu@loongson.cn>
 <564ffff9-6043-7191-2458-f425dd8d0c11@web.de>
 <1a0e007a-db94-501b-4ab9-0bb479ec093b@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a0e007a-db94-501b-4ab9-0bb479ec093b@loongson.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=1 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=1 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:35:35PM +0800, Tiezhu Yang wrote:
> On 07/01/2020 04:40 PM, Markus Elfring wrote:
> > > … were not released in a few error cases. …
> > Another small wording adjustment:
> >    … in two error cases. …
> 
> OK

A lot of people have told Marcus over and over not to comment on commit
messages.  Greg has an automatic bot to respond to him.

https://lkml.org/lkml/2020/6/13/25

Marcus ignores us when we ask him to stop.  Some new developers have
emailed me privately that they were confused and discouraged with his
feedback because they assumed he was a senior developer or something.

regards,
dan carpenter

