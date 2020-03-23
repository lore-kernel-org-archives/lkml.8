Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C43C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AAA2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLQzg5gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCWHfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:35:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57114 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCWHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:35:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02N7TCJG196590;
        Mon, 23 Mar 2020 07:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hX+vs80DDeOiro/tdn2Q9wyWfWoExexS44f4rTOFClM=;
 b=lLQzg5gddQjDpe/Z2V7KPmCdKmwN9wdJ2mYPY4HImmaInH66WsBxMo/5pxPgWDRYQKxe
 e5MQlk+1IOHlXhfXkhE6hYGSqe5fnL6qNAUf0M5+H8AcuIHKxMawH+KErCIq5Z5IaV+X
 wSnyj0wQQl5W1gqP0qcKf21aEr8KWtSntqZZnY8LOkjGRp9j+PeRaDw4MBJmeojcUF4y
 9qFFnndHdo2kwLl0STeAkOqBPI2Hw7bjCTCrIgHRWYMSKbzazLpRdoMlZe7EaU4GyXGK
 hRgET7BHJptsoYhDkbGcD8+YPlWrwaY9+rf1owS+FiuiwMypIHNt3oOPXTork0waLpBc ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ywabqvy8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 07:35:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02N7QqSn162743;
        Mon, 23 Mar 2020 07:35:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ywvdbjhqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 07:35:28 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02N7ZRTx029793;
        Mon, 23 Mar 2020 07:35:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 00:35:26 -0700
Date:   Mon, 23 Mar 2020 10:35:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT() macro instead of hex value
Message-ID: <20200323073518.GK4650@kadam>
References: <20200320171056.7841-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320171056.7841-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:10:56PM +0100, Oscar Carter wrote:
> -#define RSR_ADDRBROAD       0x80
> -#define RSR_ADDRMULTI       0x40
> +#define RSR_ADDRBROAD       BIT(7)
> +#define RSR_ADDRMULTI       BIT(6)
>  #define RSR_ADDRUNI         0x00
> -#define RSR_IVLDTYP         0x20        /* invalid packet type */
> -#define RSR_IVLDLEN         0x10        /* invalid len (> 2312 byte) */
> -#define RSR_BSSIDOK         0x08
> -#define RSR_CRCOK           0x04
> -#define RSR_BCNSSIDOK       0x02
> -#define RSR_ADDROK          0x01
> +#define RSR_IVLDTYP         BIT(5)	/* invalid packet type */
> +#define RSR_IVLDLEN         BIT(4)	/* invalid len (> 2312 byte) */
> +#define RSR_BSSIDOK         BIT(3)
> +#define RSR_CRCOK           BIT(2)
> +#define RSR_BCNSSIDOK       BIT(1)
> +#define RSR_ADDROK          BIT(0)

I like these ones because I do think the new version is more clear
now.

>  /* Bits in the EnhanceCFG_0 register */
>  #define EnCFG_BBType_a		0x00
> -#define EnCFG_BBType_b		0x01
> -#define EnCFG_BBType_g		0x02
> -#define EnCFG_BBType_MASK	0x03
> -#define EnCFG_ProtectMd		0x20
> +#define EnCFG_BBType_b		BIT(0)
> +#define EnCFG_BBType_g		BIT(1)
> +#define EnCFG_BBType_MASK	(BIT(0) | BIT(1))
> +#define EnCFG_ProtectMd		BIT(5)

Probably EnCFG_BBType_MASK should be defined using the other defines.

#define EnCFG_BBType_MASK (EnCFG_BBType_b | EnCFG_BBType_g)

Otherwise it looks good.  Can you change that one thing and then add
my Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

