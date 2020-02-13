Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A329DC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B84C20659
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fie+DQoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgBMTln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:41:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMTln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:41:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DJVJlC160309;
        Thu, 13 Feb 2020 19:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=jqeb5Lfq23noB1z/KNSk4I15+rwLe7Nyygkp9XZpH2M=;
 b=Fie+DQoMpdo7D4+e49y6+gqTDrDU1IRJDf5ua+KfLQ7rNPzurcVtIwEeNDD+qRPtrIhU
 9SlxVvnEjjD8BJR3t9z4s8mu/949Q7MIFiEqNNdLDuRrCdaU0T7g8L37k33VsbTQN6YW
 85K5q722PsITaoyBG40BMu6n2PlUcR3M8qAnkgrSamrn5yCceC0gbR+fnr5GjeFttWnR
 VTvJtSS+hmecklCexCVoq8f3gbIIfBoeHV9r5c8AqqUI/NUJLYAoRYOBzOGMLD2bkOoX
 2w9soVlr6XyU+z5e5RX5keZm5kA06F2WrbzHW7lH4X8y8KtDN2zRD7ex9nH6wQMXtqGS 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y2p3svnxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 19:41:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DJRX6t020305;
        Thu, 13 Feb 2020 19:41:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y4k37xngk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 19:41:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01DJfaDV020664;
        Thu, 13 Feb 2020 19:41:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 11:41:36 -0800
Date:   Thu, 13 Feb 2020 11:41:35 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200213194135.GF6870@magnolia>
References: <20200213172351.GA6747@dumbo>
 <20200213175753.GS6874@magnolia>
 <20200213183515.GA8798@dumbo>
 <20200213193410.GB6868@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213193410.GB6868@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:34:10AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 13, 2020 at 07:35:15PM +0100, Domenico Andreoli wrote:
> > On Thu, Feb 13, 2020 at 09:57:53AM -0800, Darrick J. Wong wrote:
> > > On Thu, Feb 13, 2020 at 06:23:51PM +0100, Domenico Andreoli wrote:
> > > > Hi,
> > > > 
> > > >   at some point between 5.2 and 5.3 my laptop started to refuse
> > > > hibernating and come back to a full functional state. It's fully 100%
> > > > reproducible, no oopses or any other damage to the state seems to happen.
> > > > 
> > > > It took me a while to follow the trail down to this commit. If I revert
> > > > it from v5.6-rc1, the hibernation is back as in the old times.
> > > 
> > > Hmm, do you know which hibernation mechanism your computer is using?
> > > 
> > > --D
> > 
> > s2disk/uswsusp. Any other tool I could use as alternative?
> 
> Well ... you could try the in-kernel hibernate (which I think is what
> 'systemctl hibernate' does), though you'd lose the nifty features of
> µswsusp.
> 
> In the end, though, I'll probably have to revert all those IS_SWAPFILE
> checks (at least if CONFIG_HIBERNATION=y) since it's not fair to force
> you to totally reconfigure your hibernation setup.

Also, does the following partial revert fix uswsusp for you?  It'll
allow the direct writes that uswsusp wants to do, while leaving the rest
(mmap writes) in place.

--D

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..077d9fa6b87d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2001,8 +2001,10 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
+#ifndef CONFIG_HIBERNATION
 	if (IS_SWAPFILE(bd_inode))
 		return -ETXTBSY;
+#endif
 
 	if (!iov_iter_count(from))
 		return 0;
diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..3df3211abe25 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2920,8 +2920,10 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	loff_t count;
 	int ret;
 
+#ifndef CONFIG_HIBERNATION
 	if (IS_SWAPFILE(inode))
 		return -ETXTBSY;
+#endif
 
 	if (!iov_iter_count(from))
 		return 0;
