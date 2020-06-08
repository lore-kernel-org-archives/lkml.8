Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D71BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A852072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TqmdI0hN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgFHL5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:57:22 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:42055 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgFHL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591617439; x=1623153439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=mBD4MaDFTceVZuqlL0CnW8gUjB4N3aqvEq6ol/w0Jn0=;
  b=TqmdI0hNOSAePCnNrB3ecJOy+CXz/rAXqlevSnFu9CuWq6mCBc6OXlJ3
   p7dgtVNruz3H1zNMojk0GLkT39fUyjfr3kg5mRj4PHxuB1FtTufsRsu9M
   0K35imttfsAh3XNABj54LZ+i5BV22Utm1vda3kEii3vWBmWl9of+uw/1/
   g=;
IronPort-SDR: A3XJASAFNQDFfveEQirqPbP6OECZKDI7BAlYdK20yPhT7gVJf2f01dlJM9Gh1+LWubHDgU5YcZ
 x1dEsF5lPsTA==
X-IronPort-AV: E=Sophos;i="5.73,487,1583193600"; 
   d="scan'208";a="36358411"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 08 Jun 2020 11:57:19 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id D635FA1E21;
        Mon,  8 Jun 2020 11:57:07 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 11:57:07 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 11:56:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     David Hildenbrand <david@redhat.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
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
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v15 01/14] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Mon, 8 Jun 2020 13:56:34 +0200
Message-ID: <20200608115634.30778-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cf508f7e-925c-790c-7477-9a1d8150336d@redhat.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D43UWC001.ant.amazon.com (10.43.162.69) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 13:53:23 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 08.06.20 13:40, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit exports 'lookup_page_ext()' to GPL modules.  This will be
> > used by DAMON.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  mm/page_ext.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index a3616f7a0e9e..9d802d01fcb5 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
> >  					MAX_ORDER_NR_PAGES);
> >  	return get_entry(base, index);
> >  }
> > +EXPORT_SYMBOL_GPL(lookup_page_ext);
> >  
> >  static int __init alloc_node_page_ext(int nid)
> >  {
> > 
> 
> I've been told to always smuggle new EXPORTs into the patch that
> actually needs it (and cc relevant people on that patch instead).

Sorry for didn't noticing that.  I will do so in the next spin.


Thanks,
SeongJae Park

> 
> -- 
> Thanks,
> 
> David / dhildenb
