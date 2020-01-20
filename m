Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F29C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 00:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B4C206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 00:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgATAgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 19:36:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:57747 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgATAgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 19:36:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 16:36:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="374184672"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2020 16:36:17 -0800
Date:   Mon, 20 Jan 2020 08:36:28 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/page_alloc.c: rename free_pages_check_bad() to
 check_free_page_bad()
Message-ID: <20200120003628.GC26292@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com>
 <20200119131408.23247-3-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.2001191406270.43388@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001191406270.43388@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 02:07:04PM -0800, David Rientjes wrote:
>On Sun, 19 Jan 2020, Wei Yang wrote:
>
>> free_pages_check_bad() is the counterpart of check_new_page_bad(), while
>> their naming convention is a little different.
>> 
>> Use verb at first and singular form.
>> 
>
>I think if you agree with the suggestion in patch 1/4 to fix the issue 
>with bad page reporting that it would likely be better to fold patches 2 
>and 3 into that change.

I am ok with this, while would it be confusing for review?

-- 
Wei Yang
Help you, Help me
