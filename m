Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10061C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5182083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zbWum2G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgEHOlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:41:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40152 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgEHOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:40:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048Ebnqo151224;
        Fri, 8 May 2020 14:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9Pd6sdzTLPNAE5lKGbzkZBJdj4O3PQMJ6IPM7eKBgG0=;
 b=zbWum2G0ONLEDe7HujZ8RBdWshb1C66Kikq4kBZLWK8MnHDZeaeAWVUKi69rxnM2H5fF
 Pp2l5cdPtT+ceGsDz8gE/TLnApl3ov1kZekOJwZETwF3KnIHUBj8ry8oS5/KOiyO7qKb
 JcZchFi6mTiicfnWuz5J27g+0+geKdvynDn/UJ+w9YDOahr1KYecK+2x95ElNdueXBHM
 uhSxQbaP90ziupWiHQjPj3nrg4lr3gKPBbe3ariNHs/42VAQ/4MZyczzF7dVDy3BLKHl
 IUu+XWX3qOYHbspSdU78fuF3wj1oTOjUnMcENgblh0Hxm4FUDPXD8uUZ6h1v5+xomvpr ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30vtewub88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 14:40:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048Eap0a190858;
        Fri, 8 May 2020 14:40:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30vtegvcrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 14:40:19 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 048EeHOB002292;
        Fri, 8 May 2020 14:40:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 07:40:16 -0700
Date:   Fri, 8 May 2020 17:40:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, rostedt@goodmis.org,
        kernel-janitors@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH v4] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <20200508144009.GQ1992@kadam>
References: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=899 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=946
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

