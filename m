Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD79C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9402063A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gVP1gwMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgAaFHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:07:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51648 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaFHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:07:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V53TxS167621;
        Fri, 31 Jan 2020 05:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=7JFbG2kfPUy9eVPdThHnQD/i6I33TVatKmhpdRLgnbw=;
 b=gVP1gwMSYRm3f9B73K8xXNQwvmyIH+c1HJFmDv3DtRzbOyJggaxnbK0d7wBOl1Kv62PR
 Q7+WP/Q7PZ00Sio1eLBuFpi8cVuQMGNyYOnp1+qzvb4WswBDAvaDlG/3YLDlbWItxyEO
 EKtWcKbDwauYwMp4zlTASnezQEK0nW5AVQPJ2qqvs7iOF1pNzdao06G8wzd5i2VzSAwW
 cSknJ+6aDADZOyEeqES3zFFPlKnGoSZiPEu/MLUi3OJXGSBG7Rpyw77JykozsuaVXDsG
 /WlAU23Adjn+kyEQVpM9+TOxqpPTSihzocHGErORafG9ITVTcBBcvYfUhbZ509PLEkB3 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xrdmr06wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:07:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V53k6K099610;
        Fri, 31 Jan 2020 05:07:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xuheughyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:07:04 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00V571i3029774;
        Fri, 31 Jan 2020 05:07:02 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 21:07:01 -0800
Date:   Fri, 31 Jan 2020 08:06:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     gregkh@linuxfoundation.org, Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for syzbot
Message-ID: <20200131050651.hlq27kehtir3agf2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000095e1d8059d4675ac@google.com>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We changed this from dev_err() to dev_WARN() in commit 0cb54a3e47cb
("USB: debugging code shouldn't alter control flow").

The difference between dev_WARN() and dev_err() is that dev_WARN()
prints a stack trace and if you have panic on OOPS enabled then it leads
to a panic.  The dev_err() function just prints the error message.

Back in the day we didn't have usb emulators fuzz testing the kernel
so dev_WARN() didn't cause a problem for anyone, but these days the
dev_WARN() interferes with syzbot so let's change this to a dev_err().

Reported-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---

 drivers/usb/core/urb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index da923ec17612..0980c1d2253d 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -475,7 +475,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 	/* Check that the pipe's type matches the endpoint's type */
 	if (usb_urb_ep_type_check(urb))
-		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
+		dev_err(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
 	/* Check against a simple/standard policy */
-- 
2.11.0

