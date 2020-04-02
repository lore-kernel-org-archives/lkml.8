Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FBBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D7E2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xplAvYEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbgDBIRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:17:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34918 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbgDBIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:17:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328HdpD077946;
        Thu, 2 Apr 2020 08:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WeanoaLBqDrBq+dsLz0IwCLWX8D0EvqVHKxzG85jwu4=;
 b=xplAvYEEBIYprbeGpiTuBI+T5ZKx8vHh+tczZOxIv7ipgoBwuEHEVkIy/6i43r5US1VE
 kWvnaG6P66KtEv/94wKgSodPPMqhqbHbx5pHcy/chSF2qvJ6SCjyIQhjF5vezy9yhJQG
 BBJAL4SBCek519hT7auJfr4n10Ra5MB4frcWKbwCjpHSx0PCNbtsN0GDElYSaLJYdSxy
 PL11OMw80qlgUjfeh34SxwVcUndy9pvUb+EATdfhbpG2cjWxs24CPgzksHJEVcM3xaBU
 0e9+iHUIUnh4rh+wlOFEIkUFEmkyDSN01TC90oWy8QEfKmgtXryIAWbPbTNgBKktRWuz Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cev9u4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:17:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328H0ak022089;
        Thu, 2 Apr 2020 08:17:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2j3nwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:17:38 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0328HcC3021911;
        Thu, 2 Apr 2020 08:17:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:17:37 -0700
Date:   Thu, 2 Apr 2020 11:17:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     aimannajjar <aiman.najjar@hurranet.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2 1/5] staging: rtl8712: fix checkpatch long-line warning
Message-ID: <20200402081730.GE2001@kadam>
References: <20200327080429.GB1627562@kroah.com>
 <cover.1585353747.git.aiman.najjar@hurranet.com>
 <6a4d94b4e5446f4665dc11290ed1351661554f01.1585353747.git.aiman.najjar@hurranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4d94b4e5446f4665dc11290ed1351661554f01.1585353747.git.aiman.najjar@hurranet.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=581 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=628 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 08:08:07PM -0400, aimannajjar wrote:
> This patch fixes these two long-line checkpatch warnings
> in rtl871x_xmit.c:
> 
> WARNING: line over 80 characters
> \#74: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:74:
> +       * Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
> 
> WARNING: line over 80 characters
> \#79: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:79:
> +               kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4, GFP_ATOMIC);
> 
> Signed-off-by: aimannajjar <aiman.najjar@hurranet.com>
                 ^^^^^^^^^^^

You need to use your proper legal name here.  Please capitalize normally
like you would on a legal document.

regards,
dan carpenter

