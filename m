Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F38DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41FF2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E7YUpOfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgEHOqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:46:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46982 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgEHOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:46:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048EhgYt060805;
        Fri, 8 May 2020 14:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mBsJBO8AIHjfSjv3iPsT+zmmyIaT3vU/FP/YdVrrvSA=;
 b=E7YUpOfGLEDqJ0uMKlRI9FGlL2K/xojah3OPtoBtuE5lRvLgjSGAAzkyvzYmyUSmsy/p
 7xr2ERQyS70wY+kWe4PeG34MWzfey0lWEXEezE9Q2iu870nl+mrVb1E003fDA5gGRVKh
 AqvJKRXsdZNbwrLIppkX1ksaESCMtutsJBZ9zrnjjrhuxGnVeTXlTVfhEC1ubhFLInYe
 6DV1bTW25YJJxLDsadsDTeZ77TVgtgky0N/UJxJt9qZgSdiykIsTKeSF/C84YuCjzQVW
 F8UCQZ+sroMqDc1px8PXsiFQWEFMQnLGgZLBkEQMfTpCJjnpe074sPZ8PJCWW3tzzbQE LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30vtepkbsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 14:45:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048EgvNo040482;
        Fri, 8 May 2020 14:45:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30vtdnqmvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 14:45:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 048EjZKg032026;
        Fri, 8 May 2020 14:45:35 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 07:45:34 -0700
Date:   Fri, 8 May 2020 17:45:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [v3] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <20200508144527.GR1992@kadam>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
 <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
 <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
 <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
 <938cd0e9-d96b-766c-cfbc-4f0b73d97cd4@huawei.com>
 <20200508090053.430d28d7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508090053.430d28d7@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:00:53AM -0400, Steven Rostedt wrote:
> On Fri, 8 May 2020 19:42:56 +0800
> Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> 
> > On 2020/5/8 19:30, Markus Elfring wrote:
> > >> this change can fix the warning of tools.  
> > > 
> > > Would you like to point any specific source code analysis tools out
> > > for this issue?
> > > (Can a corresponding attribution become relevant for a clearer
> > > change description?)
> > >   
> > The tools we used is not for open source. it point out some error description like
> > "Memory leak: data" and "Resource leak: fd" in tools/bootconfig/main.c.
> > 
> > Can I only description:
> >   "Memory and resource leak is found by a static code analysis tools" ? thanks.
> 
> Markus please stop! Your suggestions are just your preferences that are not
> required for the kernel.
> 
> Yunfeng, your v2 was fine and has already landed in Linus's tree. Feel free
> to ignore Markus's suggestions in the future.

There was actually a bug in v2.  It exits with a non-zero instead of
zero on success so it will mess up people's scripts.

regards,
dan carpenter
