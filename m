Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D43C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 11:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA2723B1F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 11:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFTLRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 07:17:34 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:11829 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFTLRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 07:17:33 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 6562A2826FF;
        Sat, 20 Jun 2020 19:16:55 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ANUAnQAuCEPyRKFA*ek664qj.3.1592651815407.Hmail.bernard@vivo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Markus Elfring <Markus.Elfring@web.de>, opensource.kernel@vivo.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Felix_K=C3=BChling?= <Felix.Kuehling@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGtmZDogRml4IG1lbW9yeSBsZWFrcyBhY2NvcmRpbmcgdG8gZXJyb3IgYnJhbmNoZXM=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 14.29.82.33
In-Reply-To: <alpine.DEB.2.22.394.2006201126130.2918@hadrien>
MIME-Version: 1.0
Received: from bernard@vivo.com( [14.29.82.33) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 20 Jun 2020 19:16:55 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Sat, 20 Jun 2020 19:16:55 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGB9NGUxOTU8eGk9DVkpOQklNTkpDSk5PTkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhDT0lCTExNTU5MN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6NS46FSo6Djg#KwIpMD06UR4QTU1PChFVSFVKTkJJTU5KQ0pOQ05LVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKT1VJQlVDSVVISFlXWQgBWUFNQ01MNwY+
X-HM-Tid: 0a72d17219fe9395kuws6562a2826ff
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGcm9tOiBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj4KRGF0ZTogMjAyMC0w
Ni0yMCAxNzozNzoxOQpUbzogIE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+
CkNjOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPixvcGVuc291cmNlLmtlcm5lbEB2
aXZvLmNvbSxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnLGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcsbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZyxBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
LCJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiwiRmVsaXggS8O8
aGxpbmciIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPixEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3
bGwuY2g+LERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KU3ViamVjdDogUmU6IFtQQVRD
SCB2Ml0gZHJtL2FtZGtmZDogRml4IG1lbW9yeSBsZWFrcyBhY2NvcmRpbmcgdG8gZXJyb3IgYnJh
bmNoZXM+Cj4KPk9uIFNhdCwgMjAgSnVuIDIwMjAsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+Cj4+
ID4gVGhlIGZ1bmN0aW9uIGtvYmplY3RfaW5pdF9hbmRfYWRkIGFsbG9jIG1lbW9yeSBsaWtlOgo+
PiA+IGtvYmplY3RfaW5pdF9hbmRfYWRkLT5rb2JqZWN0X2FkZF92YXJnLT5rb2JqZWN0X3NldF9u
YW1lX3ZhcmdzCj4+ID4gLT5rdmFzcHJpbnRmX2NvbnN0LT5rc3RyZHVwX2NvbnN0LT5rc3RyZHVw
LT5rbWFsbG9jX3RyYWNrX2NhbGxlcgo+PiA+IC0+a21hbGxvY19zbGFiLCBpbiBlcnIgYnJhbmNo
IHRoaXMgbWVtb3J5IG5vdCBmcmVlLiBJZiB1c2UKPj4gPiBrbWVtbGVhaywgdGhpcyBwYXRoIG1h
eWJlIGNhdGNoZWQuCj4+ID4gVGhlc2UgY2hhbmdlcyBhcmUgdG8gYWRkIGtvYmplY3RfcHV0IGlu
IGtvYmplY3RfaW5pdF9hbmRfYWRkCj4+ID4gZmFpbGVkIGJyYW5jaCwgZml4IHBvdGVudGlhbCBt
ZW1sZWFrLgo+Pgo+PiBJIHN1Z2dlc3QgdG8gaW1wcm92ZSB0aGlzIGNoYW5nZSBkZXNjcmlwdGlv
bi4KPj4KPj4gKiBDYW4gYW4gb3RoZXIgd29yZGluZyB2YXJpYW50IGJlIG5pY2VyPwo+Cj5NYXJr
dXMncyBzdWdnZXN0aW9uIGlzIGFzIHVzdWFsIGV4dHJlbWVseSBpbXByZWNpc2UuICBIb3dldmVy
LCBJIGFsc28gZmluZAo+dGhlIG1lc3NhZ2UgcXVpdGUgdW5jbGVhci4KPgo+SXQgd291bGQgYmUg
Z29vZCB0byBhbHdheXMgdXNlIEVuZ2xpc2ggd29yZHMuICBhbGxvYyBhbmQgZXJyIGFyZSBub3QK
PkVuZ2xpc2ggd29yZHMuICBQZXJoYXBzIG1vc3QgcGVvcGxlIHdpbGwgZmlndXJlIG91dCB3aGF0
IHRoZXkgYXJlCj5hYmJyZXZpYXRpb25zIGZvciwgYnV0IGl0IHdvdWxkIGJlIGJldHRlciB0byB1
c2UgYSBmZXcgbW9yZSBsZXR0ZXJzIHRvCj5tYWtlIGl0IHNvIHRoYXQgbm8gb25lIGhhcyB0byBn
dWVzcy4KPgo+VGhlbiB0aGVyZSBhcmUgYSBidW5jaCBvZiB0aGluZ3MgdGhhdCBhcmUgY29ubmVj
dGVkIGJ5IGFycm93cyB3aXRoIG5vCj5zcGFjZXMgYmV0d2VlbiB0aGVtLiAgVGhlIG1vc3Qgb2J2
aW91cyBtZWFuaW5nIG9mIGFuIGFycm93IHdpdGggbm8gc3BhY2UKPmFyb3VuZCBpdCBpcyBhIHZh
cmlhYmxlIGRlcmVmZXJlbmNlLiAgQWZ0ZXIgc3BlbmRpbmcgc29tZSBtZW50YWwgZWZmb3J0LAo+
b25lIGNhbiByZWFsaXplIHRoYXQgdGhhdCBpcyBub3Qgd2hhdCB5b3UgbWVhbiBoZXJlLiAgQSBs
YXlvdXQgbGlrZToKPgo+ICAgZmlyc3RfZnVuY3Rpb24gLT4KPiAgICAgc2Vjb25kX2Z1bmN0aW9u
IC0+Cj4gICAgICAgdGhpcmRfZnVuY3Rpb24KPgo+d291bGQgYmUgbXVjaCBtb3JlIHJlYWRhYmxl
Lgo+Cj5JIGRvbid0IGtub3cgd2hhdCAidGhpcyBwYXRjaCBtYXliZSBjYXRjaGVkIiBtZWFucy4g
IElzICJjYXRjaGVkIiBzdXBwb3NlZAo+dG8gYmUgImNhdWdodCIgb3IgImNhY2hlZCI/ICBPdmVy
YWxsLCB0aGUgc2VudGVuY2UgY291bGQgYmUgIkttZW1sZWFrCj5jb3VsZCBwb3NzaWJseSBkZXRl
Y3QgdGhpcyBpc3N1ZSIsIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuICBCdXQgSSBkb24ndAo+a25v
dyB3aGF0IHRoaXMgbWVhbnMuICBEaWQgeW91IGRldGVjdCB0aGUgcHJvYmxlbSB3aXRoIGttZW1s
ZWFrPyAgaWYgeW91Cj5kaWQgbm90IGRldGVjdCB0aGUgcHJvYmxlbSB3aXRoIGttZW1sZWFrLCBh
bmQgb3ZlcmFsbCB5b3UgZG9uJ3Qga25vdwo+d2hldGhlciBrbWVtbGVhayB3b3VsZCBkZXRlY3Qg
dGhlIGJ1ZyBvciBub3QsIGlzIHRoaXMgaW5mb3JtYXRpb24gdXNlZnVsCj5hdCBhbGwgZm9yIHRo
ZSBwYXRjaD8KCkhpOgoKS21lbWxlYWsgZGV0ZWN0ZWQgYSBtZW1vcnkgbGVhayBhcyBiZWxvdzoK
a29iamVjdF9pbml0X2FuZF9hZGQtPgoJa29iamVjdF9hZGRfdmFyZy0+CgkJa29iamVjdF9zZXRf
bmFtZV92YXJncy0+CgkJCWt2YXNwcmludGZfY29uc3QtPgoJCQkJa3N0cmR1cF9jb25zdC0+CgkJ
CQkJa3N0cmR1cC0+CgkJCQkJCWttYWxsb2NfdHJhY2tfY2FsbGVyLT4KCQkJCQkJCWttYWxsb2Nf
c2xhYgoJCklmIGtvYmplY3RfaW5pdF9hbmRfYWRkIGlzIGNhbGxlZCwgYnV0IGtvYmplY3RfcHV0
IGlzIG5vdCBjYWxsZWQgaW4gdGhlIGVycm9yIGJyYW5jaC4KVGhpcyB3aWxsIGJlIGRldGVjdGVk
IGJ5IGttZW1sZWFrLgoKQlIvL0Jlcm5hcmQKCj4iVGhlc2UgY2hhbmdlcyBhcmUgdG8iIG1ha2Vz
IGEgbG90IG9mIHdvcmRzIHdpdGggbm8gaW5mb3JtYXRpb24uICBXaGlsZSBpdAo+aXMgcGVyaGFw
cyBub3QgbmVjZXNzYXJ5IHRvIHNsYXZpc2hseSBmb2xsb3cgdGhlIHJ1bGUgYWJvdXQgdXNpbmcg
dGhlCj5pbXBlcmF0aXZlLCBpZiBpdCBpcyBjb252ZW5pZW50IHRvIHVzZSB0aGUgaW1wZXJhdGl2
ZSwgZG9pbmcgc28gZWxpbWluYXRlcwo+c3VjaCBtZWFuaW5nbGVzcyBwaHJhc2VzLgo+Cj5tZW1s
ZWFrIGlzIGFsc28gbm90IGFuIEVuZ2xpc2ggd29yZC4gIE1lbW9yeSBsZWFrIGlzIG9ubHkgYSBm
ZXcgbW9yZQo+Y2hhcmFjdGVycywgYW5kIGRvZXNuJ3QgcmVxdWlyZSB0aGUgcmVhZGVyIHRvIG1h
a2UgdGhlIHNtYWxsIGV4dHJhIGVmZm9ydAo+dG8gZmlndXJlIG91dCB3aGF0IHlvdSBtZWFuLgo+
Cj5qdWxpYQo+Cj4+Cj4+ICogV2lsbCB0aGUgdGFnIOKAnEZpeGVz4oCdIGJlY29tZSBoZWxwZnVs
IGZvciB0aGUgY29tbWl0IG1lc3NhZ2U/Cj4+Cj4+IFJlZ2FyZHMsCj4+IE1hcmt1cwo+PgoNCg0K
