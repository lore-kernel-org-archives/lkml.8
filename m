Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ECDC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBF9218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSKn3DTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBMTeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:34:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgBMTeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:34:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DJWfCR116529;
        Thu, 13 Feb 2020 19:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=EvYfRxXiZueFYW1/RkKgbhiGnHPy09+zWIQhEYqquoo=;
 b=JSKn3DTJpGrOUZTQNon0lK8ZE1kQNyd6QHA2jsjDrJNi3pNDFrAmDGPCs2kDkSrV08/O
 FuiWrvwFg8m4oBAoBSkxyd2gsQc/6+suJWeQQT1TEviuXlpa/2WQiGxpqtVHmLeF0Mfm
 /3q5s+2CsNtxvbRDOSob2RyUjsnJPG8spnCz8L+vWWP/fkaUzB31Dqcz2joTaB1RFShi
 oqRxHMRvIP8z+ZVrLzeCBnnsUEPvfN/zhLJm6u3JMrJU18Jh3AqDWMHOWc/1M1GWl/l8
 h/ZNFjB33tHlgnXMiJT9TPoOPaVyqAcWfaUMALrPIawjbRmUGqUK91ai8XAXvVE5MI4q Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y2k88msfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 19:34:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DJRYYE020450;
        Thu, 13 Feb 2020 19:34:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y4k37wd3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 19:34:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01DJYBvq004981;
        Thu, 13 Feb 2020 19:34:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 11:34:11 -0800
Date:   Thu, 13 Feb 2020 11:34:10 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200213193410.GB6868@magnolia>
References: <20200213172351.GA6747@dumbo>
 <20200213175753.GS6874@magnolia>
 <20200213183515.GA8798@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213183515.GA8798@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:35:15PM +0100, Domenico Andreoli wrote:
> On Thu, Feb 13, 2020 at 09:57:53AM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2020 at 06:23:51PM +0100, Domenico Andreoli wrote:
> > > Hi,
> > > 
> > >   at some point between 5.2 and 5.3 my laptop started to refuse
> > > hibernating and come back to a full functional state. It's fully 100%
> > > reproducible, no oopses or any other damage to the state seems to happen.
> > > 
> > > It took me a while to follow the trail down to this commit. If I revert
> > > it from v5.6-rc1, the hibernation is back as in the old times.
> > 
> > Hmm, do you know which hibernation mechanism your computer is using?
> > 
> > --D
> 
> s2disk/uswsusp. Any other tool I could use as alternative?

Well ... you could try the in-kernel hibernate (which I think is what
'systemctl hibernate' does), though you'd lose the nifty features of
µswsusp.

In the end, though, I'll probably have to revert all those IS_SWAPFILE
checks (at least if CONFIG_HIBERNATION=y) since it's not fair to force
you to totally reconfigure your hibernation setup.

--D

> Thanks,
> Domenico
> 
> -- 
> rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
> ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
