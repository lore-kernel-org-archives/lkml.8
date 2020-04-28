Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4783C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8245A2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxvn03Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgD1T6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:58:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgD1T6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:58:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SJrp4B001622;
        Tue, 28 Apr 2020 19:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fgVW8SHlL4lo+HxxlLz7Gr/ftUNHzPDePQJYvyyrBI4=;
 b=kxvn03Qcj77WKcY+oCnkzbE133TkmTB5xUfqKzOiKDKPtM8JYr5FTFTykSLs80QP5loP
 i4ZDn+GZWw09SkJOERPGEniHA0LmQTZREao0ypUmcLamJUgU8kApDaoJl2CSRqzL/0EJ
 pCgCJo8SMDgqn0z2i413gk7zMFA82a6opg1BJYb1rL25ShA/Z4M1+H4iED7ubC5z2qKU
 6fcp/x5CL3bxl0wlh9kLOy6eOWdfJfok6rpGsPA6aFNhF+JmoVW79vL5GnchWKvv9718
 IllIoBefAQcgtXrFa3g7Gn9GFjTxO0U3Sspnx9A9pej0RdJzotn65MH13yRTz6UokuvX qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p07gbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 19:58:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SJqfKu164941;
        Tue, 28 Apr 2020 19:56:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30mxpgv1yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 19:56:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SJu6sf008267;
        Tue, 28 Apr 2020 19:56:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 12:56:06 -0700
Date:   Tue, 28 Apr 2020 22:56:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200428195600.GN2014@kadam>
References: <20200425113234.GA14492@blackclown>
 <8518467.FNpd3NTrYF@pc-42>
 <20200427115827.GA3214@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427115827.GA3214@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 05:28:27PM +0530, Suraj Upadhyay wrote:
> On Mon, Apr 27, 2020 at 11:50:23AM +0000, Jerome Pouiller wrote:
> > On Saturday 25 April 2020 13:32:34 CEST Suraj Upadhyay wrote:
> > > Break lines with length over 80 characters to
> > > conform to the linux coding style and refactor
> > > wherever necessary.
> > > 
> > > Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> > > ---
> > > 
> > > Changes in v4:
> > > 	- Added a space after declaration in wfx_get_hw_rate().
> > > 	- A checkpatch warning for this commit is retained at line 75,
> > > 	  to maintain uniformity in function declarations. (Reviewer
> > > 	  jerome suggested).
> > > 
> > > Changes in v3:
> > >         - Changed the temporary variable name for the memzcmp statement
> > >           to is_used. (as suggested).
> > >         - Added a temporary ieee80211_supported_band variable to address
> > >           the problem in wfx_get_hw_rate() more efficiently. (not
> > >           suggested, but still).
> > > 
> > > Changes in v2:
> > >         - Introduced a temporary variable for the memzcmp statement.
> > >         - Addressed the checkpatch problem with wfx_get_hw_rate().
> > >         - Restored the function definition of wfx_tx_get_tx_parms
> > >           as suggested by the reviewer.
> > >         - Added suggested changes for req->packet_id statement.
> > > 
> > >  drivers/staging/wfx/data_tx.c | 40 +++++++++++++++++++++++------------
> > >  1 file changed, 26 insertions(+), 14 deletions(-)
> > 
> > This patch does not contain the suggestions from Dan. However, it is
> > sufficient from my personal point of view.
> 
> Yes, I considered them but thought it would be bad to introduce a new
> variable at every iteration of the for-loop.
> 

It's not bad at all.  I don't know why someone would think that.

regards,
dan carpenter

