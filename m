Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C70C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE0A2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582724299;
	bh=oA03jUi1a6+9dCg70wVVRpcCMy+Ziqvqh48sOuUaMVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PBfp4OVsFcken/y9rkdC4Ot3rpeKzrNC47qvuVkzDa2SBj9J0jLjuDq2SExeBKPch
	 4uu118zRNvLevEGS+FpFGzXa1AMwzgA3mkjm9ZhwGPfvhXjbL8YfazVJJ4KooQOEgP
	 F0wapKs84GSawkYDXrG5GK0JynTFA3A5O/0N9FWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBZNiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZNiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:38:18 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519D124685;
        Wed, 26 Feb 2020 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582724297;
        bh=oA03jUi1a6+9dCg70wVVRpcCMy+Ziqvqh48sOuUaMVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nx/mNR6d3Y5ypFfSpr66Sd+2eVCIgj2/gL0r3NpsHT0lD3bHykwNzX84z4RRkr0H+
         N3tGpCHZPQ39DFpz6pgQc564hrq5yRS1riGF8ci/4H5uaFSvR0RczyvUmRc8M562Ue
         qpaiI1yM+X6wDgT+OpIFkQJHGz0KylN77LOv1c7g=
Date:   Wed, 26 Feb 2020 14:38:13 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] modpost: rework and consolidate logging interface
Message-ID: <20200226133812.GA20449@linux-8ccs>
References: <20200225173526.9617-1-jeyu@kernel.org>
 <635523a920bcc317eaf48230f003cd050f51c9bb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <635523a920bcc317eaf48230f003cd050f51c9bb.camel@perches.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Joe Perches [25/02/20 14:30 -0800]:
>On Tue, 2020-02-25 at 18:35 +0100, Jessica Yu wrote:
>> Rework modpost's logging interface by consolidating merror(), warn(),
>> and fatal() to use a single function, modpost_log(). Introduce different
>> logging levels (WARN, ERROR, FATAL) as well as a conditional warn
>> (warn_unless()). The conditional warn is useful in determining whether
>> to use merror() or warn() based on a condition. This reduces code
>> duplication overall.
>[]
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>[]
>> @@ -51,41 +51,39 @@ enum export {
>>
>>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>>
>> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
>> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>>
>> -PRINTF void fatal(const char *fmt, ...)
>> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>>  {
>> +	char *level = NULL;
>>  	va_list arglist;
>>
>> -	fprintf(stderr, "FATAL: ");
>> +	switch(loglevel) {
>> +	case(LOG_WARN):
>> +		level = "WARNING: ";
>> +		break;
>> +	case(LOG_ERROR):
>> +		level = "ERROR: ";
>> +		break;
>> +	case(LOG_FATAL):
>> +		level = "FATAL: ";
>> +		break;
>> +	default: /* invalid loglevel, ignore */
>> +		break;
>
>Odd parentheses around case labels and
>likely level should be initialized as ""
>and not NULL.
>
>	const char *level = "";
>	...
>	switch (loglevel) {
>	case LOG_WARN:
>		level = "WARNING: ";
>		break;
>	...
>	}
>
>

Thanks for the review! Will fix this in v2 shortly.


