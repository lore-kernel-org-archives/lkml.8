Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4798C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5874206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgD3O3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:29:53 -0400
Received: from mail-oln040092073096.outbound.protection.outlook.com ([40.92.73.96]:52473
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbgD3O3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH+MGtZGusfinikFcB2UVXhlPRK071n5BsiA5uKRWm6sMo483pK77ghhaKEAaO1muiJD4zpNbRDlttfhR+JPWMAlTk6gxznfvqoDeBgyZcXM2UU/iZM6HmRYE1T7D5AMuugg/oggjlts92nLAcLc54CVvsH3wYTlCQSQMW3RAlH/dzNIkAiMd6RrszRzUUYd4FugyR170UZ7rfMQe1QI2g1oprDcgu6GptDEBa6N1iaV4s8bCv/Y4OuARfxuHG4pJD4EHrSSTYV6ObszD9I9mZIbtRCCaoYF40v/Rn8tXTaGepljOKjWc3bnEZja3us09w+/xD2rB0hDHUZIkENt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6fF/4IRI9tpncB0usY22xcm6VOOMOMqj7N0EX1H+W4=;
 b=QCjSPTeCjAcp7u1A+2cvhWUh95tdRGusCxFQjFj49Ksfk0wZ+BilijO5dBaN+GvGw8lJUtThj50lKMaBQfTPKIUGEL6elkdkw9z7aVtZ+462Q6Dmcs32DnOSRraIAqW55YU5pp7bM+qF29uk4r8mTvCGtCiMNqkOD1PWauN+10qs4sGhemGiMZ0l5zEyynznGi2hAq1r96hq9n44fJnEDsu+UvNiYA5o+UX5AZdVP9tJFT6O50qsbk5dh4pSZfu6iSs5rCZMFTxS9OxQ7siXI/su/hRPqMwXvNaEjUWs8PVPgyFxEq2kjvKgVfe524DHzngWvPOFldw8hMwX74cutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from HE1EUR04FT032.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::4b) by
 HE1EUR04HT195.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::210)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 14:29:49 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0d::47) by HE1EUR04FT032.mail.protection.outlook.com
 (2a01:111:e400:7e0d::291) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 14:29:49 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:7DE039EEE2A02A05005C27B26824583ED5FF38EF259508C9108AAB271ADFD05B;UpperCasedChecksum:528972F87A7B883BE8FEADF741BBB663960A1C66608E555F6B78117408B26968;SizeAsReceived:9996;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2958.019; Thu, 30 Apr 2020
 14:29:49 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com>
 <AM6PR03MB5170CCB8D9D41904066DAFD5E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wiOdXfMa35bwCNfCNSsAndO-hFmsSNRWEEDziA1iDYGjg@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170BC4A276D72EA54398C58E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 30 Apr 2020 16:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wiOdXfMa35bwCNfCNSsAndO-hFmsSNRWEEDziA1iDYGjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <7fca8eb0-232b-be41-1807-c8ad248173ac@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.60.225) by FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 14:29:48 +0000
X-Microsoft-Original-Message-ID: <7fca8eb0-232b-be41-1807-c8ad248173ac@hotmail.de>
X-TMN:  [x6zXf9KK/cLkIocDag0A6X4rnbYrKRpo]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2928062f-733d-429f-a367-08d7ed12f011
X-MS-TrafficTypeDiagnostic: HE1EUR04HT195:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSaEaDzoUmr1J1YYiwfDsD2dEYa/P5fCa59MdAhXFHLDVUv3exrY/h2ZQ6Pe45qX9XFu9eOOSEUpCqzmNe23jnz84EG0XdrbKj1LctyUgYr6j8xX86cDiNwQQR1UINkkMo4cWzuIJCoC6AUfM2Mp3CV8EgP2r7hArepGQVQENO55dLI47843CIPGD+y/7hnR6fFYB87j+vcrAc2qKHuVLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: QECCsltX1Z6mo3N47jcVLj1Iu2g5aDeUtHVjNllgrryX3plqz5YWJ56l+KSSvUSydNyO+5+w5I4Qz3xF4DaagGTVyLveqwB/J3mpRqg2r7VuMypgxr9vEQ33kn2son/47cIC95FW+5gX3a9yTbMLNA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2928062f-733d-429f-a367-08d7ed12f011
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 14:29:49.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 4/30/20 3:47 PM, Linus Torvalds wrote:
> On Thu, Apr 30, 2020 at 6:39 AM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>>
>> Excuse me, but what in my /proc folder there is no attr/something
>> is there a procfs equivalent of pthread_attach ?
>>
>> What exactly is "attr/something" ?
> 
> Anything that uses that proc_pid_attr_write().
> 
> Which you should have realized, since you wrote the patch that changed
> that function to return -EAGAIN.
> 

Ah, now I see, that was of course not the intended effect,
but that is not where the pseudo-deadlock happens at all,
would returning -RESTARTNOINTR in this function make this
patch acceptable, it will not have an effect on the test case?


Bernd.

> That's
> 
>     /proc/<pid>/attr/{current,exec,fscreate,keycreate,prev,sockcreate}
> 
> and some smack files.
> 
> Your patch definitely made them return -EINVAL if they happen in that
> execve() black hole, instead of waiting for the execve() to just
> complete and then just work.
> 
> Dropping a lock really is broken. It';s broken even if you then set a
> flag saying "I dropped the lock, now you can't use it".
> 
>                   Linus
> 
