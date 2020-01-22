Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D538C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E01522522
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="QHk59WIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgAVS44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:56:56 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:44522 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729406AbgAVS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:56:53 -0500
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MIpHtM026802;
        Wed, 22 Jan 2020 18:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=84Eajc8JxqbYazZtCN5GzfxkyK5qDdC45vm26w6BCe0=;
 b=QHk59WIuSf9egIf+TMq65j4xc/5A+YUqM3SAkumEmZVJiK6reI0WOS5zUDqw7JoD6f7P
 ahEnoUWCi3nD2kbZnqEmpUUMhFcYOYFLZ5dXPPpwD2VqYZFhDoCyLrKLvIo4B8X0YQg/
 LToFJ51/FdEPqdBCJ8GplJMA7OXFlQ+o+r7Uxkyi7DA+TFXaoZwK4cHzEjDmI+g491MI
 et4wXbwOLONu3SyMU7HhXPTuOnZECMYWvRLFBADvpJG9E74EefpkT12rbH+J6dZDOFd9
 +12xfXJsyDscSqNCifrFhSMqwmVZR2dTcNXnK+PBXw+dLiIs+x/FL6Bm3TSDJNQwcKwm ZA== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2xkyudfspa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 18:56:49 +0000
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 00MIldnR029127;
        Wed, 22 Jan 2020 10:56:49 -0800
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 2xm0vbptk8-1;
        Wed, 22 Jan 2020 10:56:48 -0800
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id B20EF214B1;
        Wed, 22 Jan 2020 18:56:48 +0000 (GMT)
Subject: Re: [PATCH v2] dynamic_debug: allow to work if debugfs is disabled
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com> <20200122135352.GA9458@kroah.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
Date:   Wed, 22 Jan 2020 13:56:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122135352.GA9458@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001220159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/20 8:53 AM, Greg Kroah-Hartman wrote:
> 
> With the realization that having debugfs enabled on "production" systems is
> generally not a good idea, debugfs is being disabled from more and more
> platforms over time.  However, the functionality of dynamic debugging still is
> needed at times, and since it relies on debugfs for its user api, having
> debugfs disabled also forces dynamic debug to be disabled.
> 
> To get around this, move the "control" file for dynamic_debug to procfs IFF
> debugfs is disabled.  This lets people turn on debugging as needed at runtime
> for individual driverfs and subsystems.
> 

Hi Greg,

Thanks for updating this. Just a comment below.


> Reported-by: many different companies
> Cc: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: Fix up octal permissions and add procfs reference to the Kconfig
>     entry, thanks to Will for the review.
> 
>  .../admin-guide/dynamic-debug-howto.rst         |  3 +++
>  lib/Kconfig.debug                               |  7 ++++---
>  lib/dynamic_debug.c                             | 17 ++++++++++++++---
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 252e5ef324e5..41f43a373a6a 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
>  				<debugfs>/dynamic_debug/control
>    -bash: echo: write error: Invalid argument
>  
> +Note, for systems without 'debugfs' enabled, the control file can be
> +also found in ``/proc/dynamic_debug/control``.
> +
>  Viewing Dynamic Debug Behaviour
>  ===============================
>  
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5ffe144c9794..49980eb8c18e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -98,7 +98,7 @@ config DYNAMIC_DEBUG
>  	bool "Enable dynamic printk() support"
>  	default n
>  	depends on PRINTK
> -	depends on DEBUG_FS
> +	depends on (DEBUG_FS || PROC_FS)
>  	help
>  
>  	  Compiles debug level messages into the kernel, which would not
> @@ -116,8 +116,9 @@ config DYNAMIC_DEBUG
>  	  Usage:
>  
>  	  Dynamic debugging is controlled via the 'dynamic_debug/control' file,
> -	  which is contained in the 'debugfs' filesystem. Thus, the debugfs
> -	  filesystem must first be mounted before making use of this feature.
> +	  which is contained in the 'debugfs' filesystem or procfs if
> +	  debugfs is not present. Thus, the debugfs or procfs filesystem
> +	  must first be mounted before making use of this feature.
>  	  We refer the control file as: <debugfs>/dynamic_debug/control. This
>  	  file contains a list of the debug statements that can be enabled. The
>  	  format for each line of the file is:
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c60409138e13..0f1b26f10fb2 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -993,13 +993,24 @@ static __initdata int ddebug_init_success;
>  
>  static int __init dynamic_debug_init_debugfs(void)
>  {

The naming now is a little confusing - dynamic_debug_init_control ?


> -	struct dentry *dir;
> +	struct dentry *debugfs_dir;
> +	struct proc_dir_entry *procfs_dir;
>  
>  	if (!ddebug_init_success)
>  		return -ENODEV;
>  
> -	dir = debugfs_create_dir("dynamic_debug", NULL);
> -	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
> +	/* Create the control file in debugfs if it is enabled */
> +	if (debugfs_initialized) {
> +		debugfs_dir = debugfs_create_dir("dynamic_debug", NULL);
> +		debugfs_create_file("control", 0644, debugfs_dir, NULL,
> +				    &ddebug_proc_fops);
> +		return 0;
> +	}
> +
> +	/* No debugfs so put it in procfs instead */
> +	procfs_dir = proc_mkdir("dynamic_debug", NULL);
> +	if (procfs_dir)
> +		proc_create("control", 0644, procfs_dir, &ddebug_proc_fops);
>  
>  	return 0;
>  }
> 
