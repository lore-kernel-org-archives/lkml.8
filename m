Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC8C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFED7206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wlm/MYlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgD1TFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:05:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35112 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgD1TFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:05:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SIwkx8029355;
        Tue, 28 Apr 2020 19:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4nI+wEGFfrdWDDzaHjo9Ldz40UivhTylcpIh/VH8/r0=;
 b=Wlm/MYlJnPlyZyAL6CSOUDbfC3MspXPq8LL+QC+hPmOivWaB72JP1ox2ymQ+KjytVycQ
 xA0v3QnrN8ukgnKowqvIBNSSIMvZ1laqia6+wBoSbxLoERyXZtf61i1GRP6Sesg8iWp6
 rxKVCHwCF9qyN/2CUnTvti59iV3cjPFsM2XWrbRIyDHwlhtTS8Y9ZGblNpXx8KN+jnPh
 2svHv9yi9jKdxO5bPGi2784mVlECmys4hDafDrq7ismJdCHtdG9cx1LcU2R1DbBqXB7a
 SYSy8GLqV0jsUP7BGk9XvR0WuwxQLia1fS6CYkKWx9+5lfEFkxCgN9Ww3vVBIZM8heIU OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucg1v19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 19:05:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SIvuWv121231;
        Tue, 28 Apr 2020 19:03:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30mxx0gu9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 19:03:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SJ3Coa027361;
        Tue, 28 Apr 2020 19:03:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 12:03:12 -0700
Date:   Tue, 28 Apr 2020 22:03:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Suraj Upadhyay <usuraj35@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200428190306.GM2014@kadam>
References: <20200425113234.GA14492@blackclown>
 <8518467.FNpd3NTrYF@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8518467.FNpd3NTrYF@pc-42>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:50:23AM +0000, Jerome Pouiller wrote:
> On Saturday 25 April 2020 13:32:34 CEST Suraj Upadhyay wrote:
> > Break lines with length over 80 characters to
> > conform to the linux coding style and refactor
> > wherever necessary.
> > 
> > Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> > ---
> > 
> > Changes in v4:
> > 	- Added a space after declaration in wfx_get_hw_rate().
> > 	- A checkpatch warning for this commit is retained at line 75,
> > 	  to maintain uniformity in function declarations. (Reviewer
> > 	  jerome suggested).
> > 
> > Changes in v3:
> >         - Changed the temporary variable name for the memzcmp statement
> >           to is_used. (as suggested).
> >         - Added a temporary ieee80211_supported_band variable to address
> >           the problem in wfx_get_hw_rate() more efficiently. (not
> >           suggested, but still).
> > 
> > Changes in v2:
> >         - Introduced a temporary variable for the memzcmp statement.
> >         - Addressed the checkpatch problem with wfx_get_hw_rate().
> >         - Restored the function definition of wfx_tx_get_tx_parms
> >           as suggested by the reviewer.
> >         - Added suggested changes for req->packet_id statement.
> > 
> >  drivers/staging/wfx/data_tx.c | 40 +++++++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> This patch does not contain the suggestions from Dan. However, it is
> sufficient from my personal point of view.

Yeah.  It's fine.  It wasn't 100% cut and paste from my suggestions but
it did address the stuff I cared about.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

