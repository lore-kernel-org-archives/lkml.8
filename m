Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD71C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4612084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFKkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:40:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:28360 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgCFKkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:40:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 02:40:41 -0800
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="234766235"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 02:40:37 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel,
        linux-doc@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] doc: code generation style
In-Reply-To: <20200305190253.GA28787@avx2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200305190253.GA28787@avx2>
Date:   Fri, 06 Mar 2020 12:40:35 +0200
Message-ID: <87k13xojfg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Mar 2020, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> +1) Generic techniques
> +---------------------
> +
> +### a) Inlining/uninlining function calls ###

What others said about the content is more important, but if you end up
doing this, please drop the 1) and a) stuff in the headings. It's just
manual work someone has to update for no real gain.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
