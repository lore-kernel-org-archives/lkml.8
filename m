Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913ADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDCD207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHSVGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:06:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:55834 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbgHSVGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:06:18 -0400
IronPort-SDR: KcQ6oSogylnGHzEJTJIQu2B4ps1m9HgOYNUfhLnNevyX2Kt6RXo7xyG19zeNswBgKGtWUOFz+S
 CzntsdbTfjjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="143012617"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="143012617"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:06:17 -0700
IronPort-SDR: FWr17Dun6lUnUVRUieiFkiAHoWuXzqE9QHDABZwQLIJ3rv0tQ+AjCKZ2J4wybjEYVZfmZzOwD0
 Dagg/7c9HHxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="337083065"
Received: from pbooyens-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2020 14:06:14 -0700
Date:   Thu, 20 Aug 2020 00:06:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kprobes: Use module_name() macro
Message-ID: <20200819210613.GD9942@linux.intel.com>
References: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
 <20200818234956.c616371d8766e74aef5e7bd2@kernel.org>
 <20200818163356.GG137138@linux.intel.com>
 <20200818130045.7bb13992@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818130045.7bb13992@oasis.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 01:00:45PM -0400, Steven Rostedt wrote:
> On Tue, 18 Aug 2020 19:33:56 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>  
> > 
> > Great, thank you.
> > 
> > When this might get included to a PR, or at minimum land to linux-next?
> > 
> > Just thinking what to use as the baseline for the next version of my
> > main series.
> 
> I can apply this to my tree along with Masami's latest bootconfig
> patches. This will be for linux-next. I don't usually push to
> linux-next until around -rc3. Would that be too late?
> 
> -- Steve

Nope. I have piles of stuff to catch before getting to work with this
(because coming back from vacation).

/Jarkko
