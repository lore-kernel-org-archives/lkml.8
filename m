Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A1C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 05:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BEA20746
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 05:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgELFry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 01:47:54 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:43038 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgELFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 01:47:54 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.074523|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0724473-0.00134074-0.926212;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.HXEAwpL_1589262465;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HXEAwpL_1589262465)
          by smtp.aliyun-inc.com(10.147.44.129);
          Tue, 12 May 2020 13:47:46 +0800
Subject: Re: [PATCH v8 01/11] pstore/zone: Introduce common layer to manage
 storage zones
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20200511233229.27745-1-keescook@chromium.org>
 <20200511233229.27745-2-keescook@chromium.org>
 <a9d47bf1-7498-1d07-a943-29dd0b0ef2e1@allwinnertech.com>
 <202005112212.2E75B83@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <57efa2b5-d598-a600-5f74-8fd81299fc58@allwinnertech.com>
Date:   Tue, 12 May 2020 13:47:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202005112212.2E75B83@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/5/12 PM 1:15, Kees Cook wrote:
> On Tue, May 12, 2020 at 11:55:20AM +0800, WeiXiong Liao wrote:
>> On 2020/5/12 AM 7:32, Kees Cook wrote:
>>> [...]
>>> +struct psz_context {
>>> +	struct pstore_zone **kpszs;
>>> +	unsigned int kmsg_max_cnt;
>>> +	unsigned int kmsg_read_cnt;
>>> +	unsigned int kmsg_write_cnt;
>>> +	/*
>>> +	 * These counters should be calculated during recovery.
>>> +	 * It records the oops/panic times after crashes rather than boots.
>>> +	 */
>>> +	unsigned int oops_counter;
>>> +	unsigned int panic_counter;
>>
>> oops/panic_counter is designed to count the crash times since the
>> linux kernel was installed. pstore/zone lookup the max counter from all
>> valid kmsg zones when recovery and saves them to oops/panic_counter.
>> However, they are unable to get real number if we remove files. It's
>> not serious, we can fix it after this series.
> 
> Since the kernel was installed? I don't see a kernel version check in
> here? Or do you mean "since ever", in that it's a rolling count?
> 

Yes, "since ever".

>> And since pstore supports "max_reason", should pstore/zone count for
>> other reason?
> 
> For now, no. I opted to try to keep this as simple as possible a port
> from dump_oops to max_reason for now.
> 

OK.

>>> +static inline int psz_kmsg_erase(struct psz_context *cxt,
>>> +		struct pstore_zone *zone, struct pstore_record *record)
>>> +{
>>> +	struct psz_buffer *buffer = zone->buffer;
>>> +	struct psz_kmsg_header *hdr =
>>> +		(struct psz_kmsg_header *)buffer->data;
>>> +
>>> +	if (unlikely(!psz_ok(zone)))
>>> +		return 0;
>>> +	/* this zone is already updated, no need to erase */
>>> +	if (record->count != hdr->counter)
>>> +		return 0;
>>
>> These codes is to fix bug that user remove files on pstore filesystem
>> but kmsg zone is already updated and pstore/zone should not erase
>> zone. It work for oops and panic because the count number is increasing.
>> However, it's useless for other reason of kmsg. We can fix it after this
>> series.
> 
> Okay, sounds good.
> 

-- 
WeiXiong Liao
