Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA4C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071F20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oOJhofvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgAJFyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 00:54:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgAJFyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 00:54:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A5rUEL050818;
        Fri, 10 Jan 2020 05:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=5JBntCtAE8aub1WbJjIcxc7ITMNSfHCdwR0Pl1xG8hY=;
 b=oOJhofvzKJzyBo8FnF3+GqppIDh3rSoXHI/Ik9U8XqQftXb7IJT1m61rdusR3EkRceIj
 QK8sFNbOMhrTrL8WfZfo/29zZZUTtUQvNnzBhk83laOHEeIOYMQeuSYeYcoKuVxmaCRp
 gc8xd7XGyJv4P6Hhv93qBNlEE+dOvFs3iNB80n15+zfJRsrP+LysY/qlvdVwL5kRzIE+
 rboPB5hI4GhXg4COPS+/xbxHoMOKCYX9eW1Do9Pom5JnlSBeRBYdHlBMr/w7r6pSiklM
 ePwPE5GQAFYb8WYTlcQDKZQUhI4XGdy1N2whD3GLVvmSPX+ZiCOmhVrgmdCuX2m3iG1+ cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xajnqfsgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 05:54:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A5sAlI175765;
        Fri, 10 Jan 2020 05:54:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xdrxf6kg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 05:54:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00A5r3Zh009111;
        Fri, 10 Jan 2020 05:53:03 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jan 2020 21:53:02 -0800
Date:   Fri, 10 Jan 2020 08:52:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Markus Reichl <m.reichl@fivetechno.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: mp8859: tidy up white space in probe
Message-ID: <20200110055252.rvelu4ysvoxsbmlg@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two lines are indented an extra tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/regulator/mp8859.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index e804a5267301..1d26b506ee5b 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -123,8 +123,8 @@ static int mp8859_i2c_probe(struct i2c_client *i2c)
 		ret = PTR_ERR(rdev);
 		dev_err(&i2c->dev, "failed to register %s: %d\n",
 			mp8859_regulators[0].name, ret);
-			return ret;
-		}
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.11.0

