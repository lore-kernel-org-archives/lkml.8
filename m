Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9117C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C688E20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgHQOWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:22:04 -0400
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:37035 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728465AbgHQOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:22:03 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Aug 2020 10:22:02 EDT
Received: from [31.193.165.228] (port=31326 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Henri.Roosen@ginzinger.com>)
        id 1k7fuu-0004b6-1u; Mon, 17 Aug 2020 16:15:16 +0200
Received: from exc1.buero.ginzinger.com (10.1.1.204) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Mon, 17 Aug 2020 16:15:16 +0200
Received: from exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4]) by
 exc1.buero.ginzinger.com ([fe80::ad39:a353:4517:a5c4%3]) with mapi id
 15.01.1466.012; Mon, 17 Aug 2020 16:15:16 +0200
X-CTCH-RefID: str=0001.0A090209.5F3A90F4.00A2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Roosen Henri <Henri.Roosen@ginzinger.com>
To:     "arnd@arndb.de" <arnd@arndb.de>
CC:     "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: y2038 backport to v5.4
Thread-Topic: y2038 backport to v5.4
Thread-Index: AQHWPlkSF3mzruU3kk+gCvVnHPVaZ6jQM4uAgGxv5AA=
Date:   Mon, 17 Aug 2020 14:15:16 +0000
Message-ID: <6c77e2a615ca01e753735e21752fe5e1b3fb636f.camel@ginzinger.com>
References: <d159c66c6e67480ab48ac44716443358@ginzinger.com>
         <CAK8P3a2icd72R+4Z5dLPvGuofsq3VOBYBdCnC4806V5znqrytg@mail.gmail.com>
In-Reply-To: <CAK8P3a2icd72R+4Z5dLPvGuofsq3VOBYBdCnC4806V5znqrytg@mail.gmail.com>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.1.65]
x-exclaimer-md-original-subject: [NOSIG][NODISC]Re: y2038 backport to v5.4
x-exclaimer-md-config: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----B78C6AD73F1F650EC2E3601961A17881"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------B78C6AD73F1F650EC2E3601961A17881
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E80AE24CD047B409115B7A8F734D88D@ginzinger.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

T24gVHVlLCAyMDIwLTA2LTA5IGF0IDE2OjE4ICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBPbiBUdWUsIEp1biA5LCAyMDIwIGF0IDI6MzYgUE0gUm9vc2VuIEhlbnJpIDwNCj4gSGVucmku
Um9vc2VuQGdpbnppbmdlci5jb20+IHdyb3RlOg0KPiA+IEhpIEFybmQsDQo+ID4gDQo+ID4gSSBo
b3BlIHlvdSBhcmUgd2VsbCBhbmQgY291bGQgYW5zd2VyIG1lIGEgcXVpY2sgcXVlc3Rpb24uDQo+
ID4gDQo+ID4gSSd2ZSByZWFkIG9uIHRoZSBrZXJuZWwgbWFpbGluZy1saXN0IHRoYXQgaW5pdGlh
bGx5IHRoZXJlIHdhcyBhbg0KPiA+IGludGVudGlvbiB0byBiYWNrcG9ydCB0aGUgZmluYWwgeTIw
MzggcGF0Y2hlcyB0byB2NS40LiBXZSdyZQ0KPiA+IGN1cnJlbnRseSB0YXJnZXRpbmcgdG8gdXNl
IHRoZSB2NS40IExUUyBrZXJuZWwgZm9yIGEgcHJvamVjdCB3aGljaA0KPiA+IHNob3VsZCBiZSB5
MjAzOCBjb21wbGlhbnQuDQo+ID4gDQo+ID4gSSBjb3VsZG4ndCBmaW5kIGFsbCBvZiB0aGUgeTIw
MzgtZW5kZ2FtZSBwYXRjaGVzIGluIHRoZSBjdXJyZW50DQo+ID4gdjUuNC1zdGFibGUgYnJhbmNo
LiBBcmUgdGhlcmUgYW55IHBhdGNoZXMgc3RpbGwgcmVxdWlyZWQgdG8gYmUNCj4gPiBiYWNrcG9y
dGVkIGluIG9yZGVyIGZvciB2NS40IHRvIGJlIHkyMDM4IGNvbXBsaWFudCwgb3IgY2FuIHRoZQ0K
PiA+IHJlbWFpbmluZyBwYXRjaGVzIGJlIGlnbm9yZWQgKGJlY2F1c2Ugb2Ygb25seSBjbGVhbnVw
Pyk/IEVsc2UsIGlzDQo+ID4gdGhlcmUgc3RpbGwgYW4gaW50ZW50aW9uIHRvIGdldCB0aGUgdjUu
NCBMVFMga2VybmVsIHkyMDM4DQo+ID4gY29tcGxpYW50Pw0KPiANCj4gSSBkb24ndCB0aGluayB0
aGVyZSBhcmUgY3VycmVudGx5IGFueSBwbGFucyB0byBtZXJnZSBteSB5MjAzOC1lbmRnYW1lIA0K
PiBicmFuY2gNCj4gaW50byB0aGUgb2ZmaWNpYWwgbGludXgtNS40IGx0cyBrZXJuZWwsIGJ1dCB5
b3Ugc2hvdWxkIGJlIGFibGUgdG8NCj4ganVzdCBwdWxsIGZyb20NCj4gDQo+IGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FybmQvcGxheWdyb3VuZC5naXQv
bG9nLz9oPXkyMDM4LWVuZGdhbWUNCj4gDQo+IGFuZCBnZXQgdGhlIHNhbWUgcmVzdWx0cy4gSWYg
eW91IHNlZSBhbnkgcHJvYmxlbXMgd2l0aCB0aGF0LCBwbGVhc2UNCj4gcmVwb3J0DQo+IHRoYXQg
dG8gbWUgd2l0aCBDYyB0byB0aGUgbWFpbGluZyBsaXN0IGFuZCBwZXJoYXBzIGdyZWdraCwgc28g
SSBjYW4NCj4gc2VlIGlmDQo+IEkgY2FuIHJlc29sdmUgaXQgYnkgcmViYXNpbmcgbXkgcGF0Y2hl
cywgb3IgaWYgaGUgd291bGQgbGlrZSB0byBtZXJnZQ0KPiB0aGUNCj4gcGF0Y2hlcy4NCg0KUHVs
bGluZyB0aGUgeTIwMzgtZW5kZ2FtZSBicmFuY2ggZG9lcyBsZWFkIHRvIHNvbWUgY29uZmxpY3Rz
LCB3aGljaCBhcmUNCmN1cnJlbnRseSBzdGlsbCBraW5kYSBzdGFpZ2h0Zm9yd2FyZCB0byBzb2x2
ZS4NCg0KSG93ZXZlciBJJ2QgYmUgdmVyeSBpbnRlcmVzdGVkIGluIGdldHRpbmcgdGhpcyBicmFu
Y2ggbWVyZ2VkIHRvIHY1LjQsDQpzbyB3ZSBkb24ndCBydW4gaW50byBtb3JlIGRpZmZpY3VsdCBt
ZXJnZSBjb25mbGljdHMgdGhlIGNvbWluZyB5ZWFycw0Kd2hlcmUgdGhlIHY1LjQtTFRTIHN0aWxs
IGdldHMgc3RhYmxlIHVwZGF0ZXMgKERlYywgMjAyNSkgYW5kIHBvc3NpYmx5DQp0byBnZXQgYW55
IHJlbGF0ZWQgZml4ZXMgZnJvbSB1cHN0cmVhbS4NCg0KQEdyZWc6IGFueSBjaGFuY2UgdG8gZ2V0
IHRoZSB5MjAzOC1lbmRnYW1lIG1lcmdlZCBpbnRvIHY1LjQueT8NCg0KVGhhbmtzLA0KSGVucmkN
Cg==

------B78C6AD73F1F650EC2E3601961A17881
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOFAYJKoZIhvcNAQcCoIIOBTCCDgECAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggsYMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkq
hkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYh
UPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6
fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1
KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI
03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqc
k39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMB
AAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNV
HQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0
cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
AAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwR
GiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDc
ZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwp
WZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNm
NppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztve
BdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDA
fd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/
cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe
2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxh
csjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggUqMIIEEqAD
AgECAhEAgK6FAFOiNDdgM5+lyjA8gTANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9E
TyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0Ew
HhcNMTgwNzE4MDAwMDAwWhcNMjEwNzE3MjM1OTU5WjArMSkwJwYJKoZIhvcNAQkB
FhpoZW5yaS5yb29zZW5AZ2luemluZ2VyLmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMmwBmquEWhoUH5WNJe7bQRLBAccBq0ZBVQbLAbJQwN5bg9i
wSsPG7mveXqXYWpuHhbb7lbs3zFTS4H511nWurRqcvVceVOs5vtsbVMHjfuNmHo8
WrMCJPFBw64uBUoGdsiwuAvA0CeFpPyA/CsAuvIbmvEF+GxMjaeQhqQ9d5K4z4I6
w6R3wFtNJiSUMUSdgtnNPDYnUIKILR3mfbSCHWA7Pepe1dh+S9JFWhcoNv1h6D/R
SAKVdUtC2GS0vt3nk4cEg8Z0s4/OvVDRm2jluvPK+fEeUfGahwHFrk68nYTq3v2P
dMxHg93+Li+jYAX6R3XXGbdcjZJ3UM5MGEKq+u0CAwEAAaOCAdowggHWMB8GA1Ud
IwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBQ9s9JCcV1JOI2I
/oXSyF8VIj2VhTAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUE
FjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIB
AwUwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMw
WgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RP
UlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYI
KwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2NhLmNv
bS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0Eu
Y3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wJQYDVR0R
BB4wHIEaaGVucmkucm9vc2VuQGdpbnppbmdlci5jb20wDQYJKoZIhvcNAQELBQAD
ggEBAKdv6bSTLlu63Ckq7aibIwJCE0hhs83Z6Jr5G2wWrwVdFB9Dkb6l2NmdGRoq
qbSz3Remg5qamURXec3XdEBxO1FPMcZJrHKAZuNjYdj1tzYA/rbTdYmVbno1TG5/
O6rVb7A624UZHoucW+NpfNCrxfQY+BliMbCKJEWqQE0P6vyDenSYa76NLt1699B5
vyHbYLrJHAjFzHe7BqSkP815C47KpJFXuGYasewJDOpvyINtn6kBlrAIanoVfDFa
W9aUjUeNjqmcCEN4TpuSZCf1L8oWAjv5oH0R87orEAFZnSVWDIW8i7TMiFtCiF3D
LYmN6J96LCNCs0iQIFqcnJnkHAkxggLAMIICvAIBATCBrTCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQCA
roUAU6I0N2Azn6XKMDyBMA0GCWCGSAFlAwQCAQUAoIHkMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDgxNzE0MTUxOVowLwYJKoZI
hvcNAQkEMSIEIFWLv+AmgpwtXJlBHMzgo6CtcE8ZXMvksePt87JmLnfmMHkGCSqG
SIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAKRDXn7gq7UL
+pCIVeIFHQ6Y2Kz5akjng5d/4nNqQC2y1ZSBpgFNMqYU5Y1uBiI4PQGNZDM5m5tn
/QKxoW/NXulaW//mbrASFPQxFQaFLFlKraHOGyizicmkJfVT+/GjkhRdHh/3rm+P
L5jeHK75Wz+3MdPJt6MVOofZqwEmP1BsJBYfWVl2Q0vXghv2gvWbBlaVMF1Clzc1
VE8zgUh3G4nCkhHnjrnI4QcsfwgiIr4k47+ogUZrmxZADsbGJwkQ6AF+PdXpb2AT
JvgjZA7kucCnlpVEFz06/JJv3wlOD8l9SdE4Q4aUo2lLLtMYxdOuZZ46jMJvlR3R
gsk6SL18+cU=

------B78C6AD73F1F650EC2E3601961A17881--

