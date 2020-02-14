Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAC4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1104222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgBNNTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:19:15 -0500
Received: from mail.windriver.com ([147.11.1.11]:50844 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgBNNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:19:14 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 01EDHVwX002356
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 14 Feb 2020 05:17:32 -0800 (PST)
Received: from [128.224.162.175] (128.224.162.175) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 14 Feb
 2020 05:17:30 -0800
Subject: Re: [PATCH] tools lib traceevent: Take care of return value of
 asprintf
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <rostedt@goodmis.org>, <tstoyanov@vmware.com>,
        <hewenliang4@huawei.com>, <linux-kernel@vger.kernel.org>
References: <1581665486-20386-1-git-send-email-zhe.he@windriver.com>
 <20200214125754.GA2974@redhat.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <076aa690-3781-97b4-7850-5ec0e2f5e13e@windriver.com>
Date:   Fri, 14 Feb 2020 21:17:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214125754.GA2974@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.175]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/20 8:57 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 14, 2020 at 03:31:26PM +0800, zhe.he@windriver.com escreveu:
>> From: He Zhe <zhe.he@windriver.com>
>>
>> According to the API, if memory allocation wasn't possible, or some other
>> error occurs, asprintf will return -1, and the contents of strp below are
>> undefined.
>>
>> int asprintf(char **strp, const char *fmt, ...);
>>
>> This patch takes care of return value of asprintf to make it less error
>> prone and prevent the following build warning.
>>
>> ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]
> Sure this fixes problems, but can you make it more compact, i.e. no need
> to add most if not all those 'int ret;' lines, just check the asprintf
> result directly, i.e.:
>
>                              if (asprintf(&str, val ? "TRUE" : "FALSE") < 0)
>                                      str = NULL;
>
> saving the return value for that function is interesting when you need
> to know how many bytes it printed to do some extra calculation, but if
> all you need is to know if it failed, checking against < 0 is enough,
> no?

OK. Thanks. I'll send v2.

Zhe

>
> - Arnaldo
>
>  
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>>  tools/lib/traceevent/parse-filter.c | 42 +++++++++++++++++++++++++++++--------
>>  1 file changed, 33 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
>> index 20eed71..279b572 100644
>> --- a/tools/lib/traceevent/parse-filter.c
>> +++ b/tools/lib/traceevent/parse-filter.c
>> @@ -1912,6 +1912,7 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>>  	int left_val = -1;
>>  	int right_val = -1;
>>  	int val;
>> +	int ret;
>>  
>>  	switch (arg->op.type) {
>>  	case TEP_FILTER_OP_AND:
>> @@ -1958,7 +1959,9 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>>  				default:
>>  					break;
>>  				}
>> -				asprintf(&str, val ? "TRUE" : "FALSE");
>> +				ret = asprintf(&str, val ? "TRUE" : "FALSE");
>> +				if (ret < 0)
>> +					str = NULL;
>>  				break;
>>  			}
>>  		}
>> @@ -1976,7 +1979,9 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>>  			break;
>>  		}
>>  
>> -		asprintf(&str, "(%s) %s (%s)", left, op, right);
>> +		ret = asprintf(&str, "(%s) %s (%s)", left, op, right);
>> +		if (ret < 0)
>> +			str = NULL;
>>  		break;
>>  
>>  	case TEP_FILTER_OP_NOT:
>> @@ -1992,10 +1997,14 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>>  			right_val = 0;
>>  		if (right_val >= 0) {
>>  			/* just return the opposite */
>> -			asprintf(&str, right_val ? "FALSE" : "TRUE");
>> +			ret = asprintf(&str, right_val ? "FALSE" : "TRUE");
>> +			if (ret < 0)
>> +				str = NULL;
>>  			break;
>>  		}
>> -		asprintf(&str, "%s(%s)", op, right);
>> +		ret = asprintf(&str, "%s(%s)", op, right);
>> +		if (ret < 0)
>> +			str = NULL;
>>  		break;
>>  
>>  	default:
>> @@ -2010,8 +2019,11 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>>  static char *val_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
>>  {
>>  	char *str = NULL;
>> +	int ret;
>>  
>> -	asprintf(&str, "%lld", arg->value.val);
>> +	ret = asprintf(&str, "%lld", arg->value.val);
>> +	if (ret < 0)
>> +		str = NULL;
>>  
>>  	return str;
>>  }
>> @@ -2027,6 +2039,7 @@ static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>>  	char *rstr;
>>  	char *op;
>>  	char *str = NULL;
>> +	int ret;
>>  
>>  	lstr = arg_to_str(filter, arg->exp.left);
>>  	rstr = arg_to_str(filter, arg->exp.right);
>> @@ -2069,7 +2082,9 @@ static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>>  		break;
>>  	}
>>  
>> -	asprintf(&str, "%s %s %s", lstr, op, rstr);
>> +	ret = asprintf(&str, "%s %s %s", lstr, op, rstr);
>> +	if (ret < 0)
>> +		str = NULL;
>>  out:
>>  	free(lstr);
>>  	free(rstr);
>> @@ -2083,6 +2098,7 @@ static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>>  	char *rstr;
>>  	char *str = NULL;
>>  	char *op = NULL;
>> +	int ret;
>>  
>>  	lstr = arg_to_str(filter, arg->num.left);
>>  	rstr = arg_to_str(filter, arg->num.right);
>> @@ -2113,7 +2129,9 @@ static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>>  		if (!op)
>>  			op = "<=";
>>  
>> -		asprintf(&str, "%s %s %s", lstr, op, rstr);
>> +		ret = asprintf(&str, "%s %s %s", lstr, op, rstr);
>> +		if (ret < 0)
>> +			str = NULL;
>>  		break;
>>  
>>  	default:
>> @@ -2131,6 +2149,7 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>>  {
>>  	char *str = NULL;
>>  	char *op = NULL;
>> +	int ret;
>>  
>>  	switch (arg->str.type) {
>>  	case TEP_FILTER_CMP_MATCH:
>> @@ -2148,8 +2167,10 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>>  		if (!op)
>>  			op = "!~";
>>  
>> -		asprintf(&str, "%s %s \"%s\"",
>> +		ret = asprintf(&str, "%s %s \"%s\"",
>>  			 arg->str.field->name, op, arg->str.val);
>> +		if (ret < 0)
>> +			str = NULL;
>>  		break;
>>  
>>  	default:
>> @@ -2162,10 +2183,13 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>>  static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
>>  {
>>  	char *str = NULL;
>> +	int ret;
>>  
>>  	switch (arg->type) {
>>  	case TEP_FILTER_ARG_BOOLEAN:
>> -		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
>> +		ret = asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
>> +		if (ret < 0)
>> +			str = NULL;
>>  		return str;
>>  
>>  	case TEP_FILTER_ARG_OP:
>> -- 
>> 2.7.4

