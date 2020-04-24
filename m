Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0231C55196
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC682075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pkYmgV7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgDXRgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:36:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56636 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgDXRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:35:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OHMh65085952;
        Fri, 24 Apr 2020 17:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lK2lR6oS0MmTS17S06yxfyPGi7flPdKuNqf3iWlHMCE=;
 b=pkYmgV7ciA+P+zHSuqe91yhAWFprZZffzKC77wa9GAX1G5dTFZU4M5TAjpfer/yIkPMw
 wZN/JCDTcGJ158VH432lr/eqmNtf8eK24UsoeIewCjfk9mRIcCVo+Kp0mEKSZteg4GU6
 hCobxlWFbq/EnOY4q8G3PSrJMHK9x5LrO1h/R/iAzJkoF6HtsEnY0tGWlmcpNRO0XGNq
 swYTaUxrYXy+km5PPLRG+RyNvFwAJJqGSYyN5qUduTOEvdW0tU6hxYRzzWlrbGrFP+hN
 Y1GAfSZu/6vlRtCqI6XQj2MHt8kRjKCxIBm8sBLJaF0XFxjBPC5yvFqB0xtHpK3YFqo5 IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30ketdnn7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 17:35:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OHMRmR038154;
        Fri, 24 Apr 2020 17:35:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30gb1q6yhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 17:35:47 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03OHZhUg028461;
        Fri, 24 Apr 2020 17:35:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 10:35:43 -0700
Date:   Fri, 24 Apr 2020 20:35:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH USB 1/2] usb: raw-gadget: fix return value of ep read
 ioctls
Message-ID: <20200424173536.GS2682@kadam>
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
 <20200424084307.GQ2682@kadam>
 <CAAeHK+zS3WcmPEr9+hYGTMrZUwXyn5489Ke4f1zpdvTa-U-s9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zS3WcmPEr9+hYGTMrZUwXyn5489Ke4f1zpdvTa-U-s9Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=965 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 03:16:35PM +0200, Andrey Konovalov wrote:
> On Fri, Apr 24, 2020 at 10:43 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Fri, Apr 24, 2020 at 03:09:58AM +0200, Andrey Konovalov wrote:
> > > They must return the number of bytes transferred during the data stage.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > This was my mistake.  Please add a Fixes tag.
> >
> > Fixes: 068fbff4f860 ("usb: raw-gadget: Fix copy_to/from_user() checks")
> >
> > I should have seen that bug...  I thought I was being careful and I
> > even singled out that part of the commit and mentioned it in the
> > commit message but I messed up.  Sorry.
> 
> No worries, the bug was actually present before your change, but in a
> slightly different form. So FWIW we can also add:
> 
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> 
> However raw-gadget is not present in any released kernel yet, so need
> of backporting AFAIU.

The Fixes: tag lets scripts know that it's not required to back port it.

regards,
dan carpenter


