Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1E8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ADB2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tEpitHCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgIKJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:24:57 -0400
Received: from mail-dm6nam08on2046.outbound.protection.outlook.com ([40.107.102.46]:8544
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgIKJYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfCa4Q94p94OeRg9QGvDdvXufzroJ5gqPbACKOyuwGZtsQXIgu43CS8+avV6GDXArnqF0Ia+cOX1YW0R2fznndCNExu3IpuI0sSrXX2nWqD77St4wMHgHLyAVGBtNqsgQhlVUnA1Vl/YfBaeRtBXBwC4CpZEvukWQiUv5JlA5efDKfZOD3XOQ/aqONV4U+qtIckjXB9wYckxTiaDQgFyeRV93U7k/ei9ORdhMYlc4cHRKUrh1JkKYyz2eIGK2sk3GdZm+YPZStXIr5mHtB5zThDHXkkQtoQ/hv/3F/JJmk1b7qz3wZlHRt4Zv7uI4UaIjNXjYhcRYGs4+CRbG3U0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF3BeID7oAJnXA008hSaSqOm7d0b4PQrD5riMyhPPek=;
 b=Md2JPdNl026CazhK5nJYIIx9GTlX0peeXdf6f9b3552bnUJrgZpL9qdiswMkPW4JwVmMURdFh5ECACC0sYA8X/9c2OFqI59HFBH2zDt/W8p9UmJFqRTw5Jc0qpdJMqdc3S8KW2LlEsnp2QG4VFYj1RkNtzJbNzkPM9XirgJiqwxIF1anIdqECS3QS6Vz8enF/W8kGuGaXaaCtdSITV4EpSfKffX4NdNKPOZvPVSR7honnQYY98BcgZsAsAKM2fiHBHsHmgBvIE8uFsMI1QDFTOOgbzFpbDiE3CkZ2UJe7ANi0Ff0xidfmTvEAx49RiynAFnoymSjfHSmoVd9RfZLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF3BeID7oAJnXA008hSaSqOm7d0b4PQrD5riMyhPPek=;
 b=tEpitHCPXHrkNA6XGVGQj/0PynR6hn2UAD0JjEeTTr3JCsTLy/GzyzSl8uKgP3DPcJH12KMIq/vSnNsd4ULfhG0LFQLrYPTfrBzJj7kw6pHzhp+kCIrhv3HqBsn/+2MTfl7LE/wRyPDE9lFiY0GdefnjSAdUmhWvVHnVZD+cr2g=
Received: from BL0PR0102CA0019.prod.exchangelabs.com (2603:10b6:207:18::32) by
 DM6PR02MB4748.namprd02.prod.outlook.com (2603:10b6:5:fa::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 11 Sep 2020 09:22:15 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::98) by BL0PR0102CA0019.outlook.office365.com
 (2603:10b6:207:18::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Fri, 11 Sep 2020 09:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 09:22:15
 +0000
Received: from [149.199.38.66] (port=47694 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kGfG2-0002QQ-Ad; Fri, 11 Sep 2020 02:22:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kGfG2-0000MD-O7; Fri, 11 Sep 2020 02:22:14 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08B9MBVQ000860;
        Fri, 11 Sep 2020 02:22:11 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kGfFy-0000I3-W1; Fri, 11 Sep 2020 02:22:11 -0700
Subject: Re: [PATCH v2] drivers: soc: xilinx: Call InitFinalize from
 late_initcall_sync instead of probe
To:     Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, rajanv@xilinx.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        tejasp@xilinx.com, Jolly Shah <jollys@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
References: <1599693000-25641-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <ac2ab6d1-69c9-34aa-6c25-588bacc78002@xilinx.com>
 <CAK8P3a1aaS85m5nv0hmmxgEVss-hNGL7Qg8iosSFDjDdzzP87Q@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <f90e00b6-2663-c5cd-41b6-93cd54432a6a@xilinx.com>
Date:   Fri, 11 Sep 2020 11:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1aaS85m5nv0hmmxgEVss-hNGL7Qg8iosSFDjDdzzP87Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9cf3a5-d66c-422f-d8ee-08d856342c1c
X-MS-TrafficTypeDiagnostic: DM6PR02MB4748:
X-Microsoft-Antispam-PRVS: <DM6PR02MB47486577109D75923F9206FEC6240@DM6PR02MB4748.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOSCaIROahM5slCgm05W+Dq0hP3MygfYrG9sEGeH3yA6dKWw+F9FdQPzI2uhz4YsV+vmag9oqQSDtJweHpLexqrElzBf3TpZFzx8zP5g2nOoJzi+udfW4+VEP4wvWKEXgFJAMt0uEcu1//m7AYd0su6EfmzK3oUbhTjPCjkppeVm2tSxSevil2FaxUJrdscUHiOJPbGbT25rG/6npDapPLrt4z4diPlOI/vytH93+SvCW7JyNJLHeYIwEmrzBP9BU/bR76Pzyj3ocChUYUnYBwo7hcjsxwia2E9ZoMBu78pDZesW33ey+MOeCiC1hlpcjqx9h/ZKuO03SrXpRNSJFWjXaUGIcMvprJtP7yLQY3cPOp2VMlTDp5BuSQMfkv5Prpt4CD3M+7m2iQR7oy0tktx6t0hDzNqaiNnDAWceR5k=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(46966005)(8676002)(31696002)(107886003)(110136005)(356005)(2906002)(82740400003)(54906003)(81166007)(47076004)(36756003)(426003)(316002)(53546011)(31686004)(26005)(336012)(4326008)(44832011)(7416002)(8936002)(82310400003)(70206006)(70586007)(9786002)(478600001)(2616005)(186003)(6666004)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 09:22:15.1151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9cf3a5-d66c-422f-d8ee-08d856342c1c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10. 09. 20 10:35, Arnd Bergmann wrote:
> On Thu, Sep 10, 2020 at 8:50 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>> @@ -246,6 +245,23 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
>>>       return 0;
>>>  }
>>>
>>> +static int __init do_init_finalize(void)
>>> +{
>>> +     struct device_node *np;
>>> +
>>> +     np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
>>> +     if (!np) {
>>> +             np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
>>> +             if (!np)
>>> +                     return 0;
>>> +     }
>>> +     of_node_put(np);
>>> +
>>> +     return zynqmp_pm_init_finalize();
>>> +}
>>> +
>>> +late_initcall_sync(do_init_finalize);
>>> +
>>>  static const struct of_device_id pm_of_match[] = {
>>>       { .compatible = "xlnx,zynqmp-power", },
>>>       { /* end of table */ },
>>>
>>
>> Arnd: are you fine with this way how to check that it runs on zynqmp or
>> versal?
> 
> I might be missing something, but this sounds like the wrong way to do it.
> There is already a platform driver probed in the presence of the
> "xlnx,zynqmp-power" node in the same file. Wouldn't it be better to
> either check for the same node instead of an arbitrarily different set
> of SoC names, or to make the platform driver itself get registered
> form the late initcall?

Rajan/Amit: On the top of my head I expect that you can't call it as
late initcall because you need the first part earlier.

Does it make sense to check same node?
There is and should be only one instance of this driver.
Isn't it easier just to setup one static variable instead of calling dt
functions which will take time and result will be the same.

Thanks,
Michal
