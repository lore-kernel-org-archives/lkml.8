Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054892072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FqMCZRfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437687AbgDNJdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:33:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32950 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgDNJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:33:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03E9WbCA156393;
        Tue, 14 Apr 2020 09:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=UE8WB00FR/t1Ou6MhoZLvz36hixyMK/Q2kVRh+MCims=;
 b=FqMCZRfg0iwziz4Nr4jXiJRD51IA8cw38xrS9YL70iYU/yFM7sGSDLl8ogsg8bmjzi48
 ygryOxxDAZCqtsYTPDsP7rUrvkZFG3dEZP4hFUbZwE66tH8Ylcd8/wMcFkdk9ITumvpg
 vP7/3N3R0hYeLTDzNoAEoNPJsVRImiirER3P5Ugir0Y5PAxCoTQiR3NJ35SnRtaZQPmT
 gD/tAnQ7xokyrzW7x2Y1aCMZtCeAOKuqgQQqxVwHOvsamqHHD3kNx+6tS3zJYKfsqvo1
 vmgdl9uwqBEZ7CdeujrONQuaEs6Oo4KeOgkT4+f1jVXM5IeNqGQx/GZ8Oj9Q0UHEzm/W sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30b5ar3bnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 09:33:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03E9D0UR169172;
        Tue, 14 Apr 2020 09:31:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30bqm18mt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 09:31:34 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03E9VRfY014073;
        Tue, 14 Apr 2020 09:31:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 02:31:27 -0700
Date:   Tue, 14 Apr 2020 12:31:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: phy: jz4770: Add a missing '\n' in a log message
Message-ID: <20200414093118.GD1163@kadam>
References: <20200411063811.6767-1-christophe.jaillet@wanadoo.fr>
 <ZQKM8Q.561QQF8CXZTU3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQKM8Q.561QQF8CXZTU3@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=820
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=881 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 03:13:47PM +0200, Paul Cercueil wrote:
> Hi Christophe,
> 
> Le sam. 11 avril 2020 à 8:38, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> a écrit :
> > Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> Is that so?
> 
> From what I could see these macros add the \n themselves if needed. So the
> \n were omitted on purpose.
> 

Do a "make drivers/usb/phy/phy-jz4770.i" and look at the string.  The
patch is correct.

regards,
dan carpenter

