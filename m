Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3CEC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A7921927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgBZBBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:01:38 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7225 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729277AbgBZBBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:01:37 -0500
X-IronPort-AV: E=Sophos;i="5.70,486,1574092800"; 
   d="scan'208";a="84133954"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Feb 2020 09:01:34 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 38EBC50A9984;
        Wed, 26 Feb 2020 08:51:50 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 26 Feb 2020 09:01:31 +0800
Message-ID: <5E55C36B.1060601@cn.fujitsu.com>
Date:   Wed, 26 Feb 2020 09:01:31 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>
Subject: Re: [PATCH] tools/perf/util/*.c: Use "%zd" output format for size_t
 type
References: <20200225063901.20165-1-yangx.jy@cn.fujitsu.com> <37831d22bd91f9694f7b35be158969fb997cc544.camel@perches.com>
In-Reply-To: <37831d22bd91f9694f7b35be158969fb997cc544.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 38EBC50A9984.A8B18
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/26 7:02, Joe Perches wrote:
> On Tue, 2020-02-25 at 14:39 +0800, Xiao Yang wrote:
>> Avoid the following errors when building perf:
>> -----------------------------------------------
>> util/session.c: In function 'perf_session__process_compressed_event':
>> util/session.c:91:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
>>    pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> []
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> []
>> @@ -88,7 +88,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>>   		session->decomp_last = decomp;
>>   	}
>>
>> -	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
>> +	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
> likely better as %zu, etc...
Hi,

Sorry,  %zu is obvious better.
I will send v2 patch shortly.

Thanks,
Xiao Yang
>
>
>
> .
>



