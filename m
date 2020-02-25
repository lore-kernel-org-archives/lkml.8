Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31ECC35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBBA21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqLNv0IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgBYHmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:42:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48914 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBYHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:42:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01P7WhOP083265;
        Tue, 25 Feb 2020 07:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=INcxH8t3MgyfLDXX5UOFFnVC3hnSuE6BlWvYpUVNJV8=;
 b=IqLNv0IVyVhYAv5zYqoGT8dpI6rqjyLiUsDSFAPxSbRK9FCfnAW0dbtIk386xschnjbr
 GWabdrYR+wSOqNMA19PtdkmA10KVko7yH2LmvvEdvodTKc578bbYS9WfyyvGnEF5v1H9
 LL/cCOhAgOCpaRn3jd42gWojL+wLxYrAvl6N2A2ML2MoCKUrj0StTTVYbrXXNMKwviiz
 sfFd4CwsMkmXu3XZok+2IAWqdisHK4o3tliydjPE8ciduNLh1tqCoq3XYn6zMU9r5uKa
 c8Oip+9S2h4mZDgTEOgOzaJtRm7auLra1zs4+4PvSJw78AS2x6284HQjdsaHVDnyKkrk Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yavxrm67b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 07:42:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01P7fuoM007682;
        Tue, 25 Feb 2020 07:42:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe137d9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 07:42:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01P7gDRV011335;
        Tue, 25 Feb 2020 07:42:13 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 23:42:12 -0800
Date:   Tue, 25 Feb 2020 10:42:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v7 0/2] Add initial support for slimport anx7625
Message-ID: <20200225074200.GC3308@kadam>
References: <cover.1582529411.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582529411.git.xji@analogixsemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:11:39PM +0800, Xin Ji wrote:
> Hi all,
> 
> The following series add initial support for the Slimport ANX7625 transmitter, a
> ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable device.
> 
> This is the initial version, any mistakes, please let me know, I will fix it in
              ^^^^^^^^^^^^^^^
> the next series.

This is actually the v7 version, but the patch zero cover letter hasn't
been updated.  :P  The last time anyone responded to these patches was
to point out three simple bugs which you fixed in v4 last November.

What changed in this version?  My guess is that nothing changed and you
are just prodding us to re-review it...  Feel free to say that also
because we can't read your mind.

regards,
dan carpenter

