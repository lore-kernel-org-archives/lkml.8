Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE832C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7772070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VhF9Q366"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgETMy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:54:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36728 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:54:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KCrF3r040394;
        Wed, 20 May 2020 12:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=j3qY+AimdnUvnxFvl+25yJx20/yrC+woZBSTpFQ9VfY=;
 b=VhF9Q366W2dpeQzzwA6sxglfaiUhtsndVFTY7kQD6Q5FKMHMiVGHgnM+M46HIlvi7kky
 dPIxOgCRik2CD0GruE+jtY+7Iz42Wd+8i65qyHzChwVuiL230UAEECh5v7fK0ktNHPkO
 xgJ8KrRd2pxOhjI3uDuzY92RMZY1jVcxhcZVUKZVQRqJGOseelXbV9DlWA2UWb1x4R12
 TsjcvsG9Y5hTlHl0OuXHKoflhAFxBTKeJbF1aDuSf58sWAPBn0samw6HIB86fYN+23xI
 X2BlgISO0aif6TQRWzgenMwLHFXPTcGj+wJM8lzKxhydu+usAzbfy9ZGOzPkDCtN+Clj +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3127kraxey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:54:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KCnDV3074147;
        Wed, 20 May 2020 12:52:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3150208722-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:52:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KCqIYg021917;
        Wed, 20 May 2020 12:52:18 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:52:17 -0700
Date:   Wed, 20 May 2020 15:52:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     christian.koenig@amd.com
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Rui Huang <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Yintian Tao <yttao@amd.com>
Subject: Re: [PATCH] drm/amdgpu: off by on in
 amdgpu_device_attr_create_groups() error handling
Message-ID: <20200520125209.GP3041@kadam>
References: <20200520120054.GB172354@mwanda>
 <62d9d539-8401-233a-3f20-984042489987@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62d9d539-8401-233a-3f20-984042489987@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=1 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=1 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:05:19PM +0200, Christian König wrote:
> Am 20.05.20 um 14:00 schrieb Dan Carpenter:
> > This loop in the error handling code should start a "i - 1" and end at
> > "i == 0".  Currently it starts a "i" and ends at "i == 1".  The result
> > is that it removes one attribute that wasn't created yet, and leaks the
> > zeroeth attribute.
> > 
> > Fixes: 4e01847c38f7 ("drm/amdgpu: optimize amdgpu device attribute code")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > index b75362bf0742..ee4a8e44fbeb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > @@ -1931,7 +1931,7 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
> >   					    uint32_t mask)
> >   {
> >   	int ret = 0;
> > -	uint32_t i = 0;
> > +	int i;
> >   	for (i = 0; i < counts; i++) {
> >   		ret = amdgpu_device_attr_create(adev, &attrs[i], mask);
> > @@ -1942,9 +1942,8 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
> >   	return 0;
> >   failed:
> > -	for (; i > 0; i--) {
> > +	while (--i >= 0)
> 
> As far as I know the common idiom for this is while (i--) which even works
> without changing the type of i to signed.

It's about 50/50, one way or the other.  To me --i >= 0 seems far more
readable.

I've been trying to figure out which tool tells people to make iterators
unsigned so I can help them avoid it.  :/  I understand how in theory
iterators could go above INT_MAX but if we're going above INT_MAX then
probably we should use a 64 bit type.  There are very few times where 2
billion iterations is not enough but in those situations probably 4
billion is not enough either.  So unsigned int iterators never or seldom
solve real life bugs but they regularly cause them.

regards,
dan carpenter

