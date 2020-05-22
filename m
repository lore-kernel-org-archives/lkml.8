Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF53C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6CB2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCpOf+BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgEVKgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:36:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48602 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgEVKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:36:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MAXNnw065360;
        Fri, 22 May 2020 10:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=K27L96mmV4GmzDbNladkq7oBFSKsiC4OG9GSzTfY0Ak=;
 b=BCpOf+BKx5AqZuHLlQvpkhfyOOlTJ2mOxlBW1TFVIzh3GdXhVWby1IxuqOq2J6Cgikvc
 1nHdQ4FRh1opqD1mtvnxyWpkK/lazqvA81Szytq3Ifor6fXs8He485Rnc8G6DHdX2nKb
 1Ak9x9YzyG5Zp9q+SFPzcYI1UJJIBPgAEmebcDCO+s9KyKjGqHf9oZJsVMXLbfUEAydH
 k3iOGswe2xdTMG6Rw3yq1wfRz2y741cauIcTPbLUg7yUA/27cMssCgL+KzkZxn6sD5Q2
 T6LsQgjKIkTUhHh+m+NKIxbJer/YFT4t+/dqxfp6FBbj9pgj/Gqh628O/TpAJMRo2it2 +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3127krn4hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 10:36:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MAXGkp165946;
        Fri, 22 May 2020 10:34:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 312t3e55g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 10:34:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04MAYEBO031342;
        Fri, 22 May 2020 10:34:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 03:34:13 -0700
Date:   Fri, 22 May 2020 13:34:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     MugilRaj <dmugil2000@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH] taging: speakup: remove volatile
Message-ID: <20200522103406.GK30374@kadam>
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=788
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=822 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:46:28PM +0530, MugilRaj wrote:
> fix checkpatch.pl warning, which is Use of volatile is usually wrong: see
> Documentation/process/volatile-considered-harmful.rst
> Signed-off-by: MugilRaj <dmugil2000@gmail.com>

Please put a blank before the Signed-off-by line.

Probably there should be a space between your first and last name.  It's
supposed to your legal name like for signing a legal document so use
whatever is appropriate legal documents in your country.

Also the Documentation/process/volatile-considered-harmful.rst explains
that people often use "volatile" when they should be using locking for
synchronization.  That seems to be the case here.  So the correct fix is
to add locking.  That's a little bit complicated to do and requires
testing.

If we apply this patch, then we have silenced the warning so now someone
will have to look for the bug.  But if we leave it as-is, then everyone
will know that the code is buggy.  So let's leave it as-is until we are
able to fix the bug.

It's always better to have easy to find bugs, than hidden bugs.

regards,
dan carpenter

