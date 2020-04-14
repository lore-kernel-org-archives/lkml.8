Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9316C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DDF2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gjd9tEgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438029AbgDNJye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:54:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438020AbgDNJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:54:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03E9rIGZ039973;
        Tue, 14 Apr 2020 09:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RNjbjBea2yPyYlo8Dy1KxUbyXQZ2fhl+B1f7RROmYig=;
 b=Gjd9tEgQJA1CCDoAV1Z92vjUXYP74T69H8YNOOuMssWNn9d76B3PH534Z910ajqs86qs
 HFdFPxhYRQtvrKB3dRqZQVdqE5V7j69bU195C5Y8emf5f2XVTdLFzCqqL8Y5TcVtv+x/
 ZWLsNA8klKgEjKshwIilh7b59w6ydlR+l/VDQ3iwsrQYjsXDqAUlYwnR2QFDj44uw4y6
 LLo2X2ziSLxVnZnvcUY4qkYfbLPQBHQife7ldkZ9QjJfDIcZfyglJNogkJNtl8tJUPy1
 6AL6tBkW04ShfKMsRNkKnvD6PM8WkPpIRDJewIZ6fHKFlGecsKbaU3bDhKDXwHO6nMUK bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30b6hpke05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 09:53:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03E9qxPS089717;
        Tue, 14 Apr 2020 09:53:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30bqm1ad9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 09:53:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03E9r8Sk028919;
        Tue, 14 Apr 2020 09:53:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 02:53:07 -0700
Date:   Tue, 14 Apr 2020 12:52:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     MugilRaj <dmugil2000@gmail.com>
Cc:     mugil2301 <110117057@nitt.edu>, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] taging: android: ashmem: Declared const key
Message-ID: <20200414095249.GE1163@kadam>
References: <1586633396-24237-1-git-send-email-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586633396-24237-1-git-send-email-dmugil2000@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 12:59:56AM +0530, MugilRaj wrote:
> From: mugil2301 <110117057@nitt.edu>
        ^^^^^^^^^
1) Real name.

2) Add a commit message.

> 
> Signed-off-by: mugil2301 <110117057@nitt.edu>
                 ^^^^^^^^^
3) Real name here as well.

> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 8044510..50f882a 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const  struct file_operations vmfile_fops;
                    ^^
4) Too many space characters.

Please resend.

regards,
dan carpenter

