Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1CB2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZePvzY6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHYXgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:36:32 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com ([40.107.22.134]:53792
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbgHYXg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe4BO+Wq99rRz7xQyaXzITSCX6/l3uCMh4Igt5N1vVuNFeoDNi9w/Xiu1PBIM+27FjhPhQ/zD/yS+dFnUW7rZBRTRqvHMSG8G2LJerYy6fzzUDTktzKV18YD9CknI35OWgN5WEtLRE6sOJCNTa0+f1wxh5nnyLzahHaQ5YwCsMsWbzD2ijByOFK188u+Psc4XgnnQ/e9MM2sDVS5kYlyQAb3hVMG1gPFccLyh7nZieUMqykN+cu9kP5t3kvpdLdq/qs9Rl55jz5dR+jBaQLVSUzufJ2CVTteaZKQsZ3G0oV+iMuHWIsnl9ovaryzXGsbmdZaQmp+F8V4XtfL7tLcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JWkIMfIXRHwgbvD0rLcsLMi4dN+wYtY9IPAJATzryI=;
 b=czQbiS+b9yfyAyqm1MqjOFVw5nUIGc1yGGUMczHMDAh9fUZa+lUn2Fn7k0E6sZr3/tvAVupg7IbdPDbcngS5JOYjju3rARjH+NJh9OtDx5CQyfKJnXJt+fNgPinuSRkwFqlhjSOCAF1dSKn0wBdJwmuZe+z5S8lTfi7/DyCjDxGkW445p+j1YoPnQUzDtM7VPJ3yQ2iUla9D9Y4ZEIpRFh7XV/eQaKP96Nij7xiKbbzwIgCPblfGOnexyVBURCKdGklxsdq1c5CbQvcHDH8p4v/SlLjbRXKlBc+1HKHnw6gO5wLT84JOoOqi5qc40wpaKOrLsZZUwJC3fbtPUk4Thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JWkIMfIXRHwgbvD0rLcsLMi4dN+wYtY9IPAJATzryI=;
 b=ZePvzY6BbhrGmkGTS26DixS+KNygfcYECk5R4LsGHSzZ+dfTftVpU7UmVxKty0R8bkuwYzfAYezAc7rW+qcT8FeARPLedLITbEjOXoro/Te477+Q0irXJIC0oqf+pK44uhkMviOAZwjfGDHSs+PpH/pmkZE4eqaoYPQYVwWcgE0=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4218.eurprd02.prod.outlook.com (2603:10a6:10:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 23:36:24 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 23:36:24 +0000
In-Reply-To: <20200824034841.GA29995@embeddedor>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Peter Rosin <peda@axentia.se>
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for
 5.9-rc3
Organization: Axentia Technologies AB
Message-ID: <d2c2cbb5-c63e-773f-5e90-1287e926bfa8@axentia.se>
Date:   Wed, 26 Aug 2020 01:36:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0342.eurprd05.prod.outlook.com
 (2603:10a6:7:92::37) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR05CA0342.eurprd05.prod.outlook.com (2603:10a6:7:92::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 23:36:23 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a26d2729-41f7-4d89-7079-08d8494fadd8
X-MS-TrafficTypeDiagnostic: DB7PR02MB4218:
X-Microsoft-Antispam-PRVS: <DB7PR02MB42189A341DB11CB2D1053BFDBC570@DB7PR02MB4218.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu6oAVjo6As0kMQtwcsV50olwsprvUR2H3byTGyMhR+paKBtASsQGOLO1X/YYJd/88NAzzVEE9Rcdludg0r2xJJX4ccNyr79YWKL4LM/6Va4IgNA2OWdgjDfd6L4QtdUigltwa8WpzgfEHOoWWzna5vJOFVkSpMUL5ZvvZu7wBalJ/06AuoTQupqI+A6LLYqGXLEgLOGWbWoy4vyD+NDZwkQyI/qS0FCnEyBuYM7bPkXgfpq03ZDMmrQFI3BrqSk5BVkx3VEGxkTZylWWk5ijaAYo2GBjM4YslMz49F5UuyiKQyrwU6ee/ydNOnyoqhLNIdqgxPEkuyT//hCEciMMR8a9HKfHVvL1RtCLx7XemzJ12qqj2GPrEUhEEg8R3SHD3u7TGf7r8gMi3tj1Eyl9PYiUXAUx+urHEJGW6B6Xf4TOaHw+cpMjsLT72wjV/a0xRYT17a0oQMN3tMfRG7thA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39830400003)(396003)(8676002)(6486002)(8936002)(54906003)(16576012)(6916009)(86362001)(31696002)(2906002)(31686004)(316002)(4326008)(966005)(186003)(16526019)(52116002)(66556008)(956004)(478600001)(83380400001)(66476007)(53546011)(66946007)(2616005)(26005)(36916002)(5660300002)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7YfZ81biCb0Z5NTaYNQjsLglQR+oyJPPnrw/7WSH7hA+1I/ctqzsPIN2kXEHnA3hQ3oicgIGbH/cLb5CZ2/cEr1H8Ast5IqaK1k30yvds6TQtNU9xSmXPQI0gZ8TNhLstEdz5Rg9J9GrE9yiLJIIwFqY+rD00nPAb9i0sIcfRFqc4202iF3WSD8pfe5QTbLtBYi99sOr+NzcFDP9pJGK2sBtWS8Y9bGWry0jDXBPOQ3ZTzAfCwbWj20wZZBX1or6LsEwk9RUzG8GW57V5AFpdWuFfgVzQqKoqfXd8sfUSO9h0udSkWBWcHjz0zFdkcJUr40PmNz5LaeFIPZQGrz+4fmDxLW2CWyZccZ3aGZALp5diHzhsK7Jfq47s0HOCIrPyhzSwNJC73N4i28HjKZZ4BM+Fk8jjphc5876BSfwx40eFg9Ot8RCBMzaa8k9uo3I/mPugg6SssYsz5Vcp9fYcBNty0lcAb/k4CkDT7Xl0OZUpuf6X2DI/Z9SezipQBWSuDL9pVIAEHRdIPCWns84HNNaJfe8lvCZ11297roKpG7CTBPTIR+0jRUc4iO4S99xzLPtFj4WAIzd/+eUW0tx519brrosmj2upVQ5rNvU1beqqKrDwG4iatRUrNtf4th5nRT+ZMPcH6Os41mwqfsowQ==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a26d2729-41f7-4d89-7079-08d8494fadd8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 23:36:24.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HNRln4KM2ESgiwUPvczwn2AuW61r7u++SU+XARlqzODRv6y73kAkG7Bp9t8loyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-23 22:48, Gustavo A. R. Silva wrote:
> Hi Linus,
> 
> Please, pull the following tree-wide patch that replaces tons (2484) of
> /* fall through */ comments, and its variants, with the new pseudo-keyword
> macro fallthrough[1]. Also, remove unnecessary fall-through markings when
> it is the case.

Hi.

This is the second time [1] you have messed up the reading pleasure of
drivers/iio/dac/dpot-dac.c with mindless fall through conversions.
The comments in that file no longer make sense.

With more context:

 		case IIO_VAL_INT:
 			/*
 			 * Convert integer scale to fractional scale by
 			 * setting the denominator (val2) to one, and...
 			 */
 			*val2 = 1;
 			ret = IIO_VAL_FRACTIONAL;
-			/* fall through */
+			fallthrough;
 		case IIO_VAL_FRACTIONAL:
 			*val *= regulator_get_voltage(dac->vref) / 1000;
 			*val2 *= dac->max_ohms;
 			break;
 		}

See how the comment ending with "and..." is no longer continued? I
disliked the last change to this file [2] that (after pressure) moved
"and" from the original "...and fall through." comment away from where
it belonged (instead of just removing it) exactly because it was less
clear that the "fall through" was part of the natural comment reading.
But this latest patch just destroys the commentary completely.

I guess I should have stood my ground the last time with my

	/* ...and fall through. Say it again for GCC. */
	/* fall through */

suggestion, so that it would now have become

	/* ...and fall through. Say it again for GCC. */
	fallthrough;

with this latest change. Because that makes sense.

If it was someone else, it would be understandable, but since it was
you - again - I expect a patch fixing this. Either as I suggested above
or some other way.

Comments are important.

Cheers,
Peter

[1] https://lore.kernel.org/lkml/20181008173528.GA31787@embeddedor.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/dac/dpot-dac.c?id=c65a0d84ee9c
