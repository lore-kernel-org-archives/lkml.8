Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FED206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ru7o1usU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgGGG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:56:38 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:49395 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGGG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594104997; x=1625640997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=dYTenh+4o/E5myW1JLq36hnqWz98bpD2JBziT4XX3pU=;
  b=Ru7o1usUeqF5LoH3R/DjTHwCXMxyclt4tKiyb2S0UopGQqm1OFCNex8g
   Ls2zyLOOT7TlnSoXfE0Ip5Adr0AEZ/84YTZceuqFAwu50v9d6oP6tpXXL
   Drtjpzt1ChNL+uyHJWA8duljW5TZbqwi2ta0v77oG35cytCK/evrww3du
   M=;
IronPort-SDR: 6J3coRccikdW1T9bSDb8H9lL3PtPOgswF22QI0fS3hcrC5A7Wn4q495t7lL19LXA0m8OpNz9kb
 fx29I08i9XKQ==
X-IronPort-AV: E=Sophos;i="5.75,321,1589241600"; 
   d="scan'208";a="40386945"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Jul 2020 06:56:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id EC10DA1F51;
        Tue,  7 Jul 2020 06:56:34 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 06:56:34 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.145) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 06:56:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <torvalds@linux-foundation.org>,
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Date:   Tue, 7 Jul 2020 08:56:12 +0200
Message-ID: <20200707065612.8239-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 04 Jul 2020 13:02:51 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> Recent events have prompted a Linux position statement on inclusive
> terminology. Given that Linux maintains a coding-style and its own
> idiomatic set of terminology here is a proposal to answer the call to
> replace non-inclusive terminology.

I'm glad to see this patch.

> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: SeongJae Park <sjpark@amazon.de>

> ---
>  Documentation/process/coding-style.rst          |   12 ++++
>  Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
>  Documentation/process/index.rst                 |    1 
>  3 files changed, 77 insertions(+)
>  create mode 100644 Documentation/process/inclusive-terminology.rst
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..4b15ab671089 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>  
> +For symbol names, avoid introducing new usage of the words 'slave' and
> +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
> +'denylist'.

I have submitted a couple of patches for automated encouragement of the the
inclusive terms and those merged in the -next tree[1,2] now.  Nonetheless, the
version says only "please consider using 'denylist' and 'allowlist' instead of
'blacklist' and 'whitelist'" for now.  I think we could add more terms in there
based on this discussion.  I could do that after this patch is merged, or you
could do that yourself in the next spin of this patch.  Please do whatever you
feel comfort.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7d0bea01dec27195d95d929c1ee49a4a74dd6671
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=95a94258ceb27052f00b7e51588a128d20bf05ed


Thanks,
SeongJae Park
