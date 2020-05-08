Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E86C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803A821655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YYBbcw9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEHPEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:04:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44076 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:04:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048F3oTu122021;
        Fri, 8 May 2020 15:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ak+KS6cmfHXjY6qcAVO3aGp10fSQOuF6YLLnnfnHRtM=;
 b=YYBbcw9nkzniiFX/z/kJ6hUg0596KLR4N6Sng4tfllHuxeU6JbSlEBO3ojO4dI5/wV+z
 hIa2AlOzb6Mecytdbepfp4LjqjJgPBAH8ZBPdh6yRgpg62OawOdvyVwBYNmJJ2ZfZ9aO
 qwr7EJUSKpcax/4VCZTVSKLpCENdIRFdtovSm0mPJaUA2gpn638J85CzTq7/sCqTjKxr
 js6Fdrqb07IHA9z5HXas2rOANFx8h+XMZvY/QDY4gDnF56MFdU7heEfG+9M4IdkGSbPJ
 oMLO7TFGj0HoXco3qG8j1Jn7cs/eI+Rt/7MZfIJsuK4svyblQ7XPJcaMDDPoiyAqmKSS Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30vtexufcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 15:03:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048F1tew021973;
        Fri, 8 May 2020 15:03:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30vtecqgae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 15:03:44 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 048F3gAv009790;
        Fri, 8 May 2020 15:03:42 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 08:03:42 -0700
Subject: Re: [Jfs-discussion] [PATCH] JFS: Replace zero-length array with
 flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20200507185550.GA14715@embeddedor>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Autocrypt: addr=dave.kleikamp@oracle.com; prefer-encrypt=mutual; keydata=
 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
 rnNNL3zBkwD3nWcTxFnX
Message-ID: <141a7573-bd2a-4b89-e62b-8e18464071ae@oracle.com>
Date:   Fri, 8 May 2020 10:03:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507185550.GA14715@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Gustavo.

I have already merged this into jfs-next. It was all I had queued up and
I failed to push it in the last merge window to Linus. I'll make sure I
get it in the next one.

https://github.com/kleikamp/linux-shaggy/commits/jfs-next

Shaggy

On 5/7/20 1:55 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/jfs/jfs_dtree.c |    2 +-
>  fs/jfs/jfs_xattr.h |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
> index 3acc954f7c04..837d42f61464 100644
> --- a/fs/jfs/jfs_dtree.c
> +++ b/fs/jfs/jfs_dtree.c
> @@ -2964,7 +2964,7 @@ struct jfs_dirent {
>  	loff_t position;
>  	int ino;
>  	u16 name_len;
> -	char name[0];
> +	char name[];
>  };
>  
>  /*
> diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
> index f0558b3348da..c50167a7bc50 100644
> --- a/fs/jfs/jfs_xattr.h
> +++ b/fs/jfs/jfs_xattr.h
> @@ -17,12 +17,12 @@ struct jfs_ea {
>  	u8 flag;	/* Unused? */
>  	u8 namelen;	/* Length of name */
>  	__le16 valuelen;	/* Length of value */
> -	char name[0];	/* Attribute name (includes null-terminator) */
> +	char name[];	/* Attribute name (includes null-terminator) */
>  };			/* Value immediately follows name */
>  
>  struct jfs_ea_list {
>  	__le32 size;		/* overall size */
> -	struct jfs_ea ea[0];	/* Variable length list */
> +	struct jfs_ea ea[];	/* Variable length list */
>  };
>  
>  /* Macros for defining maxiumum number of bytes supported for EAs */
> 
> 
> 
> _______________________________________________
> Jfs-discussion mailing list
> Jfs-discussion@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/jfs-discussion
> 
