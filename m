Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A28CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A0520706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MDtiYd+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgFRKkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:40:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54300 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgFRKkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:40:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IAHocf105967;
        Thu, 18 Jun 2020 10:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qF2LPpEZDaLj0pOOQN4XthlIZQst0I61pB954/2aATg=;
 b=MDtiYd+wCnz6cj5iRKwDnhFh+Cq5byR8mQsoBX0yScNvEN6dWwH0garSyT4vfGxLeDR2
 FZ4GBGyB7ij0qp41hrn7XMEDVskmkx+R7+oZfFIh+Dx0qPyfKjII8K3jgwX7yVX1PZJK
 pLayV8RAcNvSmBLZCRlZYGcZ0/Homd3D7AJ7mn5qCVdlskv0j6+iwyFocwL8J5hNmNCX
 AiB+jbFrVhhHDEZYARA2m1H1I8S3Yu0f/bJCiLGb8zQ1Ss0YsyVkM9pF0eeWAzIPnRUA
 rC8sA1Oa0q6HWRMCIHucc5+2inJaXPFjqotUkNTO48ss7vT76Vz37phsfqxUH3TopuW2 yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31q6600dr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 10:40:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IAJCxg130162;
        Thu, 18 Jun 2020 10:40:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31q66pj8t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 10:40:15 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05IAe3LF009658;
        Thu, 18 Jun 2020 10:40:03 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 03:40:03 -0700
Date:   Thu, 18 Jun 2020 13:39:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/mm/selftests: fix unsigned comparison with
 less than zero
Message-ID: <20200618103956.GQ4151@kadam>
References: <20200617155959.231740-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617155959.231740-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:59:59PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Function get_insert_time can return error values that are cast
> to a u64. The checks of insert_time1 and insert_time2 check for
> the errors but because they are u64 variables the check for less
> than zero can never be true. Fix this by casting the value to s64
> to allow of the negative error check to succeed.
> 
> Addresses-Coverity: ("Unsigned compared against 0, no effect")
> Fixes: 6e60d5ded06b ("drm/mm: add ig_frag selftest")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/selftests/test-drm_mm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
> index 3846b0f5bae3..671a152a6df2 100644
> --- a/drivers/gpu/drm/selftests/test-drm_mm.c
> +++ b/drivers/gpu/drm/selftests/test-drm_mm.c
> @@ -1124,12 +1124,12 @@ static int igt_frag(void *ignored)
>  
>  		insert_time1 = get_insert_time(&mm, insert_size,
>  					       nodes + insert_size, mode);
> -		if (insert_time1 < 0)
> +		if ((s64)insert_time1 < 0)
>  			goto err;

The error codes in this function seem pretty messed up.

Speaking of error codes, what the heck is going on with
prepare_igt_frag().

  1037  static int prepare_igt_frag(struct drm_mm *mm,
  1038                              struct drm_mm_node *nodes,
  1039                              unsigned int num_insert,
  1040                              const struct insert_mode *mode)
  1041  {
  1042          unsigned int size = 4096;
  1043          unsigned int i;
  1044          u64 ret = -EINVAL;
                ^^^^^^^^^^^^^^^^^^
Why is it u64?

  1045  
  1046          for (i = 0; i < num_insert; i++) {
  1047                  if (!expect_insert(mm, &nodes[i], size, 0, i,
  1048                                     mode) != 0) {
  1049                          pr_err("%s insert failed\n", mode->name);
  1050                          goto out;
                                ^^^^^^^^
One of the common bugs with do nothing gotos is that we forget to set
the error code.  If we did a direct "return -EINVAL;" here, then there
would be no ambiguity.

  1051                  }
  1052          }
  1053  
  1054          /* introduce fragmentation by freeing every other node */
  1055          for (i = 0; i < num_insert; i++) {
  1056                  if (i % 2 == 0)
  1057                          drm_mm_remove_node(&nodes[i]);
  1058          }
  1059  
  1060  out:
  1061          return ret;
  1062  
  1063  }

regards,
dan carpenter

