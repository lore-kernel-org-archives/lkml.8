Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E4CC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71FC208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cypress.com header.i=@cypress.com header.b="PkwLxFt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCEDvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 22:51:15 -0500
Received: from mail-dm6nam11on2102.outbound.protection.outlook.com ([40.107.223.102]:8736
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbgCEDvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:51:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXU+KC7GYQWLnon6G25R8/SL9z+JwK7eJJKXxavXxtomhG2ho1i5DHC5+0nLeJTAvGmF7RkM3SVEyGNRsF4aTp8935MVCW4MGCt2XPCpAMvQF97mRfM0Edljdnvi3yBmWtGcWgQDBxjHiXcXLj73XvAx3/oH1x7E50VISgQtYTJ8N+kw+Pz+KPiz5q39qnLwb5XzuxsV0S8r9+wyW+pLjhXTFi2phOMaHEx7Vq0QkAxlyoW5wexPxjFw3SCC9BjrLi98gy++/7Yy2hF0gg1s8aL/FljL1d0uiXygT3vDpv2vcqKeykRA3Pz/lTV8dx99ueL9sinCnn607IKqTUwphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZWFI+phPEI8QwNtQwMjFaGHL3bjZWcUsrDDLdQkSTo=;
 b=F6MeBwb0L/3suiO8BK66SjAnGbQRksf3ZIAVImPil3KW4MewPMIRCHLWuNkqKWv5T5Y6hLmplm07dgP94yVFC/F320bd8IvaQb8OqvRRzhwdOHqPSMlI/G3ViPJpzVFf9HHGwSHnkFWvNPVGBUC0ssfHVixesBU76iIOtgp9h5gHP9F9KcqBX5DF4R3XvV9CAlaE6ayx3V9fUKYt9HkRcwVDgQFs+gDqDHcAArHCAuIiGsyyeU5yGzM6fnjhvmsuWL/OeCIzeamQGuLUHRfhhjo5tF38tvTWWmsSMCDWvT2IXYRTQedhyR1YarR7+PAp91C2w0qclf82Aq7JY+pHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZWFI+phPEI8QwNtQwMjFaGHL3bjZWcUsrDDLdQkSTo=;
 b=PkwLxFt/rPFMCvW9wU7w7BeL9AjhmvsM8TRGoNFXk3WpInal00osXR+P8W6N+Z11GPxqCq77ECrYrlqXEw6Tb4l5P9j/vmLrMPW+WgYhR59IJOwpZaVtcJFvhIMYc5OZMeDdiW9r1hdbbTAvwqxzkYvfdtGRtwlt6MAQzj4NIVI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB3912.namprd06.prod.outlook.com (2603:10b6:a02:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 03:51:10 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 03:51:10 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: Updating cypress/brcm firmware in linux-firmware for
 CVE-2019-15126
To:     Hans de Goede <hdegoede@redhat.com>,
        Christopher Rumpf <Christopher.Rumpf@cypress.com>,
        Chung-Hsien Hsu <cnhu@cypress.com>
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
 <c2f75e84-6c8d-f4f0-bcc6-5fb2b662de33@redhat.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <3cf961a6-56c8-81fb-3bf9-fc36e2601d2c@cypress.com>
Date:   Thu, 5 Mar 2020 11:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <c2f75e84-6c8d-f4f0-bcc6-5fb2b662de33@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0032.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BYAPR07CA0032.namprd07.prod.outlook.com (2603:10b6:a02:bc::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Thu, 5 Mar 2020 03:51:08 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa41a757-845b-4fba-fd16-08d7c0b870ff
X-MS-TrafficTypeDiagnostic: BYAPR06MB3912:|BYAPR06MB3912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB39122222F68CA432BBB73D35BBE20@BYAPR06MB3912.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(81166006)(6666004)(8676002)(81156014)(4326008)(16576012)(6486002)(31696002)(52116002)(316002)(26005)(186003)(31686004)(5660300002)(16526019)(86362001)(36756003)(66476007)(3450700001)(478600001)(2906002)(4001150100001)(66556008)(53546011)(956004)(966005)(110136005)(6636002)(66946007)(2616005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB3912;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06ZziBZbf7QAatdZORahHPk8cDPIB6Z4KOvnw0yLp1zdSP6teq1Z9TWT784CPsnrkGBEJe9uAaC3ERnJck27zV3e4It637pymvGKwnWTC59541k/gcIVyMA0bgUD/lXOiXhSpLNwE9LHT+deoyr8d0/naHCSrXGzv32RBOftjdx0SfMf+Yir6AJUZ9BSO2z/NExm/DZHB3rdJCUQrbqGDDKaCxXu1djFTQk231OOOpJyf0OG0nju+kov0axBwtzUl/ayr03x2NQDA9NdYJUnFl3bRRbk97sO3Ok0RgLAEi4wnLjP2BPkT9U/MCvw8wNFAnp8iN4UVh0I5IHNeGltxkMrKmYKkZqqxT76ZnjpGxlMdjIiHrdQpwsEjn3kYyOW0D+Jq/ZMXphAAiJfRh6U5jv47u1PdvdFmq/cOHA6GNAWELkt3hyky7y4hrzvVKnctBLn8bc6uILNvTIjnDJCZvZu07Ks6RzA9WL8CYp8vDA36X42sW+vszwPhjdJTNR+2CzNGbsbqOni/pWw/sjYeg==
X-MS-Exchange-AntiSpam-MessageData: neVk+4Cdwc7s8fxmZHd2OYcz10WjWvvtu8wvMRNUUFNQE9efUmFKtdXvwVdJ2T/d4nZtxJkeghAMTJFSsdyc612n1unlSGOZ5si/wgx8O2u5SVzWgg3E8hG5F5nQGK3PN8vT3H9SG2y6j30ACfmKqg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa41a757-845b-4fba-fd16-08d7c0b870ff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 03:51:10.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H8ggI5j5zdcRkA4xc7Q/+ykXWHjjpD5F8ubEHG3AvkSqMED5U4l8i2fYee0RGu7CSVLOaa8e2RZqgG92n/EpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+Chris)

On 03/04/2020 7:45, Hans de Goede wrote:
> Hi,
> 
> On 2/26/20 11:16 PM, Hans de Goede wrote:
>> Hello Cypress people,
>>
>> Can we please get updated firmware for
>> brcm/brcmfmac4356-pcie.bin and brcm/brcmfmac4356-sdio.bin
>> fixing CVE-2019-15126 as well as for any other affected
>> models (the 4356 is explicitly named in the CVE description) ?
>>
>> The current Cypress firmware files in linux-firmware are
>> quite old, e.g. for brcm/brcmfmac4356-pcie.bin linux-firmware has:
>> version 7.35.180.176 dated 2017-10-23, way before the CVE
>>
>> Where as https://community.cypress.com/docs/DOC-19000 /
>> cypress-fmac-v4.14.77-2020_0115.zip has:
>> version 7.35.180.197 which presumably contains a fix (no changelog)
> 
> Ping?
> 
> The very old age of the firmware files in linux-firmware is really
> UNACCEPTABLE and very irresponsible from a security POV. Please
> fix this very soon.
> 
> If you do not reply to this email I see no choice but to switch
> the firmwares in linux-firmware over to the ones from the SDK which
> you do regularly update, e.g. those from:
> https://community.cypress.com/docs/DOC-19000
> 
> Yes those are under an older, slightly different version of the Cypress
> license, which is less then ideal, but that license is still acceptable
> for linux-firmware (*) and since you are not providing any updates to
> the special builds you have been doing for linux-firmware you are
> really leaving us no option other then switching to the SDK version
> of the firmwares.

Hans,

As we discussed previously, those files are not suitable for 
linux-firmware for the reason of regulatory (blobs are only for Cypress 
reference boards and could violate regulatory on other boards); also 
clm_blob download is not supported in kernels prior to 4.15 so those 
files won't work with older kernels.

Chris owns the Cypress firmware upstream strategy and will explain our 
going-forward strategy to you.


Regards,
Chi-hsien Lin


> 
> Regards,
> 
> Hans
> 
> *) We have distributed files under the old version of the license before
> 
> .
> 
