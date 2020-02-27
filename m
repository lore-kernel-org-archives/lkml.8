Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8D3C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3524688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgB0PJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:09:49 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:33484 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbgB0PJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:09:49 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RF6iK0023731;
        Thu, 27 Feb 2020 15:09:32 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2yeerrrwp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 15:09:32 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 3173D91;
        Thu, 27 Feb 2020 15:09:31 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id B3A9637;
        Thu, 27 Feb 2020 15:09:30 +0000 (UTC)
Date:   Thu, 27 Feb 2020 09:09:30 -0600
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dimitri Sivanich <sivanich@sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Replace zero-length array with flexible-array
 member
Message-ID: <20200227150930.GA16632@hpe.com>
References: <20200226222240.GA14474@embeddedor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226222240.GA14474@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_04:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:22:40PM -0600, Gustavo A. R. Silva wrote:
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
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

> ---
>  drivers/misc/mei/hw.h            | 2 +-
>  drivers/misc/mei/mei_dev.h       | 2 +-
>  drivers/misc/sgi-gru/grulib.h    | 2 +-
>  drivers/misc/sgi-gru/grutables.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
> index 8231b6941adf..b1a8d5ec88b3 100644
> --- a/drivers/misc/mei/hw.h
> +++ b/drivers/misc/mei/hw.h
> @@ -216,7 +216,7 @@ struct mei_msg_hdr {
>  
>  struct mei_bus_message {
>  	u8 hbm_cmd;
> -	u8 data[0];
> +	u8 data[];
>  } __packed;
>  
>  /**
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
> index 76f8ff5ff974..3a29db07211d 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -533,7 +533,7 @@ struct mei_device {
>  #endif /* CONFIG_DEBUG_FS */
>  
>  	const struct mei_hw_ops *ops;
> -	char hw[0] __aligned(sizeof(void *));
> +	char hw[] __aligned(sizeof(void *));
>  };
>  
>  static inline unsigned long mei_secs_to_jiffies(unsigned long sec)
> diff --git a/drivers/misc/sgi-gru/grulib.h b/drivers/misc/sgi-gru/grulib.h
> index e77d1b1f9d05..85c103923632 100644
> --- a/drivers/misc/sgi-gru/grulib.h
> +++ b/drivers/misc/sgi-gru/grulib.h
> @@ -136,7 +136,7 @@ struct gru_dump_context_header {
>  	pid_t		pid;
>  	unsigned long	vaddr;
>  	int		cch_locked;
> -	unsigned long	data[0];
> +	unsigned long	data[];
>  };
>  
>  /*
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index a7e44b2eb413..5ce8f3081e96 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -372,7 +372,7 @@ struct gru_thread_state {
>  	int			ts_data_valid;	/* Indicates if ts_gdata has
>  						   valid data */
>  	struct gru_gseg_statistics ustats;	/* User statistics */
> -	unsigned long		ts_gdata[0];	/* save area for GRU data (CB,
> +	unsigned long		ts_gdata[];	/* save area for GRU data (CB,
>  						   DS, CBE) */
>  };
>  
> -- 
> 2.25.0
> 
