Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E320C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545D42070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CToSh1WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHJbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:31:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37648 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgEHJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:31:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0489KDOD099780;
        Fri, 8 May 2020 09:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UZ2ma67AX3lRvpseip2E11GzpNLI8lK74io02epYF/E=;
 b=CToSh1WHAGRDRcQA1nPPfiTLuX+deuWKH0cxtc3rFESAO8F7KyCX7Mj4lvXUYjQXt13N
 Zg/N4C7N5zBg7q7JOhjp9FKEMi+YoEiYrwqaymwqGNYcKSoPkFdy4oIJ+QtNaORqQcPY
 VksM+qezkjen8pyL2lZZNXPBs6iDD10pBGIfRISLxhhIF6LCCiiLHMcUCTm+NeHxz0XN
 d5j0DW4ghxs5M5ZjB/AYgkHsY3Q+Se90flVjO2iukMZ9OxWMQmn7ksI4ViDCdFfv3GPT
 enhc4rOUGIdJK+9Zzv8rM9KgpK9XHtxXFAeeker/+/1IbIT80L5NpjW1c5gPovOR9Qmm Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30vtepj2jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 09:31:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0489JvpK151688;
        Fri, 8 May 2020 09:31:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30vtdn8ga8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 09:31:09 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0489V69Y027596;
        Fri, 8 May 2020 09:31:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 02:31:06 -0700
Date:   Fri, 8 May 2020 12:30:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH v2] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <20200508093059.GF9365@kadam>
References: <189d719f-a8b8-6e10-ae2f-8120c3d2b7a9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189d719f-a8b8-6e10-ae2f-8120c3d2b7a9@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=896 bulkscore=0 phishscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=2 mlxscore=0
 mlxlogscore=926 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:51:15PM +0800, Yunfeng Ye wrote:
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 16b9a420e6fd..d034f86022b7 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -314,31 +314,33 @@ int apply_xbc(const char *path, const char *xbc_path)
>  	ret = delete_xbc(path);
>  	if (ret < 0) {
>  		pr_err("Failed to delete previous boot config: %d\n", ret);
> -		return ret;
> +		goto free_data;
>  	}
> 
>  	/* Apply new one */
>  	fd = open(path, O_RDWR | O_APPEND);
>  	if (fd < 0) {
>  		pr_err("Failed to open %s: %d\n", path, fd);
> -		return fd;
> +		ret = fd;
> +		goto free_data;
>  	}
>  	/* TODO: Ensure the @path is initramfs/initrd image */
>  	ret = write(fd, data, size + 8);
>  	if (ret < 0) {
>  		pr_err("Failed to apply a boot config: %d\n", ret);
> -		return ret;
> +		goto close_fd;
>  	}
>  	/* Write a magic word of the bootconfig */
>  	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);

write returns the number of bytes written on success

> -	if (ret < 0) {
> +	if (ret < 0)
>  		pr_err("Failed to apply a boot config magic: %d\n", ret);
> -		return ret;
> -	}
> +
> +close_fd:
>  	close(fd);
> +free_data:
>  	free(data);
> 
> -	return 0;
> +	return ret;

But we want to return zero on success.

>  }

Btw, these leaks are totally harmless.  This is a short running user
space program with is going to immediately exit on error so the memory
will be freed anyway.  But the benifit is to silence static checker
warnings so that's useful.

regards,
dan carpenter

