Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C5C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076A12078E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgEKPDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:03:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbgEKPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:03:46 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3CEBA7F2CD3F1CC8B4DC;
        Mon, 11 May 2020 16:03:44 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 11 May
 2020 16:03:40 +0100
Subject: Re: [PATCH RFC v3 02/12] perf jevents: Add support for system events
 tables
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <qiangqing.zhang@nxp.com>, <irogers@google.com>,
        <robin.murphy@arm.com>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-3-git-send-email-john.garry@huawei.com>
 <20200511110137.GC2986380@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9f4ea413-325f-98b4-eb4c-e47aead4f455@huawei.com>
Date:   Mon, 11 May 2020 16:02:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200511110137.GC2986380@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.142]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 12:01, Jiri Olsa wrote:
> On Thu, May 07, 2020 at 07:57:41PM +0800, John Garry wrote:
> 
> SNIP
> 
>> +				      &sys_event_tables);
>> +		}
>> +
>>   		print_events_table_prefix(eventsfp, tblname);
>>   		return 0;
>>   	}
>> @@ -1180,7 +1253,6 @@ int main(int argc, char *argv[])
>>   	} else if (rc < 0) {
>>   		/* Make build fail */
>>   		fclose(eventsfp);
>> -		free_arch_std_events();
>>   		ret = 1;
>>   		goto out_free_mapfile;
>>   	} else if (rc) {
>> @@ -1206,27 +1278,31 @@ int main(int argc, char *argv[])
>>   	if (close_table)
>>   		print_events_table_suffix(eventsfp);
>>   
>> -	if (!mapfile) {
>> -		pr_info("%s: No CPU->JSON mapping?\n", prog);
>> -		goto empty_map;
>> +	if (mapfile) {
>> +		if (process_mapfile(eventsfp, mapfile)) {
>> +			pr_err("%s: Error processing mapfile %s\n", prog,
>> +			       mapfile);
>> +			/* Make build fail */
>> +			fclose(eventsfp);
>> +			ret = 1;
>> +		}
>> +	} else {
>> +		pr_err("%s: No CPU->JSON mapping?\n", prog);
> 
> shouldn't we jump to empty_map in here? there still needs to be a
> mapfile, right?

In theory we could only support sys events :)

But I'll now make this a (empty map) failure case. And I think that 
another error case handling needs fixing in my patch.


As for this:

  +	fprintf(outfp, "struct pmu_sys_events pmu_sys_event_tables[] = {");
 >> +
 >> +	list_for_each_entry(sys_event_table, &sys_event_tables, list) {
 >> +		fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
 >> +			sys_event_table->name);
 >> +	}
 >> +	fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");
 >
 > this will add extra tabs:
 >
 >          {
 >                  .table = 0
 >          },
 >
 > while the rest of the file starts items without any indent
 >

I'll ensure the indent is the same.

BTW, is there anything to be said for removing the empty map feature 
(and always breaking the perf build instead)? I guess that it was just 
an early feature for dealing with unstable JSONs.

Thanks,
john

> 
> jirka
> 
>>   	}
>>   
>> -	if (process_mapfile(eventsfp, mapfile)) {
>> -		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
>> -		/* Make build fail */
>> +	if (process_system_event_tables(eventsfp)) {
>>   		fclose(eventsfp);
>> -		free_arch_std_events();
>>   		ret = 1;
>>   	}
>>   
>> -
>>   	goto out_free_mapfile;
>>   
>>   empty_map:
>>   	fclose(eventsfp);
>>   	create_empty_mapping(output_file);
>> -	free_arch_std_events();
>>   out_free_mapfile:
>> +	free_arch_std_events();
>> +	free_sys_event_tables();
>>   	free(mapfile);
>>   	return ret;
>>   }
> 
> SNIP
> 
> .
> 

