Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54A4C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8099720714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cwY+dBq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgG0LpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:45:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgG0LpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:45:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBgkOY131177;
        Mon, 27 Jul 2020 11:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/2Bqbh6mqEzNlmJp3/m5FcHLpogK8hoaUEdhgHBnRQk=;
 b=cwY+dBq91vP6K4S/p3qzO7J1vrmggFsezqZnrUydf6kZ8YxdNkrAblw23f13pv7PdaVr
 bvBy5typaaIrD1BbGqXZE5XN++9OgiXXJZyP3Y3u2VjJGDSGTFqv4bw7QImVRn1Yt4pE
 cWRNd146HxzSb0aU+laHDhQCC23QXCrUTza1oluiWZXN3Du4UNSmnYPkx6r6fzr3M47E
 no4fDY+MTuCxhHrs9SPfmdWiUiCduNLsthZcR1VmGrrRu/GoWRrYy5Dps0JH+8wC5p2C
 97W3crDVz7H8ycBkqh+IY3PLqNUgeiEXG9+CYw8HL5u8hDRoyqxkRODAKNDW8UkMY1Sa iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32hu1j119u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 11:45:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBhGp9154648;
        Mon, 27 Jul 2020 11:45:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32hu5qhhu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 11:45:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06RBj0gB014202;
        Mon, 27 Jul 2020 11:45:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 04:44:59 -0700
Date:   Mon, 27 Jul 2020 14:44:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
        Stefano Brivio <sbrivio@redhat.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Staging: rtl8188eu: rtw_mlme: Fix uninitialized variable
 authmode
Message-ID: <20200727114451.GA1913@kadam>
References: <20200724122957.30411-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724122957.30411-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=18 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=18 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:29:55PM +0800, Dinghao Liu wrote:
> The variable authmode will keep uninitialized if neither if
> statements used to initialize this variable are not triggered.
> Then authmode may contain a garbage value and influence the
> execution flow of this function.
> 
> Fix this by initializing it to zero.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

This matches how rtl8723bs does it.

Fixes: 7b464c9fa5cc ("staging: r8188eu: Add files for new driver - part 4")
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

There is a quirk/bug in GCC where it's initializing stuff to zero
sometimes instead of printing a compile warning so this probably doesn't
change run time very much.

regards,
dan carpenter

