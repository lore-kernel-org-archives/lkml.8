Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93524C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9AC20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgBJQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:23:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2404 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbgBJQXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:23:00 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 799985B6A78DA43BBA1D;
        Mon, 10 Feb 2020 16:22:58 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Feb 2020 16:22:58 +0000
Received: from [127.0.0.1] (10.202.227.179) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 10 Feb
 2020 16:22:57 +0000
Subject: Re: [PATCH RFC 5/7] perf pmu: Support matching by sysid
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-6-git-send-email-john.garry@huawei.com>
 <20200210120759.GG1907700@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <63799909-067b-e5f4-dcf1-9ba1ec145348@huawei.com>
Date:   Mon, 10 Feb 2020 16:22:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200210120759.GG1907700@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jirka,

> 
>> +		fclose(file);
>> +		pr_debug("gets failed for file %s\n", path);
>> +		free(buf);
>> +		return NULL;
>> +	}
>> +	fclose(file);
>> +
>> +	/* Remove any whitespace, this could be from ACPI HID */
>> +	s = strlen(buf);
>> +	for (i = 0; i < s; i++) {
>> +		if (buf[i] == ' ') {
>> +			buf[i] = 0;
>> +			break;
>> +		};
>> +	}
>> +
>> +	return buf;
>> +}
>> +

I have another series to add kernel support for a system identifier 
sysfs entry, which I sent after this series:

https://lore.kernel.org/linux-acpi/1580210059-199540-1-git-send-email-john.garry@huawei.com/

It is different to what I am relying on here - it uses a kernel soc 
driver for firmware ACPI PPTT identifier. Progress is somewhat blocked 
at the moment however and I may have to use a different method:

https://lore.kernel.org/linux-acpi/20200128123415.GB36168@bogus/

>> +static char *perf_pmu__getsysid(void)
>> +{
>> +	char *sysid;
>> +	static bool printed;
>> +
>> +	sysid = getenv("PERF_SYSID");
>> +	if (sysid)
>> +		sysid = strdup(sysid);
>> +
>> +	if (!sysid)
>> +		sysid = get_sysid_str();
>> +	if (!sysid)
>> +		return NULL;
>> +
>> +	if (!printed) {
>> +		pr_debug("Using SYSID %s\n", sysid);
>> +		printed = true;
>> +	}
>> +	return sysid;
>> +}
> 
> this part is getting complicated and AFAIK we have no tests for it
> 
> if you could think of any tests that'd be great.. Perhaps we could
> load 'our' json test files and check appropriate events/aliasses
> via in pmu object.. or via parse_events interface.. those test aliases
> would have to be part of perf, but we have tests compiled in anyway

Sorry, I don't fully follow.

Are you suggesting that we could load the specific JSONs tables for a 
system from the host filesystem?

Thanks,
John
