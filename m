Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A913C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5AB21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcdMYQAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCJKqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:46:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgCJKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:46:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAcoWR081573;
        Tue, 10 Mar 2020 10:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1RisN3S7KM3q/8X60PBMjhXZIbFkHsb770PygEikLQM=;
 b=UcdMYQAOyUZiSFKHzyk6WZHOZfZ1jSJpCZgDUTkHTIamr9/HJdnodla4sGz/3TYPExfx
 faKxU3h/FFJmqGEpHlcpUSRWQgvw65E9LLe4YbutcmO242GFBednrEi9NP84ysSOwL5a
 oK++BuqCkNrNbKVSSnieI427QoDr5+8PY4wD6W0Fzjzsb4DlDan9MLKKdSY6gUWT/JK4
 D3dmWGD5VxLFW5btxzgSau3LqJD3zTw7G8jBcTSP4+JJt80DGUPFTPVfTibpxnCT6BnL
 B2pPLaFVSJpofP+dBatFF/utz8UfGK/AGyS3w7PyddyhQ3NEC/3Y0gF5LAVSTlUIi6YR Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ym3jqmsva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:46:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAcQYm069503;
        Tue, 10 Mar 2020 10:46:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yp8nry2uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:46:09 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AAk8Rs026312;
        Tue, 10 Mar 2020 10:46:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 03:46:08 -0700
Date:   Tue, 10 Mar 2020 13:46:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, surenb@google.com,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC] ashmem: Fix ashmem shrinker nr_to_scan
Message-ID: <20200310104601.GB11561@kadam>
References: <20200306011930.99378-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306011930.99378-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 08:19:30PM -0500, Joel Fernandes (Google) wrote:
> nr_to_scan is the number of pages to be freed however ashmem doesn't
> discount nr_to_scan correctly as it frees ranges. It should be
> discounting them by pages than by ranges. Correct the issue.
> 
> Cc: surenb@google.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/staging/android/ashmem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 5891d0744a760..cb525ea6db98a 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -458,6 +458,8 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		lru_del(range);
>  
>  		freed += range_size(range);
> +		sc->nr_to_scan -=  range_size(range);
                                 ^^
Two space characters.

In the old code we didn't *really* have to worry about sc->nr_to_scan
dropping to negative, but now we do.  ->nr_to_scan is unsigned so it
would be a high positive value now so it's maybe a forever loop?  I'm
too lazy to verify...

regards,
dan carpenter
