Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420BFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2182D20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uCJ+3MMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbgFWJet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:34:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbgFWJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:34:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05N9GQYR018709;
        Tue, 23 Jun 2020 09:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4GZ+lAHaQT1ZwUI8rD/MMNRHeM2iw7kQTbeUV+DTFfc=;
 b=uCJ+3MMMjtAzIAKPVHM4tivjv0fWPilltvMkeN0HCWauR4EToFJm9s91W8zURFu7uSCg
 d8VDLP9fnFewVOGNFmVBidfcuQLObrVoykYCDMD7Mihe1QcrERe9s4cocpORqBCbBZGX
 dM7GH35qalQC0c/f4e4pzUNyBrlEi6+UPNUZ8Ti3wH2EeSYkYeTdV4lBTZsoiutfEMSr
 JztWBfnQYbXT8dWMo9KZtIcbqWdJhvCTaFhpUD28GBA5+FBFBpH9VNB6CZ8gXBi5T1PZ
 cdAyFHu+ZZMilsqVU2u88qH/4gO9adlqSXy7ju2/G64S3vqNJtHaZRY1qDSQmM2xy+Mz 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31sebbm72b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 09:34:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05N9I0qZ034859;
        Tue, 23 Jun 2020 09:32:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31svc3nj4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 09:32:37 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05N9WZbN021581;
        Tue, 23 Jun 2020 09:32:36 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jun 2020 09:32:35 +0000
Date:   Tue, 23 Jun 2020 12:32:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>, trivial@kernel.org,
        kernel-janitors@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial: fix kerneldoc comments
Message-ID: <20200623093228.GI4151@kadam>
References: <1592854669-20606-1-git-send-email-Julia.Lawall@inria.fr>
 <6b0649c53e853fd2a35e9996f13e702daa0d7e2f.camel@perches.com>
 <alpine.DEB.2.22.394.2006230954560.2367@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006230954560.2367@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:59:57AM +0200, Julia Lawall wrote:
> > > diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
> > []
> > > @@ -519,7 +519,7 @@ u32 spum_assoc_resp_len(enum spu_cipher_mode cipher_mode,
> > >   * spu_aead_ivlen() - Calculate the length of the AEAD IV to be included
> > >   * in a SPU request after the AAD and before the payload.
> > >   * @cipher_mode:  cipher mode
> > > - * @iv_ctr_len:   initialization vector length in bytes
> > > + * @iv_len:   initialization vector length in bytes
> > >   *
> > >   * In Linux ~4.2 and later, the assoc_data sg includes the IV. So no need
> > >   * to include the IV as a separate field in the SPU request msg.
> > > @@ -917,7 +917,7 @@ u16 spum_cipher_req_init(u8 *spu_hdr, struct spu_cipher_parms *cipher_parms)
> > >   * setkey() time in spu_cipher_req_init().
> > >   * @spu_hdr:         Start of the request message header (MH field)
> > >   * @spu_req_hdr_len: Length in bytes of the SPU request header
> > > - * @isInbound:       0 encrypt, 1 decrypt
> > > + * @is_inbound:       0 encrypt, 1 decrypt
> >
> > odd alignments
> 
> Sorry to have missed these.
> 
> > etc...
> 
> Are there a lot of other such problems?  I did look through the whole
> patch several times by hand, but perhaps it is just too big to see
> everything.

Probably the comments for spum_assoc_resp_len() could be tweaked.

I had written an email about this one that Joe mentioned and
spum_assoc_resp_len() but then I decided that it wasn't enough to worry
about so I deleted the email instead of sending it.

regards,
dan carpenter

