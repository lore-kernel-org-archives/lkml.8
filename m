Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E125C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6FF20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9oQ7pXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgIJWTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:19:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72653C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:19:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so5625895pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dvP7V0T9HkPbDpdUEFrDiOxvK8qa0XZPhS3F7Oqqwxc=;
        b=R9oQ7pXA/c0lZeV14Dm7qqv6025jr49V/L1ldKLzpy+F47pYVsRbYMi9o9BXpRn/X3
         eOmVjGtmQbGT1RiVVmcWdD/nT6o/4OqDmzIHu/1ev+HJPik4Dwu4R3XQtu/djxigj/GS
         sBLOuUm/PTrXXRudrPYTkU4lUNrj/WU2rDPVrWeun5p8YlnvMu45WOdb6cPSktjXZ1hE
         URPvOfZEZaqMJcYMSw6KMyCeXtDEjE83Q1QFr8+4uIlR5vTciOdB9pAXZWD68vxdrZj0
         M3wV2LFUV8P0fa0hnKeAhzx3QrwB/zDwa2k6lP3SnFCpYmtlumrxcoLvutc3eLNUCSIL
         GdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dvP7V0T9HkPbDpdUEFrDiOxvK8qa0XZPhS3F7Oqqwxc=;
        b=qZtvAa4DLclWa34JUZIMS5SYtY5RFEtpSojKEwczQO9o9TQvIZKK3H0VhrHsJLWfuh
         IBzVz1YpyMANWF+c33JIICNK6d1NpZJ4CY90ooGneOMPeOQHa4WM/hKxNDXTDmxdVdwH
         auXgcTcDrFwKFOW9WpVbJhh+WEQA7bmN2Powi0Ui7weqTJUAm3hsUqyM8gWVBX6Thtri
         uY3NlvxuAS+3LoGkuPZDnEysM9l52zmtKB4RgZx5/O64p4HlwFiRbtLJekEewBJynhPs
         nKkd4Na9Cu8hIxx7BBtJaeN0tu6xR1wAbkiSOm1SO+pm8N0kQ1tbT9sdgF43ooQunaGk
         tZpw==
X-Gm-Message-State: AOAM532/XPt2kob97rRMOQ/5+LGCuYWdCyitekM7HsiFQnu7A1/v4ypC
        sHKN1a1HiMRPpxFDO7r1cetD/A==
X-Google-Smtp-Source: ABdhPJygb86nqLNOdHUeLvSSD8F9QRsi74sX874rMXt7ADW2ahqSMeoeuC+z4gOp5BNrGyVqwdrKRA==
X-Received: by 2002:a62:dd01:0:b029:13c:f607:5fff with SMTP id w1-20020a62dd010000b029013cf6075fffmr7372214pff.3.1599776360917;
        Thu, 10 Sep 2020 15:19:20 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id gk14sm42292pjb.41.2020.09.10.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 15:19:20 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:19:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 04/24] coresight: add coresight prefix to barrier_pkt
Message-ID: <20200910221918.GA590446@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-5-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034445.967-5-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:25AM +0800, Tingwei Zhang wrote:
> Add coresight prefix to make it specific. It will be a export symbol.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
>  drivers/hwtracing/coresight/coresight-priv.h    | 8 ++++----
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>  drivers/hwtracing/coresight/coresight.c         | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 03e3f2590191..04ee9cda988d 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -525,7 +525,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
>  
>  	cur = buf->cur;
>  	offset = buf->offset;
> -	barrier = barrier_pkt;
> +	barrier = coresight_barrier_pkt;
>  
>  	for (i = 0; i < to_read; i += 4) {
>  		buf_ptr = buf->data_pages[cur] + offset;
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index d801a2755432..dcb8aeb6af62 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -66,8 +66,8 @@ static DEVICE_ATTR_RO(name)
>  #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
>  	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
>  
> -extern const u32 barrier_pkt[4];
> -#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt))
> +extern const u32 coresight_barrier_pkt[4];
> +#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
>  
>  enum etm_addr_type {
>  	ETM_ADDR_TYPE_NONE,
> @@ -104,10 +104,10 @@ struct cs_buffers {
>  static inline void coresight_insert_barrier_packet(void *buf)
>  {
>  	if (buf)
> -		memcpy(buf, barrier_pkt, CORESIGHT_BARRIER_PKT_SIZE);
> +		memcpy(buf, coresight_barrier_pkt,
> +				CORESIGHT_BARRIER_PKT_SIZE);

Didn't I comment on this before?

>  }
>  
> -
>  static inline void CS_LOCK(void __iomem *addr)
>  {
>  	do {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 6375504ba8b0..44402d413ebb 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -519,7 +519,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  
>  	cur = buf->cur;
>  	offset = buf->offset;
> -	barrier = barrier_pkt;
> +	barrier = coresight_barrier_pkt;
>  
>  	/* for every byte to read */
>  	for (i = 0; i < to_read; i += 4) {
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index e9c90f2de34a..d515088cc47d 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -53,7 +53,7 @@ static struct list_head *stm_path;
>   * beginning of the data collected in a buffer.  That way the decoder knows that
>   * it needs to look for another sync sequence.
>   */
> -const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
> +const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
>  
>  static int coresight_id_match(struct device *dev, void *data)
>  {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
