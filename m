Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5723720674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgESXtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:49:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:14086 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESXtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:49:18 -0400
IronPort-SDR: eyKOnRWDRskodIF4mGjgDwFOlonTjjRk+QLa2IFsBO33w4T05uER2fJD+JtEPuDBJ13/wN+OYI
 aZuzbPmph6bw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 16:49:17 -0700
IronPort-SDR: 8LEvj2Uij7gEX6fj7vZsR9AYBGaODVOUxwm28nDwhMn/tuvzXxwFz62VQKKqLuRGwdhjO86Jj9
 /6uDb56vbj0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,411,1583222400"; 
   d="scan'208";a="343309189"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2020 16:49:16 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 May 2020 16:49:16 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 May 2020 16:49:16 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.245]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.232]) with mapi id 14.03.0439.000;
 Wed, 20 May 2020 07:49:14 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, lkp <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>,
        "Nathan Chancellor" <natechancellor@gmail.com>
Subject: RE: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
Thread-Topic: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no
 previous prototype for function 'x86_has_pat_wp'
Thread-Index: AQHWLiqdnaNIwjwzlU2snsVS1CT3bKiwE2HQ
Date:   Tue, 19 May 2020 23:49:13 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E6624952648ACF@shsmsx102.ccr.corp.intel.com>
References: <202005200123.gFjGzJEH%lkp@intel.com>
 <20200519205505.GD444@zn.tnic>
 <20200519212541.GA3580016@ubuntu-s3-xlarge-x86>
 <CAKwvOdk+JwddxLaXc9S7SMMTye8bDaGEckcs7zu5tEMD0G3Yog@mail.gmail.com>
In-Reply-To: <CAKwvOdk+JwddxLaXc9S7SMMTye8bDaGEckcs7zu5tEMD0G3Yog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW3RpcDp4ODYvbW0gMS8yM10gYXJjaC94ODYvbW0vaW5pdC5jOjc1OjY6
IHdhcm5pbmc6IG5vIHByZXZpb3VzDQo+IHByb3RvdHlwZSBmb3IgZnVuY3Rpb24gJ3g4Nl9oYXNf
cGF0X3dwJw0KPiANCj4gTWFzYWhpcm8gYW5kIFBoaWxpcCwNCj4gV2UncmUgc2VlaW5nIGEgYnVu
Y2ggb2YgLVdtaXNzaW5nLXByb3RvdHlwZXMgd2FybmluZ3MgZnJvbSAwZGF5IGJvdA0KPiBzdWRk
ZW5seSB0b2RheS4gIERpZCBzb21ldGhpbmcgY2hhbmdlIG9uIHRoZSBLYnVpbGQgb3IgMGRheSBi
b3Qgc2lkZT8NCkhpIE5pY2ssIFc9MSB3YXMgYWRkZWQgdG8gbWFrZS4gVGhpcyBsZWFkcyB0byBl
eHRyYSB3YXJuaW5ncy4NCg0KPiANCj4gT24gVHVlLCBNYXkgMTksIDIwMjAgYXQgMjoyNSBQTSBO
YXRoYW4gQ2hhbmNlbGxvcg0KPiA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IE9uIFR1ZSwgTWF5IDE5LCAyMDIwIGF0IDEwOjU1OjA1UE0gKzAyMDAsIEJvcmlzbGF2
IFBldGtvdiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDAxOjUxOjI1QU0g
KzA4MDAsIGtidWlsZCB0ZXN0IHJvYm90IHdyb3RlOg0KPiA+ID4gPiB0cmVlOiAgIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0IHg4Ni9t
bQ0KPiA+ID4gPiBoZWFkOiAgIGJkMWRlMmE3YWFjZTRkMWQzMTJmYjFiZTI2NGI4ZmFmZGI3MDYy
MDgNCj4gPiA+ID4gY29tbWl0OiAxZjZmNjU1ZTAxYWRlYmY1YmQ1ZTZjM2RhMmU4NDNjMTA0ZGVk
MDUxIFsxLzIzXSB4ODYvbW06IEFkZA0KPiBhIHg4Nl9oYXNfcGF0X3dwKCkgaGVscGVyDQo+ID4g
PiA+IGNvbmZpZzogeDg2XzY0LXJhbmRjb25maWctcjAxMi0yMDIwMDUxOSAoYXR0YWNoZWQgYXMg
LmNvbmZpZykNCj4gPiA+ID4gY29tcGlsZXI6IGNsYW5nIHZlcnNpb24gMTEuMC4wIChodHRwczov
L2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3QNCj4gMTM1Yjg3Nzg3NGZhZTk2YjQzNzJjOGEz
ZmJmYWE4ZmY0NGZmODZlMykNCj4gPiA+ID4gcmVwcm9kdWNlOg0KPiA+ID4gPiAgICAgICAgIHdn
ZXQgaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2ludGVsL2xrcC0NCj4gdGVzdHMv
bWFzdGVyL3NiaW4vbWFrZS5jcm9zcyAtTyB+L2Jpbi9tYWtlLmNyb3NzDQo+ID4gPiA+ICAgICAg
ICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcw0KPiA+ID4gPiAgICAgICAgICMgaW5zdGFsbCB4
ODZfNjQgY3Jvc3MgY29tcGlsaW5nIHRvb2wgZm9yIGNsYW5nIGJ1aWxkDQo+ID4gPiA+ICAgICAg
ICAgIyBhcHQtZ2V0IGluc3RhbGwgYmludXRpbHMteDg2LTY0LWxpbnV4LWdudQ0KPiA+ID4gPiAg
ICAgICAgIGdpdCBjaGVja291dCAxZjZmNjU1ZTAxYWRlYmY1YmQ1ZTZjM2RhMmU4NDNjMTA0ZGVk
MDUxDQo+ID4gPiA+ICAgICAgICAgIyBzYXZlIHRoZSBhdHRhY2hlZCAuY29uZmlnIHRvIGxpbnV4
IGJ1aWxkIHRyZWUNCj4gPiA+ID4gICAgICAgICBDT01QSUxFUl9JTlNUQUxMX1BBVEg9JEhPTUUv
MGRheSBDT01QSUxFUj1jbGFuZw0KPiBtYWtlLmNyb3NzIEFSQ0g9eDg2XzY0DQo+ID4gPiA+DQo+
ID4gPiA+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWcgYXMg
YXBwcm9wcmlhdGUNCj4gPiA+ID4gUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBBbGwgd2FybmluZ3MgKG5ldyBvbmVzIHByZWZp
eGVkIGJ5ID4+LCBvbGQgb25lcyBwcmVmaXhlZCBieSA8PCk6DQo+ID4gPiA+DQo+ID4gPiA+ID4+
IGFyY2gveDg2L21tL2luaXQuYzo3NTo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUg
Zm9yIGZ1bmN0aW9uDQo+ICd4ODZfaGFzX3BhdF93cCcgWy1XbWlzc2luZy1wcm90b3R5cGVzXQ0K
PiA+ID4gPiBib29sIHg4Nl9oYXNfcGF0X3dwKHZvaWQpDQo+ID4gPiA+IF4NCj4gPiA+DQo+ID4g
PiBUcmlnZ2VycyB3aXRoIGdjYyB0b286DQo+ID4gPg0KPiA+ID4gbWFrZSBXPTEgYXJjaC94ODYv
bW0vaW5pdC5vDQo+ID4gPg0KPiA+ID4gLi4uDQo+ID4gPg0KPiA+ID4gYXJjaC94ODYvbW0vaW5p
dC5jOjgxOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYeDg2X2hhc19w
YXRfd3DigJkNCj4gWy1XbWlzc2luZy1wcm90b3R5cGVzXQ0KPiA+ID4gICAgODEgfCBib29sIHg4
Nl9oYXNfcGF0X3dwKHZvaWQpDQo+ID4gPiAgICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn4NCj4g
PiA+DQo+ID4gPg0KPiA+ID4gLVdtaXNzaW5nLXByb3RvdHlwZXMgaXMgZGVmYXVsdCBvZmYsIHRo
b3VnaCwgZHVubm8gd2h5IGNsYW5nIDExIGhhcyBpdA0KPiA+ID4gb24uDQo+ID4NCj4gPiBJdCBk
b2Vzbid0OiBodHRwczovL2dvZGJvbHQub3JnL3ovclU1XzVIDQo+ID4NCj4gPiBJIGFzc3VtZSB0
aGlzIGlzIGNhdXNlZCBieSBzb21lIHNvcnQgb2YgaW50ZXJuYWwgY2hhbmdlIHRvIHRoZSAwZGF5
DQo+ID4gaW5mcmFzdHJ1Y3R1cmUgKHRlc3RpbmcgVz0xPykNCj4gPg0KPiA+IEkgY2Fubm90IHNl
ZSB0aGlzIHdpdGhvdXQgYWRkaW5nIFc9MSB0byBtYWtlIGF0IHRoZSBsaXN0ZWQgY29tbWl0IHdp
dGgNCj4gPiB0aGUgcHJvdmlkZWQgY29uZmlnLg0KPiA+DQo+ID4gQ2hlZXJzLA0KPiA+IE5hdGhh
bg0KPiA+DQo+ID4gPiBBbnl3YXksIHNvbWV0aGluZyBmb3IgQmVubmkgdG8gZml4LiBDQ2VkIGFu
ZCBsZWF2aW5nIHRoZSByZXN0IGZvciBoaW0gYXMNCj4gPiA+IHJlZmVyZW5jZS4NCj4gPiA+DQo+
ID4gPiA+IGFyY2gveDg2L21tL2luaXQuYzo3NToxOiBub3RlOiBkZWNsYXJlICdzdGF0aWMnIGlm
IHRoZSBmdW5jdGlvbiBpcyBub3QgaW50ZW5kZWQNCj4gdG8gYmUgdXNlZCBvdXRzaWRlIG9mIHRo
aXMgdHJhbnNsYXRpb24gdW5pdA0KPiA+ID4gPiBib29sIHg4Nl9oYXNfcGF0X3dwKHZvaWQpDQo+
ID4gPiA+IF4NCj4gPiA+ID4gc3RhdGljDQo+ID4gPiA+IGFyY2gveDg2L21tL2luaXQuYzo4NjY6
MTM6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3IgZnVuY3Rpb24NCj4gJ21lbV9l
bmNyeXB0X2ZyZWVfZGVjcnlwdGVkX21lbScgWy1XbWlzc2luZy1wcm90b3R5cGVzXQ0KPiA+ID4g
PiB2b2lkIF9fd2VhayBtZW1fZW5jcnlwdF9mcmVlX2RlY3J5cHRlZF9tZW0odm9pZCkgeyB9DQo+
ID4gPiA+IF4NCj4gPiA+ID4gYXJjaC94ODYvbW0vaW5pdC5jOjg2NjoxOiBub3RlOiBkZWNsYXJl
ICdzdGF0aWMnIGlmIHRoZSBmdW5jdGlvbiBpcyBub3QgaW50ZW5kZWQNCj4gdG8gYmUgdXNlZCBv
dXRzaWRlIG9mIHRoaXMgdHJhbnNsYXRpb24gdW5pdA0KPiA+ID4gPiB2b2lkIF9fd2VhayBtZW1f
ZW5jcnlwdF9mcmVlX2RlY3J5cHRlZF9tZW0odm9pZCkgeyB9DQo+ID4gPiA+IF4NCj4gPiA+ID4g
c3RhdGljDQo+ID4gPiA+IDIgd2FybmluZ3MgZ2VuZXJhdGVkLg0KPiA+ID4gPg0KPiA+ID4gPiB2
aW0gKy94ODZfaGFzX3BhdF93cCArNzUgYXJjaC94ODYvbW0vaW5pdC5jDQo+ID4gPiA+DQo+ID4g
PiA+ICAgICA3Mw0KPiA+ID4gPiAgICAgNzQgICAgICAvKiBDaGVjayB0aGF0IHRoZSB3cml0ZS1w
cm90ZWN0IFBBVCBlbnRyeSBpcyBzZXQgZm9yIHdyaXRlLXByb3RlY3QgKi8NCj4gPiA+ID4gICA+
IDc1ICAgICAgYm9vbCB4ODZfaGFzX3BhdF93cCh2b2lkKQ0KPiA+ID4gPiAgICAgNzYgICAgICB7
DQo+ID4gPiA+ICAgICA3NyAgICAgICAgICAgICAgcmV0dXJuIF9fcHRlMmNhY2hlbW9kZV90Ymxb
X1BBR0VfQ0FDSEVfTU9ERV9XUF0gPT0NCj4gX1BBR0VfQ0FDSEVfTU9ERV9XUDsNCj4gPiA+ID4g
ICAgIDc4ICAgICAgfQ0KPiA+ID4gPiAgICAgNzkNCj4gPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IDAtREFZIENJIEtlcm5lbCBUZXN0IFNlcnZpY2UsIEludGVsIENvcnBvcmF0aW9uDQo+ID4g
PiA+IGh0dHBzOi8vbGlzdHMuMDEub3JnL2h5cGVya2l0dHkvbGlzdC9rYnVpbGQtYWxsQGxpc3Rz
LjAxLm9yZw0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IFJlZ2FyZHMvR3J1
c3MsDQo+ID4gPiAgICAgQm9yaXMuDQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9wZW9wbGUua2VybmVs
Lm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCj4gPiA+DQo+ID4NCj4gPiAtLQ0KPiA+
IFlvdSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgYmVjYXVzZSB5b3UgYXJlIHN1YnNjcmliZWQgdG8g
dGhlIEdvb2dsZSBHcm91cHMNCj4gIkNsYW5nIEJ1aWx0IExpbnV4IiBncm91cC4NCj4gPiBUbyB1
bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5nIGVtYWlscyBmcm9t
IGl0LCBzZW5kIGFuIGVtYWlsDQo+IHRvIGNsYW5nLWJ1aWx0LWxpbnV4K3Vuc3Vic2NyaWJlQGdv
b2dsZWdyb3Vwcy5jb20uDQo+ID4gVG8gdmlldyB0aGlzIGRpc2N1c3Npb24gb24gdGhlIHdlYiB2
aXNpdA0KPiBodHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2QvbXNnaWQvY2xhbmctYnVpbHQtDQo+
IGxpbnV4LzIwMjAwNTE5MjEyNTQxLkdBMzU4MDAxNiU0MHVidW50dS1zMy14bGFyZ2UteDg2Lg0K
PiANCj4gDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IH5OaWNrIERlc2F1bG5pZXJzDQo=
