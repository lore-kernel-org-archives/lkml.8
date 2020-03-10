Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB873C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68020674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N1dCEwQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCJJG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:06:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60664 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgCJJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:06:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A8ww95158497;
        Tue, 10 Mar 2020 09:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CkKkorWH0ym37kCwUHtkNg4nbHsOSLF362VSkXjqG6A=;
 b=N1dCEwQRh8tkvI4zhrJZxQSJjR+3/1GPSyVa3dc0lKZtKojg/C/tHDY/VQIxuJYB7IMk
 SKFYKCkjzwp12rmfUMU5Sln+caPXtsmv79p5T251Lrc3xiAQqgLCQQ7jfRTdW8vEwzeF
 UFNOhscRz9ujLpTP64NaFlsj5+Y0oBbe7BVVpfmJTvqb0YGhFpyJETpTXk11VddYcgD6
 JNp2beTqdJikMycsq9C6BdP2FaZiUbK81o6DLWsrBQnTwvtrfkKY/G6eJt0XithZO+5I
 WbeLITQ+CaVXQn1tGUpz0VXRBRwO+1J+nWET197QFmEbI9ZQT106bEM+gWwJDF+knhej Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ym31ubvvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 09:06:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A914ix147236;
        Tue, 10 Mar 2020 09:06:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ymnb3hbst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 09:06:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02A96pCY011064;
        Tue, 10 Mar 2020 09:06:52 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 02:06:51 -0700
Date:   Tue, 10 Mar 2020 12:06:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] bfs: prevent underflow in bfs_find_entry()
Message-ID: <20200310090644.GA11583@kadam>
References: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
 <ba294b1d861142ca8f7b204356009dd0@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba294b1d861142ca8f7b204356009dd0@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=935
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 08:40:28AM +0000, Walter Harms wrote:
> hi Dan,
> the namelen usage is fishy. It goes into bfs_namecmp()
> where it is checked for namelen < BFS_NAMELEN, leaving
> only the case ==.

The rule in bfs_namecmp() is that the name has to be NUL terminated if
there is enough space.

regards,
dan carpenter

