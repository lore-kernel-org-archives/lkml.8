Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E63C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 02:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C211206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 02:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="kcNctyIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbgEZCF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 22:05:56 -0400
Received: from mail-eopbgr760055.outbound.protection.outlook.com ([40.107.76.55]:9058
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388351AbgEZCFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 22:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1ZahTXVjJSdeshGIvGTJOO7PL6wv8uajsXuLvlcY4iNS8DNYORMN8omoiDzs/lDfQCCm0PhbVK943heg2Uy2hNUxez7mJB6QIPSeULCpqCxYBCUN1IgGwN6hewlGGpBW4wzDzG7mPQSuLcnArsRSBwGisJpZ0jqQbguo1OCnuSdaJOIW63fgbh+W4PFnOlCNhZqgtJBn6/UKkOGYeVFLfeMqdeLWP3xN05ZmIOg9OCkZapSVIoZ+/diZ3u85vfbKacWyCsUdKwJOHeJJhLklZo/udF5K2hPehNns3XahE/lel43UxQWDknRhfddI809zIXEicege++IA2qy9FuyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA0Zuzc81+5+/vQtKDNM2wy2C1JezaYXOGTQmpmLBCE=;
 b=JDRqzzCsSUzOMvTtbFwF6MYduuUFWNSMM2EMFIeyZAYOefUS0Fopq5DIooSlty1Zf7fH/WHfm77vsm+yKcEDcc7S9L4GJeWHm/1t2xZtJ2KAs/GIHfpDNZ+ASG53CZHyNmv1f5+6IpApAz+5RED4vax1GIJJJxIIWMSDgJ6S9o5a1B21gz/QW+LqoScCm32lu6oP6Cy0aGusI6vhZBYcr/EycYgDkUgP8Cvrj7uzLQguqdlHT/nvBnIH+2SrB91V/n2xJ/J96VkEWNI2BRtREOuVWvsdGib+K4z4Q2UcYQNQAZ4jJCpUOoRHwAFxFJ7VNSpeCbFN3VWD7ydKT2BwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA0Zuzc81+5+/vQtKDNM2wy2C1JezaYXOGTQmpmLBCE=;
 b=kcNctyIVgcHDs3AuPfJjRdK9rjZ3+21bubL1DuLrsPBqlWevS/Rn2GNoytD9MketACu4/Ixim4Pw4CiTXbEugCuQ6wZGAkINTyM8wpBJdVk0GbzbZ6LWE/HpcfIVKquM4Ju7LLhRs5sjIm5ntI69b0KbhhyorFrmsA9GA43PJfU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3253.namprd11.prod.outlook.com (2603:10b6:a03:77::31)
 by BYAPR11MB3687.namprd11.prod.outlook.com (2603:10b6:a03:ff::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Tue, 26 May
 2020 02:05:53 +0000
Received: from BYAPR11MB3253.namprd11.prod.outlook.com
 ([fe80::18e7:4cfc:e31:8ccd]) by BYAPR11MB3253.namprd11.prod.outlook.com
 ([fe80::18e7:4cfc:e31:8ccd%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 02:05:52 +0000
Subject: Re: [v2] workqueue: Fix double kfree for rescuer
To:     Markus Elfring <Markus.Elfring@web.de>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200525075901.12699-1-qiang.zhang@windriver.com>
 <7d19381c-2c51-deb4-f82f-d54bc56c6ecf@web.de>
 <bee86d19-6c14-1fd9-eead-24e63af6cf8e@windriver.com>
 <8b67c327-e70c-1e96-6a99-a5fd2667f666@web.de>
From:   qzhang2 <qiang.zhang@windriver.com>
Message-ID: <e002d552-b161-0cc3-88ea-daee541ee6f4@windriver.com>
Date:   Tue, 26 May 2020 10:05:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <8b67c327-e70c-1e96-6a99-a5fd2667f666@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To BYAPR11MB3253.namprd11.prod.outlook.com
 (2603:10b6:a03:77::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 02:05:50 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d07f479-5fc6-40df-cb46-08d8011950ea
X-MS-TrafficTypeDiagnostic: BYAPR11MB3687:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3687179E4BF79468EF508092FFB00@BYAPR11MB3687.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnP98BctUDqIAFqUDjhtB4rXxmNSBOIvv3j+tzJb4+vCuo/7IfrBHhU+HO29kUFAGe1spyl8KbFx2NfL3rlab3RYRMEbhq1eN5Dvk0HPiwPzCPKhaeg9HnIPepzyL+0g42l1EL35UbZLEZ1OcsvSoUcykeUtAMprnU3qGJuuC9tmqk3H1vsdwbGV/lTRlXvDYHCZEarEotx4Rp4nAEYXwLNzZzyJrIsbG3FIdZKjOLvwzzmDiJFhuqs+atPKI4+8SwPccuRu+lzP7kAPZpLBWD5eeNosUtuzBO6Rwu2ofzFzKbo0egauMt72y0+AyUm4mSRhwKQmXQKvuL82x7kjSh3QUmQFlRzjJrbhVsZJZvXuyoiMPX7Go6r5mMVfyO2pjq6mDnWdlAwl/spvlR7+oHNJ7Ah0J5rZxeak6FaxoWIVldvKdIr3G/WlFADxlvU/pDw/ojiDR7O0i69z7YYZ+EHC3zSUQR0G055m6eQF1kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3253.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(396003)(366004)(376002)(346002)(136003)(956004)(2616005)(31686004)(8676002)(16576012)(478600001)(8936002)(66946007)(316002)(4326008)(53546011)(6666004)(66556008)(66476007)(16526019)(86362001)(4744005)(6706004)(31696002)(110136005)(2906002)(5660300002)(26005)(6486002)(52116002)(36756003)(186003)(78286006)(43062003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 74tclJ0sUNzJhB+nS31luU14eq2x9gq3dU+Yc0iiNDKUvffpWE0raOtD9nmmKkOhYpgf5on7CYE/ug4FhKkUWLmhbAqNPzkyfIOevvgHUJa3WlcUXb8+A0GPJ+vEf1sps3dBL/QaZ92yZZtJQCwmKhlVbnfqFGL2YMgvBGqgTqIxcCefY895+DLCRcF9gZPqZUWsCf08XvHRjNGEKaYs1kMfVBa2Kklied1hyic8C8lK0v7pD6yYQF4Gjf/I4nZijV8TZjpHdCovQegskE+rHu5/EuAk3vfRi9/Q212rBFQSFwq133QqkH/mVfbN1soOtRvCJqHDFOKsveo+qQAIGvH6OXF+4FCGQEPnSUv/DjDV0v/jh3O6wNk4gzF1JNonL8CdK/xLw5M3zqYNvuyvQ9m1JEw63c0dx1bx8snv0BwejlkugUxPFShlwcRhuPU3ixS0PsdHq1axZ/T7bF3R5slUdr4V5/OYtfUJpGV0kYo=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d07f479-5fc6-40df-cb46-08d8011950ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 02:05:52.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahFfhuzJhkT+449WgyTZ5rSyk65VrW2bcMzNWmbFUXPnLXCijbFmQgTnAK38tGMcKqtnlP3cfbzSFvEBe6wUgHkZPWXyxCTFbGYdYj+rk18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice.
The rescuer null pointer is intentionally passed by a data structure?
and also I read the code of workqueue again, when destroy_workqueue is
called, after "wq->rescuer = NULL" was executed, The scenario described 
below does not happen

"if non-null pointers (according to valid rescuer objects) are 
occasionally passed by the corresponding data structure member
for the callback function "rcu_free_wq"."


On 5/25/20 6:40 PM, Markus Elfring wrote:
>> I see, kfree does nothing with null pointers and direct return.
>> but again kfree is not a good suggestion.
> 
> I have got the impression that the implementation detail is important here
> if non-null pointers (according to valid rescuer objects) are occasionally
> passed by the corresponding data structure member for the callback
> function “rcu_free_wq”.
> Can another clarification attempt reduce unwanted confusion for this patch review?
> 
> Regards,
> Markus
> 
