Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1FEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B622076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZnJNcIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbgFYKFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:05:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403848AbgFYKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:05:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PA2ko9068025;
        Thu, 25 Jun 2020 10:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rtWVb/DasMEwTb3euQBD1fXSHM6/TSZdxpSwwI2jZHQ=;
 b=mZnJNcImvuACO+tTVXCHlb9fLzhsxBOpK0N5zJenM9AuUZ3gzj5H6EhZUvUHOBzeLyLF
 6rvJSlUT62O6VHdLkZoQqcwPGgCgVUDqVAGPZbI1xUNw7zeAk+HQnVg/tCzkqhNshlUv
 60EVIeouzi+ptiE3UiBmCkYXrIHm8K2Sd3+KRMMmhVd3z7hEAtQmL3XyFYmrM6gl6sza
 kr3EDbE6nqt909x5UgZKRiqIOMvURcuUD2qsduJKgNcvxWZTv3oGLr0Nb5FJpWF2MF8y
 f9sGj/aJNMCEohiadMpcagRXfO1XBfrTAaGkbijUDhufhl9Llu6laJWhSN7OnbykK5Sy Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31uut5qkvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 10:04:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PA3vE5054503;
        Thu, 25 Jun 2020 10:04:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 31uur10qht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 10:04:43 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05PA4b96012742;
        Thu, 25 Jun 2020 10:04:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jun 2020 10:04:36 +0000
Date:   Thu, 25 Jun 2020 13:04:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <20200625100429.GB2571@kadam>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200624165148.GD31008@kadam>
 <202006241238.E9CB1CE85B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006241238.E9CB1CE85B@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 impostorscore=0 cotscore=-2147483648 priorityscore=1501
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:39:24PM -0700, Kees Cook wrote:
> On Wed, Jun 24, 2020 at 07:51:48PM +0300, Dan Carpenter wrote:
> > In Debian testing the initrd triggers the warning.
> > 
> > [   34.529809] process '/usr/bin/fstype' started with executable stack
> 
> Where does fstype come from there? I am going to guess it is either
> busybox or linked against klibc?
> 
> klibc has known problems with executable stacks due to its trampoline
> implementation:
> https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks

Yeah.  It comes from klibc-utils.

regards,
dan carpenter

