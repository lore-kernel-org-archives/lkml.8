Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBEC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BD92173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfLsY8G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgEHOwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:52:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgEHOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:52:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048EnS7G066839;
        Fri, 8 May 2020 14:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=H53MWy6dhP3UdGhQsVHvIU1qakOi+iDSoSFMC+dgrvs=;
 b=KfLsY8G0zHjnTr9Fba5pSDHbZNgaB3jQUv3bF0bm+60uJ88JModvJ6vqfx/6NsU5Pcgj
 gNE3Qply8HfD+euxqH5tuIm3rA+T6K1Lz8PZJghoL2tfBAoyczl5pLOSzvISrUlU8wf5
 fIg0qZIQklSTxSVCCuZl3i1bNoV3goqzi+57Se8/FJdsPQU2AJJ2FxGaxHpBCVCUm7yD
 hH5aDOR3i9SKGPdtd+4NkY9JS0edCkTUiD2YjX4zz8M60ZhDfF7PbOw1Oqcx58qggxjY
 PXRZ1E+LKk82dzk7NXgFzVV2HaGFkf+kpegH4Z3SbnGaHChcvzi7JUlcT9M1GV8x0xfa Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30vtepkcy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 14:51:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048EkvhN050162;
        Fri, 8 May 2020 14:51:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30vtdnr041-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 14:51:45 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 048EpftU026800;
        Fri, 8 May 2020 14:51:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 07:51:41 -0700
Date:   Fri, 8 May 2020 17:51:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, rostedt@goodmis.org,
        kernel-janitors@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH v4] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <20200508145133.GG9365@kadam>
References: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
 <20200508144009.GQ1992@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508144009.GQ1992@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=785 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=846 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 05:40:09PM +0300, Dan Carpenter wrote:
> Looks good thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

I was also absolutely fine with the v3 patch as well.

regards,
dan carpenter

