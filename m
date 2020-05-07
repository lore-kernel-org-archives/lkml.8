Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484DEC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C072068E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgEGDJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:09:52 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:5357 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGDJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:09:52 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id E210C1A30A3;
        Thu,  7 May 2020 11:09:15 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAsA8gAQCF1C9rDJm0RSQaqC.3.1588820955909.Hmail.bernard@vivo.com>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6W1BBVENIXSBkcm0vbWVzb246IHBtIHJlc3VtZSBhZGQgcmV0dXJuIGVycm5vIGJyYW5jaA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200428131747.2099-1-bernard@vivo.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 7 May 2020 11:09:15 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Thu, 7 May 2020 11:09:15 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVNQ0lLS0tKTUtJSkxJQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMTktISU9MQk5JN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Ogg6Qxw6Kjg9SjhCCT8xFkspKCoaCjhVSFVKTkNDQ0lLQk5NS0hIVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT0tOSDcG
X-HM-Tid: 0a71ed1bd32393b4kuwse210c1a30a3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkZyb206IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KRGF0ZTogMjAyMC0wNC0yOCAy
MToxNzo0NwpUbzogIE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT4sRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPixEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+LEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+LGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcsbGludXgtYW1sb2dpY0BsaXN0cy5pbmZyYWRlYWQub3JnLGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
CkNjOiAgb3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20sQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZp
dm8uY29tPgpTdWJqZWN0OiBbUEFUQ0hdIGRybS9tZXNvbjogcG0gcmVzdW1lIGFkZCByZXR1cm4g
ZXJybm8gYnJhbmNoPnBtX3Jlc3VtcCBhcGkgZGlkIG5vdCBoYW5kbGUgZHJtX21vZGVfY29uZmln
X2hlbHBlcl9yZXN1bWUgZXJyb3IuCj5UaGlzIGNoYW5nZSBhZGQgaGFuZGxlIHRvIHJldHVybiBk
cm1fbW9kZV9jb25maWdfaGVscGVyX3Jlc3VtZWBzCj5lcnJvciBudW1iZXIuIFRoaXMgY29kZSBs
b2dpYyBpcyBhbGlnbmVkIHdpdGggYXBpIHBtX3N1c3BlbmQuCj5BZnRlciB0aGlzIGNoYW5nZSwg
dGhlIGNvZGUgbWF5YmUgYSBiaXQgcmVhZGFibGUuCj4KPlNpZ25lZC1vZmYtYnk6IEJlcm5hcmQg
WmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KPi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNv
bl9kcnYuYyB8IDQgKy0tLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNvbl9kcnYu
YyBiL2RyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNvbl9kcnYuYwo+aW5kZXggYjVmNWViN2I0YmI5
Li44YzJlMWI0N2U4MWEgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVzb24vbWVzb25f
ZHJ2LmMKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNvbl9kcnYuYwo+QEAgLTQxMiw5
ICs0MTIsNyBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG1lc29uX2Rydl9wbV9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQo+IAlpZiAocHJpdi0+YWZiY2Qub3BzKQo+IAkJcHJpdi0+YWZi
Y2Qub3BzLT5pbml0KHByaXYpOwo+IAo+LQlkcm1fbW9kZV9jb25maWdfaGVscGVyX3Jlc3VtZShw
cml2LT5kcm0pOwo+LQo+LQlyZXR1cm4gMDsKPisJcmV0dXJuIGRybV9tb2RlX2NvbmZpZ19oZWxw
ZXJfcmVzdW1lKHByaXYtPmRybSk7Cj4gfQo+IAo+IHN0YXRpYyBpbnQgY29tcGFyZV9vZihzdHJ1
Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpCj4tLSAKPjIuMjYuMgo+Cg0KDQo=
