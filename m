Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F49C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D520728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F8+rpfJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgDXIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:43:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32914 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:43:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03O8gkqb185611;
        Fri, 24 Apr 2020 08:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zivr8YfPZWKR+1AB9kVD2ltz8Thkr6z6zfpjQtCJAl8=;
 b=F8+rpfJIzNqiXL79BFMjmXhS+Z19ynDwC238hk6/Tee5AKqscD1vGd6KKGbFfl4uQqmn
 Ow0sMTZI97u2oYMGgabKBSeUtedB1+qDlGiZRCM7VAFMH9s8mJW8SAYLRg+RDq692ITT
 MeloKVUlhEohrelVUMY4kaWdR8r7jZPw37pNMz5dyZrlDiQT3/TUiyRYyKE8izbThQ7V
 Skdyz7HQxQdNBXxTpDtPIN5kfRR4gS+LIF+kCjsujZa92X+mODbnKFCoL00PyNa538Nw
 nqhHm0qw0th8YanbU9/cSUkPTvZQuYhM8sDBJFXafHYkubmv0oHgxZTMBpHuMZP7Mk7F XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30ketdk3p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 08:43:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03O8gfeE172054;
        Fri, 24 Apr 2020 08:43:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30gbbpj3kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 08:43:19 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03O8hF3t029366;
        Fri, 24 Apr 2020 08:43:15 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 01:43:14 -0700
Date:   Fri, 24 Apr 2020 11:43:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH USB 1/2] usb: raw-gadget: fix return value of ep read
 ioctls
Message-ID: <20200424084307.GQ2682@kadam>
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=896 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=955 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 03:09:58AM +0200, Andrey Konovalov wrote:
> They must return the number of bytes transferred during the data stage.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

This was my mistake.  Please add a Fixes tag.

Fixes: 068fbff4f860 ("usb: raw-gadget: Fix copy_to/from_user() checks")

I should have seen that bug...  I thought I was being careful and I
even singled out that part of the commit and mentioned it in the
commit message but I messed up.  Sorry.

regards,
dan carpenter

