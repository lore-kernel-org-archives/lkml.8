Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE84C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8802084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cypress.com header.i=@cypress.com header.b="IJMu0zsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFJ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:58:55 -0500
Received: from mail-dm6nam12on2127.outbound.protection.outlook.com ([40.107.243.127]:50400
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbgCFJ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:58:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxhuCZqS2P+v858v3GEVujyPJrK6qQKC7ExNPp0vAqUejOh8cZ5L1ENKPxS2yT6XiuA7uv8fSGpTQsGFhgcEgZtUoDRvNZvO07Ww3OogBMBPxl2XX7wuiqgpc8lNYHGpyUXuPKBcLueS5cXPZet90hc3Ybz1dqr3Msvj5WtB52LV3V5tYiPRd0LLUP5iWuKZRVqTaNnaXXhPfEXJGhvnBR7w1Z6AXRtaPVyy1nDzxHlCP+778A0KVT0YFFFxt1ntsBRul2bPFLwIdWpXW9GheaQjHb6ror2zTanmkKcfzCIfHN1Sqnhg9ofERVNy+4QOA80OQAolZfP2QOcZArIOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS0gwHrfPmQhsBd2yT/gnsCs2pn8C1oOPMuySOUnJzU=;
 b=S7gKKK362bZQnz7L8cT/s8rJ6hBfkvTTlE9SiEyVliCUKXfu7Zjke2BWnQZDRxdCeZw2RcDtyeuG5IUYONrODiU0BX6PcWrtCAYyXmEcoldCPEl1PKNlxYjE+3zZNjE2QNU5AsLYJJRiL2cpct6W413Ma0gX+E3rTOuSYNl2HIIbmm11vyBug1H4AHrPiKeEwBREm4u6GIh8bI5OcfZQl1QZnX2pA6xNXoJtC29E1LzHE2B9NXwNoiH47JJhxeFGFPpE19NqH0qg8DFItdRU8NFozAjOmEqf77ixVNAaOWz+u2eJKXm0CZ0IM2xkQm8MDE0wgitJsIwtb0zIIopHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS0gwHrfPmQhsBd2yT/gnsCs2pn8C1oOPMuySOUnJzU=;
 b=IJMu0zsdM4AL2DfL/xYW7RqVJcNO27a6SvCJxNXFEeV+3YW9s8INcVZp/HsY51dv0QJZXq+EGmus+0+1WAMET6zBnQvyTBadsUuEHRSXdSFdHySfldhe+jVcst44i4qLWrYfLKyUaTBXw6kP58cygDePiR9yoRU6da9HVnQhLCA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5974.namprd06.prod.outlook.com (2603:10b6:a03:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 6 Mar
 2020 09:58:51 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 09:58:51 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: Updating cypress/brcm firmware in linux-firmware for
 CVE-2019-15126
To:     Hans de Goede <hdegoede@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christopher Rumpf <Christopher.Rumpf@cypress.com>,
        Chung-Hsien Hsu <cnhu@cypress.com>
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
 <c2f75e84-6c8d-f4f0-bcc6-5fb2b662de33@redhat.com>
 <3cf961a6-56c8-81fb-3bf9-fc36e2601d2c@cypress.com>
 <17ec344e-80c5-02a9-59a3-35789a2eaaf9@redhat.com>
 <40403657934d090d4668916a02878f476b34c9fd.camel@infradead.org>
 <e6c7ec6c-8619-1511-8626-70ebdea3cec5@redhat.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <c52f8724-a629-2bfd-03c3-d5f4083dcfef@cypress.com>
Date:   Fri, 6 Mar 2020 17:58:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <e6c7ec6c-8619-1511-8626-70ebdea3cec5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BYAPR11CA0055.namprd11.prod.outlook.com (2603:10b6:a03:80::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 09:58:50 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9168912-a2d9-48c3-c4da-08d7c1b4f914
X-MS-TrafficTypeDiagnostic: BYAPR06MB5974:|BYAPR06MB5974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB597446CAC72B4EDD5F95689EBBE30@BYAPR06MB5974.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(366004)(189003)(199004)(478600001)(2906002)(3450700001)(6666004)(26005)(6486002)(186003)(110136005)(956004)(2616005)(53546011)(16526019)(66476007)(66556008)(8676002)(316002)(66946007)(31686004)(81166006)(36756003)(81156014)(16576012)(5660300002)(4326008)(6636002)(86362001)(31696002)(52116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5974;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtjudNmKKuyrZc3u5smkfymGdBmiylVzp6N00PBpvajASw7iq2h5guDPH7Z5+8WnoovOXpmd+s+E9qLgLZezn3uLiz6XX5vsqJDifQoyW1oSu1x3ovYohREwQ1YQCfENE9h2uCpsQpe8Y7zFhTux8pKPOs3FX41rVcA+1h5+RYV/laJRx/mYIYfHP6XkWvnm3IbMjnhE+KGTuTXm5+U+B00CKr3MZDxzYHxjSjOeQbT7nmEXekB37yFAOmeqxyWkVHZJMwawA7/lLk1/feRlBJoHN4+a/7bdThmWgh2pXovP1pSWpQOGoz9Eb658LkJ2NjUwj/GxgDTMUg0x/xxWS8a+yjwEiEfSgZFIF9oL1H7NIvaDEty452DSFyhg03H+RcSop+iH6t66YHGUMqYBrqGzcvPaScQmB2yT+qjiSe8pKrAPsApeldjGKstXPpey
X-MS-Exchange-AntiSpam-MessageData: cGX0scxGwsJS5/vxm676Gajjd8Nptia8pPSRBu1ekTTMP6ZHpvKPEK/ROPAJKC/J+0MTRwud+acQEsSqbIiFSBI30g997t5tc8+JzdtMKWq6kZY8NAAYS8kNuy7vQ+DPQuz66K4O6wOD+Ylfl9uWMQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9168912-a2d9-48c3-c4da-08d7c1b4f914
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 09:58:51.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDbIvp6ga8yYVFHftTCISL7a4FdrZ2gqiLUQ2c9fxG309LL/kNbB7b4G+Jy2j8m+DhCAQso7v1my7GOOil4P3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5974
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2020 10:00, Hans de Goede wrote:
> Hi,
> 
> On 3/5/20 10:16 AM, David Woodhouse wrote:
>> On Thu, 2020-03-05 at 07:24 +0100, Hans de Goede wrote:
>>>> also clm_blob download is not supported in kernels prior to 4.15 so
>>>> those files won't work with older kernels.
>>>
>>> That is a valid concern, I'm not sure what the rules for linux-firmware
>>> are with regards to this.
>>
>> Not quite sure I understand the problem.
>>
>> The rules for Linux firmware are just the same as basic engineering
>> practice for loadable libraries.
>>
>> If you change the ABI, you change the "soname" of a library, which
>> equates to changing the filename of a linux-firmware object.
>>
>> So if you make a new file format for the firmware which requires new
>> driver support, then you give it a new name. The updated driver can
>> attempt to load the old firmware filename as a fallback, if it still
>> supports that, or you just have a clean separation between the two.
>>
>> The linux-firmware repository then carries *both* files, supporting
>> both old and new kernels in parallel.
> 
> That is true, adding support to the brcm drivers for that should
> be easy enough and backporting that to older still supported drivers
> (which already support the separate regulatory db the new firmware
> uses) should also be easy enough.
> 
> So that removes one concern, leaving just the regulatory concerns.
> 
> To be honest I do not completely understand the regulatory concerns
> about using the drivers from the SDK.
> 
> Chi-hsien, you say that the clm_blob files from the Cypress SDK are
> only valid for the Cypress reference designs, but AFAIK the clm_blob
> only contains per country regulatory info, so which channels can
> be used, how much mW/dB signal strength is allowed in those channels,
> etc.  Which I would expect to not change on a per design basis.
> Parameters which can change on a per design basis like antenna gain,
> are stored in the nvram and not part of the clm_blob (AFAIK).
> 
> So I still do not understand why using the clm_blob files files from
> the SDK would be a problem? Can you explain this in more detail?
> 
> Even if the clm_blob as distributed in the SDK is a problem, then
> I believe there should be a way to make a generic clm_blob which
> is not tied to the reference designs. The current brcm firmware
> files in linux-firmware have such a generic clm_blob builtin,
> if one can be builtin, then it should be possible to also create
> a generic clm_blob for the newer style firmware where the clm_blob
> is a separate binary ?
> 
> Note that going this route (combined with different names for the
> new style firmware so that we can keep the old files for old kernels)
> will mean less work for Cypress. I believe that the current problem
> is that Cypress needs to do firmware builds for each chipset twice,
> once for the new-style format used inside Cypress' SDK and once for
> the old-style format used in linux-firmware. And it seems that there
> are not enough resources to do the old-style builds causing the firmware
> versions in linux-firmware to lag behind by multiple years!
> 

First of all, the limits in clm_blob were tuned for each product (not 
really for each board, my bad) based on the real test data in the lab, 
so it's not just about the limits set by countries. Different product 
needs different configs even when being used in the same country and on 
the same channel.

The clm_blob came with previous firmware isn't really "generic". It's 
actually a collection of configs for many products. That collection is 
not comprehensive, so there will be products that it doesn't cover. If 
such product uses the firmware/clm_blob, it could violate regulatory. 
Cypress clm_blob may or may not cover Broadcom products.

To make it truly safe on linux-firmware.git, a real "geneirc" clm_blob 
would be needed. I'll leave that discussion to Chris.




> Regards,
> 
> Hans
> 
> 
> 
> p.s.
> 
> Also note that the Linux 802.11 stack already takes care of only
> selecting channels which are allowed in the country where the wifi
> card is (as advertised by the access-point). AFAIK by some other
> vendors this alone is enough for regulatory concerns and there is
> no firmware level country settting.
> 
> 
> 
> 
> .
> 
