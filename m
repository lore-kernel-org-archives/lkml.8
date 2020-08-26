Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A880C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C2C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgHZNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:24:03 -0400
Received: from foss.arm.com ([217.140.110.172]:46302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHZNYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:24:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BE35101E;
        Wed, 26 Aug 2020 06:24:01 -0700 (PDT)
Received: from [10.57.5.66] (unknown [10.57.5.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E74D3F68F;
        Wed, 26 Aug 2020 06:23:59 -0700 (PDT)
Subject: Re: [PATCH] perf inject: correct event attribute sizes
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, Denis Nikitin <denik@google.com>
References: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
 <20200826112745.GB43491@C02TD0UTHF1T.local>
From:   Al Grant <al.grant@foss.arm.com>
Message-ID: <9a48bd74-42ad-4498-7f38-aed560031c4e@foss.arm.com>
Date:   Wed, 26 Aug 2020 14:23:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20200826112745.GB43491@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2020 12:27, Mark Rutland wrote:
> On Wed, Aug 26, 2020 at 10:42:04AM +0100, Al Grant wrote:
>> When perf inject reads a perf.data file from an older version of perf,
>> it writes event attributes into the output with the original size field,
>> but lays them out as if they had the size currently used. Readers see
>> a corrupt file. Update the size field to match the layout.
>>
>> From: Denis Nikitin <denik@google.com>
>> Signed-off-by: Al Grant <al.grant@foss.arm.com>
> 
> Did Denis write this patch?

Joint work - I fixed the sizes in the event attributes section,
but Denis noticed that the copies in HEADER_EVENT_DESC also need
fixing, so the final text is his.

> If so, we need an S-o-B line from them.

I have his approval to upstream this, so:

Signed-off-by: Denis Nikitin <denik@google.com>

Al


> 
> Mark.
> 
>>   tools/perf/util/header.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 9cf4efdcbbbd..762eb94bd532 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -3326,6 +3326,14 @@ int perf_session__write_header(struct
>> perf_session *session,
>>          attr_offset = lseek(ff.fd, 0, SEEK_CUR);
>>
>>          evlist__for_each_entry(evlist, evsel) {
>> +               if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
>> +                       /*
>> +                        * We are likely in "perf inject" and have read +
>> * from an older file. Update attr size so that
>> +                        * reader gets the right offset to the ids.
>> +                        */
>> +                       evsel->core.attr.size = sizeof(evsel->core.attr);
>> +               }
>>                  f_attr = (struct perf_file_attr){
>>                          .attr = evsel->core.attr,
>>                          .ids  = {
