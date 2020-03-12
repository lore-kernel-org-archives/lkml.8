Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE8AC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B38205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CiWLzRyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCLNjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:39:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46270 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgCLNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:39:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CDE0s4158349;
        Thu, 12 Mar 2020 13:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=7iLVrV7AP0thjT8x8OkA4+ouxS7s/jxo7fgh9+ubWsY=;
 b=CiWLzRyI5RgydfyMrSLmJQV+vFsSQYfLwiwagRd1FIxq210dT7JkJBhh9Z/GLQXAy5x7
 EuZpoZHZE/4EcWEqTrQQ6TnWsqq4F2fTgb1E+sQs4Tyfgerk5txEFiLYsanMvM910e08
 Dq4LKfSj+nPvc6vU5BRTAlOAwcA3kk1Q2pZf3nrPNdciphgRmk/QFVE7aE/saVrv2Fte
 KerJzepInzNJ9E9OVzC1ySvSAA1lTaPbjiUJLtOC20PjbhiaNtAYLo08OzErWVK3l9t7
 jFZol+R+eF4G9HobM+T/Fv+9kHC1vKjqy3Aw0P/cawQenwVYBdn1j8py6oMIP9tFFFEI Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yqkg88tfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 13:38:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CDcFkn005506;
        Thu, 12 Mar 2020 13:38:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yqkvmpx8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 13:38:58 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CDcogX008791;
        Thu, 12 Mar 2020 13:38:51 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 06:38:50 -0700
Date:   Thu, 12 Mar 2020 16:38:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
        "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
        "mario.kleiner.de@gmail.com" <mario.kleiner.de@gmail.com>,
        "David.Francis@amd.com" <David.Francis@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu/display: Fix an error handling path in
 'dm_update_crtc_state()'
Message-ID: <20200312133842.GI11561@kadam>
References: <20200308092637.8194-1-christophe.jaillet@wanadoo.fr>
 <97d88948e2ab4ec19c5a0c6d064df08b@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97d88948e2ab4ec19c5a0c6d064df08b@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 08:24:04AM +0000, Walter Harms wrote:
> 
> ________________________________________
> Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kernel.org> im Auftrag von Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Gesendet: Sonntag, 8. März 2020 10:26
> An: harry.wentland@amd.com; sunpeng.li@amd.com; alexander.deucher@amd.com; christian.koenig@amd.com; David1.Zhou@amd.com; airlied@linux.ie; daniel@ffwll.ch; nicholas.kazlauskas@amd.com; Bhawanpreet.Lakha@amd.com; mario.kleiner.de@gmail.com; David.Francis@amd.com
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILLET
> Betreff: [PATCH] drm/amdgpu/display: Fix an error handling path in 'dm_update_crtc_state()'
> 
> 'dc_stream_release()' may be called twice. Once here, and once below in the
> error handling path if we branch to the 'fail' label.
> 
> Set 'new_stream' to NULL, once released to avoid the duplicated release
> function call.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Maybe the 'goto fail' at line 7745 should be turned into a 'return ret'
> instead. Could be clearer.
> 
> No Fixes tag provided because I've not been able to dig deep enough in the
> git history.
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 97c1b01c0fc1..9d7773a77c4f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7704,8 +7704,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
> 
>  skip_modeset:
>         /* Release extra reference */
> -       if (new_stream)
> -                dc_stream_release(new_stream);
> +       if (new_stream) {
> +               dc_stream_release(new_stream);
> +               new_stream = NULL;
> +       }
> 
> 
> dc_stream_release() is NULL-checked, so the if can be dropped.
> 
> re,
>  wh

Walter, it's really hard to separate your reply from the quoted email.
What's going on with that?  Could you configure your email client to
use "> " for the quoted bit?

regards,
dan carpenter

