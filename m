Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A72CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DC5206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HFIRD0S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgFJUO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:14:27 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:56299 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbgFJUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591820049; x=1623356049;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/zjjMaVbDmqq3wXpUWjYwp9e/G6JsSEa+Pr+btXJzbo=;
  b=HFIRD0S2jd2xGzeGfVPImOl8whrm0oZvG+sySDFeb9+vDs5h/DnVG23t
   g7HrYQtsra8+qKp6+RiUFZJaii7iaATx0ght1l218mCRB4cyJylysSqwu
   vYR0OEWKsrP1E7uPIR/yDh5fKXMWNSQwr1V4IouapNguNJi9PblzXRapF
   o=;
IronPort-SDR: VWTjnwx3BrftDrQJamoKDCQfbyc9UdmuRrreUu/coR2zBRNaPZDAbzHzrPzdDM24LOKWEymkSA
 iMm+WNP7shvw==
X-IronPort-AV: E=Sophos;i="5.73,497,1583193600"; 
   d="scan'208";a="35620000"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Jun 2020 20:14:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id D3A1CA260A;
        Wed, 10 Jun 2020 20:13:56 +0000 (UTC)
Received: from EX13D07EUA004.ant.amazon.com (10.43.165.172) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 20:13:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D07EUA004.ant.amazon.com (10.43.165.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 20:13:43 +0000
Received: from u908889d5e8f057.ant.amazon.com (10.1.212.33) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 10 Jun 2020 20:13:35 +0000
Subject: Re: [PATCH v15 01/14] mm/page_ext: Export lookup_page_ext() to GPL
 modules
To:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200608114047.26589-1-sjpark@amazon.com>
 <20200608114047.26589-2-sjpark@amazon.com>
From:   <vrd@amazon.com>
Message-ID: <e6d6f74f-0ff5-e4f3-7b6b-9ff0ce5b4f48@amazon.com>
Date:   Wed, 10 Jun 2020 22:13:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608114047.26589-2-sjpark@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi84LzIwIDE6NDAgUE0sIFNlb25nSmFlIFBhcmsgd3JvdGU6Cj4gRnJvbTogU2VvbmdKYWUg
UGFyayA8c2pwYXJrQGFtYXpvbi5kZT4KPiAKPiBUaGlzIGNvbW1pdCBleHBvcnRzICdsb29rdXBf
cGFnZV9leHQoKScgdG8gR1BMIG1vZHVsZXMuICBUaGlzIHdpbGwgYmUKPiB1c2VkIGJ5IERBTU9O
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNlb25nSmFlIFBhcmsgPHNqcGFya0BhbWF6b24uZGU+Cj4g
UmV2aWV3ZWQtYnk6IExlb25hcmQgRm9lcnN0ZXIgPGZvZXJzbGVvQGFtYXpvbi5kZT4KClJldmll
d2VkLWJ5OiBWYXJhZCBHYXV0YW0gPHZyZEBhbWF6b24uZGU+Cgo+IC0tLQo+ICBtbS9wYWdlX2V4
dC5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1n
aXQgYS9tbS9wYWdlX2V4dC5jIGIvbW0vcGFnZV9leHQuYwo+IGluZGV4IGEzNjE2ZjdhMGU5ZS4u
OWQ4MDJkMDFmY2I1IDEwMDY0NAo+IC0tLSBhL21tL3BhZ2VfZXh0LmMKPiArKysgYi9tbS9wYWdl
X2V4dC5jCj4gQEAgLTEzMSw2ICsxMzEsNyBAQCBzdHJ1Y3QgcGFnZV9leHQgKmxvb2t1cF9wYWdl
X2V4dChjb25zdCBzdHJ1Y3QgcGFnZSAqcGFnZSkKPiAgCQkJCQlNQVhfT1JERVJfTlJfUEFHRVMp
Owo+ICAJcmV0dXJuIGdldF9lbnRyeShiYXNlLCBpbmRleCk7Cj4gIH0KPiArRVhQT1JUX1NZTUJP
TF9HUEwobG9va3VwX3BhZ2VfZXh0KTsKPiAgCj4gIHN0YXRpYyBpbnQgX19pbml0IGFsbG9jX25v
ZGVfcGFnZV9leHQoaW50IG5pZCkKPiAgewo+IAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRl
ciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVo
cnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0g
QW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxp
bgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

