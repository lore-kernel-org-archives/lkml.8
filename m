Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A4C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE79A225AA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Bk2NQv1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgGNSNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:13:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36192 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgGNSNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:13:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594750393; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UjPUFQ1EtLebHvthn1YqzmWPP5W/lmX2Xc528+THCzw=;
 b=Bk2NQv1KsA+35bqhc6lCEGFQwSxc98zT6HVzTWJaioq4AwTkn73OVxcs41p1kkL2ZEmZNYB8
 TtISmBZwZa1XBljUhkAWpXG0FFLDcglzO/BUi0jerXJe/vpBWmEpBWheEmMErAsBkj69XkPm
 wYJvwgA9o1naYs9WTfq0kdV6WtQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f0df5a9e3bee12510706f14 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 18:12:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0D9EC433C8; Tue, 14 Jul 2020 18:12:55 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F043C433CA;
        Tue, 14 Jul 2020 18:12:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jul 2020 23:42:49 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v1 2/4] remoteproc: qcom_q6v5_mss: Replace mask based
 tracking with size
In-Reply-To: <20200714171836.GA1407705@xps15>
References: <1594326716-15474-1-git-send-email-rishabhb@codeaurora.org>
 <1594326716-15474-3-git-send-email-rishabhb@codeaurora.org>
 <20200714171836.GA1407705@xps15>
Message-ID: <a069385c747dda15fa7f037ae2930aee@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-14 22:48, Mathieu Poirier wrote:
> On Thu, Jul 09, 2020 at 01:31:54PM -0700, Rishabh Bhatnagar wrote:
>> From: Sibi Sankar <sibis@codeaurora.org>
>> 
>> In order to land inline coredump support for mss, the dump_segment
>> function would need to support granularities less than the segment
>> size. This is achieved by replacing mask based tracking with size.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  drivers/remoteproc/qcom_q6v5_mss.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c 
>> b/drivers/remoteproc/qcom_q6v5_mss.c
>> index feb70283b..c6ce032 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -181,8 +181,8 @@ struct q6v5 {
>>  	bool running;
>> 
>>  	bool dump_mba_loaded;
>> -	unsigned long dump_segment_mask;
>> -	unsigned long dump_complete_mask;
>> +	size_t current_dump_size;
>> +	size_t total_dump_size;
>> 
>>  	phys_addr_t mba_phys;
>>  	void *mba_region;
>> @@ -1203,7 +1203,6 @@ static void qcom_q6v5_dump_segment(struct rproc 
>> *rproc,
>>  {
>>  	int ret = 0;
>>  	struct q6v5 *qproc = rproc->priv;
>> -	unsigned long mask = BIT((unsigned long)segment->priv);
>>  	int offset = segment->da - qproc->mpss_reloc;
>>  	void *ptr = NULL;
>> 
>> @@ -1229,10 +1228,10 @@ static void qcom_q6v5_dump_segment(struct 
>> rproc *rproc,
>>  		memset(dest, 0xff, segment->size);
>>  	}
>> 
>> -	qproc->dump_segment_mask |= mask;
>> +	qproc->current_dump_size += segment->size;
>> 
>>  	/* Reclaim mba after copying segments */
>> -	if (qproc->dump_segment_mask == qproc->dump_complete_mask) {
>> +	if (qproc->current_dump_size == qproc->total_dump_size) {
>>  		if (qproc->dump_mba_loaded) {
>>  			/* Try to reset ownership back to Q6 */
>>  			q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
>> @@ -1274,7 +1273,7 @@ static int q6v5_start(struct rproc *rproc)
>>  			"Failed to reclaim mba buffer system may become unstable\n");
>> 
>>  	/* Reset Dump Segment Mask */
>> -	qproc->dump_segment_mask = 0;
>> +	qproc->current_dump_size = 0;
>>  	qproc->running = true;
>> 
>>  	return 0;
>> @@ -1323,7 +1322,7 @@ static int 
>> qcom_q6v5_register_dump_segments(struct rproc *rproc,
>> 
>>  	ehdr = (struct elf32_hdr *)fw->data;
>>  	phdrs = (struct elf32_phdr *)(ehdr + 1);
>> -	qproc->dump_complete_mask = 0;
>> +	qproc->total_dump_size = 0;
>> 
>>  	for (i = 0; i < ehdr->e_phnum; i++) {
>>  		phdr = &phdrs[i];
>> @@ -1338,7 +1337,7 @@ static int 
>> qcom_q6v5_register_dump_segments(struct rproc *rproc,
>>  		if (ret)
>>  			break;
> 
> There is also no longer a need to carry the 'i' in:
> 
>                 ret = rproc_coredump_add_custom_segment(rproc, 
> phdr->p_paddr,
>                                                         phdr->p_memsz,
>                                                         
> qcom_q6v5_dump_segment,
>                                                         (void *)i);

Mathieu,
Thanks for the review. Will pass in
NULL instead in the next re-spin.

>> 
>> -		qproc->dump_complete_mask |= BIT(i);
>> +		qproc->total_dump_size += phdr->p_memsz;
>>  	}
>> 
>>  	release_firmware(fw);
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
