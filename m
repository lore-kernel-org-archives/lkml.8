Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA0BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7167E207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="eLN9RmOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgFIDIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:08:09 -0400
Received: from mail-eopbgr680064.outbound.protection.outlook.com ([40.107.68.64]:1508
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbgFIDIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXwfdOAK147mQyzWS/Gh00wwQ2RFpv+sVNEfVyW9CFibyrijpXqmJ5jQfF18PcfbS3m/zeWe4NuHkxnJZUZMvjBb5DZi7y2j3Vxo5krRIcajIoRTOT3YTbkILiKxoL1bvqLTQpLJ4c2p8LGSqpsR/OgAdok/9QsOccI5wZofhp7lGR0kZnazZyQi7cBaKyrmXUV7H6JUXt2Rw/fNdBlfy2RxlNjbCtfbllKml/Q57xlr/afuqsCztYE6pNp8k0rdPU7jTCV/5eEeNKGUpla+/eElBj9d6ku/wqQExOBC9RIjoB55nittluY1k9F5/yAu6yUQ0xeC9o7skWzDW5F4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQsMU6gNuowAtZGbEP37YPhYzVX+cbmwawQyWiwB2zI=;
 b=caJ3tIjO8NHwuMx756Qkj+wu9HAB9azcSCRYfcFicXJVBE21xlUZZPAxhj6anK3rOG5eA+a7y60uGCrNjQ53u49VYEQBvF2hQs3fdqGE4xosAjOyo5LF7/tyzoLVi8mLwTaQL/PyGAx1SIpjlRVy7aA0SLYieya3asntt334qrpL30VWDgwMxmPC4IoQlTU/wO0UxgFLetWz6KplA+YGBfVWHvEA1DcTzxSlOrnd06nC908KSJnhLxu7ydVcdbSQWtG/vHV25MB0SB/mgZNHWGxTtDbzmgH/vDhwVuCaIY6y496MA+UHEMPPnzvKDDfpICo5MLJBesn5jxdMa2oCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQsMU6gNuowAtZGbEP37YPhYzVX+cbmwawQyWiwB2zI=;
 b=eLN9RmOj1/XJmm2oE04zdH8amMxBA6AkHdyeIbmX69HamP5gpaiZvhEogWWl2W3//SwXf5RPHHI5Egx7aA+HYu6fZZ0QrydJBoOol2Ru7Pk+8POb0jPS/7bYMM8jqde/TW79FVKUtgkx+FZpb9sB1gFfP7oLyUCi7R5yNpXDSVw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2747.namprd11.prod.outlook.com (2603:10b6:5:c6::22) by
 DM6PR11MB3465.namprd11.prod.outlook.com (2603:10b6:5:b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19; Tue, 9 Jun 2020 03:08:04 +0000
Received: from DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8]) by DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8%4]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 03:08:04 +0000
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
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <d76f0e39-e22c-7179-955a-981d42b7bc01@windriver.com>
Date:   Tue, 9 Jun 2020 11:07:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <CAK7LNAS3xOvkUWZzZcb7Mk2YsWo+A6XTjzTZjxjvkYCjWjQvFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To DM6PR11MB2747.namprd11.prod.outlook.com
 (2603:10b6:5:c6::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 03:08:02 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de77cec3-4d74-4089-ce87-08d80c225352
X-MS-TrafficTypeDiagnostic: DM6PR11MB3465:
X-Microsoft-Antispam-PRVS: <DM6PR11MB34651B0C349B854C774C47BBD8820@DM6PR11MB3465.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUaUucBzNiQ13MNWQRx5TVOkOqEppQqim5IGPoNChnjdu/omUtwAxkvp6lu64ytwJY5QkNwWok2/zMj9bfF0B52Ef8LtURrxewfPTR3jCHH+r5SqNdmf7dE4wOf48kALszCykIsdRWMMn+Y4oVl8yUsE84gv1x/w3PC7RETKC0K1ZygJgAtkalrQm1EcdOXKmtK2f/VA+W7/u52H6zC8Kx+0WSh7XEw57UlN86bmegiXMAFjpSCy0ujrJNA5A7CLweShaXaDvM41APDi+XcGcA+WQg9BKfPdqB6QyO2QK02NaPZ56LfvJ0VAYV/BIJaiq5IanjcoYl2CbG9MlKKQsOqP7FRVVNDUvftYn8QpdtXmh0GBrgojJb5vWGlKd6yxHe4fqxss405s5EuDg9UsHIU5oVv713tF5SrxJPPG35GocrS7DyYwL3wjPFVTx8jtzGaYuHzn75Xl4H5tCfqWFGVp2elLeXJ9SpoeNd9oMhUtSRlD5prchr0ys8BA18Qyx1KfoTCppjiQIczLLUPKQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39850400004)(346002)(396003)(376002)(136003)(6486002)(316002)(2906002)(66476007)(966005)(16576012)(86362001)(478600001)(54906003)(6666004)(66556008)(6706004)(66946007)(31686004)(8676002)(52116002)(26005)(36756003)(16526019)(4326008)(2616005)(186003)(8936002)(5660300002)(31696002)(6916009)(956004)(53546011)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S1uB+9Vloj6P40IeA7QvJ9BKxFSBilJ1Wpv2zVuZxsRvVegwYnoWsqcBAHI1cCmk9Ggkhb3OLWBvIJYny8O2ltkJrTksuC7rLCI8WsG99E/x5ggiqTeDwa7jwHTc6fm7THqxbirIbzbMT8PhYBSxMmzocMrmX6U/UbBr5y3Kj/6nCXCFDFNLjKDT3hilPsED+1AV6PQ5/raHp4wZQEixp/+FQXKMQddh5QswSEPnRHyQAxDDWh87BC3T4j1SkWb5cmRutai56cTwfppQXJS0ZvB36HwTvYhyiKVwvU+vkU+v76USuSehIwryiIOBpVt45ti5o5stV/bioiUrMOuS793VOeFADAKhBmsflFcnL7KuaNaAD1olLaovn/AFCAqxz8h+yf6A1nH80cLeEZwdZklyBLnNvHzrRpi3hd5cl875gtrVlA9EFYKcVC6F30yrURLc+O6KW8zsRzrbul1Myc6tZOTMaDkAmctGGMzlrG4=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de77cec3-4d74-4089-ce87-08d80c225352
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 03:08:04.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rb5t1bxDIC5SnjeD7u3kjWTcKP8OEtHyJaj+2pPgJSswskJ+jXHFg7AHJ89rVDv5jLYcQJMRme6lRjp9LY6BZrMQE2IOmsi05ZBHDuYASoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2020 10:52 AM, Masahiro Yamada wrote:
> On Tue, Jun 9, 2020 at 10:01 AM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
>>
>>
>> On 06/09/2020 03:09 AM, Rob Herring wrote:
>>> On Mon, Jun 8, 2020 at 2:42 AM Jiping Ma <jiping.ma2@windriver.com> wrote:
>>>> yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
>>>> it fails to build.
>>> Does this patch fix your issue?:
>>>
>>> https://lore.kernel.org/linux-devicetree/20200505100319.741454-1-masahiroy@kernel.org/
>> No, it did not fix the issue.
>>
>> $ pkg-config --cflags yaml-0.1
>>
>> $ pkg-config yaml-0.1 --libs
>> -L/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux/usr/lib64
>> -lyaml
This issue happened in Yocto,  After completing the SDK build and 
installing it, use a new shell to source the environment and try to 
build the helper scripts.
export 
SDKTARGETSYSROOT=/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux
export 
PKG_CONFIG_PATH=$SDKTARGETSYSROOT/usr/lib64/pkgconfig:$SDKTARGETSYSROOT/usr/share/pkgconfig
>
>
>
> If I install libyaml to a non-standard location
> (/home/masahiro/foo), my pkg-config shows as follows:
>
>
>
> masahiro@oscar:~$ pkg-config --cflags   yaml-0.1
> -I/home/masahiro/foo/include
> masahiro@oscar:~$ pkg-config --libs   yaml-0.1
> -L/home/masahiro/foo/lib -lyaml
>
>
>
>
>
>
>
>>>
>>>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>>>> ---
>>>>    scripts/dtc/Makefile | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>>> index b5a5b1c..b49dfea 100644
>>>> --- a/scripts/dtc/Makefile
>>>> +++ b/scripts/dtc/Makefile
>>>> @@ -18,9 +18,13 @@ $(error dtc needs libyaml for DT schema validation support. \
>>>>    endif
>>>>    HOST_EXTRACFLAGS += -DNO_YAML
>>>>    else
>>>> +ifeq ($(wildcard /usr/include/yaml.h),)
>>>> +HOST_EXTRACFLAGS += -DNO_YAML
>>>> +else
>>>>    dtc-objs       += yamltree.o
>>>>    HOSTLDLIBS_dtc := $(shell pkg-config yaml-0.1 --libs)
>>>>    endif
>>>> +endif
>>>>
>>>>    # Generated files need one more search path to include headers in source tree
>>>>    HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
>>>> --
>>>> 1.9.1
>>>>
>

