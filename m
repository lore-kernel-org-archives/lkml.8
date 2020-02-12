Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C61C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A2B21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p9vCGHfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBLOtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:49:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:49:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CEXCK9004249;
        Wed, 12 Feb 2020 14:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9kz3g8SppE3C8092it7UV1WcnHIeXA9iH/3T2Jic3VM=;
 b=p9vCGHflG5TyIueboQKKkxf09DlNK3AThJpo9NbBO8eHyNzioRFLTqF5+cCF1aiApO+b
 ppMrz2mk5ZANaPWk9/CHLQz6+zSl0uvZq/oTdZXm9bcQaQnNaeiQkRr1a5RTQdAnPlU1
 sUHSG3oItzm5hY+FsAptEfNNgVQhoV6pLI+JU0aCToQ0MUUVjU+dCVjlpBXWfqu/Ontk
 cm6Trb1hpkdmssDzQR1KaYVi7lyFEO9yKZnMx91UuJP7r0u2mhdZQbnHgb4gcs6XuJaY
 M3I1fMxoqQqmkInkLztvjiiBuEDo1wNr2JIXa7DNrwP/NDaZHPX3VCp5YIa8d1k1SnoX BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y2p3sjrmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 14:49:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CEbAmJ046573;
        Wed, 12 Feb 2020 14:49:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2y4k9frmrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 14:49:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CEnff8030258;
        Wed, 12 Feb 2020 14:49:41 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 06:49:40 -0800
Date:   Wed, 12 Feb 2020 17:49:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v2] staging:gasket:gasket_core.c:unified quoted string
 split across lines in one line
Message-ID: <20200212144933.GJ1778@kadam>
References: <20200211200456.GA10351@kaaira-HP-Pavilion-Notebook>
 <alpine.DEB.2.21.2002112139550.3266@hadrien>
 <20200212115035.GB21751@kaaira-HP-Pavilion-Notebook>
 <20200212144424.GI1778@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212144424.GI1778@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:44:24PM +0300, Dan Carpenter wrote:
> On Wed, Feb 12, 2020 at 05:20:35PM +0530, Kaaira Gupta wrote:
> > When the driver tries to map a region, but the region has certain
> > permissions, or when it attempts to open gasket with tgid, or when it
> > realeases device node;
> 
> We don't care about any of this information...
> 
> > the logs are displayed in one line only while the
> > code has the strings split in two lines which makes it difficult for
> > developers to search for code based on the log messages. So, this patch
> > fixes three warnings of 'quoted string split across lines' in
> > gasket_core.c by merging the strings in one line.

Another perfectly adequate commit message would be:

Fix three checkpatch.pl warnings of 'quoted string split across lines'
in gasket_core.c by merging the strings in one line.

Which is imperative.  :)  Hooray!

regards,
dan carpenter

