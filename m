Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC52C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7082087C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fq2ISN5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgHZLEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:04:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46886 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHZLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:00:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QB01qb030251;
        Wed, 26 Aug 2020 11:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/fCtBAfUW9DNJUfT9YZ2XuOf8t/lJOxdFK2upLxSyFk=;
 b=fq2ISN5JKb5GnTBZyyPq3NdLSmJTI/PZFQKX2oBj/LK1JWBJNo1u80XccBy7q1FkU1Qn
 QbAlTwB3C+KDuHb3m1dh4Ccw1bancmQzeyYIUzr1HFLlG3gSM9uEB5v9ne2cw1Jk3ZuB
 ylWSIs8recNuMed8oX01uw01QLRAdltaZQhkDGvfYzaERxU0VLBoFw7a+MT0ACMKB7im
 ebMwWc8EHQCFGVQw3uvw40QqWTBIwSFD5hae0NL1edDRdHH4KVVLPox34PotvXzFO3BM
 12wfy1pCSAHSe0uAF+K+edaS9a53aeJk+wRsxZONxtt8tnURMjkO5bVlvTG8DsikrXtp jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 333dbrypp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 11:00:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAtLoB081719;
        Wed, 26 Aug 2020 11:00:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 333r9kred8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:00:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QB07uK028348;
        Wed, 26 Aug 2020 11:00:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 04:00:07 -0700
Date:   Wed, 26 Aug 2020 13:59:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     FelixCuioc <FelixCui-oc@zhaoxin.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, kbuild@lists.01.org,
        kbuild-all@lists.01.org, CobeChen-oc@zhaoxin.com,
        RaymondPang-oc@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH 3/3] iommu/vt-d:Add mutex_unlock() before returning
Message-ID: <20200826105959.GB5493@kadam>
References: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
 <20200826102752.3776-4-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826102752.3776-4-FelixCui-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 06:27:52AM -0400, FelixCuioc wrote:
> In the probe_acpi_namespace_devices function,when the physical
> node of the acpi device is NULL,the unlock function is missing.
> Add mutex_unlock(&adev->physical_node_lock).
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>

Oh...  Crap.  I wondered why I was being CC'd on this patchset.  Just
fold this into the ealier patch.  Don't worry about the Reported-by.

regards,
dan carpenter

