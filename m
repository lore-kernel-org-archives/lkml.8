Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1066C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8CD206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GUs3p2oT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgEVRvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:51:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58044 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbgEVRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:50:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MHg0BB003279;
        Fri, 22 May 2020 17:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Y5AXc/cpSAeSmxucaXQUpDP0kiRMqR98nq1i3vlmXro=;
 b=GUs3p2oTIgP2UCZ9nvvO+JUfUUnqedORu4HYHpVBhSGkNl+SBUeU6ymkKradd+x3VzPx
 YRG58/wdLXVXp1kAY3KXpD4P60I/9JqbTduDN0t1r/66U+ri2npaIZ7XWDlAjtWjD9Bk
 b5hoOWEUm6RsCXTT+Kectvb07ygYqr84QEcHj1Fo4dOO9+rpm5vMbFr/1jg3tcUZTevN
 qiE2gBMArgJzlAaLcRfTL9ZaXCvUpctTqUV1DIWwSCn8Mcqf9UnXL5CAsqjrMAR1YaXq
 tvoanOcxtK2pKuXO2RqMRxFBzcpopYNSRc1gDxLiJC5OHhHsFAi25FVOE2mfCwEe9JAN bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31284mf0w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 17:50:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MHmjIm121754;
        Fri, 22 May 2020 17:50:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj7un2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 17:50:41 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04MHockS008585;
        Fri, 22 May 2020 17:50:39 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 10:50:38 -0700
Date:   Fri, 22 May 2020 20:50:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Joe Perches <joe@perches.com>, MugilRaj <dmugil2000@gmail.com>,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH] taging: speakup: remove volatile
Message-ID: <20200522175031.GO30374@kadam>
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
 <20200522103406.GK30374@kadam>
 <6ab4139ec78928961a19e5fdbda139bb8cff9cb5.camel@perches.com>
 <20200522171312.s2ciifuxozwav2ym@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522171312.s2ciifuxozwav2ym@function>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9629 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9629 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did *really look* at the code when I was reviewing this patch.  :P

regards,
dan carpenter

