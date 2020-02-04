Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D120C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AEC20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPbMY8mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgBDHX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:23:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgBDHX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:23:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0147NQS3010279;
        Tue, 4 Feb 2020 07:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Ij7io4GUXzasW7kqfziYoaIi88dN3t5qR5PedXGC7Q8=;
 b=mPbMY8mmWlZXnYNwLOgaWPeUatfXaoeggd9mCeJ5qNx4vNCKWYFQ4LBAg34P5Dz7sqLo
 NnrlGHM4Rtfoc1hjYfTH+4tE44CaR7ROHVSlyG2wNiCE7HCuMZhIVWj2sq2jBjHnVflk
 HauDb/kTe1mRSKJttt7oW753H9ZfUHpOnjcdTmZykhjZ2436CHxpb5IZUa2ZU61iZ/QO
 XK5f0Pl6wMLIxun3c2wNCsjxb89dWWDB2UB69yMJZCPnTWDnzcNdxV5d8JN76zacuzNg
 hbDqpvoJ/PN9LJHVMkkOQ5/JZAk7NMFt0xhidUGh+aWzNMl62qTStgdzXwmtnNp5KA1+ 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xwyg9gwa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 07:23:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0147JMEp052982;
        Tue, 4 Feb 2020 07:21:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xxvy26x70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 07:21:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0147LU1A015593;
        Tue, 4 Feb 2020 07:21:30 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 23:21:30 -0800
Date:   Tue, 4 Feb 2020 10:21:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "ddaney.cavm@gmail.com" <ddaney.cavm@gmail.com>,
        "pundirsumit11@gmail.com" <pundirsumit11@gmail.com>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nishkadg.linux@gmail.com" <nishkadg.linux@gmail.com>,
        "frank@generalsoftwareinc.com" <frank@generalsoftwareinc.com>,
        "laura.lazzati.15@gmail.com" <laura.lazzati.15@gmail.com>
Subject: Re: [PATCH 2/2] staging: octeon-usb: delete the octeon usb host
 controller driver
Message-ID: <20200204072122.GR1778@kadam>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <20191210091509.3546251-2-gregkh@linuxfoundation.org>
 <e97e28140b8c46cde93f40b93e2e0614943e96fc.camel@alliedtelesis.co.nz>
 <20200204071548.GB966981@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204071548.GB966981@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=971
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My advice is to delete all the COMPILE_TEST code.  That stuff was a
constant source of confusion and headaches.

regards,
dan carpenter

