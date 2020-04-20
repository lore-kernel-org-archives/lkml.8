Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4493C38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4B4214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTBEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:04:05 -0400
Received: from mail-m127108.qiye.163.com ([115.236.127.108]:8739 "EHLO
        mail-m127108.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDTBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:04:05 -0400
Received: from vivo.com (wm-13.qy.internal [127.0.0.1])
        by mail-m127108.qiye.163.com (Hmail) with ESMTP id 21F458422E8;
        Mon, 20 Apr 2020 08:56:16 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AA2AnwCHCIqvuawqjhyAZKo2.3.1587344176120.Hmail.bernard@vivo.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogUmV0dXJuIG1vcmUgZXJyb3IgY29kZXMgaW4gYW1kZ3B1X2Nvbm5lY3Rvcl9zZXRfcHJvcGVydHkoKQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <a00cc21a-383f-67ca-cdc5-b727ae59d31c@web.de>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 20 Apr 2020 08:56:16 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Mon, 20 Apr 2020 08:56:16 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VISEJLS0tJSU5LTUxKT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEtJTENOSUlON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Okk6FQw4MzgyCg0OGgwKERMCOiEwFElVSFVKTkNMSE9PSkxNSUpJVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT01OQjcG
X-HM-Tid: 0a719515f416986ckuuu21f458422e8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgrlj5Hku7bkurrvvJpNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPgrlj5Hp
gIHml6XmnJ/vvJoyMDIwLTA0LTE5IDE3OjM0OjQ3CuaUtuS7tuS6uu+8mkJlcm5hcmQgWmhhbyA8
YmVybmFyZEB2aXZvLmNvbT4sYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcsZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+LCJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPixDaHVu
bWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgrmioTpgIHkurrvvJpBbmRyemVqIFBpZXRy
YXNpZXdpY3ogPGFuZHJ6ZWoucEBjb2xsYWJvcmEuY29tPixEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+LERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4sRGhpbmFrYXJhbiBQYW5k
aXlhbiA8ZGhpbmFrYXJhbi5wYW5kaXlhbkBpbnRlbC5jb20+LCJKb3PDqSBSb2JlcnRvIGRlIFNv
dXphIiA8am9zZS5zb3V6YUBpbnRlbC5jb20+LEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+
LE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT4sU2FtIFJhdm5ib3JnIDxz
YW1AcmF2bmJvcmcub3JnPixsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLG9wZW5zb3VyY2Uu
a2VybmVsQHZpdm8uY29tCuS4u+mimO+8mlJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFJldHVybiBt
b3JlIGVycm9yIGNvZGVzIGluIGFtZGdwdV9jb25uZWN0b3Jfc2V0X3Byb3BlcnR5KCk+PiBUaGUg
ImlmKCFlbmNvZGVyKSIgYnJhbmNoIHJldHVybiB0aGUgc2FtZSB2YWx1ZSAwIG9mIHRoZSBzdWNj
ZXNzCj4+IGJyYW5jaCwgbWF5YmUgcmV0dXJuIC1FSU5WQUwgaXMgbW9yZSBiZXR0ZXIuCj4KPkkg
c3VnZ2VzdCB0byBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZS4KClN1cmUuCgo+Cj4qIFdvdWxk
IHlvdSBsaWtlIHRvIGFkanVzdCB0aGUgcGF0Y2ggc3ViamVjdD8KPgo+KiBIb3cgZG8geW91IHRo
aW5rIGFib3V0IHRvIGFkZCB0aGUgdGFnIOKAnEZpeGVz4oCdCj4gIGJlY2F1c2Ugb2YgYWRqdXN0
bWVudHMgZm9yIHRoZSBleGNlcHRpb24gaGFuZGxpbmc/CgpUaGlzIGlzIGEgZ29vZCBpZGVhLCB0
aGUgY29kZSB3aWxsIGJlIG1vcmUgaW4gbGluZSB3aXRoIHRoZSBMaW51eCBzcGVjaWZpY2F0aW9u
cy4KSSB3aWxsIGFkanVzdCB0aGlzIHBhdGNoIGNvbW1pdCBtZXNzYWdlIGFuZCBtb2RpZnkgdGhl
IGNvZGUuIEkgd2lsbCBzdWJtaXQgaXQgYWdhaW4uCgo+Cj5SZWdhcmRzLAo+TWFya3VzCg0KDQo=
