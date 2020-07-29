Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1EE20838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pMrMCK01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgG2S3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:29:37 -0400
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:20992
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbgG2S3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwo7VHmah7ZCTM5e+nVbJaZ0AIJNzTXKNR/8DSm+WwMXoEtATkxL9AcKXI5BFEOVuOfZf1aG4E9MeBZ6Y/aGkGc5s/jw5vs/pI83wSeWNZtPTJ3TepTDS6K2BXrGvLGjoJev507dcV00LB8xHnXTy2ShXGWwS57a0UeqcM3X7XW6v218LWzg3AGqfWqVjxEq1klqPKcFltRY6vBK3Nb7B0/4gweM//adhO9C5xz2lNtTwCo9OdoOxSLD/2BBzFSq3YvggjhP4Cc4RGB/kooYXrQjC7ZTeLVEv/Wl8W4jQ/1/unozffcB/h5+k9Nm8Z+nqtfcrURMuWLIDQWuxpD+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtpxUyAYdwxJgZJc7z4hb2V1bEgPmhcTp2g27y4aBxc=;
 b=CdT01Fe1YgCc0NPsue1cL4fo9a5fBDPbrZ8ld5vHFyPcbeaojtLnSNdWG9j3nIRTwPbnmriwhQMKwGbZwRXh3LkU39bqZhoRBgVIoSwvPO+DAJ5CnlE60bj7axlIzWKSZMu8nSBlNOv+QDyO/HpbsKCwZhP09VOwMG9Umf6VXiZRm9/fIkncuDHsrRdYVUXZpQPOkjtypltA3qfiKc/T7AqTS71ulQqYTawO7gJ+wqLC/kf2oJ7zOOR5+rBUXZ9f0SqxOm9n0q490tbS1GQwaShS5w7ZMCyE+zm8hvx9fY9T3ES/s1r7crEdtmZcBaDaj5xvIvQRPp/T+SrUZ0LSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtpxUyAYdwxJgZJc7z4hb2V1bEgPmhcTp2g27y4aBxc=;
 b=pMrMCK015MEbDCA1HXQiK0t3pfVopO2Zmd8VnCbnP2ykbrrhMcHkhdCyczKNwJ1qeiOBTYG+4uvNTwQCiNBzY8xqihQs6tCqojqccli/FKaAqkB3AFmWeSw5KitJTjNl+SQMjM7lbQXXD132ovKRcRc7cYywKsZZU5K4Bdg/zM0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3772.namprd12.prod.outlook.com (2603:10b6:5:1c3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22; Wed, 29 Jul 2020 18:29:34 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::25ec:e6ba:197c:4eb0]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::25ec:e6ba:197c:4eb0%8]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 18:29:34 +0000
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!
To:     Thomas Gleixner <tglx@linutronix.de>,
        Scott Branden <scott.branden@broadcom.com>, bp@alien8.de,
        x86@kernel.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
 <87h7tsbs1n.fsf@nanos.tec.linutronix.de>
 <e0ce41cd-9149-e43e-f4ca-e75503cb82e3@broadcom.com>
 <87blk0aw1k.fsf@nanos.tec.linutronix.de>
 <cc298d3e-9a14-d3e1-025b-6bb1f8bfb4ae@broadcom.com>
 <87y2n2abv2.fsf@nanos.tec.linutronix.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e41ea714-a042-b29b-d22e-8ee71d23f2e9@amd.com>
Date:   Wed, 29 Jul 2020 13:29:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87y2n2abv2.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0134.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::36) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM6PR02CA0134.namprd02.prod.outlook.com (2603:10b6:5:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 18:29:33 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fda64a6-94b9-4ccd-b044-08d833ed576a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3772:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3772CBF132046BB845034EAAEC700@DM6PR12MB3772.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHa6jk0Lnsf36BpEW5+O0+l2/+laUgnRs4GjPBw2EjJLsj9I15f9/0L2BWXAUT23gMgGK5XAMPRWwNM7sxk4uDFbAXvgwj3A8fOvh02cYCV7QZoY8UB9nYeq31kz/XX7yQuExnLfzx9J3oVatAlpvkCTESyf0OYrJyiz2qzRMJf/3/DkuzbN/EB9UpIhEPfkheHoC9a1Vdp5+SGT/qOddU9v6vw03Nb4orU6Qaoe8VB/5gT4hfaB71wt3KF6t0c7mP3QoOW3RYxPoXFmZxb/QR5QwIT5lwGfB67IEyrrNFMcW3ex0iHWDwImPfPgaHx+wtR+TA3K1UruYUx0k6Vd0kYI5B41pWwbuwRcW7+phoJfR9ChfZyu69uDEEBy49Xa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(2616005)(16576012)(316002)(4326008)(110136005)(956004)(31696002)(31686004)(2906002)(5660300002)(8936002)(8676002)(26005)(66946007)(478600001)(6486002)(83380400001)(66556008)(186003)(52116002)(66476007)(16526019)(86362001)(36756003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +0YvQXBN6/0bGzfckL0NqCpHU35BhF7KkHx+QOwkmtgSe5N86R7hmkawtQFWIkWIeVF9jz1xKbirgFC821ZPRvQw6KqCC9sO5EKJS/zpc0faDbtLR9jFo4ihncd0DJWFCW1wI3g/RUP//ZnIII7VDjmZ8L3GJRS0bH6TU2E6uWRD0DW5F2aEb1B1BMFdF/TMkb8RxsWKrW/44qyyLPY1pyGvY7prKObwllFHvKdQjYyPnw7Ehy96u4QTFsroA52Y0EJ89HR2JUEeXoBLtyhY+Evdtqs7xQGyXU3sGH0r+6o13YRZ3JlLzMIaTOnvZ+N29DSRwZY7jd+FpopSwaC9ATCvXWD72INJl1UgQbn0MlV6+Lqinpft1hkaOhRxzjn4n449RKlOKPhgqPMrqRT33wayreja6h9z2q7CKaWFAiZSI2PRy9QtGYPoewk/ITPKtP0PFgIgO3dcxrnkuSVsTMbi1YnwHgt1nbqufueVpR0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fda64a6-94b9-4ccd-b044-08d833ed576a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 18:29:34.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhkU4eR5N9Zgj7QDbNpeCmuoewZ7xAJeoRgSPzVktAnnQvqS5PwZjtL8lDb5/Q/Ugs+UcRL9U06S9SajpE6FxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 4:50 AM, Thomas Gleixner wrote:
> Scott,
> 
> Scott Branden <scott.branden@broadcom.com> writes:
>> On 2020-07-28 1:22 a.m., Thomas Gleixner wrote:
>>> Scott Branden <scott.branden@broadcom.com> writes:
>>>> Bios now updated to latest.  Same kernel panic issue.  Log below.
>>>>
>>>> I think it is related to power cycling quickly.
>>>> Should APIC work if PC power cycled in a few seconds or is that the
>>>> problem?
>>> Yes, emphasis on should. Just to clarify, if you reboot it works and
>>> cold start works as well if power was off long enough?
>>>
>> So far I have only been able to reproduce the issue by cold start with power off for only a few seconds
>> before re-powering the system.  It has not failed via reboot yet that I remember.
>> Will have to keep my eye on whether using reboot is an issue or not.
>> And also keeping power off longer when doing a cold start.
> 
> Weird.
> 
>> Please find attached the failed console log with ignore_loglevel.
> 
> Aside of the differences caused by the BIOS update there is nothing
> related to the APIC/IO-APIC setup which is different between the working
> and failing boot.
> 
> TBH, I have no idea what's going wrong there. Maybe Tom has one.

I asked around and was told this is most likely the motherboard has not
decayed its DC rails. So it's quite possible that keeping it powered off
for a longer period of time before powering back on may help.

Thanks,
Tom

> 
> Thanks,
> 
>         tglx
> 
