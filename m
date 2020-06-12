Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12703C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA565207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ZxFl2fHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgFLUg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:36:59 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D7EC03E96F;
        Fri, 12 Jun 2020 13:36:58 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 05CKVc1H014102;
        Fri, 12 Jun 2020 21:36:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=1YwoF03jwcFoe5+1gkp78Gtn2ylOYhUdyPI/OKSa25U=;
 b=ZxFl2fHrEBWEnNLwrGHtLh8hi40K6zkmB2nToD5e//5tgKmgAbA+G7K9ZRxcvaeO8J0y
 NtkZ4L30tdc9IsvEL0bAarCC/KZGBB+n+1akX9yvf+9d+8R5VFcCDWd8YwwO/LleFu0A
 MEG/PUrvG5IpVlnnpSRZxZ+8Am1VoZ8GvqyKi55GVAxEqTN6WXq1tklm6g4CobLP7wD+
 o85nlPWthsmyiPGBGaAd8PzPNxMs4mOigMJvRuHzVhdRjEzCIsmiNsdQYMgU/aI43s7W
 8QtR9WY/K7jTeAujSqhxwoIoUEGH+j07o+5/A7pK+l/h1HWSleXQ1eRQqzUyUjvrDifo ow== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 31jrjtasqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 21:36:48 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 05CKVr90028564;
        Fri, 12 Jun 2020 13:36:47 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 31g94bcwcc-1;
        Fri, 12 Jun 2020 13:36:47 -0700
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 337BE21FDB;
        Fri, 12 Jun 2020 20:36:47 +0000 (GMT)
Subject: Re: [PATCH 09/16] dyndbg: accept 'file foo.c:func1' and 'file
 foo.c:10-100'
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org
References: <20200605162645.289174-1-jim.cromie@gmail.com>
 <20200605162645.289174-10-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <61514f3b-0361-83b4-727d-75587a3a8893@akamai.com>
Date:   Fri, 12 Jun 2020 16:36:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605162645.289174-10-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_16:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 cotscore=-2147483648
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/20 12:26 PM, Jim Cromie wrote:
> Accept these additional query forms:
> 
>    echo "file $filestr +_" > control
> 
>        path/to/file.c:100	# as from control, column 1
>        path/to/file.c:1-100	# or any legal line-range
>        path/to/file.c:func_A	# as from an editor/browser
>        path/to/file.c:drm_\*	# wildcards still work
>        path/to/file.c:*_foo	# lead wildcard too
> 
> 1st 2 examples are treated as line-ranges, 3,4 are treated as func's
> 
> Doc these changes, and sprinkle in a few extra wild-card examples and
> trailing # explanation texts.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  .../admin-guide/dynamic-debug-howto.rst       |  5 +++++
>  lib/dynamic_debug.c                           | 20 ++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 2854d418b31b..880d33d1782f 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -159,6 +159,7 @@ func
>      of each callsite.  Example::
>  
>  	func svc_tcp_accept
> +	func *recv*		# in rfcomm, bluetooth, ping, tcp
>  
>  file
>      The given string is compared against either the src-root relative
> @@ -167,6 +168,9 @@ file
>  
>  	file svcsock.c
>  	file kernel/freezer.c	# ie column 1 of control file
> +	file drivers/usb/*	# all callsites under it
> +	file inode.c:start_*	# parse :tail as a func (above)
> +	file inode.c:1-100	# parse :tail as a line-range (above)
>  
>  module
>      The given string is compared against the module name
> @@ -176,6 +180,7 @@ module
>  
>  	module sunrpc
>  	module nfsd
> +	module drm*	# both drm, drm_kms_helper
>  
>  format
>      The given string is searched for in the dynamic debug format
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index d43bc3547d3a..8f250c67acbe 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -321,6 +321,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
>  	} else {
>  		query->last_lineno = query->first_lineno;
>  	}
> +	vpr_info("parsed line %d-%d\n", query->first_lineno,
> +		 query->last_lineno);
>  	return 0;
>  }
>  
> @@ -357,6 +359,7 @@ static int ddebug_parse_query(char *words[], int nwords,
>  {
>  	unsigned int i;
>  	int rc = 0;
> +	char *fline;
>  
>  	/* check we have an even number of words */
>  	if (nwords % 2 != 0) {
> @@ -373,7 +376,22 @@ static int ddebug_parse_query(char *words[], int nwords,
>  		if (!strcmp(words[i], "func")) {
>  			rc = check_set(&query->function, words[i+1], "func");
>  		} else if (!strcmp(words[i], "file")) {
> -			rc = check_set(&query->filename, words[i+1], "file");
> +			if (check_set(&query->filename, words[i+1], "file"))
> +				return -EINVAL;
> +
> +			/* tail :$info is function or line-range */
> +			fline = strchr(query->filename, ':');
> +			if (!fline)
> +				break;
> +			*fline++ = '\0';
> +			if (isalpha(*fline) || *fline == '*' || *fline == '?') {
> +				/* take as function name */
> +				if (check_set(&query->function, fline, "func"))
> +					return -EINVAL;
> +			} else
> +				if (parse_linerange(query, fline))
> +					return -EINVAL;
> +

coding style here is to use braces for both branches.



>  		} else if (!strcmp(words[i], "module")) {
>  			rc = check_set(&query->module, words[i+1], "module");
>  		} else if (!strcmp(words[i], "format")) {
> 
