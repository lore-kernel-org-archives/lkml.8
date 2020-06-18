Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5A8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA6D20773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h9S765iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgFROEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:04:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgFROEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:04:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IDvpQa099280;
        Thu, 18 Jun 2020 14:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7Q0XFI0Oxm9Myh+3IsKSVpS74n63CuzM1B1s0gyKVmA=;
 b=h9S765iXMk7XkTerh/y8VGi3aPhMZIEz4DJqXxI0KYGrt0FeDc/WpYUhhlH63mvTxFUQ
 ATD+5stxqHpBq046D5ODc/vFu+NKTWQmI7qUQws9r3GJlLnAUdl0MCvF+00sHh7hF1Qc
 nF157yeaN59zGLxu6qcZZuYP6zLZIVtR9Azj1REqeWNaAnqKHfFVuYJhQuCooJLydruA
 pZ8QGb5mpR+r08DxZm5hua2qiyMojQNGtg3kpXz7sl7D2A0gay6srj0l5DA7BDgNVX2y
 0wRzgs5R5A5oFq+4TsArNHSZ9L4QJK2kwPs4Aa+DjBkoDc4uF3mT1cebXOjkTyBhV/mo 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31q6601chf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 14:03:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IDvkNM191162;
        Thu, 18 Jun 2020 14:03:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31q660t3bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 14:03:37 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05IE3YdR005939;
        Thu, 18 Jun 2020 14:03:35 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 14:03:34 +0000
Date:   Thu, 18 Jun 2020 17:03:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhixu Zhao <zhixu001@126.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Richard Yeh <rcy@google.com>,
        Rob Springer <rspringer@google.com>,
        Joe Perches <joe@perches.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
Message-ID: <20200618140327.GS4151@kadam>
References: <20200617161127.32006-1-zhixu001@126.com>
 <20200618134422.24278-1-zhixu001@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618134422.24278-1-zhixu001@126.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 09:44:22PM +0800, Zhixu Zhao wrote:
> At 2020-06-18 03:10:02, "Dan Carpenter" <dan.carpenter@oracle.com> wrote:
> >It would be better to do this in the declaration block so you can change
> >the earlier two uses in this function:
> >
> >+	struct gasket_bar_data *data = &gasket_dev->bar_data[bar_num];
> >-	ulong desc_bytes = driver_desc->bar_descriptions[bar_num].size;
> >+	ulong desc_bytes = data->size;
> >
> >...
> >
> >-	if (driver_desc->bar_descriptions[bar_num].type != PCI_BAR) {
> >+	if (data->type != PCI_BAR) {
> 
> `struct gasket_bar_data *data` and `driver_desc->bar_descriptions[bar_num]`
> are not the same thing as I see it. Besides, `struct gasket_bar_data`
> doesn't have a `size` field (it does have a `length_bytes` field).
> So... did I miss anything?
> 

Ah wow...  I'm so sorry.  You're right.  Sorry for the noise.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
