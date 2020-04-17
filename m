Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2049FC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E4A207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgDQJM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:12:29 -0400
Received: from m177126.mail.qiye.163.com ([123.58.177.126]:48727 "EHLO
        m177126.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbgDQJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:12:28 -0400
Received: from vivo.com (wm-5 [127.0.0.1])
        by m177126.mail.qiye.163.com (Hmail) with ESMTP id A691D182FE2;
        Fri, 17 Apr 2020 17:12:22 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJkA0AC2CGauZEv3r-l2napW.1.1587114742624.Hmail.bernard@vivo.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0ga21hbGxvY19pbmRleCBvcHRpbWl6YXRpb24oY29kZSBzaXplICYgcnVudGltZSBzdGFibGUp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 17 Apr 2020 17:12:22 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Fri, 17 Apr 2020 17:12:22 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVMS05CQkJDTkpJSU1DSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzoxEDpLOjhJODwaDiE#DUgJVhdJ
        FRoLLFVKVUpOQ0xKSk9MT05CT0hVMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWUpOTFVL
        VUhKVUpJSVlXWQgBWUFITUpNNwY+
X-HM-Tid: 0a71876913b46458kursa691d182fe2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKRGF0ZTogMjAyMC0wNC0xNyAxMToyMzo1NApUbzogIEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2
aXZvLmNvbT4KQ2M6ICBDaHJpc3RvcGggTGFtZXRlciA8Y2xAbGludXguY29tPixQZWtrYSBFbmJl
cmcgPHBlbmJlcmdAa2VybmVsLm9yZz4sRGF2aWQgUmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5j
b20+LEpvb25zb28gS2ltIDxpYW1qb29uc29vLmtpbUBsZ2UuY29tPixBbmRyZXcgTW9ydG9uIDxh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPixsaW51eC1tbUBrdmFjay5vcmcsbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZyxrZXJuZWxAdml2by5jb20KU3ViamVjdDogUmU6IFtQQVRDSF0ga21h
bGxvY19pbmRleCBvcHRpbWl6YXRpb24oY29kZSBzaXplICYgcnVudGltZSBzdGFibGUpPk9uIFRo
dSwgQXByIDE2LCAyMDIwIGF0IDA3OjAzOjMwUE0gLTA3MDAsIEJlcm5hcmQgWmhhbyB3cm90ZToK
Pj4ga21hbGxvY19pbmRleCBpbmxpbmUgZnVuY3Rpb24gY29kZSBzaXplIG9wdGltaXphdGlvbiBh
bmQgcnVudGltZQo+PiBwZXJmb3JtYW5jZSBzdGFiaWxpdHkgb3B0aW1pemF0aW9uLiBBZnRlciBv
cHRpbWl6YXRpb24sIHRoZSBmdW5jdGlvbgo+PiBrbWFsbG9jX2luZGV4IGlzIG1vcmUgc3RhYmxl
LCB0aGUgc2l6ZSB3aWxsIG5ldmVyIGFmZmVjdGUgdGhlIGZ1bmN0aW9uYHMKPj4gZXhlY3V0aW9u
IGVmZmljaWVuY3kuCj4+IEFuZCBmb2xsb3cgdGVzdCBkYXRhIHNob3dzIHRoYXQgdGhlIHBlcmZv
cm1hbmNlIG9mIG5ldyBvcHRpbWl6YXRpb24KPj4gZXhjZWVkcyB0aGUgb3JpZ2luYWwgYWxnb3Jp
dGhtIHdoZW4gYXBwbHlpbmcgZm9yIG1vcmUgdGhhbiA1MTIgQnl0ZXMKPj4gKGluY2x1ZGUgNTEy
QikuQW5kIG5ldyBvcHRpbWl6YXRpb24gcnVudGltZSBpcyBtb3JlIHN0YWJsZSB0aGFuIGJlZm9y
ZS4KPgo+VGhhdCdzIGFsbCB2ZXJ5IHdlbGwgYW5kIGdvb2QsIGJ1dCB0aGUgdmFzdCBtYWpvcml0
eSBvZiBhbGxvY2F0aW9ucwo+YXJlIGxlc3MgdGhhbiA1MTIgYnl0ZXMgaW4gc2l6ZSEgIFlvdXIg
bnVtYmVycyBzaG93IHRoYXQgb24gYXZlcmFnZSwKPnRoaXMgcGF0Y2ggbWFrZXMgdGhlIGtlcm5l
bCBzbG93ZXIhCgo+CgoKICAgIFRoaXMgaXMgaW5kZWVkIHRoZSBjYXNlLCB0aGUgbmV3IGFsZ29y
aXRobSBpcyBzdGFibGUgYXQgYSB0aW1lIGxldmVsLCBidXQgCnRoZXJlIGlzIGEgY2VydGFpbiBw
ZXJmb3JtYW5jZSBsb3NzIGZvciByZWxhdGl2ZWx5IHNtYWxsIG1lbW9yeShsaXR0bGUgdGhhbiA1
MTIpLgpJIHdpbGwgY29udGludWUgdG8gcGF5IGF0dGVudGlvbiB0byB0aGlzIHBhcnQgbGF0ZXIu
ICBUaGFua3MuCgo+PiAgICAgICAgICAgICBzaXplICAgICAgICB0aW1lL1BlciAxMDAgbWlsbGlv
biB0aW1lcy51cwo+PiAgICAgICAgICAgICAgICAgICAgICAgICBvbGQgZnVuCQluZXcgZnVuIHdp
dGggb3B0aW1pc2UKPj4gCQk4CTIwMzc3NwkJMjQxOTM0Cj4+IAkJMTYJMjQ1NjExCQk0MDkyNzgK
Pj4gCQkzMgkyMzYzODQJCTQwODQxOQo+PiAJCTY0CTI3NTQ5OQkJNDQ3NzMyCj4+IAkJMTI4CTM1
NDkwOQkJNDE2NDM5Cj4+IAkJMjU2CTM2MDQ3MgkJNDA2NTk4Cj4+IAkJNTEyCTQzMTA3MgkJNDA5
MTY4Cj4+IAkJMTAyNAk0NjM4MjIJCTQwNzQwMQo+CgoNCg0K
