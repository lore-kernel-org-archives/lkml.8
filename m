Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B084C2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UZhk6k9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgHUNci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:32:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgHUNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:32:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LDWKuh089069;
        Fri, 21 Aug 2020 13:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XdOvmH5USVXtysoB6X6erYb50z818EW7yPrG9RtuMu0=;
 b=UZhk6k9/ysu0qPh1meR7Saz8Rf6jBkJ942tZT+iAGW+XrzcaB8FI6KwErGKCk6UYUkCg
 ZtO72YaVffsqTXiNiXGWdlCCm3nDkroyyi4OdTe7542Zu9h84+x9aVtK8Gco5K4FIs0Q
 kO/VwsUIRKj7VTiFyCEdzXmx/m6zTOx6AlrQj5sRfWITINCptSXdc8wEqNRzZZMhWZAH
 x4U041R0R/iAGuKQ6Yo6P4ZOStVV+5f5FTXXo8bjjpKJAx8bWsL7j0IEUZjGEKKzJoFG
 qxk8GCwNt28uvVe74Q833w1MLS5EfZYIWC37GOeFpx3gSYjIA71AwjKBinXnrj21aMqz jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32x74rp2c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 13:32:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LDSOt2045064;
        Fri, 21 Aug 2020 13:32:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 332536r5xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 13:32:21 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07LDWKtj022084;
        Fri, 21 Aug 2020 13:32:20 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 13:32:19 +0000
Date:   Fri, 21 Aug 2020 16:32:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v3 2/2] staging: android: Remove BUG from
 ion_system_heap.c
Message-ID: <20200821133210.GV1793@kadam>
References: <cover.1597865771.git.tomersamara98@gmail.com>
 <39222c3a041708c41ab3bc1be855ac83912ee07b.1597865771.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39222c3a041708c41ab3bc1be855ac83912ee07b.1597865771.git.tomersamara98@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=2 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:39:34PM +0300, Tomer Samara wrote:
> Remove BUG()  at ion_sytem_heap.c and error handling to:
>  - free_buffer_page
>  - alloc_buffer_page
> this fix the following checkpatch issue:
> Avoid crashing the kernel - try using WARN_ON &
> recovery code ratherthan BUG() or BUG_ON().
> 
> Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> ---
>  drivers/staging/android/ion/ion_system_heap.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index eac0632ab4e8..56d53268b82c 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -30,7 +30,7 @@ static int order_to_index(unsigned int order)
>  	for (i = 0; i < NUM_ORDERS; i++)
>  		if (order == orders[i])
>  			return i;
> -	BUG();
> +
>  	return -1;
>  }

Just delete the BUG() and put a comment that /* This is impossible. */
so that reviewers know that we never return -1.

I suspect that there are some static analysis tools which might complain
about this -1 return.  But those tools are pretty crap.  Never change
code just to make the tools happy.

regards,
dan carpenter


