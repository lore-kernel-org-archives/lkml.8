Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEAAC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCA32253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780960;
	bh=nODn956GT+Zousmucyy1TimLViyW+Jtk5KlJzh6Pkds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=Rhx3TkibNzm7VPw0JcCUVLTLxNTMY+pQGWzLWi4lNiBK8ZuFlxgBYLCewjFBQi2qz
	 +yMXyUUhtJ/aa+FYo/eMATpKlqbDGRD8YxPEoUEwnK3FEXWR0O2FODE+h/djwW+me+
	 fdVj60/zAU8o25zuot9+MkKnCSiS7ZWFAUWqQJvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCITJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgCITJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:09:19 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D0B21655;
        Mon,  9 Mar 2020 19:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780957;
        bh=nODn956GT+Zousmucyy1TimLViyW+Jtk5KlJzh6Pkds=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dRliLFreS4QuAotNsnqlP6TY4DT8l3hH8N8wf/RkyPhfujQh/orwImYSqUtSxVHMw
         BzmSSzwwQcXX4DkwnSp16oKsmr/Itf/d4dLlrm36hLBgY/Bj2P1O9SID4hbOk8Uowp
         7rCS9osoAB0U7wGXtmlHXcZ3R4QQXLPKQ9EXgm4Y=
Message-ID: <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        yangerkun <yangerkun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Neil Brown <neilb@suse.de>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 09 Mar 2020 15:09:15 -0400
In-Reply-To: <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
Content-Type: multipart/mixed; boundary="=-bMosJv09m7X+Hcceq0Wv"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bMosJv09m7X+Hcceq0Wv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-03-09 at 13:22 -0400, Jeff Layton wrote:
> On Mon, 2020-03-09 at 08:52 -0700, Linus Torvalds wrote:
> > On Mon, Mar 9, 2020 at 7:36 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > On Sun, 2020-03-08 at 22:03 +0800, kernel test robot wrote:
> > > > FYI, we noticed a -96.6% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > This is not completely unexpected as we're banging on the global
> > > blocked_lock_lock now for every unlock. This test just thrashes file
> > > locks and unlocks without doing anything in between, so the workload
> > > looks pretty artificial [1].
> > > 
> > > It would be nice to avoid the global lock in this codepath, but it
> > > doesn't look simple to do. I'll keep thinking about it, but for now I'm
> > > inclined to ignore this result unless we see a problem in more realistic
> > > workloads.
> > 
> > That is a _huge_ regression, though.
> > 
> > What about something like the attached? Wouldn't that work? And make
> > the code actually match the old comment about wow "fl_blocker" being
> > NULL being special.
> > 
> > The old code seemed to not know about things like memory ordering either.
> > 
> > Patch is entirely untested, but aims to have that "smp_store_release()
> > means I'm done and not going to touch it any more", making that
> > smp_load_acquire() test hopefully be valid as per the comment..
> 
> Yeah, something along those lines maybe. I don't think we can use
> fl_blocker that way though, as the wait_event_interruptible is waiting
> on it to go to NULL, and the wake_up happens before fl_blocker is
> cleared.
> 
> Maybe we need to mix in some sort of FL_BLOCK_ACTIVE flag and use that
> instead of testing for !fl_blocker to see whether we can avoid the
> blocked_lock_lock?
>   

How about something like this instead? (untested other than for
compilation)

Basically, this just switches the waiters over to wait for
fl_blocked_member to go empty. That still happens before the wakeup, so
it should be ok to wait on that.

I think we can also eliminate the lockless list_empty check in
locks_delete_block, as the fl_blocker check should be sufficient now.
-- 
Jeff Layton <jlayton@kernel.org>

--=-bMosJv09m7X+Hcceq0Wv
Content-Disposition: attachment;
	filename="0001-locks-reinstate-locks_delete_lock-optimization.patch"
Content-Type: text/x-patch;
	name="0001-locks-reinstate-locks_delete_lock-optimization.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBjMTc5ZDc3OWM5YjcyODM4ZWQ5OTk2YTY1ZDY4NmQ4NjY3OWQxNjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgOSBNYXIgMjAyMCAxNDozNTo0MyAtMDQwMApTdWJqZWN0OiBb
UEFUQ0hdIGxvY2tzOiByZWluc3RhdGUgbG9ja3NfZGVsZXRlX2xvY2sgb3B0aW1pemF0aW9uCgou
Li5ieSB1c2luZyBzbXBfbG9hZF9hY3F1aXJlIGFuZCBzbXBfc3RvcmVfcmVsZWFzZSB0byBjbG9z
ZSB0aGUgcmFjZQp3aW5kb3cuCgpbIGpsYXl0b246IHdhaXQgb24gdGhlIGZsX2Jsb2NrZWRfcmVx
dWVzdHMgbGlzdCB0byBnbyBlbXB0eSBpbnN0ZWFkIG9mCgkgICB0aGUgZmxfYmxvY2tlciBwb2lu
dGVyIHRvIGNsZWFyLiBSZW1vdmUgdGhlIGxpc3RfZW1wdHkgY2hlY2sKCSAgIGZyb20gbG9ja3Nf
ZGVsZXRlX2xvY2sgc2hvcnRjdXQuIF0KClNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvY2lmcy9maWxlLmMgfCAgMyArKy0KIGZzL2xvY2tzLmMg
ICAgIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCiAyIGZp
bGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZnMvY2lmcy9maWxlLmMgYi9mcy9jaWZzL2ZpbGUuYwppbmRleCAzYjk0MmVjZGQ0YmUuLjhm
OWQ4NDlhMDAxMiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9maWxlLmMKKysrIGIvZnMvY2lmcy9maWxl
LmMKQEAgLTExNjksNyArMTE2OSw4IEBAIGNpZnNfcG9zaXhfbG9ja19zZXQoc3RydWN0IGZpbGUg
KmZpbGUsIHN0cnVjdCBmaWxlX2xvY2sgKmZsb2NrKQogCXJjID0gcG9zaXhfbG9ja19maWxlKGZp
bGUsIGZsb2NrLCBOVUxMKTsKIAl1cF93cml0ZSgmY2lub2RlLT5sb2NrX3NlbSk7CiAJaWYgKHJj
ID09IEZJTEVfTE9DS19ERUZFUlJFRCkgewotCQlyYyA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJs
ZShmbG9jay0+Zmxfd2FpdCwgIWZsb2NrLT5mbF9ibG9ja2VyKTsKKwkJcmMgPSB3YWl0X2V2ZW50
X2ludGVycnVwdGlibGUoZmxvY2stPmZsX3dhaXQsCisJCQkJCWxpc3RfZW1wdHkoJmZsb2NrLT5m
bF9ibG9ja2VkX21lbWJlcikpOwogCQlpZiAoIXJjKQogCQkJZ290byB0cnlfYWdhaW47CiAJCWxv
Y2tzX2RlbGV0ZV9ibG9jayhmbG9jayk7CmRpZmYgLS1naXQgYS9mcy9sb2Nrcy5jIGIvZnMvbG9j
a3MuYwppbmRleCA0MjZiNTVkMzMzZDUuLjMwOTIzZGI3MDhjMiAxMDA2NDQKLS0tIGEvZnMvbG9j
a3MuYworKysgYi9mcy9sb2Nrcy5jCkBAIC03MjUsNyArNzI1LDYgQEAgc3RhdGljIHZvaWQgX19s
b2Nrc19kZWxldGVfYmxvY2soc3RydWN0IGZpbGVfbG9jayAqd2FpdGVyKQogewogCWxvY2tzX2Rl
bGV0ZV9nbG9iYWxfYmxvY2tlZCh3YWl0ZXIpOwogCWxpc3RfZGVsX2luaXQoJndhaXRlci0+Zmxf
YmxvY2tlZF9tZW1iZXIpOwotCXdhaXRlci0+ZmxfYmxvY2tlciA9IE5VTEw7CiB9CiAKIHN0YXRp
YyB2b2lkIF9fbG9ja3Nfd2FrZV91cF9ibG9ja3Moc3RydWN0IGZpbGVfbG9jayAqYmxvY2tlcikK
QEAgLTc0MCw2ICs3MzksMTIgQEAgc3RhdGljIHZvaWQgX19sb2Nrc193YWtlX3VwX2Jsb2Nrcyhz
dHJ1Y3QgZmlsZV9sb2NrICpibG9ja2VyKQogCQkJd2FpdGVyLT5mbF9sbW9wcy0+bG1fbm90aWZ5
KHdhaXRlcik7CiAJCWVsc2UKIAkJCXdha2VfdXAoJndhaXRlci0+Zmxfd2FpdCk7CisKKwkJLyoK
KwkJICogVGVsbCB0aGUgd29ybGQgd2UncmUgZG9uZSB3aXRoIGl0IC0gc2VlIGNvbW1lbnQgYXQK
KwkJICogdG9wIG9mIGxvY2tzX2RlbGV0ZV9ibG9jaygpLgorCQkgKi8KKwkJc21wX3N0b3JlX3Jl
bGVhc2UoJndhaXRlci0+ZmxfYmxvY2tlciwgTlVMTCk7CiAJfQogfQogCkBAIC03NTMsMTEgKzc1
OCwzMSBAQCBpbnQgbG9ja3NfZGVsZXRlX2Jsb2NrKHN0cnVjdCBmaWxlX2xvY2sgKndhaXRlcikK
IHsKIAlpbnQgc3RhdHVzID0gLUVOT0VOVDsKIAorCS8qCisJICogSWYgZmxfYmxvY2tlciBpcyBO
VUxMLCBpdCB3b24ndCBiZSBzZXQgYWdhaW4gYXMgdGhpcyB0aHJlYWQKKwkgKiAib3ducyIgdGhl
IGxvY2sgYW5kIGlzIHRoZSBvbmx5IG9uZSB0aGF0IG1pZ2h0IHRyeSB0byBjbGFpbQorCSAqIHRo
ZSBsb2NrLiAgU28gaXQgaXMgc2FmZSB0byB0ZXN0IGZsX2Jsb2NrZXIgbG9ja2xlc3NseS4KKwkg
KiBBbHNvIGlmIGZsX2Jsb2NrZXIgaXMgTlVMTCwgdGhpcyB3YWl0ZXIgaXMgbm90IGxpc3RlZCBv
bgorCSAqIGZsX2Jsb2NrZWRfcmVxdWVzdHMgZm9yIHNvbWUgbG9jaywgc28gbm8gb3RoZXIgcmVx
dWVzdCBjYW4KKwkgKiBiZSBhZGRlZCB0byB0aGUgbGlzdCBvZiBmbF9ibG9ja2VkX3JlcXVlc3Rz
IGZvciB0aGlzCisJICogcmVxdWVzdC4gIFNvIGlmIGZsX2Jsb2NrZXIgaXMgTlVMTCwgaXQgaXMg
c2FmZSB0bworCSAqIGxvY2tsZXNzbHkgY2hlY2sgaWYgZmxfYmxvY2tlZF9yZXF1ZXN0cyBpcyBl
bXB0eS4gIElmIGJvdGgKKwkgKiBvZiB0aGVzZSBjaGVja3Mgc3VjY2VlZCwgdGhlcmUgaXMgbm8g
bmVlZCB0byB0YWtlIHRoZSBsb2NrLgorCSAqLworCWlmICghc21wX2xvYWRfYWNxdWlyZSgmd2Fp
dGVyLT5mbF9ibG9ja2VyKSkKKwkJcmV0dXJuIHN0YXR1czsKKwogCXNwaW5fbG9jaygmYmxvY2tl
ZF9sb2NrX2xvY2spOwogCWlmICh3YWl0ZXItPmZsX2Jsb2NrZXIpCiAJCXN0YXR1cyA9IDA7CiAJ
X19sb2Nrc193YWtlX3VwX2Jsb2Nrcyh3YWl0ZXIpOwogCV9fbG9ja3NfZGVsZXRlX2Jsb2NrKHdh
aXRlcik7CisKKwkvKgorCSAqIFRlbGwgdGhlIHdvcmxkIHdlJ3JlIGRvbmUgd2l0aCBpdCAtIHNl
ZSBjb21tZW50IGF0IHRvcAorCSAqIG9mIHRoaXMgZnVuY3Rpb24KKwkgKi8KKwlzbXBfc3RvcmVf
cmVsZWFzZSgmd2FpdGVyLT5mbF9ibG9ja2VyLCBOVUxMKTsKIAlzcGluX3VubG9jaygmYmxvY2tl
ZF9sb2NrX2xvY2spOwogCXJldHVybiBzdGF0dXM7CiB9CkBAIC0xMzUwLDcgKzEzNzUsOCBAQCBz
dGF0aWMgaW50IHBvc2l4X2xvY2tfaW5vZGVfd2FpdChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgZmlsZV9sb2NrICpmbCkKIAkJZXJyb3IgPSBwb3NpeF9sb2NrX2lub2RlKGlub2RlLCBmbCwg
TlVMTCk7CiAJCWlmIChlcnJvciAhPSBGSUxFX0xPQ0tfREVGRVJSRUQpCiAJCQlicmVhazsKLQkJ
ZXJyb3IgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoZmwtPmZsX3dhaXQsICFmbC0+ZmxfYmxv
Y2tlcik7CisJCWVycm9yID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKGZsLT5mbF93YWl0LAor
CQkJCQlsaXN0X2VtcHR5KCZmbC0+ZmxfYmxvY2tlZF9tZW1iZXIpKTsKIAkJaWYgKGVycm9yKQog
CQkJYnJlYWs7CiAJfQpAQCAtMTQzNSw3ICsxNDYxLDggQEAgaW50IGxvY2tzX21hbmRhdG9yeV9h
cmVhKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxwLCBsb2ZmX3Qgc3RhcnQs
CiAJCWVycm9yID0gcG9zaXhfbG9ja19pbm9kZShpbm9kZSwgJmZsLCBOVUxMKTsKIAkJaWYgKGVy
cm9yICE9IEZJTEVfTE9DS19ERUZFUlJFRCkKIAkJCWJyZWFrOwotCQllcnJvciA9IHdhaXRfZXZl
bnRfaW50ZXJydXB0aWJsZShmbC5mbF93YWl0LCAhZmwuZmxfYmxvY2tlcik7CisJCWVycm9yID0g
d2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKGZsLmZsX3dhaXQsCisJCQkJCWxpc3RfZW1wdHkoJmZs
LmZsX2Jsb2NrZWRfbWVtYmVyKSk7CiAJCWlmICghZXJyb3IpIHsKIAkJCS8qCiAJCQkgKiBJZiB3
ZSd2ZSBiZWVuIHNsZWVwaW5nIHNvbWVvbmUgbWlnaHQgaGF2ZQpAQCAtMTYzOCw3ICsxNjY1LDgg
QEAgaW50IF9fYnJlYWtfbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IG1v
ZGUsIHVuc2lnbmVkIGludCB0eXBlKQogCiAJbG9ja3NfZGlzcG9zZV9saXN0KCZkaXNwb3NlKTsK
IAllcnJvciA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KG5ld19mbC0+Zmxfd2Fp
dCwKLQkJCQkJCSFuZXdfZmwtPmZsX2Jsb2NrZXIsIGJyZWFrX3RpbWUpOworCQkJCQlsaXN0X2Vt
cHR5KCZuZXdfZmwtPmZsX2Jsb2NrZWRfbWVtYmVyKSwKKwkJCQkJYnJlYWtfdGltZSk7CiAKIAlw
ZXJjcHVfZG93bl9yZWFkKCZmaWxlX3J3c2VtKTsKIAlzcGluX2xvY2soJmN0eC0+ZmxjX2xvY2sp
OwpAQCAtMjEyMiw3ICsyMTUwLDggQEAgc3RhdGljIGludCBmbG9ja19sb2NrX2lub2RlX3dhaXQo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGVfbG9jayAqZmwpCiAJCWVycm9yID0gZmxv
Y2tfbG9ja19pbm9kZShpbm9kZSwgZmwpOwogCQlpZiAoZXJyb3IgIT0gRklMRV9MT0NLX0RFRkVS
UkVEKQogCQkJYnJlYWs7Ci0JCWVycm9yID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKGZsLT5m
bF93YWl0LCAhZmwtPmZsX2Jsb2NrZXIpOworCQllcnJvciA9IHdhaXRfZXZlbnRfaW50ZXJydXB0
aWJsZShmbC0+Zmxfd2FpdCwKKwkJCQlsaXN0X2VtcHR5KCZmbC0+ZmxfYmxvY2tlZF9tZW1iZXIp
KTsKIAkJaWYgKGVycm9yKQogCQkJYnJlYWs7CiAJfQpAQCAtMjM5OSw3ICsyNDI4LDggQEAgc3Rh
dGljIGludCBkb19sb2NrX2ZpbGVfd2FpdChzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgaW50
IGNtZCwKIAkJZXJyb3IgPSB2ZnNfbG9ja19maWxlKGZpbHAsIGNtZCwgZmwsIE5VTEwpOwogCQlp
ZiAoZXJyb3IgIT0gRklMRV9MT0NLX0RFRkVSUkVEKQogCQkJYnJlYWs7Ci0JCWVycm9yID0gd2Fp
dF9ldmVudF9pbnRlcnJ1cHRpYmxlKGZsLT5mbF93YWl0LCAhZmwtPmZsX2Jsb2NrZXIpOworCQll
cnJvciA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZShmbC0+Zmxfd2FpdCwKKwkJCQkJbGlzdF9l
bXB0eSgmZmwtPmZsX2Jsb2NrZWRfbWVtYmVyKSk7CiAJCWlmIChlcnJvcikKIAkJCWJyZWFrOwog
CX0KLS0gCjIuMjQuMQoK


--=-bMosJv09m7X+Hcceq0Wv--

