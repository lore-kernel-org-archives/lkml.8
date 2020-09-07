Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A7C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 01:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE7B206B5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 01:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=BOOTS1.onmicrosoft.com header.i=@BOOTS1.onmicrosoft.com header.b="zSAxy3v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgIGBav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 21:30:51 -0400
Received: from esa2.wba.c3s2.iphmx.com ([68.232.133.216]:38588 "EHLO
        esa2.wba.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIGBau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 21:30:50 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Sep 2020 21:30:50 EDT
IronPort-SDR: oBft64mf1wUwFGVt3jVAPyZYb71B7aX9YG0kaVsNwHQr41meeWa8QPYi2Rjbn2cEMiOrQwrZ+C
 4+cJcI3vY4HK5NV5HvIDPj2u2wOsg7ptuY5u220xi72qkFvplik2JqSEx8UtllWVjsRMa7RjrH
 55C/OIac+ZGPyYDu+vvUm0VhOgCbh4SOfMPWnO9Py3jBXGqmKQqSoN+ZiM/p+9f5HdWQJLzT83
 ix9NvS2pq5zfl8IPxWmj0WQPr4aozwRisMtZ8VqOTsS8FxpotbB4G5G+xaN44ltj1hrXEY+CXI
 sBI=
X-IronPort-AV: E=Sophos;i="5.76,400,1592870400"; 
   d="scan'208";a="321781275"
Received: from mail-db3eur04lp2059.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) ([104.47.12.59])
  by ob1.wba.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 01:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtPDkkAwIVKoBW4yhEgDbChMJxEQcYXFrcVITMO8+7Z4kMgqYnXYuiy/3vEke8vna8Bu1OIMkICLx0E0uGQ4xCZJEmkk4syD1pTh9WmwK57RHAS8y27KZWC/i9BUSi9jM+5wAU0ARLdKycj1pfWt3OwxcLbE9pKBVgpKzhRRogAphOSLZjfSREFx+DGVHezk1v+SYJpfKVr/KlaFVz6s6UVCKN3gVfYwojFFlK5Df18yuzHNedFFSxu/sVI5Ty0alrDMscSCHw1Od+W05jrmayzEI1AEZpaBbr8qaxTYv6G5+k5nRIYCni2L8QlN1ZSmpLOlxT8wKUR0Eco9CBSwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K29uejQgMN/OTteyJBppvtNmF0bKD274t0811pRLf00=;
 b=TEJ6TDtB8N5SPCWull/4QAcGgfSr0yoITyY8rsy0LwNwRsV51Vx317FwtXbuMBthnuGrsqfmDSx8E4xODbcvf4BATZGjUwGwSKhKjB+bWNR84H0IbTFye1nk5Va21Vv8FZx4OUcUh5pfHElKTl++cvGaQNhuStoEpxkl4amF2/bDnhE0nJBDcPG8Wa+6VquVZvxaZSBN8dVfjrhfIHTdYrgOCGY/uC64rgn3tLVZesrqj97clWHTAkte6PhgKF07q2foqzeA/uSIsk0LDzZeash7D6yEvi7aUqouzfZFYu06ILdZGoQ+bFWsyDQPJL8u4T50fMrZiUSRIrzAk47WnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bootsretailusa.com; dmarc=pass action=none
 header.from=bootsretailusa.com; dkim=pass header.d=bootsretailusa.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=BOOTS1.onmicrosoft.com; s=selector1-BOOTS1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K29uejQgMN/OTteyJBppvtNmF0bKD274t0811pRLf00=;
 b=zSAxy3v6MIvTKbKqfPHdrp3aiwPVw81AAsMmjLkMItwkRbgVtxw45vLlllD9jlibk8oAhpPstlQKAmwDSwz131enrfl1TPZJRdDoh6DhXzKVNw7MdQIU4V0GkOGvcxrn1KjooTonC4OJK8TPSHV9Ng4gPoutCpMpMjNylTarI8k=
Authentication-Results: pantiesparadise.de; dkim=none (message not signed)
 header.d=none;pantiesparadise.de; dmarc=none action=none
 header.from=bootsretailusa.com;
Received: from AM5PR0401MB2466.eurprd04.prod.outlook.com
 (2603:10a6:203:35::23) by AM6PR04MB5159.eurprd04.prod.outlook.com
 (2603:10a6:20b:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 01:25:15 +0000
Received: from AM5PR0401MB2466.eurprd04.prod.outlook.com
 ([fe80::9025:3642:4459:65bb]) by AM5PR0401MB2466.eurprd04.prod.outlook.com
 ([fe80::9025:3642:4459:65bb%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 01:25:15 +0000
To:     "annabell 92" <annabell_92@pantiesparadise.de>,
        "Michael Kores" <michaelkores@me.com>,
        "hotjosie" <hotjosie@pantiesparadise.de>,
        "Euphoristin" <Euphoristin@pantiesparadise.de>,
        "sweet and hot" <sweet_and_hot@pantiesparadise.de>,
        "utf 8 B WmRlbsSbayBQb2zDoWNo" <zdenek@kaora.cz>,
        "linux kernel" <linux-kernel@vger.kernel.org>
From:   Bernd Weber <sarah.nierenberg@bootsretailusa.com>
Subject: =?UTF-8?Q?=EF=BB=BFRe=3A=F0=9F=91=8D=5BBernd_?= =?UTF-8?Q?Weber=5D_=285=29?=
Message-ID: <567d417e-248d-46f6-bd95-4d2def7b229f@bootsretailusa.com>
Date:   Sun, 6 Sep 2020 15:16:29 -1000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Language: en-US
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To AM5PR0401MB2466.eurprd04.prod.outlook.com
 (2603:10a6:203:35::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail.bootsretailusa.com (139.5.159.88) by SG2PR02CA0111.apcprd02.prod.outlook.com (2603:1096:4:92::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 01:25:10 +0000
X-Originating-IP: [139.5.159.88]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b100b3ad-294d-4d98-58d1-08d852ccdf6e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5159:
X-Microsoft-Antispam-PRVS:      <AM6PR04MB515909F028183DA742E896FAFE280@AM6PR04MB5159.eurprd04.prod.outlook.com>
X-WBArule: V1
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:      rWjF62ig9al7ssteRkdHrwWZv/h4o0tcvOnoKdCXEjhuYdExhXshInuEwgM8TcrWBN+mCnxrHI6HCJswHzK0crq1vCXaESZGatM0mHS4Px+L+d9oKip3GH72jf0JF0q5WcwmpVFDbkLeYETbTqsJFau1ErFV0wVKk3M4IQvjLYElK0D9FeDtV8l8oBJRUfoKpOZ8/h7QOeiJ1fgSOaDgnMeIOkAXRPnzi78awfk7P/NutHC0+le8Xkj+oK00Nm6TD1BCZxkjrbD9gco0VBMcC/kkfpp0JW1V0m/Jrjj7jCHgWuBgM5dqeaVMIdA1NTa+3DBDwDqgOcGBxJTcdYbdriISGNMuHzsQbIR4A4Oj6o1u/D7szwPbLjTDvmUbmGBOcwgqDcM4HL7faa4e78DYuwDnfqfz5fnbzvkZZote5KT6yN3VIjMmP4Za1z+WocTkMYRkxM31k9L0Ei5k7S8ldgvp1EzazQsgl0D56+eMZNU=
X-Forefront-Antispam-Report:    CIP:255.255.255.255;CTRY:;LANG:de;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0401MB2466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(966005)(83080400001)(4744005)(36756003)(5660300002)(110136005)(6486002)(8936002)(86362001)(66574015)(2906002)(6666004)(316002)(26005)(186003)(478600001)(52116002)(7696005)(31696002)(66556008)(66476007)(66946007)(16526019)(31686004)(83380400001)(2616005)(956004)(43740500002)(493534005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData:     Rt/e/hgKkfd+I1vQ0NVLJsN95C7BcaIsIn/CiADI/t4AYgnRpWgG0ru99te1WYIaSXo2DIG/e0YnKV3A8h73EgqokBHajlft7HG6929onAM1uFgW/sgWHxEp5ThJ3tIxNqTJSHglNQBhU7bqywJ9nEN+F5e+wG9yx3d7XHJk7WchUb/REp746XWVgqRTXqw36Irr4fG+B6DUPvB5VAbQT1ctOw7i+Fpw2KDLY0T3IV8TtfzK53P8bUbo/wH/6dEyU+CUIh42NnIprZKukxeeS4ZtcyveX38/va1F2FDzoSXfqc3TuwePCh0oj8RSqBjqS82q7ULJOXOelllSO4mWIPbeIG/0iSMHPWP7P3albyVQIe8D2JtBaYoT47uRFSccB9uA5Hhzga6deXAe7lYSat/vkpdnbxjjdHXbpNvbOVmWffMUkW7IPRL1BsahhLPIr6Al+7BFO3Lm4JmWSnt6KRTBjrj4H2HL0MrHpZjJfzX9lZhfzfGETyrMQRiM/VFLLaSQtU6CB+SPMHtqnBWQE0Rc5LInh2mqSfAjqQOn1tq83W+tml88NjoaMhbrgVvs9zIsxURyB+HuZgbu9N2GviKQy1b6bsi6rrj5+IOCqj2OddMIwVbC1+Ec9sZEucCkzfib5BEeMSCiokBSSLhBXQ==
X-OriginatorOrg: BootsRetailUSA.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b100b3ad-294d-4d98-58d1-08d852ccdf6e
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0401MB2466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 01:25:15.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f761680c-0582-4825-b245-62c1d05b6b3a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpiIE3nL2szSOG+Wj+L2utP/wEHzgbQX+zSfH6jTOw6ZfOp4bgUfUAK0K1Vfjf1jkXcxHQXIKybu31AqG09ypcVHeOyZvImjHC/0ENO7QUuuEhmDrZ2o2Ha/Pm9gptY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5159
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgrwn5OpIFNhbHV0LiBJY2ggaG9mZmUsIGRpciBnZWh0IGVzIGViZW5zbyBndXQgd2llIG1pci4K
aHR0cHM6Ly9iaXQubHkvM2p1OFR5VAoKCgogQmVybmQgV2ViZXIKCgoKIDkvNi8yMDIwIDY6MTY6
MjkgUE0KQm9vdHMgUmV0YWlsIFVTQSwgSW5jLiBpcyBhIG1lbWJlciBvZiBXYWxncmVlbnMgQm9v
dHMgQWxsaWFuY2UuIFRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBpcyBj
b25maWRlbnRpYWwgYW5kIG1heSBiZSBwcml2aWxlZ2VkIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQu
IEl0IG1heSBiZSByZWFkLCBjb3BpZWQgYW5kIHVzZWQgb25seSBieSB0aGUgaW50ZW5kZWQgcmVj
aXBpZW50LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IHlvdSBzaG91bGQg
bm90IGNvcHkgaXQgb3IgdXNlIGl0IGZvciBhbnkgcHVycG9zZSBvciBkaXNjbG9zZSBpdHMgY29u
dGVudHMgdG8gYW5vdGhlciBwZXJzb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgbWVzc2Fn
ZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB1cyBhbmQgcmVtb3ZlIGl0IGZyb20geW91ciBzeXN0
ZW0uIE1lc3NhZ2VzIHNlbnQgdG8gYW5kIGZyb20gV2FsZ3JlZW5zIEJvb3RzIEFsbGlhbmNlIG1h
eSBiZSBtb25pdG9yZWQgdG8gZW5zdXJlIGNvbXBsaWFuY2Ugd2l0aCBpbnRlcm5hbCBwb2xpY2ll
cyBhbmQgdG8gcHJvdGVjdCBvdXIgYnVzaW5lc3MuIEVtYWlscyBhcmUgbm90IHNlY3VyZSBhbmQg
Y2Fubm90IGJlIGd1YXJhbnRlZWQgdG8gYmUgZXJyb3IgZnJlZS4gV2UgY2Fubm90IGFjY2VwdCBs
aWFiaWxpdHkgZm9yIGFueSBkYW1hZ2UgeW91IGluY3VyIGFzIGEgcmVzdWx0IG9mIHZpcnVzIGlu
ZmVjdGlvbi4KCgpCb290cyBSZXRhaWwgVVNBLCBJbmMuIGlzIGEgbWVtYmVyIG9mIFdhbGdyZWVu
cyBCb290cyBBbGxpYW5jZS4gVGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMp
IGlzIGNvbmZpZGVudGlhbCBhbmQgbWF5IGJlIHByaXZpbGVnZWQgb3Igb3RoZXJ3aXNlIHByb3Rl
Y3RlZC4gSXQgbWF5IGJlIHJlYWQsIGNvcGllZCBhbmQgdXNlZCBvbmx5IGJ5IHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgeW91IHNo
b3VsZCBub3QgY29weSBpdCBvciB1c2UgaXQgZm9yIGFueSBwdXJwb3NlIG9yIGRpc2Nsb3NlIGl0
cyBjb250ZW50cyB0byBhbm90aGVyIHBlcnNvbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBt
ZXNzYWdlIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHVzIGFuZCByZW1vdmUgaXQgZnJvbSB5b3Vy
IHN5c3RlbS4gTWVzc2FnZXMgc2VudCB0byBhbmQgZnJvbSBXYWxncmVlbnMgQm9vdHMgQWxsaWFu
Y2UgbWF5IGJlIG1vbml0b3JlZCB0byBlbnN1cmUgY29tcGxpYW5jZSB3aXRoIGludGVybmFsIHBv
bGljaWVzIGFuZCB0byBwcm90ZWN0IG91ciBidXNpbmVzcy4gRW1haWxzIGFyZSBub3Qgc2VjdXJl
IGFuZCBjYW5ub3QgYmUgZ3VhcmFudGVlZCB0byBiZSBlcnJvciBmcmVlLiBXZSBjYW5ub3QgYWNj
ZXB0IGxpYWJpbGl0eSBmb3IgYW55IGRhbWFnZSB5b3UgaW5jdXIgYXMgYSByZXN1bHQgb2Ygdmly
dXMgaW5mZWN0aW9uLgo=

