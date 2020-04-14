Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0AEC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E0C20575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lv1rUkd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504020AbgDNSco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:32:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33064 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503999AbgDNSck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:32:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EIABfO076585;
        Tue, 14 Apr 2020 18:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=GTvnzmPIuo+zTA3LV2i2vcOkGvW+n0eKPUcwXXWxyHQ=;
 b=Lv1rUkd0In8etyKFdwJQxVsGJI9E/m4wkPCei6qvgpMHTkjq79ezUkpDfzxL0ULw84Zd
 CzideGZzS16NPhzCt00rz5zjoFeRAzgUHat4N8d4snKi+8AVseHWf+ENxBiH+wvamMVD
 imcNE06zwyq1Auk/yX/ZkMXg5+fLu3pZTYprduPzMtYu3MKJ17rFItAP5Xvo3fN+/KAy
 sysPKjMlaFpJuf8ACFcuufkyzxnFe2oAAkUqyXon17LUoQPPfVKY+0ZNLRbT3pOVFtzK
 CpAJGmWqcdD54wJffz4Z5HFJ6z5ZKHTVC5t8BhhzJzIO80V9mdTSm0+/vyZqtIAWrWum Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30b5um6mdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 18:32:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EI77AP155020;
        Tue, 14 Apr 2020 18:32:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30bqm2j9hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 18:32:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EIWSSx020662;
        Tue, 14 Apr 2020 18:32:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 11:32:27 -0700
Date:   Tue, 14 Apr 2020 21:32:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>,
        gregkh@linuxfoundation.org, navid.emamdoost@gmail.com,
        sylphrenadin@gmail.com, nishkadg.linux@gmail.com,
        stephen@brennan.io, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
Message-ID: <20200414181812.GE14511@kadam>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
 <20200414123326.GG1163@kadam>
 <d3725a08531898adc1bfb1e6d875888c434b42d6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3725a08531898adc1bfb1e6d875888c434b42d6.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=915
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=983 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:01:18AM -0700, Joe Perches wrote:
> On Tue, 2020-04-14 at 15:33 +0300, Dan Carpenter wrote:
> > On Mon, Apr 13, 2020 at 03:01:28AM +0000, Camylla Goncalves Cantanheide wrote:
> > > +
> > > +	for (i = 2; i < CAM_CONTENT_COUNT; i++) {
> > > +		write_nic_dword(dev, WCAMI, *keycontent++);
> > 
> > This code was wrong in the original as well, but now that I see the bug
> > let's fix it.  CAM_CONTENT_COUNT is 8.  8 - 2 = 6.  We are writing 6
> > u32 variables to write_nic_dword().  But the *keycontent buffer only has
> > 4 u32 variables so it is a buffer overflow.
> 
> Did you find the overflow with smatch?

No.  Smatch isn't smart enough to understand that *(keycontent + i - 2)
is an array overflow.  It thinks *(keycontent + i) is an array overflow
but the "- 2" confuses it.  Also Smatch isn't smart enough to parse the
*keycontent++.  It takes a shortcut when it parses loops.

To be honest, I just didn't like starting the loop from 2 and was trying
to see if there was a better define to use.

I agree that your solution of making the buffer larger is probably the
safest approach given that none of us really know the hardware.

regards,
dan carpenter

