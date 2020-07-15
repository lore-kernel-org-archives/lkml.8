Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81580C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD152065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgGOMTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:19:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:38998 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgGOMTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:19:16 -0400
IronPort-SDR: TJ1ngcIFV1P8cXgwVe8hnKMapai6GjBquAEn7k1wRMAuYi+V2ZPWxSnNcaZZVe8dAafyTEgLnG
 qrHq7HW7q2mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="233988230"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="233988230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 05:19:15 -0700
IronPort-SDR: kXB9TWIVBm4Sbe3w+71xC2TYXsmh9E312mvHk1RuDdeTcp8fqWcIMJ1Lqip7FpjiLWhk+UFb73
 xGEs0Pp0NHjQ==
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="460051039"
Received: from iferdane-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.55.197])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 05:19:10 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, corbet@lwn.net
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
In-Reply-To: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Wed, 15 Jul 2020 15:19:06 +0300
Message-ID: <87o8oh0y4l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Dan Williams <dan.j.williams@intel.com> wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
>
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Chris Mason <clm@fb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
> Changes since v2 [1]:
> - Pick up missed sign-offs and acks from Jon, Shuah, and Christian
>   (sorry about missing those earlier).
>
> - Reformat the replacement list to make it easier to read.
>
> - Add 'controller' as a suggested replacement (Kees and Mark)
>
> - Fix up the paired term for 'performer' to be 'director' (Kees)
>
> - Collect some new acks, reviewed-by's, and sign-offs for v2.
>
> - Fix up Chris's email
>
> [1]: http://lore.kernel.org/r/159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com
>
>
>  Documentation/process/coding-style.rst |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..1bee6f8affdb 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,26 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>  
> +For symbol names and documentation, avoid introducing new usage of
> +'master / slave' (or 'slave' independent of 'master') and 'blacklist /
> +whitelist'.
> +
> +Recommended replacements for 'master / slave' are:
> +    '{primary,main} / {secondary,replica,subordinate}'
> +    '{initiator,requester} / {target,responder}'
> +    '{controller,host} / {device,worker,proxy}'
> +    'leader / follower'
> +    'director / performer'
> +
> +Recommended replacements for 'blacklist/whitelist' are:
> +    'denylist / allowlist'
> +    'blocklist / passlist'
> +
> +Exceptions for introducing new usage is to maintain a userspace ABI/API,
> +or when updating code for an existing (as of 2020) hardware or protocol
> +specification that mandates those terms. For new specifications
> +translate specification usage of the terminology to the kernel coding
> +standard where possible.
>  
>  5) Typedefs
>  -----------
>
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

-- 
Jani Nikula, Intel Open Source Graphics Center
