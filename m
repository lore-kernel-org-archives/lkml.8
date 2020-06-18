Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61563C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34432217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TlRNMtTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgFRHDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:03:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:39886 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgFRHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:02:57 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200618070253epoutp016bbafa6e556730c8a8c2cdfb87f7e6e5~ZkV1p5o3w0653306533epoutp01P
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:02:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200618070253epoutp016bbafa6e556730c8a8c2cdfb87f7e6e5~ZkV1p5o3w0653306533epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592463773;
        bh=ls1ySa4sCYDpC+WfJ4XyK2tqKI6beYTc/ZQcX1v3oY0=;
        h=To:Cc:From:Subject:Date:References:From;
        b=TlRNMtTRjWlS+Faj5VEAB9qiARoPlIOnuZY46T5VndsqRcuFe/eA2REKyayE2j2bM
         1CMEKebDS8PmkVr0r3y9tgdqDvPOSrpi1zriQ7PrShVAGo2fZ9y1/5d/9+zIvYPRlv
         okqTxgx3TjlF2jcpFTeFxQbn48hpvmFHKLsKKdm8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200618070253epcas1p1c42d753f2d53ffd87991676dabf9bcef~ZkV1QN-BP3101931019epcas1p1h;
        Thu, 18 Jun 2020 07:02:53 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49nXvJ1Yj8zMqYm9; Thu, 18 Jun
        2020 07:02:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.78.18978.A911BEE5; Thu, 18 Jun 2020 16:02:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25~ZkVytozK72920429204epcas1p4F;
        Thu, 18 Jun 2020 07:02:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618070250epsmtrp2a59c7d796bd7fdfa4f83cb987a94ebdc~ZkVys_xeg2848228482epsmtrp2L;
        Thu, 18 Jun 2020 07:02:50 +0000 (GMT)
X-AuditID: b6c32a35-b8298a8000004a22-bb-5eeb119a7a4a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.75.08382.A911BEE5; Thu, 18 Jun 2020 16:02:50 +0900 (KST)
Received: from [10.253.105.155] (unknown [10.253.105.155]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618070250epsmtip18810653d5dd9abb3c6c6cd16e3ee97a9~ZkVydJTJ20875208752epsmtip1e;
        Thu, 18 Jun 2020 07:02:50 +0000 (GMT)
To:     snitzer@redhat.com
Cc:     agk@redhat.com, dm-devel@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
Subject: [patch] New mode DM-Verity error handling
Message-ID: <98eac3fc-c399-625d-5730-29853b3a0771@samsung.com>
Date:   Thu, 18 Jun 2020 15:56:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------9C73C137154A1ECE1862557A"
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmru4swddxBru+2FisP3WM2eLJgXZG
        i73vZrNaLGxbwmJxedccNou2jV8ZHdg8FvdNZvV4v+8qm8fnTXIBzFE5NhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZzxd/YC/4qVuxeftS
        5gbG5dpdjJwcEgImEkc7nrJ0MXJxCAnsYJTYMeMLI0hCSOATo8SXpQYQiW+MEi+2djHDdJxb
        ehGqYy+jxNbOg2wQzntGicffXrKCVIkIiEkc6XsAZjMLFElM+f6aCcRmE9CWuN2yiR3EFhYw
        kvh8/SdYnFfATmLS5sVgq1kEVCWubH4MFhcViJC4f2wDK0SNoMTJmU9YIGYGSBx93Qpli0vc
        ejKfCeQICYFODonjlzpZIE51kdj0+xkThC0s8er4FnYIW0ri87u9bBB2ucSVpsuMEHaNxIQL
        3awQtrHE/JaFUC8rSuz8PZcRYhmfxLuvPUA1HEBxXomONiGIEiWJFf+uQa2VkNhwuBtqvIfE
        0tbprJAgjZW48X8qywRG+VlI3pmF5J1ZSN6BsOUltr+dwzwLaBuzgKbE+l36EGaKxI5GH4gK
        RYkp3Q/ZIewGRon+myYLGDlWMYqlFhTnpqcWGxYYIieITYzgdKtluoNx4tsPeocYmTgYDzGq
        APU+2rD6AqMUS15+XqqSCK/z7xdxQrwpiZVVqUX58UWlOanFhxhNgXEzkVlKNDkfmAnySuIN
        TY2MjY0tTMzMzUyNlcR5xWUuxAkJpCeWpGanphakFsH0MXFwSjUwrbuXvfFi/TX3joS8irUf
        vgWXTTJ2OdMVnFv/62XTi5OCovWXt096MuuF8r2ddx++ZrDYZB2178Qd68VnZB8Jn5aKTUvn
        401e3f49YJ/EurToCb3vGw07Qp7GJ8apydU9UWKO7jW8V+Ap8UhunuDBkohS92VJSj8/LrrY
        JCX/9LQk22kRmQnPVs/7whvhMY/JZ5Lo3MWmtn9nHjqb9YX1fuuDablTXFJmKm0tZFHYcc6B
        9eraOf/F5b/dVzxaoFIVseUZ/8/NZadev36Uc/X1/FsRVdPPv/zTutLHbE5hXf2BzcHuFx8v
        lw2527WR2XX+hR2L7oi7P0g6U6vtyJ6Z95HlwQqhP0fMKy+2iIaYhSixFGckGmoxFxUnAgD8
        /1siTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO4swddxBm9ei1msP3WM2eLJgXZG
        i73vZrNaLGxbwmJxedccNou2jV8ZHdg8FvdNZvV4v+8qm8fnTXIBzFFcNimpOZllqUX6dglc
        GT86kgv2q1R82XuLuYFxqlwXIyeHhICJxLmlF1m6GLk4hAR2M0psXbuWFSIhIbFh01r2LkYO
        IFtY4vDhYoiat4wSzSv/sYDUiAiISRzpewBWzyxQJLF62V0wm01AW+J2yyZ2EFtYwEji8/Wf
        TCA2r4CdxKTNixlBbBYBVYkrmx+DxUUFIiTOvF/BAlEjKHFy5hMWiJkBEm9n/IaaLy5x68l8
        pgmM/LOQlM1CUjYLSRmEbSYxb/NDZghbXmL72zlQdorEtscv0cS5gOwGRonbq24yLWDkWMUo
        mVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwvWpo7GLev+qB3iJGJg/EQowpQ/6MNqy8w
        SrHk5eelKonwOv9+ESfEm5JYWZValB9fVJqTWnyIUZqDRUmc90bhwjghgfTEktTs1NSC1CKY
        LBMHp1QD02LvM88TiwqKfv5IOOej+l9AsnCj/3XRrPJVbzcmnHl8LDXJuznE/MKmNJt18zwb
        JONP95zbtqTTy/3sLvHDKeXV155aBv70mZd+S+vAzK5JP0/6+yQz3d+bpPnh5YQpT6qvVmap
        nnIx1uXQ4WRMM37D/o3zyrx1t8P2ibHfE5hqYzzZV+yyrA3zggaDKO9PWiv3FRQc2dv7zT5P
        8Ya71VZWyccBJTftRBgnikx932Sl8ylUu7pObP+Kl1fv5WyeO+v3YoPkGwx2d86EPk1Yaz1r
        2VQrqbPNJkvPWbc9/H94YWGjy42/j1uvWomFFfyymPJSQu/zPg4di4oFzuzKvBH/3n9pu7Xx
        r0mKfczFp0osxRmJhlrMRcWJAFgT+FASAwAA
X-CMS-MailID: 20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25
References: <CGME20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9C73C137154A1ECE1862557A
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hello, Dear devcice-mapper maintainers.

I'm JeongHyeon Lee, work in Samsung. I'm chage of DM-Verity feature with 
Mr. sunwook eom.
I have a patch or suggestion about DM-Verity error handling.

Our device (smart phone) need DM-Verity feature. So I hope there is new 
mode DM-Verity error handling.
This new mode concept is When detect corrupted block, will be go to panic.

Because our team policy is found device DM-Verity error, device will go 
panic.
And then analyze what kind of device fault (crash UFS, IO error, DRAM 
bit flip etc)

In addition to the smart phone, I would like to have an option that 
users or administrators can use accordingly.
There are patch contents in the attachment. I would really appreciate it 
if you could check it.

I will look forward to hearing from yours.
Thank you :)


--------------9C73C137154A1ECE1862557A
Content-Type: text/x-patch;
	name="0001-dm-verity-new-error-handling-mode-for-corrupted-bloc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-dm-verity-new-error-handling-mode-for-corrupted-bloc.pa";
	filename*1="tch"

RnJvbSA2ZDNlNTA4ZWQ2ODcyYmZkYzg4ZDZhZDk3OWFjNWMwMzQ3MTQ0ZmJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogImpoczIubGVlIiA8amhzMi5sZWVAc2Ftc3VuZy5jb20+DQpE
YXRlOiBUaHUsIDE4IEp1biAyMDIwIDE1OjMyOjIwICswOTAwDQpTdWJqZWN0OiBbUEFUQ0hdIGRt
IHZlcml0eTogbmV3IGVycm9yIGhhbmRsaW5nIG1vZGUgZm9yIGNvcnJ1cHRlZCBibG9ja3MNCg0K
VGhlcmUgaXMgbm8gcGFuaWMgZXJyb3IgaGFuZGxpbmcgbW9kZSB3aGVuIGEgcHJvYmxlbSBvY2N1
cnMuDQpTbyBXZSBhZGQgbmV3IGVycm9yIGhhbmRsaW5nIG1vZGUuIHVzZXJzIGFuZCBhZG1pbmlz
dHJhdG9ycw0Kc2V0dXAgdG8gZml0IHlvdXIgbmVlZC4NCg0KU2lnbmVkLW9mZi1ieTogamhzMi5s
ZWUgPGpoczIubGVlQHNhbXN1bmcuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9kZXZpY2UtbWFwcGVyL3Zlcml0eS5yc3QgfCAgNCArKysrDQogZHJpdmVycy9tZC9kbS12ZXJp
dHktdGFyZ2V0LmMgICAgICAgICAgICAgICAgICAgICAgfCAxMSArKysrKysrKysrKw0KIGRyaXZl
cnMvbWQvZG0tdmVyaXR5LmggICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKystDQog
MyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2RldmljZS1tYXBwZXIvdmVyaXR5LnJz
dCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvZGV2aWNlLW1hcHBlci92ZXJpdHkucnN0DQpp
bmRleCBiYjAyY2FhNDUyODkuLjY2ZjcxZjBkYWIxYiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUvZGV2aWNlLW1hcHBlci92ZXJpdHkucnN0DQorKysgYi9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2RldmljZS1tYXBwZXIvdmVyaXR5LnJzdA0KQEAgLTgzLDYgKzgzLDEw
IEBAIHJlc3RhcnRfb25fY29ycnVwdGlvbg0KICAgICBub3QgY29tcGF0aWJsZSB3aXRoIGlnbm9y
ZV9jb3JydXB0aW9uIGFuZCByZXF1aXJlcyB1c2VyIHNwYWNlIHN1cHBvcnQgdG8NCiAgICAgYXZv
aWQgcmVzdGFydCBsb29wcy4NCiANCitwYW5pY19vbl9jb3JydXB0aW9uDQorICAgIFBhbmljIHRo
ZSBkZXZpY2Ugd2hlbiBhIGNvcnJ1cHRlZCBibG9jayBpcyBkaXNjb3ZlcmVkLiBUaGlzIG9wdGlv
biBpcw0KKyAgICBub3QgY29tcGF0aWJsZSB3aXRoIGlnbm9yZV9jb3JydXB0aW9uIGFuZCByZXN0
YXJ0X29uX2NvcnJ1cHRpb24uDQorDQogaWdub3JlX3plcm9fYmxvY2tzDQogICAgIERvIG5vdCB2
ZXJpZnkgYmxvY2tzIHRoYXQgYXJlIGV4cGVjdGVkIHRvIGNvbnRhaW4gemVyb2VzIGFuZCBhbHdh
eXMgcmV0dXJuDQogICAgIHplcm9lcyBpbnN0ZWFkLiBUaGlzIG1heSBiZSB1c2VmdWwgaWYgdGhl
IHBhcnRpdGlvbiBjb250YWlucyB1bnVzZWQgYmxvY2tzDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZC9kbS12ZXJpdHktdGFyZ2V0LmMgYi9kcml2ZXJzL21kL2RtLXZlcml0eS10YXJnZXQuYw0KaW5k
ZXggZWVjOWYyNTJlOTM1Li5jODkxMTRlNzg4NmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21kL2Rt
LXZlcml0eS10YXJnZXQuYw0KKysrIGIvZHJpdmVycy9tZC9kbS12ZXJpdHktdGFyZ2V0LmMNCkBA
IC0zMCw2ICszMCw3IEBADQogDQogI2RlZmluZSBETV9WRVJJVFlfT1BUX0xPR0dJTkcJCSJpZ25v
cmVfY29ycnVwdGlvbiINCiAjZGVmaW5lIERNX1ZFUklUWV9PUFRfUkVTVEFSVAkJInJlc3RhcnRf
b25fY29ycnVwdGlvbiINCisjZGVmaW5lIERNX1ZFUklUWV9PUFRfUEFOSUMJCSJwYW5pY19vbl9j
b3JydXB0aW9uIg0KICNkZWZpbmUgRE1fVkVSSVRZX09QVF9JR05fWkVST0VTCSJpZ25vcmVfemVy
b19ibG9ja3MiDQogI2RlZmluZSBETV9WRVJJVFlfT1BUX0FUX01PU1RfT05DRQkiY2hlY2tfYXRf
bW9zdF9vbmNlIg0KIA0KQEAgLTI1NCw2ICsyNTUsOSBAQCBzdGF0aWMgaW50IHZlcml0eV9oYW5k
bGVfZXJyKHN0cnVjdCBkbV92ZXJpdHkgKnYsIGVudW0gdmVyaXR5X2Jsb2NrX3R5cGUgdHlwZSwN
CiAJaWYgKHYtPm1vZGUgPT0gRE1fVkVSSVRZX01PREVfUkVTVEFSVCkNCiAJCWtlcm5lbF9yZXN0
YXJ0KCJkbS12ZXJpdHkgZGV2aWNlIGNvcnJ1cHRlZCIpOw0KIA0KKwlpZiAodi0+bW9kZSA9PSBE
TV9WRVJJVFlfTU9ERV9QQU5JQykNCisJCXBhbmljKCJkbS12ZXJpdHkgZGV2aWNlIGNvcnJ1cHRl
ZCIpOw0KKw0KIAlyZXR1cm4gMTsNCiB9DQogDQpAQCAtNzQyLDYgKzc0Niw5IEBAIHN0YXRpYyB2
b2lkIHZlcml0eV9zdGF0dXMoc3RydWN0IGRtX3RhcmdldCAqdGksIHN0YXR1c190eXBlX3QgdHlw
ZSwNCiAJCQljYXNlIERNX1ZFUklUWV9NT0RFX1JFU1RBUlQ6DQogCQkJCURNRU1JVChETV9WRVJJ
VFlfT1BUX1JFU1RBUlQpOw0KIAkJCQlicmVhazsNCisJCQljYXNlIERNX1ZFUklUWV9NT0RFX1BB
TklDOg0KKwkJCQlETUVNSVQoRE1fVkVSSVRZX09QVF9QQU5JQyk7DQorCQkJCWJyZWFrOw0KIAkJ
CWRlZmF1bHQ6DQogCQkJCUJVRygpOw0KIAkJCX0NCkBAIC05MDcsNiArOTE0LDEwIEBAIHN0YXRp
YyBpbnQgdmVyaXR5X3BhcnNlX29wdF9hcmdzKHN0cnVjdCBkbV9hcmdfc2V0ICphcywgc3RydWN0
IGRtX3Zlcml0eSAqdiwNCiAJCQl2LT5tb2RlID0gRE1fVkVSSVRZX01PREVfUkVTVEFSVDsNCiAJ
CQljb250aW51ZTsNCiANCisJCX0gZWxzZSBpZiAoIXN0cmNhc2VjbXAoYXJnX25hbWUsIERNX1ZF
UklUWV9PUFRfUEFOSUMpKSB7DQorCQkJdi0+bW9kZSA9IERNX1ZFUklUWV9NT0RFX1BBTklDOw0K
KwkJCWNvbnRpbnVlOw0KKw0KIAkJfSBlbHNlIGlmICghc3RyY2FzZWNtcChhcmdfbmFtZSwgRE1f
VkVSSVRZX09QVF9JR05fWkVST0VTKSkgew0KIAkJCXIgPSB2ZXJpdHlfYWxsb2NfemVyb19kaWdl
c3Qodik7DQogCQkJaWYgKHIpIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLXZlcml0eS5o
IGIvZHJpdmVycy9tZC9kbS12ZXJpdHkuaA0KaW5kZXggNjQxYjllM2EzOTliLi40ZTc2OWQxMzQ3
M2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21kL2RtLXZlcml0eS5oDQorKysgYi9kcml2ZXJzL21k
L2RtLXZlcml0eS5oDQpAQCAtMjAsNyArMjAsOCBAQA0KIGVudW0gdmVyaXR5X21vZGUgew0KIAlE
TV9WRVJJVFlfTU9ERV9FSU8sDQogCURNX1ZFUklUWV9NT0RFX0xPR0dJTkcsDQotCURNX1ZFUklU
WV9NT0RFX1JFU1RBUlQNCisJRE1fVkVSSVRZX01PREVfUkVTVEFSVCwNCisJRE1fVkVSSVRZX01P
REVfUEFOSUMNCiB9Ow0KIA0KIGVudW0gdmVyaXR5X2Jsb2NrX3R5cGUgew0KLS0gDQoyLjE3LjEN
Cg0K

--------------9C73C137154A1ECE1862557A--
