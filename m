Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11AAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA120835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sIhuLsfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbgE0Rlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:41:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgE0Rlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:41:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RHfl50183983;
        Wed, 27 May 2020 17:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PK51SzOBvZ8R1oDn+sXjXMpcGWRS6/VN8/Q6+fQ5Oow=;
 b=sIhuLsfQv8J+L6DXMb10GEBjel3vAPUAUKqRxjRxHdPumzzkWx23AKYrJO2/aUVCi9BM
 Gg886E8phaEn9dTTxu8vaim6Ld4Su7MoHrqncmEG+pe3FD8L0s+n33fL3Y0d2dyW5gR8
 vC39sOLs5jFOXxJuabwdZtnB2dr5jA44tDLYajTqQX4mdylwSJku56qt52tTgh3kwwWu
 58ogc7BemR015NVTXrZNDArFFatyuyaqyTxuMYxee0lXUviQ09BvQok53GOMiQBhZExG
 O5g6VL3I0IXDAcFJ/o3jWRScC50FSlte/r5HUNBBHx1GgL0n/Q7Jt7MlyN6ZFFNisWaO tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 318xbk0vw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 17:41:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RHXd8e105821;
        Wed, 27 May 2020 17:41:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 317j5sg6g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 17:41:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04RHff5f015866;
        Wed, 27 May 2020 17:41:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 10:41:40 -0700
Date:   Wed, 27 May 2020 20:41:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, lkml <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: net/dsa/tag_8021q.c:109 dsa_8021q_restore_pvid() error:
 uninitialized symbol 'pvid'.
Message-ID: <20200527174134.GM22511@kadam>
References: <20200526145454.GZ30374@kadam>
 <CA+h21hqw8Ed_k_E8KK7mzDTag7p8jTYFLLkJ_i6+8__BKCdEUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hqw8Ed_k_E8KK7mzDTag7p8jTYFLLkJ_i6+8__BKCdEUQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=979 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005270138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 07:43:29PM +0300, Vladimir Oltean wrote:
> For net-next I just sent a patch that removes this function altogether:
> https://patchwork.ozlabs.org/project/netdev/patch/20200527164134.1081548-1-olteanv@gmail.com/
> Do you think a patch for the net tree is still necessary, that
> reorders the checks? Will you send that patch or should I?

Since you've already removed the function then that's fine.  Thanks!

regards,
dan carpenter

