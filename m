Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37B4C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020A2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="fuBCG49b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCYNGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:06:08 -0400
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:38613
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbgCYNGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma6s26joFKJxeQHe4sjATZ89a//jU0fRhen/theLf/HXcVrJ2Lmy+wvbISwoP2tm9al65SFEZLLLMdyqN7wZryUvWV57XfHWiAIObF2RadT+7q7BCPYiV+0oUXd88A3KTdwLvnfj98JZbZL36KeoL8y8tw/YEhWWjU+u+db3EU8npjovCwVO8+mSk12c3iaJcOjYa6HsKfCOxVdLOhrijodeVyYSaoeXDI99AEiF5ZgKxyGbQiwvTgQgBgvr8dPHQoCNaeD6Gx1FEqVBTdTf1tBZfXH4RWdMhCZx58b3v6xSWwTlmnhIhUzO3W0YC72et7IrUtnAmM+rvVYX3mHlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOxNvilnHznOlLSFz3cUUZVaeWXYT15Uz3u7DtFu4Xs=;
 b=AH+q8bHmTTOSlcyBHKgbC1C4tOD3htdM8WDSgH+5YlPb1LHwwMW/WQY8tdgV+aQ6y0V6dfCuYpxWN7Nm71UW3+PerXLzfFYMX2AHXwYmRJEGJgT/QD3qBNh2AZaLm3GXkdyBFRBR0fTgNIKa0x5+KWTtRrxXj6DMxrvXAXt4hT0yPhrIZFNNMVtkXnrg+N9xg9bAxBaHzoh+n7UEyDT+HG7a2Sy6Z5I3i+ujUhQkJKYtNvdnbFa6AA8VnwKvIGGx23emG8++mvj3R87Sb1tBKHp5m1cRKtnpdNkBZqAcXUn0IlfRnOI2x0Pcn7ley0BF5L+74rJnv+sj19MjdkZP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOxNvilnHznOlLSFz3cUUZVaeWXYT15Uz3u7DtFu4Xs=;
 b=fuBCG49btW7xM72zWRk4fahET8xdg9wrRJ5MgUZnABB7b10o2vONdTUXXjGVJUx614i1DKDQlFn6nWYYnS7nSHgqdKAMAZWdfUFSlFvNsaDST9W6NDPfJEPE8s+YM87lWjsJkM2fKL0WiQXXD1oVzXmROSr5+n+0WiRTg3bQgGQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2749.namprd11.prod.outlook.com (2603:10b6:805:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 13:05:54 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 13:05:54 +0000
Subject: Re: [PATCH v3] tools lib traceevent: Take care of return value of
 asprintf
To:     rostedt@goodmis.org, acme@redhat.com, tstoyanov@vmware.com,
        hewenliang4@huawei.com, linux-kernel@vger.kernel.org
References: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
Date:   Wed, 25 Mar 2020 21:05:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 13:05:52 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1642cb58-4ee1-4b9d-98d1-08d7d0bd402a
X-MS-TrafficTypeDiagnostic: SN6PR11MB2749:
X-Microsoft-Antispam-PRVS: <SN6PR11MB274986E85CE30D92299C98348FCE0@SN6PR11MB2749.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(136003)(346002)(376002)(6486002)(36756003)(316002)(66556008)(956004)(86362001)(66946007)(31696002)(6666004)(66476007)(6706004)(53546011)(2616005)(8676002)(2906002)(16576012)(31686004)(8936002)(186003)(16526019)(5660300002)(52116002)(478600001)(81156014)(81166006)(26005)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2749;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJHUTLUsfegHv5UWAZtr8Vq/hIGT/j1/Nmd5k+wTHjaBrmny3/M949AHgVr/n67AeqpLge7ftb//nYOAVYJmDVy0ANVQfX2KDAo/fBxqMbsGiVXns/kZYZipZgnLprRfN7gMxJCFmN7/u4zbyY5NrA5wEh0Oj5ansWeAUxs6cv9eFa+FMYhoRGpZVabL3iMNUX71EeiIONECwYj/hk/whSR1CleIg7Cktcg9Fd66jY95UPN6eNtR8l6sx1khXYQ6j98ZGRN3TTc2yJ/jQ89NQySavWXqg2u0pfVtNTjEFJwvsFpA7RiuJWs6GkFKNJJZc9xKMfD6ls9fnfxINvxAqWErIrYl4j9sBHXGChWKczNbhMyqpUUL7jfoey6gW2cyC4SgR7yXwiQkGnXoG8e/oRuoiE3/v5jCZ1lbTvDUruEVeQAhdD1unm7FzWzmNgZE4GIq0P11xIRDukSkvhqoRsJQM9PXRwxW4YHIow5NuUhRv01KrLTtAF9lUr3ER8APdh+bH43OfZwooxeOYG7NMujliujvhHOe5yAIUmrBXrc=
X-MS-Exchange-AntiSpam-MessageData: 6+enaFpHU+sQB+myAAfGQT7bM7fqvvHw84m5s71mi/cgPDXvkeVfujdJ8fOARVHsNUoh6C4xiHN+EavBAZpi7ILsDqM9Uh4pfquRaY/3Oq2CtZ+lD6s17boSbaUgFH3zG9zRsYuD8m7xHmEwP4zZHQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1642cb58-4ee1-4b9d-98d1-08d7d0bd402a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:05:54.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mKBOtiX3ISPSv8/sjOlvfKeCVSHrwZ9VxRz0yKEQhEvvtUkZeOMAZaDBOIOoYfWS+C7+QgIqz5uVHbF72V84g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can this be considered for the moment?

Thanks,
Zhe

On 2/20/20 9:58 AM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> According to the API, if memory allocation wasn't possible, or some other
> error occurs, asprintf will return -1, and the contents of strp below are
> undefined.
>
> int asprintf(char **strp, const char *fmt, ...);
>
> This patch takes care of return value of asprintf to make it less error
> prone and prevent the following build warning.
>
> ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: directly check the return value without saving to a variable
> v3: as asked, not remove those that already save the return value
>
>  tools/lib/traceevent/parse-filter.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> index 20eed71..c271aee 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -1958,7 +1958,8 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>  				default:
>  					break;
>  				}
> -				asprintf(&str, val ? "TRUE" : "FALSE");
> +				if (asprintf(&str, val ? "TRUE" : "FALSE") < 0)
> +					str = NULL;
>  				break;
>  			}
>  		}
> @@ -1976,7 +1977,8 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>  			break;
>  		}
>  
> -		asprintf(&str, "(%s) %s (%s)", left, op, right);
> +		if (asprintf(&str, "(%s) %s (%s)", left, op, right) < 0)
> +			str = NULL;
>  		break;
>  
>  	case TEP_FILTER_OP_NOT:
> @@ -1992,10 +1994,12 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
>  			right_val = 0;
>  		if (right_val >= 0) {
>  			/* just return the opposite */
> -			asprintf(&str, right_val ? "FALSE" : "TRUE");
> +			if (asprintf(&str, right_val ? "FALSE" : "TRUE") < 0)
> +				str = NULL;
>  			break;
>  		}
> -		asprintf(&str, "%s(%s)", op, right);
> +		if (asprintf(&str, "%s(%s)", op, right) < 0)
> +			str = NULL;
>  		break;
>  
>  	default:
> @@ -2011,7 +2015,8 @@ static char *val_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>  {
>  	char *str = NULL;
>  
> -	asprintf(&str, "%lld", arg->value.val);
> +	if (asprintf(&str, "%lld", arg->value.val) < 0)
> +		str = NULL;
>  
>  	return str;
>  }
> @@ -2069,7 +2074,8 @@ static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>  		break;
>  	}
>  
> -	asprintf(&str, "%s %s %s", lstr, op, rstr);
> +	if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> +		str = NULL;
>  out:
>  	free(lstr);
>  	free(rstr);
> @@ -2113,7 +2119,8 @@ static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>  		if (!op)
>  			op = "<=";
>  
> -		asprintf(&str, "%s %s %s", lstr, op, rstr);
> +		if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> +			str = NULL;
>  		break;
>  
>  	default:
> @@ -2148,8 +2155,9 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>  		if (!op)
>  			op = "!~";
>  
> -		asprintf(&str, "%s %s \"%s\"",
> -			 arg->str.field->name, op, arg->str.val);
> +		if (asprintf(&str, "%s %s \"%s\"",
> +			 arg->str.field->name, op, arg->str.val) < 0)
> +			str = NULL;
>  		break;
>  
>  	default:
> @@ -2165,7 +2173,8 @@ static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
>  
>  	switch (arg->type) {
>  	case TEP_FILTER_ARG_BOOLEAN:
> -		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
> +		if (asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE") < 0)
> +			str = NULL;
>  		return str;
>  
>  	case TEP_FILTER_ARG_OP:

