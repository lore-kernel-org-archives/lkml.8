Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB6C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD592070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XIHlmBeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgGOL0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:26:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41052 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:26:04 -0400
X-Greylist: delayed 1163 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 07:26:03 EDT
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FAvwHk143967;
        Wed, 15 Jul 2020 11:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9czQzPDZKgqDt9khTd+GxIMpAN8cHPITMRgapCFPeQ4=;
 b=XIHlmBeAC2KsfU6WBvEP1lPt4wKBcsVkMdLaqCf5XUOa2C1QVzPGKM6Whki9YUs3AFTm
 3bhTISNATPiMe2bLpPn0c/23Xh6OszcgXHFLpVLtNijaQqaHTS9QgDoFPZ5ol27tB+ui
 k4gy283vAf3WImq/uHo2LgW22SVNdRgJfuQYVYnQZXTf8IuHbJex9IY1LL7ui3kkRuPc
 auXnk7VJx25KMKPHWiL1sUbZUG5dyruWgkfkBEkxRC/kuIyyLcMi46twe9oJhE1CgPD6
 0wCr73DlPjuQLpjxWklQ1KUMScazTFqwkXcAzCNd/WpZlvC2Nbh0pKWVHNpXBjVl66Co ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 327s65gy2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 11:06:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FB3dqT097137;
        Wed, 15 Jul 2020 11:06:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 327q0r162k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 11:06:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06FB6K7G028955;
        Wed, 15 Jul 2020 11:06:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 04:06:20 -0700
Date:   Wed, 15 Jul 2020 14:06:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhao <zhixu001@126.com>
Cc:     Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, rcy@google.com, toddpoynor@google.com,
        rspringer@google.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue
 in gasket_core.c
Message-ID: <20200715110613.GZ2549@kadam>
References: <20200617161127.32006-1-zhixu001@126.com>
 <20200714234440.27009-1-zhixu001@126.com>
 <20200715071748.GC2305231@kroah.com>
 <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
 <20200715075755.GA2516028@kroah.com>
 <20200715083727.GY2549@kadam>
 <128a9f7de9885257736b3bb2648ea90bcbc2c760.camel@perches.com>
 <7d0444ff.5c46.17352142e11.Coremail.zhixu001@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0444ff.5c46.17352142e11.Coremail.zhixu001@126.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 06:45:21PM +0800, Zhao wrote:
> At 2020-07-15 17:04:06, "Joe Perches" <joe@perches.com> wrote:
> >On Wed, 2020-07-15 at 11:37 +0300, Dan Carpenter wrote:
> >> On Wed, Jul 15, 2020 at 09:57:55AM +0200, Greg KH wrote:
> >> > On Wed, Jul 15, 2020 at 12:24:22AM -0700, Joe Perches wrote:
> >> > > On Wed, 2020-07-15 at 09:17 +0200, Greg KH wrote:
> >> > > > On Wed, Jul 15, 2020 at 07:44:40AM +0800, Zhixu Zhao wrote:
> >> > > > > On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> >> > > > > > A coding alignment issue is found by checkpatch.pl.
> >> > > > > > Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> >> > > > > > 
> >> > > > > > Signed-off-by: Zhixu Zhao <zhixu001@126.com>
> >> > > > > 
> >> > > > > Hi, there~
> >> > > > > 
> >> > > > > Does anybody have any further comments on this?
> >> > > > > Can it be merged?
> >> > > > 
> >> > > > I never saw the first version of this, are you sure it got sent to the
> >> > > > mailing list?  It's not in any archives anywhere.
> >> > > 
> >> > > I saw it.  It's here:
> >> > > https://lore.kernel.org/lkml/20200617161127.32006-1-zhixu001@126.com/
> >> > 
> >> > Ah, doh, sorry.
> >> > 
> >> > Zhixu, please address the comments given to you on the series and resend
> >> > it as a new version.
> >> 
> >> He responded but not as a reply to my email.  It turns out I made a
> >> mistake.
> >> 
> >> Anyway, just resend, Zhixu.
> >
> >It's a pity a resend is being requested.
> >
> >It'd be a better process if the original patch could
> >be applied via the link akin to a git pull.
> >
> 
> Yes. All comments have been resolved by now. Patch v2 is sufficient.
> 
> As Dan said, there was a tailing thread because I mis-replied his mail.
>  I just now replied that mail with a reference to the final resolution mail.

Just resend.

regards,
dan carpenter

