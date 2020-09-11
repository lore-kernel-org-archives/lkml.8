Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2621B2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YjpbUQGE";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ghks9whi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgIKCjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:39:10 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:58924
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgIKCjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599791948;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=GkhKFw9XmRuxNliwCF8Xn9NY+pcBGmdmA6bzddKVM6Q=;
        b=YjpbUQGEExAMu2nwxhgF8LVfp9iG/ykLURv5vMeT06wSaaGwqGe5hyxUMm9yi+0Y
        7iqzGdobJLmV85XuEeC8LAKiWV0wuUGGHJcqW0l5nZPEFdNTTWwXpX9MtSBcyLLqp1v
        COJ8bGadzrqjUhgDwKFuSX3tCL8sEpLfCycP6Kuo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599791948;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=GkhKFw9XmRuxNliwCF8Xn9NY+pcBGmdmA6bzddKVM6Q=;
        b=ghks9whi9DMlHN9Tm0XhUFXwl+CIOzx+zuzB3kk2A7vgUQlkqcCJ0fAtExOvqnZF
        +Jq1gCb4JKhglVUJBjXtSd4CJod90jJECHvDqP783PNVaHcc3vYB1OHW0+IGYzzt8qN
        VQTqvjWLOHt7wMrQ33ZSnxNWXnXg6mM+IklLIHrM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 407ECC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Fri, 11 Sep 2020 02:39:08 +0000
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, Randy Dunlap <rdunlap@infradead.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v10 04/24] coresight: add coresight prefix to barrier_pkt
Message-ID: <010101747b07e180-4022bb44-65df-41c4-af32-1e177843c0e4-000000@us-west-2.amazonses.com>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-5-tingwei@codeaurora.org>
 <20200910221918.GA590446@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910221918.GA590446@xps15>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.11-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 06:19:18AM +0800, Mathieu Poirier wrote:
> On Fri, Aug 21, 2020 at 11:44:25AM +0800, Tingwei Zhang wrote:
> > Add coresight prefix to make it specific. It will be a export symbol.
> > 
> > Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
> >  drivers/hwtracing/coresight/coresight-priv.h    | 8 ++++----
> >  drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
> >  drivers/hwtracing/coresight/coresight.c         | 2 +-
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etb10.c
> b/drivers/hwtracing/coresight/coresight-etb10.c
> > index 03e3f2590191..04ee9cda988d 100644
> > --- a/drivers/hwtracing/coresight/coresight-etb10.c
> > +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> > @@ -525,7 +525,7 @@ static unsigned long etb_update_buffer(struct
> coresight_device *csdev,
> >  
> >  	cur = buf->cur;
> >  	offset = buf->offset;
> > -	barrier = barrier_pkt;
> > +	barrier = coresight_barrier_pkt;
> >  
> >  	for (i = 0; i < to_read; i += 4) {
> >  		buf_ptr = buf->data_pages[cur] + offset;
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h
> b/drivers/hwtracing/coresight/coresight-priv.h
> > index d801a2755432..dcb8aeb6af62 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > @@ -66,8 +66,8 @@ static DEVICE_ATTR_RO(name)
> >  #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
> >  	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
> >  
> > -extern const u32 barrier_pkt[4];
> > -#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt))
> > +extern const u32 coresight_barrier_pkt[4];
> > +#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
> >  
> >  enum etm_addr_type {
> >  	ETM_ADDR_TYPE_NONE,
> > @@ -104,10 +104,10 @@ struct cs_buffers {
> >  static inline void coresight_insert_barrier_packet(void *buf)
> >  {
> >  	if (buf)
> > -		memcpy(buf, barrier_pkt, CORESIGHT_BARRIER_PKT_SIZE);
> > +		memcpy(buf, coresight_barrier_pkt,
> > +				CORESIGHT_BARRIER_PKT_SIZE);
> 
> Didn't I comment on this before?
> 
Sorry for missing below comment from you, Mathieu.
Indentation problem.

I'll fix it in v11.

Thanks,
Tingwei

> >  }
> >  
> > -
> >  static inline void CS_LOCK(void __iomem *addr)
> >  {
> >  	do {
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > index 6375504ba8b0..44402d413ebb 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > @@ -519,7 +519,7 @@ static unsigned long tmc_update_etf_buffer(struct
> coresight_device *csdev,
> >  
> >  	cur = buf->cur;
> >  	offset = buf->offset;
> > -	barrier = barrier_pkt;
> > +	barrier = coresight_barrier_pkt;
> >  
> >  	/* for every byte to read */
> >  	for (i = 0; i < to_read; i += 4) {
> > diff --git a/drivers/hwtracing/coresight/coresight.c
> b/drivers/hwtracing/coresight/coresight.c
> > index e9c90f2de34a..d515088cc47d 100644
> > --- a/drivers/hwtracing/coresight/coresight.c
> > +++ b/drivers/hwtracing/coresight/coresight.c
> > @@ -53,7 +53,7 @@ static struct list_head *stm_path;
> >   * beginning of the data collected in a buffer.  That way the decoder
> knows that
> >   * it needs to look for another sync sequence.
> >   */
> > -const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff,
> 0x7fffffff};
> > +const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff,
> 0x7fffffff, 0x7fffffff};
> >  
> >  static int coresight_id_match(struct device *dev, void *data)
> >  {
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> > a Linux Foundation Collaborative Project
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
