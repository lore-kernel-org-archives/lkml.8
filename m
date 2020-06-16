Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F0DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D0D20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RvffjM+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgFPKPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:15:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPKPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:15:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GADoJu099196;
        Tue, 16 Jun 2020 10:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EcCRdlTazRb67PyCgCpOVI9R4o0XkJK0W6v5NveMssw=;
 b=RvffjM+9CMJ4C/L8puXpo97FV9+aBJljjjTBGzU7m1Z8F9EdvY9ymZyyB4vXTkMHVnaY
 D3KpmLTQnhMWUfQROAoQdlgmVQ9cngXVVRYAHQakQo1FWfq2mwbBN02Yo02sd+Xb3E2a
 U7mKBFtwYBACgMTc+BijX2kbwgePEOq1T6tAJiVi1dRG2OYE93zKLcrkhlnZEcVB2UPR
 gImCAW7/ckfJAvSv6LkL8nF0mGIRJq5y7FSmqXt4fpfGfG7qaq+8jCKtVHI+CHhNdug9
 acfhEsu6M9nFPzBEHLAkToC9yvPcZgVRRooZVsqgHYfNiZMH4ntHB+w6HfClB+Jlxy4+ qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31p6e5wypt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 10:15:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GA49E4024221;
        Tue, 16 Jun 2020 10:13:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31p6s76x2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 10:13:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05GADIGv023265;
        Tue, 16 Jun 2020 10:13:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 03:13:18 -0700
Date:   Tue, 16 Jun 2020 13:13:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] staging: rts5208: Use array_size() helper in
 vmalloc()
Message-ID: <20200616101312.GM4151@kadam>
References: <20200615230811.GA18818@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615230811.GA18818@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:08:11PM -0500, Gustavo A. R. Silva wrote:
> and memset()

Please don't start the commit message in the middle of a sentence.  It's
a completely different thing from the title.  When you're reading the
full email then the title is hidden in the headers and the Date: and
Message-ID: field go in between the title and the message body.

https://lore.kernel.org/lkml/20200615230811.GA18818@embeddedor/

I normally read either the title or the body but seldom read both when
I'm reviewing patches.

regards,
dan carpenter

