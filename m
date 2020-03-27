Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE85DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F445206F8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgC0L3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:29:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:42872 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0L3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:29:01 -0400
IronPort-SDR: qmRQtPUyEqOI3dZ0YK37c52nazaj6MqnxJn68ovJVmOS9grsNHqWkW5FjysdrNYSOL3pnOIHx5
 F5IOPvIGeBYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 04:29:00 -0700
IronPort-SDR: TplRB2qtu8oKUu9udsKs3UpndgrkxW74fpbT7cF7If3oZvrQSJN5Eibvf6GDn9jmdtzJskRy33
 sd2jMyaKWhLQ==
X-IronPort-AV: E=Sophos;i="5.72,312,1580803200"; 
   d="scan'208";a="421070855"
Received: from defretin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 04:28:57 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     peter@bikeshed.quignogs.org.uk,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
In-Reply-To: <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200326192947.GM22483@bombadil.infradead.org> <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
Date:   Fri, 27 Mar 2020 13:28:54 +0200
Message-ID: <87imiqghop.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, peter@bikeshed.quignogs.org.uk wrote:
> From: Peter Lister <peter@bikeshed.quignogs.org.uk>
>
> [ A couple of typos corrected. Thanks, Matthew ]
>
> In a previous patch, I fixed a couple of doc build warnings due to a
> section heading "Example:" which didn't have the intended effect of
> inserting a heading and literal quoting the following code snippet. I
> added an explicit double colon to fix warnings and produce nice ReST.
>
> Jon suggested that I could have used a minimal form "Example::".
> Unfortunately not - kernel-doc munges the output so that the formatted
> output ends up as a stray colon and no literal block.
>
> Looking around in the source tree, it seems that parameter definitions
> can be more complex than the original authors of kernel-doc allowed
> for. Return values often need lists and examples often should be
> literal blocks. Many comments in the source are "ASCII formatted" but
> kernel-doc can make a mess of them and generate doc build warnings
> along the way.
>
> It seems useful to support some terse idioms which serve as compact
> source annotation and also generate well formed ReST.
>
> Here is a first try to let a heading directly introduce a literal
> block - the "Example::" form for code snippets and an update to
> platform.c to use it, just as Jon suggested.

IMHO the real problem is kernel-doc doing too much preprocessing on the
input, preventing us from doing what would be the sensible thing in
rst. The more we try to fix the problem by adding more kernel-doc
processing, the further we dig ourselves into this hole.

If kernel-doc didn't have its own notion of section headers, such as
"example:", we wouldn't have this problem to begin with. We could just
use the usual rst construct; "example::" followed by an indented block.

I'm not going to stand in the way of the patch, but I'm telling you,
this is going to get harder, not easier, on this path.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
