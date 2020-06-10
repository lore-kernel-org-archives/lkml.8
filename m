Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07E42078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="GfRVeO2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgFJBM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:12:29 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:45825
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbgFJBMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:12:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ+s+9/UXTJFcGxiQeB5xR4PSegyiFm2om+yfB5ZU0vJ2HKqDopv+1Vj1f/7lURPw/9TKo1j/SCnQ43KB/sVe2PVG2f8Jz7SsQBNEx5NbZDLb/QDB/f6qd8VKM1PcaCKYaq+PU30j+6ltsrDWziH0JNZVvSOWTAVqQ+gQN4gT5ikAHk4LSLX52Ru952444V1EVWx14prNAI77ZCGWUL86LxVaJpsTf8/TSnxAWKO70QX3koe+JOepqcM458dQyddahcctMxQUcSTDpUj1HMZ7HeZnbGLOsnWP2wQS+XWDC74EuwyY3BkJw9kYjVpuN2pJQvMhD+zQmGTwTVcudM+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZTv9tMKt5HXCGBa5/75leXl8NiAktY7EfoHquH7Dtc=;
 b=iIy+hK0Yh0B9BoEkc2qO/3r+htzfRNU9vyzPrhnrGNilfeKyR0rXsgMGjRcwODMGiBJTuXmu0AwNkOIQaZ8qoTnAm7K7mV6SQYRmEOu7ds1SY0qO/ycVq4WbtogTrIWfVpG2fdfYIEEaPsdycCTTj6Tl3EAPM0AZ4sdxkBIKkO9A7wNEDBXbKDoHuURgKu3XiqP+oD7kx5MSVDuScBub+Gkn0yyyvf1ukhQvm5YBEi0RBcbCZZquZfV2+WeVGgzuFaqBySCnO6vQDhJsOn01j5f94YAe+aGtBG+sOTdRvpPIGA1B0hxWVwewPXo5DeO9S8Qoxrpnh0rB8vpN9q+fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZTv9tMKt5HXCGBa5/75leXl8NiAktY7EfoHquH7Dtc=;
 b=GfRVeO2c+sZGZfOtMTF6j9ql0tx0DihK95oJnnuqH2Go7reUDyzQtEQbwojS+AAs1OaNDC9HRCgqUl45HmoV/M2WdGgwcYtkiw36DDe5FP6kLRLdbedb8mKoHh/FZJ3unfsTo/pwbDDCzHeYS2OOVwQI1FKEBPixgwGTmEsQvE0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2747.namprd11.prod.outlook.com (2603:10b6:5:c6::22) by
 DM6PR11MB4267.namprd11.prod.outlook.com (2603:10b6:5:14e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Wed, 10 Jun 2020 01:12:19 +0000
Received: from DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8]) by DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8%4]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 01:12:19 +0000
Subject: Re: [PATCH] dtc: also check <yaml.h> for libyaml
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200608084117.4563-1-jiping.ma2@windriver.com>
 <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com>
 <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com>
 <CAK7LNAS3xOvkUWZzZcb7Mk2YsWo+A6XTjzTZjxjvkYCjWjQvFg@mail.gmail.com>
 <d76f0e39-e22c-7179-955a-981d42b7bc01@windriver.com>
 <CAK7LNAQkXiw9cV=Qt5VrpDGd5CPAPS-EBs0AeOhSJd5JbXtkZg@mail.gmail.com>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <6c5b1422-5b8a-03fe-57ea-567767ed75e2@windriver.com>
Date:   Wed, 10 Jun 2020 09:12:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <CAK7LNAQkXiw9cV=Qt5VrpDGd5CPAPS-EBs0AeOhSJd5JbXtkZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To DM6PR11MB2747.namprd11.prod.outlook.com
 (2603:10b6:5:c6::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.9 via Frontend Transport; Wed, 10 Jun 2020 01:12:17 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78490127-feba-4544-f07f-08d80cdb5264
X-MS-TrafficTypeDiagnostic: DM6PR11MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4267846C8758AAA5C6007B08D8830@DM6PR11MB4267.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxoHs5K+Um0BhpAGSZTXEXB9EICGqpmJfnpTDrMM9FR1wx+g/j6qdRl5swZPe4RS5XSd+OGhp0lpXbNhZW3kAEn9qvzZkiedvxyV+1W7999frofPNh9Kfq949MZ0YJQQzrNXwFqCfRcS8/ytidCtNOPiAdg1SY143AtN8U1Rb91Ew2ALIaWKYvlpWxXxbGFxsHBYAp9AwqYSz5Q62ntMyNIq+ZENtR+6lMHGDVjZG2DX4SzJpLxro3gECTNg6Nh/alCfvlRac64sWu69n328m6CyLkz9b/batZh+6B6fReSa/kBzfwmyaQRZElnL2jPHn4ocmFbkWuIzpYNfyvlGKfeu+tjjhkl0Ve4SdQw90KOZf0ZLgoZVmow83c5Tt4flLXvs9SEAy2S4/VFozG57qSzdsXsvHL5g974hagx39doVVjG9Qr+vSZH5qz5eWWb/jHuT8OtLEMv1lK4ZFCfK4jVzd4+/B/g71dNyAseLeCNOwF/HNMmGjNEHY6ZhPiZk3cSXEiXqQ3k1FIOMGbi51Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39850400004)(396003)(366004)(5660300002)(86362001)(36756003)(53546011)(26005)(6666004)(66556008)(66476007)(31696002)(66946007)(966005)(316002)(52116002)(186003)(8676002)(31686004)(2906002)(16526019)(16576012)(8936002)(54906003)(4326008)(6916009)(6706004)(956004)(478600001)(2616005)(6486002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OK8UdFQyjiJYhpUe4zuLkGeIwCwxr7+OER70k0UARLESpijYbLZCkYj/BEZvn7ItZpel08Z2xBO+J2zxgpKpsTSBbTCINd0eBByYc8pt//xMf5vb2R6HonKkigHYXN+h7ET4LpJaEz1oPGtAdgCW06UBG5X3zG8r7C3uQnDUHFBFRECnLaVjrihSb038o6/DI2Wm020gIhFKL0PrMXx/wr61R9KnV8tVUOQQ6FOK9AAHZ7+R9Rse+zHOU/IsJTCGLAUyleQN0I9hQqwitcuiW8otrcZmuKkotevks/TIU3zzevtxDlPrRXtmYmLJT/yCoMbvOHuZZXRlwElLoPoKP2Mmgs0W7W4r59yM80SlD1t4FHLiWcsvlDLw0I36HL79CMZVX2s6kVPilfIeBNB8p9pFK6Gs2upqT0Xbx0rXuUriOW2dCLJlbWEE1g1t/hPDYJIDzTJ9CtXa+dzkdaMToxuy9m50Uq/hubqNM8mgO3Q=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78490127-feba-4544-f07f-08d80cdb5264
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 01:12:19.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1puLHVC2WLR+M9S6g9pQ6W5k9NeE1xZSti21TIu60kuY2+p3jXlexrSTd+W9x/aTtn7b8/QDnGDLPxsAuLt2Qcb07HdGlPKjWknRn9/ADXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2020 08:28 AM, Masahiro Yamada wrote:
> On Tue, Jun 9, 2020 at 12:08 PM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
>>
>>
>> On 06/09/2020 10:52 AM, Masahiro Yamada wrote:
>>> On Tue, Jun 9, 2020 at 10:01 AM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
>>>>
>>>> On 06/09/2020 03:09 AM, Rob Herring wrote:
>>>>> On Mon, Jun 8, 2020 at 2:42 AM Jiping Ma <jiping.ma2@windriver.com> wrote:
>>>>>> yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
>>>>>> it fails to build.
>>>>> Does this patch fix your issue?:
>>>>>
>>>>> https://lore.kernel.org/linux-devicetree/20200505100319.741454-1-masahiroy@kernel.org/
>>>> No, it did not fix the issue.
>>>>
>>>> $ pkg-config --cflags yaml-0.1
>>>>
>>>> $ pkg-config yaml-0.1 --libs
>>>> -L/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux/usr/lib64
>>>> -lyaml
>> This issue happened in Yocto,  After completing the SDK build and
>> installing it, use a new shell to source the environment and try to
>> build the helper scripts.
>> export
>> SDKTARGETSYSROOT=/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux
>> export
>> PKG_CONFIG_PATH=$SDKTARGETSYSROOT/usr/lib64/pkgconfig:$SDKTARGETSYSROOT/usr/share/pkgconfig
>>>
>
> Probably, this commit:
>
> https://github.com/yaml/libyaml/commit/3c80be99fb18f3ee18af37221a3b0c4760e8df06
>
>
> Use newer libyaml, and that's fine.
This commit already was included in our code.
>
>

