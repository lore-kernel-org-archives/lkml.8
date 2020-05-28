Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2587C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A211D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHJDaRqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgE1KEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:04:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgE1KEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:04:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S9tPjX085670;
        Thu, 28 May 2020 10:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/KSuSX3QihRtC4WO/4NLERdREBLmtzhRjH7jJcqHAXA=;
 b=MHJDaRqi6IPK7bv/ILFZfjgfKp8q9mql065vuZsJCV/Gg0oVJlni1+bmyM2WHFOENOWg
 B4xFW0f0HcWhqL8EcpEbqKtG/51Wv6QAbIwVTdT70CrONPpB4Y7vsXHvhr6w+auLmLLW
 pvj1Uh/WQBhw9minbKjAdiDXZ9JHv1b3xy5ci7JHbJuCII+CZZYp3rmJ6tKlNqMYXhYW
 ftn0QXzSNuiaJx0Rq1M7inongrf31+Ra4B4+FdeslJsCcgdXmX9kYnxdpusTo0GTkzpt
 d86IDObYl3dHV2kjy/7pnf8N9qzVikSgdmU4IoHsYS/3mW8yCLjhuU95sFAoFOjVxXKn ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 316u8r44gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 10:04:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S9mvTn052896;
        Thu, 28 May 2020 10:04:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 317ds28hyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 10:04:46 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04SA4iZk019698;
        Thu, 28 May 2020 10:04:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 03:04:44 -0700
Date:   Thu, 28 May 2020 13:04:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: Use common packet header constants
Message-ID: <20200528100438.GI30374@kadam>
References: <20200527194811.GF30374@kadam>
 <20200527205100.35794-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527205100.35794-1-pterjan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:51:00PM +0100, Pascal Terjan wrote:
> This driver contains a local version of the rfc1042 header and bridge
> tunnel header constants which are available from cfg80211.h, switch to
> those.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
> v2: improve description and drop confusing cosmetic changes

Perfect!  Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


