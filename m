Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732F420737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="Oea9ECza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgFIBA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:00:59 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:6096
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727884AbgFIBAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGVdN7sg0GenyobMj2gNVuJ48zawcZZmPGqETycQdrAHRfLXXCNH3Y4BR5TYiGAybcdOTG4PBVMqF29F/pZwtB4bsGRFy/Hkn9BT1QyLSqXQcr9NqfZ9GBTMY6AP2twXCFf4qQYQRffsBzOArqxDTcAqXLAlWBvgjDX1wDm/LCckdrJTnwsOuC+YkHxZOXVOldQAqsmIx6laDgP1hCZ0JyHf1YlVLIVuvGp6zIUzAqyDFtLlhwrsBTHAJdW6jcHOU+ek8RQYrc0DtomfaeS3RHSMEA7Ra1s4WBcQnBQUn6OtNK0lLG9LjS2/QLMz8PVkMKhDc+4cm8xKtZraD2UzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9c5B8+hT9NSRU4nWj6ZWB7+/535KG6Plkzp6oQHtz4=;
 b=Jjyvc2lYFDws8nXFM/wzE6Lxc65hHAdjEzMcjs8hCBVvGQRt9FFmVmfz2U9kh5tpdJs2VRkoiGQ+jTvh7AJzKHFptWTgwYA40Vb7yYM/BRp/S1kBPltUqbZwXqw/dbjkvGY5ZY4sn8klE+Mu4O1EnapYA+4+sM6CTGutlLQWFRjmA89g27eBeZbNxksLcLq8RYHaumHpZlL1RhcBA9kyrQ+68KF6eWvgl/X2w26hVXDiEULqA3Z+iyHvtNUecVRR55qc8ZMccAipP0I8W9Z7fZwZ6dd4B8srqGVX9hVhH+BcNWCTeot2ACiwi0+bzkPSQEx9b2+nuoPC7uA7x2+1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9c5B8+hT9NSRU4nWj6ZWB7+/535KG6Plkzp6oQHtz4=;
 b=Oea9ECzaqf9eTUVbHcIdgp6+4QDXWxDwsw2IEBdoxWHPO6x6XKMj7zP02Fjl8SCV98Iz5X4s/4kLuye19qmDjCwCgHDDyxc0a31RlSjKGnY0VsExKWMY8ox7DSQHjUyLOyxWyg3LBvOvAxy7I842GT/bfQSte2xDY8UN8iZKO00=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2747.namprd11.prod.outlook.com (2603:10b6:5:c6::22) by
 DM6PR11MB3084.namprd11.prod.outlook.com (2603:10b6:5:6c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.22; Tue, 9 Jun 2020 01:00:44 +0000
Received: from DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8]) by DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8%4]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 01:00:44 +0000
Subject: Re: [PATCH] dtc: also check <yaml.h> for libyaml
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200608084117.4563-1-jiping.ma2@windriver.com>
 <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com>
Date:   Tue, 9 Jun 2020 09:00:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To DM6PR11MB2747.namprd11.prod.outlook.com
 (2603:10b6:5:c6::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend Transport; Tue, 9 Jun 2020 01:00:42 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21624f09-73b7-41d7-02cc-08d80c10897d
X-MS-TrafficTypeDiagnostic: DM6PR11MB3084:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3084A31E2C7B03744D00287AD8820@DM6PR11MB3084.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UslHGx2ec5+UDdslXVZaWtddrx67Dt25urGYEQnz9fHCZ3Loo7pLX/CW89fq3Vm1MDmf+t716gWbvLVDEdDn7xQgxmPKZgIbgN+/AWaTOFaivvf/38P+tJRbRF7li4VK57d3L9+DqOrPoaOX8arpw6KMkFsNgocpV2L9DkKP43SsRH9jdMm8B3I6+ZuTRkEGwkcV18Ds49E5PisZi1cxnaaek8uDhgEZDITc2RryXW9rzGH+h0nj7vICy2fmHPUZO3pbfRb4s+N4K0dtgJwMLGFXmuHa8J0VN4WHjWqrmW8FsgzbCZ6RdSRmjltoPVSFPpSNipxMPKe3lFOynmCehZxPkcs1WFLp6cfFo0PCbfFnnVa2rBFuIA7/GuhInrfJ6nxUkkxixGBXMEZ76O5Gtjl6poAEKH5Ng+Ujq9YwTujapiNE2ouI6S3QkUaVU3Gh2ITNuY9mi5YFBQCj1ZmJfd+6EB70GrsC/MNyl6616wu7hN29VphQA5cUy3TISZEJw+fEFxLIyDhNbjWl8GmxHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(136003)(39850400004)(346002)(86362001)(2906002)(6916009)(956004)(5660300002)(186003)(6706004)(53546011)(966005)(16576012)(52116002)(66946007)(16526019)(36756003)(316002)(2616005)(478600001)(6666004)(31696002)(26005)(4326008)(31686004)(66556008)(8676002)(66476007)(8936002)(6486002)(54906003)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: H2rKUpsJc2KSAOc1UcXtjXV3UJQ5KCFCkyc3mKn97cmaxtVKJXQz9c5ijT5TzMno+IEDA16tZxU8yBrzDTbSUMpluveGdyw2E9+ShodcPRHgeDCKKB9xMT4mwGGCDao5PdnjBC0EvNp/HoW7NL3bUnGh7aJbrodPgXYcCY1D6kOnoSQrkazVBVYPmPF4AXGWoU7aMPMxT/WyfoZe+au1iCuMz6xleypTnrI10Adby05u0qFMSj1S+N7Qkmeqktn+/5/PxEh16Kf6Z/ymhinDiB/oYmEMYWYP40vC4/84oRqCmy4i/ag8QTUF+CuAayWwcb8nYTtHz6ywtAvqt6tNPWRI5mKSwxX7YxQ0ODnX8kSS6Pb6YPJxbwYU/J/KysIxP/CG599Nb0TDRIddBhYOFgcnosQfd4HSA9AQZmAoiEvJQsxHLOVpPiZQVbWahVGdKfhtpPjaOPyjTnNTgsvXb55G7FZWdRAlKF9amHjdPTs=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21624f09-73b7-41d7-02cc-08d80c10897d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 01:00:44.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kHBufCYTMdCtSTvHbNxr3o7d97wqvdM7SH7k5fuvcEbqj+KqnQUN0r2WcgSPv/jVVwTmkx8hdtzyKrigcY3jn902Gmn5BjC903m/ZnDaSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2020 03:09 AM, Rob Herring wrote:
> On Mon, Jun 8, 2020 at 2:42 AM Jiping Ma <jiping.ma2@windriver.com> wrote:
>> yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
>> it fails to build.
> Does this patch fix your issue?:
>
> https://lore.kernel.org/linux-devicetree/20200505100319.741454-1-masahiroy@kernel.org/
No, it did not fix the issue.

$ pkg-config --cflags yaml-0.1

$ pkg-config yaml-0.1 --libs
-L/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux/usr/lib64 
-lyaml

>
>
>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>> ---
>>   scripts/dtc/Makefile | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>> index b5a5b1c..b49dfea 100644
>> --- a/scripts/dtc/Makefile
>> +++ b/scripts/dtc/Makefile
>> @@ -18,9 +18,13 @@ $(error dtc needs libyaml for DT schema validation support. \
>>   endif
>>   HOST_EXTRACFLAGS += -DNO_YAML
>>   else
>> +ifeq ($(wildcard /usr/include/yaml.h),)
>> +HOST_EXTRACFLAGS += -DNO_YAML
>> +else
>>   dtc-objs       += yamltree.o
>>   HOSTLDLIBS_dtc := $(shell pkg-config yaml-0.1 --libs)
>>   endif
>> +endif
>>
>>   # Generated files need one more search path to include headers in source tree
>>   HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
>> --
>> 1.9.1
>>

