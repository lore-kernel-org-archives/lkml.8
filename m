Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCA7206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="odzUhjLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLVsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgFLVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:48:11 -0400
X-Greylist: delayed 2539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Jun 2020 14:48:11 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12241C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:48:11 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 05CL42l9013014;
        Fri, 12 Jun 2020 22:05:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=d1xhnEJ2u7GOYfH7O2aC15ZtQ2SBqf4tZ6eKc92acNI=;
 b=odzUhjLA1u59iNpWZgHok2xp5qBzdambDwH4YyC0J2Skvp2LXNH46jQzrB8fp6+PEx0a
 QTyavJUMYfTsfVifL/3+L7/wqf4pZ4XFGrZFT6ExD2sRLqrKcMINCvfL0rkv6OCiNw1W
 ZkZqzMLvcdJrjCfJomeR7kmIJINPj1fsCvgKXyjGb3Zade1zalEfQxlGdmnAPixNtu0D
 5xKgCrzVwfedLbDi28iKyZvPuDz9KP4Ti3oVyk4rFjWPedg1sbY4DIBn5N/TS5+10zDs
 EdCJ+T5HtdV56XXhS6+9HVtZlERQb0MWGwcMkMjyLyMfUttRs00wKJ0AS9gw5LzTL4da ag== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 31kh9fx01f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 22:05:49 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 05CKKk7h009233;
        Fri, 12 Jun 2020 17:05:48 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com with ESMTP id 31g6fy69r0-1;
        Fri, 12 Jun 2020 17:05:47 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id B5CC939EB1;
        Fri, 12 Jun 2020 21:05:47 +0000 (GMT)
Subject: Re: [PATCH 12/16] dyndbg: add filter parameter to ddebug_parse_flags
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk
References: <20200605162645.289174-1-jim.cromie@gmail.com>
 <20200605162645.289174-13-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <549fd78f-d9e0-3ae9-276f-38cde40a7ac1@akamai.com>
Date:   Fri, 12 Jun 2020 17:05:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605162645.289174-13-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_16:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/20 12:26 PM, Jim Cromie wrote:
> Add a new *filter param to ddebug_parse_flags(), allowing it to
> communicate optional filter flags back to its caller: ddebug_change()
>

I think you meant ddebug_exec_query() here?

Thanks,


-Jason


> Also, ddebug_change doesn't alter any of its arguments, including its 2
> new ones; mods, filter.  Say so by adding const modifier to them.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 2ecabfd3f432..32eb7d9545c7 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -146,7 +146,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>   * logs the changes.  Takes ddebug_lock.
>   */
>  static int ddebug_change(const struct ddebug_query *query,
> -			 struct flagsettings *mods)
> +			 const struct flagsettings *mods,
> +			 const struct flagsettings *filter)
>  {
>  	int i;
>  	struct ddebug_table *dt;
> @@ -444,7 +445,10 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
>   * flags fields of matched _ddebug's.  Returns 0 on success
>   * or <0 on error.
>   */
> -static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
> +
> +static int ddebug_parse_flags(const char *str,
> +			      struct flagsettings *mods,
> +			      struct flagsettings *filter)
>  {
>  	int op;
>  
> @@ -476,7 +480,9 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
>  		mods->flags = 0;
>  		break;
>  	}
> -	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
> +
> +	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
> +		 mods->flags, mods->mask, filter->flags, filter->mask);
>  
>  	return 0;
>  }
> @@ -484,6 +490,7 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
>  static int ddebug_exec_query(char *query_string, const char *modname)
>  {
>  	struct flagsettings mods = {};
> +	struct flagsettings filter = {};
>  	struct ddebug_query query;
>  #define MAXWORDS 9
>  	int nwords, nfound;
> @@ -495,7 +502,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
>  		return -EINVAL;
>  	}
>  	/* check flags 1st (last arg) so query is pairs of spec,val */
> -	if (ddebug_parse_flags(words[nwords-1], &mods)) {
> +	if (ddebug_parse_flags(words[nwords-1], &mods, &filter)) {
>  		pr_err("flags parse failed\n");
>  		return -EINVAL;
>  	}
> @@ -504,7 +511,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
>  		return -EINVAL;
>  	}
>  	/* actually go and implement the change */
> -	nfound = ddebug_change(&query, &mods);
> +	nfound = ddebug_change(&query, &mods, &filter);
>  	vpr_info_dq(&query, nfound ? "applied" : "no-match");
>  
>  	return nfound;
> 
