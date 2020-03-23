Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF51C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DEC20781
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mn7R6b0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgCWLGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:06:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37414 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgCWLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:06:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NB349S019401;
        Mon, 23 Mar 2020 11:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=w5K+Q/84iqNbz33/6C2NZu0Q3vAYsOs50DjnxAcgG1Y=;
 b=Mn7R6b0l8wez1yAcZLSfpc2wrIhMuzIwnTi0DtAnf8n+KJJWKQeqrHu46og+68aFWP5o
 UlNfC2u8vRgCUcQw+sT5NelWNsoTB2CtwLH/MVe1bQdl0y32RZY72hNojPZEPiYBrrc8
 S3dxgQ50L9JIoialZaoweLgtoj/hidwCVju76UtCSHbvBwYILrom3gW9x0IAjqwGKhOS
 2cMWUfxtvB9b5Dq7Iv2zuxqOxLj/Cqi1oM4mR+hSuH1E2GlY8o97hOltmHXLS+GxIvlN
 S1TSKze+GqbnJSzp7SDqIeegRc6yWOkw2+PIeEaCTE5uZNmUKaWfkqd509W0XibbdIdx Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ywabqwx7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 11:05:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NAvRWn067564;
        Mon, 23 Mar 2020 11:03:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ywwuht83f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 11:03:47 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02NB3igg014374;
        Mon, 23 Mar 2020 11:03:45 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 04:03:44 -0700
Date:   Mon, 23 Mar 2020 14:03:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, kan.liang@linux.intel.com,
        zhe.he@windriver.com, dzickus@redhat.com, jstancek@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf cpumap: Use scnprintf instead of snprintf
Message-ID: <20200323110334.GC26299@kadam>
References: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 06:25:23PM +0100, Christophe JAILLET wrote:
> 'scnprintf' returns the number of characters written in the output buffer
> excluding the trailing '\0', instead of the number of characters which
> would be generated for the given input.
> 
> Both function return a number of characters, excluding the trailing '\0'.
> So comparaison to check if it overflows, should be done against max_size-1.
> Comparaison against max_size can never match.
> 
> Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
> Fixes: a24020e6b7cf6 ("perf tools: Change cpu_map__fprintf output")
> Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  tools/perf/util/cpumap.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 983b7388f22b..b87e7ef4d130 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -316,8 +316,8 @@ static void set_max_cpu_num(void)
>  		goto out;
>  
>  	/* get the highest possible cpu number for a sparse allocation */
> -	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
> -	if (ret == PATH_MAX) {
> +	ret = scnprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
> +	if (ret == PATH_MAX-1) {

This should be a static analysis warning.

But isn't this stuff userspace?  I can't figure out how to compile it on
Debian so I'm not sure.  There is no scnprintf() in user space.

regards,
dan carpenter

