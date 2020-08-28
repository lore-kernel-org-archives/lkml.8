Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE4B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="Uem7gECo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgH1TcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:32:19 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:37318 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgH1TcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:32:17 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCFCB640FC;
        Fri, 28 Aug 2020 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598643136;
        bh=BfduHoPBRqw542mp4yCCJAun7NmcVtuhCzggelPOdLA=; h=From:To:Date;
        b=Uem7gECoruu2Nkeu+sPDFVgVKU7eLZxI91C5MhI7+wP/oD5+/RVeD6uoLMWsPpbXK
         Km5ICJ+FzbG4takf1yVZPGmCE1G23jfOgLIQfcJQVrZQCJYbe3bjmdlzC1Z/KZ/GgR
         MkecUaNDZDi6eyLwy5XbXR5rbSih3HOgNVAKKanY=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B09B8640F9;
        Fri, 28 Aug 2020 12:32:15 -0700 (PDT)
Received: from SJDC-EXNABU02.us.trendnet.org (unknown [10.45.175.98])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Fri, 28 Aug 2020 12:32:15 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU02.us.trendnet.org (10.45.175.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Fri, 28 Aug 2020 12:32:15 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Fri, 28 Aug 2020 19:32:12 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae%18]) with mapi id
 15.01.1979.003; Fri, 28 Aug 2020 19:32:12 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v4 19/23] kprobes: Remove kretprobe hash
Thread-Topic: [PATCH v4 19/23] kprobes: Remove kretprobe hash
Thread-Index: AQHWfTcCPAvijWdZV02kFYMcVOy18qlN53EQ
Date:   Fri, 28 Aug 2020 19:32:11 +0000
Message-ID: <305dad6efa9e4c42b13b72a5f770b933@trendmicro.com>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861780638.992023.16486601398173945135.stgit@devnote2>
In-Reply-To: <159861780638.992023.16486601398173945135.stgit@devnote2>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25632.002
X-TM-AS-Result: No--18.835-5.0-31-10
X-TMASE-MatchedRID: /4SShi32LqnUL3YCMmnG4vHkpkyUphL9Ud7Bjfo+5jS+neTg/GjYRWtC
        BJGDrKJFMxxiwjuhslSIRzTlyFW0T1WZAt3VKpANDDlsUbcsIPoV8rV6fVLsBJGPHiE2kiT4CK1
        n+RaAKL/4okNLoAgG2AzXhWRvHirtfn4iGFMOjcF/RMANDlvEJUjkgoGa55VaubyBLYGTbJ4kwl
        cMmOSp1MzNmiK+FZHsh77ERM5D5CigOLpAtl1GSiHy+OQp353mVaIFkbBGkf5orJ9Zo8/Nn3Q/j
        3O0draBLNsZ5fRaFK8uqQBB7/YUXCH/qIKp8YHg1sSjM2FcB1c6En2bnefhoFY9yet6QEd8qkgD
        Tw+5vfzhy4iI9Ia71x7iZrW5w/uYf/9oLiCflNjCtSG/SQAC8f9k6rHgljHbmyiLZetSf8n5kvm
        j69FXvEpZ1N/CwmPLVkVZa47CjvDdB/CxWTRRu25FeHtsUoHuKCXl0h2WI7pqNEAypi/a342SSp
        F7FcRttn1t2BvNAaBLhb8xGEnVfg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.834600-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25632.002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0CED7D414FFB1DADD234A20FD946366168524266467BB94417AA2B5DBA024D302000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--18.835-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hc2FtaSBIaXJhbWF0c3Ug
PG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+DQo+IEBAIC0xMzExLDI0ICsxMjU3LDIzIEBAIHZvaWQg
a3Byb2JlX2J1c3lfZW5kKHZvaWQpDQo+ICB2b2lkIGtwcm9iZV9mbHVzaF90YXNrKHN0cnVjdCB0
YXNrX3N0cnVjdCAqdGspDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGtyZXRwcm9iZV9pbnN0YW5j
ZSAqcmk7DQo+IC0gICAgICAgc3RydWN0IGhsaXN0X2hlYWQgKmhlYWQ7DQo+IC0gICAgICAgc3Ry
dWN0IGhsaXN0X25vZGUgKnRtcDsNCj4gLSAgICAgICB1bnNpZ25lZCBsb25nIGhhc2gsIGZsYWdz
ID0gMDsNCj4gKyAgICAgICBzdHJ1Y3QgbGxpc3Rfbm9kZSAqbm9kZTsNCj4NCj4gKyAgICAgICAv
KiBFYXJseSBib290LCBub3QgeWV0IGluaXRpYWxpemVkLiAqLw0KPiAgICAgICAgIGlmICh1bmxp
a2VseSgha3Byb2Jlc19pbml0aWFsaXplZCkpDQo+IC0gICAgICAgICAgICAgICAvKiBFYXJseSBi
b290LiAga3JldHByb2JlX3RhYmxlX2xvY2tzIG5vdCB5ZXQgaW5pdGlhbGl6ZWQuICovDQo+ICAg
ICAgICAgICAgICAgICByZXR1cm47DQo+DQo+ICAgICAgICAga3Byb2JlX2J1c3lfYmVnaW4oKTsN
Cj4NCj4gLSAgICAgICBoYXNoID0gaGFzaF9wdHIodGssIEtQUk9CRV9IQVNIX0JJVFMpOw0KPiAt
ICAgICAgIGhlYWQgPSAma3JldHByb2JlX2luc3RfdGFibGVbaGFzaF07DQo+IC0gICAgICAga3Jl
dHByb2JlX3RhYmxlX2xvY2soaGFzaCwgJmZsYWdzKTsNCj4gLSAgICAgICBobGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlKHJpLCB0bXAsIGhlYWQsIGhsaXN0KSB7DQo+IC0gICAgICAgICAgICAgICBp
ZiAocmktPnRhc2sgPT0gdGspDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJlY3ljbGVfcnBf
aW5zdChyaSk7DQo+ICsgICAgICAgbm9kZSA9IGN1cnJlbnQtPmtyZXRwcm9iZV9pbnN0YW5jZXMu
Zmlyc3Q7DQo+ICsgICAgICAgY3VycmVudC0+a3JldHByb2JlX2luc3RhbmNlcy5maXJzdCA9IE5V
TEw7DQoNCkkgdGhpbmsgd2UgYXJlIGZsdXNoaW5nIHRrIGluc3RlYWQgb2YgY3VycmVudCBoZXJl
Lg0KQWZ0ZXIgZml4aW5nIHRoaXMgdG8gdGssIHRoZSBOVUxMIHBvaW50ZXIgZGVmZXJlbmNlIGlz
IGdvbmUhDQoNCj4gKw0KPiArICAgICAgIHdoaWxlIChub2RlKSB7DQo+ICsgICAgICAgICAgICAg
ICByaSA9IGNvbnRhaW5lcl9vZihub2RlLCBzdHJ1Y3Qga3JldHByb2JlX2luc3RhbmNlLCBsbGlz
dCk7DQo+ICsgICAgICAgICAgICAgICBub2RlID0gbm9kZS0+bmV4dDsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgcmVjeWNsZV9ycF9pbnN0KHJpKTsNCj4gICAgICAgICB9DQo+IC0gICAgICAga3Jl
dHByb2JlX3RhYmxlX3VubG9jayhoYXNoLCAmZmxhZ3MpOw0KPg0KPiAgICAgICAgIGtwcm9iZV9i
dXN5X2VuZCgpOw0KPiAgfQ0KDQpUUkVORCBNSUNSTyBFTUFJTCBOT1RJQ0UNCg0KVGhlIGluZm9y
bWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgaXMgY29u
ZmlkZW50aWFsIGFuZCBtYXkgYmUgc3ViamVjdCB0byBjb3B5cmlnaHQgb3Igb3RoZXIgaW50ZWxs
ZWN0dWFsIHByb3BlcnR5IHByb3RlY3Rpb24uIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQsIHlvdSBhcmUgbm90IGF1dGhvcml6ZWQgdG8gdXNlIG9yIGRpc2Nsb3NlIHRoaXMg
aW5mb3JtYXRpb24sIGFuZCB3ZSByZXF1ZXN0IHRoYXQgeW91IG5vdGlmeSB1cyBieSByZXBseSBt
YWlsIG9yIHRlbGVwaG9uZSBhbmQgZGVsZXRlIHRoZSBvcmlnaW5hbCBtZXNzYWdlIGZyb20geW91
ciBtYWlsIHN5c3RlbS4NCg0KRm9yIGRldGFpbHMgYWJvdXQgd2hhdCBwZXJzb25hbCBpbmZvcm1h
dGlvbiB3ZSBjb2xsZWN0IGFuZCB3aHksIHBsZWFzZSBzZWUgb3VyIFByaXZhY3kgTm90aWNlIG9u
IG91ciB3ZWJzaXRlIGF0OiBSZWFkIHByaXZhY3kgcG9saWN5PGh0dHA6Ly93d3cudHJlbmRtaWNy
by5jb20vcHJpdmFjeT4NCg==
