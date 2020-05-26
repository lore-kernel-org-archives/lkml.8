Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39265C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1263D20899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kZzF82xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbgEZU0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:26:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389367AbgEZU0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:26:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QKLiRG108249;
        Tue, 26 May 2020 20:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zp67SJ8wHWZ6NZ+pwGwU9iQZ1C5+zthzljWao4iQ30Q=;
 b=kZzF82xGeR2082VG/T17QanUig8g2TZWNTXFtn+6JRBJxhyXKctmbt1yHyerDnaU/qwS
 CL81kM5msFKRHxJ6862iSWZH2HVPzxu0u4RjTM+Z7QnEgb4R3Jq6yMCUoeYqRb8cXvZ9
 OUXCFMWY2gB4wXEYT0PY3/pMqRrM8crCwFRL/E73a0IYSUwsJYdV6LF1CDTNX+PNeawU
 /eo2ElbJMNThecOajPfmtoig86QForViPW5tUthsBULSpfMzPaoyEogKOfaSrZXzn5HR
 JQ/8xjVJCvLwFV5OAw/roqvKG4FwgkCts0HRWhotsWf62LiYslk+DpTK8VJzpHF+/6+R Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 318xbjv1k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 20:26:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QKMtYi156141;
        Tue, 26 May 2020 20:24:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 317dry54fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 20:24:40 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04QKOWPc030383;
        Tue, 26 May 2020 20:24:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 13:24:32 -0700
Date:   Tue, 26 May 2020 23:24:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaurav Pathak <gauravpathak129@gmail.com>
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3] Staging: comedi: dt2814: remove unused assignments
Message-ID: <20200526202425.GH22511@kadam>
References: <20200526174813.GB30374@kadam>
 <20200526185130.7160-1-gauravpathak129@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526185130.7160-1-gauravpathak129@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005260159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, crap.  I'm really sorry but these lines of code can't be deleted.
Luc was suggesting that earlier and I saw what he said but I was sure
they could be deleted.  Now that I look at it more closely I see I was
wrong.

	hi = inb(dev->iobase + DT2814_DATA);
	lo = inb(dev->iobase + DT2814_DATA);

Every time we read from DT2814_DATA we get different data.  The first
time we get the byte and the second time we get the low byte.  In other
words reading from the register has side effects so if we delete a read
then the next thing to read from there will get the data that we were
supposed to read.

What we could do instead would be to remove the "hi = " assignment.
There is one other places where the assignment is not used.

	i = inb(dev->iobase + DT2814_DATA);
	i = inb(dev->iobase + DT2814_DATA);

I feel really bad for not seeing this earlier.  I know everyone hates
redoing patches.  I certain hate redoing patches.  This one was my
fault.  :/  The v3 was in the right format and all, but it will cause a
bug.

regards,
dan carpenter

