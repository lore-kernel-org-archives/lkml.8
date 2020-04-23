Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2699FC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B982076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i24mLnir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgDWKe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:34:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgDWKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:34:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NAWuDF062412;
        Thu, 23 Apr 2020 10:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yVhcOPH5NmXAs6Vn/3Nm2sX2Plx+OSxpYkzzKGQ2y+c=;
 b=i24mLnir7ZUnOcWpYfGcnB+gVswRzg55sPQc/W9qc9OJAfKxQkJdH1RDS9tZUfIuNHUx
 llrJInezVPtbCadLUxjSSLdBUSTLwndHRroBtCwRuhlgQOiLYyHEfnJLjZr9aweDY19+
 nr3EB9u/Q4Bf+1aCl8d1aFzKYfpJR6VzNMqCy3WVZTROfRMfXscJ23z8dWsUCiLAK02W
 oj6FcEt9YC/UqJv5Ec5SC7yzvdJuYYujk37jIGtry9NYkWS3QM4fOic8J+aVQntTBYje
 Ex38o/02i3r+5HWwukFrVDtek9zkLrCPzvYknIa6ZLasAd5ULugOuGO11uAy/plH//PL Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30k7qe0ghu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 10:34:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NAWKcK075127;
        Thu, 23 Apr 2020 10:34:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30gb1mejyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 10:34:52 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NAYpi7032291;
        Thu, 23 Apr 2020 10:34:51 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 03:34:50 -0700
Date:   Thu, 23 Apr 2020 13:34:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Suraj Upadhyay <usuraj35@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200423103439.GN2659@kadam>
References: <20200422153900.GA6184@blackclown>
 <2253201.upfRyW1aZW@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2253201.upfRyW1aZW@pc-42>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=951 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 09:29:28AM +0000, Jerome Pouiller wrote:
> >         req->data_flags.fc_offset = offset;
> >         if (tx_info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM)
> >                 req->data_flags.after_dtim = 1;
> > @@ -517,7 +523,8 @@ void wfx_tx_confirm_cb(struct wfx_vif *wvif, const struct hif_cnf_tx *arg)
> >                 if (tx_count < rate->count &&
> >                     arg->status == HIF_STATUS_RETRY_EXCEEDED &&
> >                     arg->ack_failures)
> > -                       dev_dbg(wvif->wdev->dev, "all retries were not consumed: %d != %d\n",
> > +                       dev_dbg(wvif->wdev->dev,
> > +                               "all retries were not consumed: %d != %d\n",
> 
> Is this reported by checkpatch? The strings can exceed 80 columns.
> 

The string can go over 80 characters, but it's nice to do our best to
avoid it so we do normally break it up like this where the string is
on its own line.

regards,
dan carpenter

