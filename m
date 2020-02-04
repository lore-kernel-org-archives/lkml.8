Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A2C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E689A2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LqRKRqnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBDJrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:47:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52106 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgBDJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:47:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0149h8wA127919;
        Tue, 4 Feb 2020 09:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=LFXX5TW52Au4ETytZUXFf1LYC9hvm0znVke+Xqg410E=;
 b=LqRKRqnvKs5OzNffZTUd7IVqNjkR95Oc+vxE9RoP2QNouUXApNtPrK3PUUIo8MDSWx4U
 NwUbWIbQOSPFaKnOYGUwIbSMpos4FQGuDbaHT9RcohmYCblEDd9+9FUwRt8u0h97ekWj
 ZDYmB0k989TjKoBI66wktZsU16frQJBh+dm6RClrAjjiE1E3XubhujyMDuHFTD6MZqBt
 7XrM8Ym85hUr026zYNKncVOK/4KarldDp808H4yFqbfLFLsSZcAjqqvet56IZw5aqs4e
 TRtEnmUKANBtcmPqWvX0lyJTfL7wYAaOnnVsFDsPpzHY1RUFLjVxpE6nxv6ig99KlroT ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xwyg9hnkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 09:46:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0149hBrx037783;
        Tue, 4 Feb 2020 09:46:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xxvy2h2wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 09:46:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0149krpM017731;
        Tue, 4 Feb 2020 09:46:54 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 01:46:53 -0800
Date:   Tue, 4 Feb 2020 12:46:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     devel@driverdev.osuosl.org, NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-dts: add dt node for 2nd/3rd uart on
 mt7621
Message-ID: <20200204094647.GS1778@kadam>
References: <20200204090022.123261-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204090022.123261-1-gch981213@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=841 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use ./scripts/get_maintainer.pl to pick the CC list and resend.

The MAINTAINERS file says Matthias Brugger is supposed to be CC'd and
a couple other email lists.

regards,
dan carpenter

