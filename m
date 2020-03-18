Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD439C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824302076A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgCRFcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:32:45 -0400
Received: from m177129.mail.qiye.163.com ([123.58.177.129]:15146 "EHLO
        m177129.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRFcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:32:45 -0400
Received: from vivo.com (wm-2.qy.internal [127.0.0.1])
        by m177129.mail.qiye.163.com (Hmail) with ESMTP id 1ABAA5C18EA;
        Wed, 18 Mar 2020 13:32:28 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AG*ACQC2CEOOiVKFwxZXw4qM.3.1584509548085.Hmail.wenhu.wang@vivo.com>
To:     Zheng Wei <wei.zheng@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com, Will Deacon <will@kernel.org>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gYXJtNjQ6IGFkZCBibGFuayBhZnRlciAnaWYn?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
In-Reply-To: <20200317222823.GG20788@willie-the-truck>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.227) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 18 Mar 2020 13:32:28 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Wed, 18 Mar 2020 13:32:28 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VJTkNCQkJDSU9OSUhCSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNTE9LTEJNQ0xPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PFE6OCo4STg#NDQSLTA9DAMhIwxPCjZVSFVKTkNPTktCTk5LSUNCVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlMWVdZCAFZQU9NQkw3Bg++
X-HM-Tid: 0a70ec20f65c6447kurs1abaa5c18ea
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4KRGF0ZTogMjAyMC0wMy0xOCAwNjoy
ODoyNApUbzogIFpoZW5nIFdlaSA8d2VpLnpoZW5nQHZpdm8uY29tPgpDYzogIENhdGFsaW4gTWFy
aW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+LEhhbmp1biBHdW8gPGd1b2hhbmp1bkBodWF3
ZWkuY29tPixFbnJpY28gV2VpZ2VsdCA8aW5mb0BtZXR1eC5uZXQ+LEFsbGlzb24gUmFuZGFsIDxh
bGxpc29uQGxvaHV0b2submV0PixHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPixUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sWXVuZmVuZyBZ
ZSA8eWV5dW5mZW5nQGh1YXdlaS5jb20+LGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLGtlcm5lbEB2aXZvLmNvbSx3ZW5odS53
YW5nQHZpdm8uY29tClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBhZGQgYmxhbmsgYWZ0ZXIg
J2lmJz5PbiBGcmksIE1hciAxMywgMjAyMCBhdCAxMDo1NDowMlBNICswODAwLCBaaGVuZyBXZWkg
d3JvdGU6Cj4+IGFkZCBibGFuayBhZnRlciAnaWYnIGZvciBhcm12OF9kZXByZWNhdGVkX2luaXQo
KQo+PiB0byBtYWtlIGl0IGNvbXBseSB3aXRoIGtlcm5lbCBjb2Rpbmcgc3R5bGUuCj4+IAo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuZyBXZWkgPHdlaS56aGVuZ0B2aXZvLmNvbT4KPj4gLS0tCj4+ICBh
cmNoL2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVkLmMgfCAyICstCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVkLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9h
cm12OF9kZXByZWNhdGVkLmMKPj4gaW5kZXggNzgzMmIzMjE2MzcwLi40Y2M1ODFhZjJkOTYgMTAw
NjQ0Cj4+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2FybXY4X2RlcHJlY2F0ZWQuYwo+PiArKysg
Yi9hcmNoL2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVkLmMKPj4gQEAgLTYzMCw3ICs2MzAs
NyBAQCBzdGF0aWMgaW50IF9faW5pdCBhcm12OF9kZXByZWNhdGVkX2luaXQodm9pZCkKPj4gIAkJ
cmVnaXN0ZXJfaW5zbl9lbXVsYXRpb24oJmNwMTVfYmFycmllcl9vcHMpOwo+PiAgCj4+ICAJaWYg
KElTX0VOQUJMRUQoQ09ORklHX1NFVEVORF9FTVVMQVRJT04pKSB7Cj4+IC0JCWlmKHN5c3RlbV9z
dXBwb3J0c19taXhlZF9lbmRpYW5fZWwwKCkpCj4+ICsJCWlmIChzeXN0ZW1fc3VwcG9ydHNfbWl4
ZWRfZW5kaWFuX2VsMCgpKQo+PiAgCQkJcmVnaXN0ZXJfaW5zbl9lbXVsYXRpb24oJnNldGVuZF9v
cHMpOwo+PiAgCQllbHNlCj4+ICAJCQlwcl9pbmZvKCJzZXRlbmQgaW5zdHJ1Y3Rpb24gZW11bGF0
aW9uIGlzIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyBzeXN0ZW1cbiIpOwo+Cj4oQ2F0YWxpbjogSSdt
IGp1c3QgYWNraW5nIHRoZXNlIHRyaXZpYWwgdHlwby9zdHlsZSBmaXhlcyB0byBnZXQgdGhlbSBv
dXQKPm9mIG15IGluYm94OyBkbyB3aGF0ZXZlciB5b3UgbGlrZSB3aXRoIHRoZW0gOykKPgo+QWNr
ZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Cj4KPldpbGwKClNob3VsZG4ndCB5
b3UgaGF2ZSBDYyB0cml2aWFsPHRyaXZpYWxAa2VybmVsLm9yZz4/CkFza2VkLWJ5OiBXYW5nIFdl
bmh1IDx3ZW5odS53YW5nQHZpdm8uY29tPgoKV2VuaHUKDQoNCg==
