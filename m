Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B1FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2138C207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="geoh4f3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGNC35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:29:57 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:38990 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgGNC35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:29:57 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 06E2Pgf7028288;
        Tue, 14 Jul 2020 03:26:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=CMcWgeN70W9yzJtbKSXSLvUJZMguz5JGKLMRefnJ8lw=;
 b=geoh4f3TugKozfQ9Cfy3aRtr+995DFFBaOKo0APSihxXRXFCe+FPFSSWNX8MyP3I1TcE
 /npw2P0wBD0pXnTQjLVjdpentHTmJI1tsUEAJnk+H7LaMUte+RfHXjnjDkXsjTX1f8WH
 BYp0ItB6UiJifUoZA2tWRktRg2jkmAPo2oJrPxmSW8Ct0v2lVs4zlRfSvKfvp1XsNXb8
 4Zm7fup2nuFtt+4zC1jfWHCGHNMx/DLoSAAn5q5i0EMCXNhKydpOv45BJWqcrQDFOi3D
 0ez6EyK4YAcl3/bpoujT5kawQ1/aYsBBQmDsWkNIY8gzfWczyz6q/8okxN21KxGOe/9o tw== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 328kc6gxan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 03:26:36 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 06E2HXAA023075;
        Mon, 13 Jul 2020 22:26:34 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com with ESMTP id 3278rx7aq1-1;
        Mon, 13 Jul 2020 22:26:34 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 1996F229E9;
        Tue, 14 Jul 2020 02:26:34 +0000 (GMT)
Subject: Re: [PATCH v4 13/17] dyndbg: accept 'file foo.c:func1' and 'file
 foo.c:10-100'
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-doc@vger.kernel.org
References: <20200620180643.887546-1-jim.cromie@gmail.com>
 <20200620180643.887546-14-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <30de6359-e56b-0915-5742-a360ef1b2814@akamai.com>
Date:   Mon, 13 Jul 2020 22:26:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200620180643.887546-14-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140014
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/20 2:06 PM, Jim Cromie wrote:
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
> index 1423af580bed..6c04aea8f4cd 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -164,6 +164,7 @@ func
>      of each callsite.  Example::
>  
>  	func svc_tcp_accept
> +	func *recv*		# in rfcomm, bluetooth, ping, tcp
>  
>  file
>      The given string is compared against either the src-root relative
> @@ -172,6 +173,9 @@ file
>  
>  	file svcsock.c
>  	file kernel/freezer.c	# ie column 1 of control file
> +	file drivers/usb/*	# all callsites under it
> +	file inode.c:start_*	# parse :tail as a func (above)
> +	file inode.c:1-100	# parse :tail as a line-range (above)
>  
>  module
>      The given string is compared against the module name
> @@ -181,6 +185,7 @@ module
>  
>  	module sunrpc
>  	module nfsd
> +	module drm*	# both drm, drm_kms_helper
>  
>  format
>      The given string is searched for in the dynamic debug format
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index ae6e523fdecd..7eb963b1bd11 100644
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

This bit seems like its unrelated to this patch and makes more sense in the
previous patch, or as separate patch...

Thanks,

-Jason


>  
> @@ -357,6 +359,7 @@ static int ddebug_parse_query(char *words[], int nwords,
>  {
>  	unsigned int i;
>  	int rc = 0;
> +	char *fline;
>  
>  	/* check we have an even number of words */
>  	if (nwords % 2 != 0) {
> @@ -372,7 +375,22 @@ static int ddebug_parse_query(char *words[], int nwords,
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
> +			} else {
> +				if (parse_linerange(query, fline))
> +					return -EINVAL;
> +			}
>  		} else if (!strcmp(words[i], "module")) {
>  			rc = check_set(&query->module, words[i+1], "module");
>  		} else if (!strcmp(words[i], "format")) {
> 
