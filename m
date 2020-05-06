Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F1BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BF020714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MIuH9691"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgEFKFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:05:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60306 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgEFKFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:05:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0469vdto049129;
        Wed, 6 May 2020 10:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3oh7HarTSxz1XIgzxje6tJoDFgumYXnu8ULdheUzXjA=;
 b=MIuH9691bvG55EQ0VXiuyvYHuf0r43XonMGQcT15u/7dDXW52bkeZ7UeOsspvFB19jOP
 Ros/e68ae6XFAb0iEHpV8e8JDf1201hylqBt/R0NaZTFJuLbbD1c05hd0noeirl1tJgw
 JyN35w64UsKKEKM8s19RozvydzR6CcdvCyu6PoOzhmgNuDjoOIS6RoNuUP635dXYyGCD
 zpDs+0xUIVVm+yvT3/lWDwQmdENE07Q1a9aGsfkV2teoWrmCjeF3iT9nZNF9a5lJL3kp
 x4FV3ujEZnqFIktUUMPVmHKLxuvXteKiOE9IH29svxCh5qfCzhTmUis7cPZRGVcobleY 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09r9ght-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 10:05:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046A4vA5023736;
        Wed, 6 May 2020 10:05:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdv4h9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 10:05:02 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046A506M011143;
        Wed, 6 May 2020 10:05:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 03:05:00 -0700
Date:   Wed, 6 May 2020 13:04:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 4/4 v2] firmware: stratix10-svc: Slightly simplify code
Message-ID: <20200506100453.GA9365@kadam>
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
 <8c505c686438c54da61ad4fe15e1eae722011153.1588142343.git.christophe.jaillet@wanadoo.fr>
 <1f8ae50d-6830-7fbb-e999-3e8110fe7cd6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8ae50d-6830-7fbb-e999-3e8110fe7cd6@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:40:20AM -0500, Richard Gong wrote:
> Hi,
> 
> On 4/29/20 1:52 AM, Christophe JAILLET wrote:
> > Replace 'devm_kmalloc_array(... | __GFP_ZERO)' with the equivalent and
> > shorter 'devm_kcalloc(...)'.
> > 
> It doesn't make much sense.
> Actually devm_kcalloc returns devm_kmalloc_array(.., flag | __GFP_ZERO).
> 

devm_kcalloc() is better style and easier to read.  I was just reading
a bunch of AMD code that does this and I almost complained to them
that devm_kmalloc_array() doesn't zero the memory so they were freeing
uninitialized pointers.

regards,
dan carpenter

