Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27158C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F58206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgGYCsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:48:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:47558 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgGYCsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:48:41 -0400
IronPort-SDR: LnndAmwUL2clo5PDm++AsNGuOzliVquDR/YAwgWqN9dKP9Im5E31lxSurzVvTgnbQyrlsR11xo
 6I0Ln1zXTawQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130885133"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="130885133"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 19:48:41 -0700
IronPort-SDR: fzqS3eLZLAAO3Tug8va7oJq1zLXSeJ8KCeB1kRH1CBPIHN4j/QCtgtzobUGR5h7sifonFMs3XN
 sgIH0Tmhnl5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="329100321"
Received: from jcrametz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2020 19:48:36 -0700
Date:   Sat, 25 Jul 2020 05:48:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 1/6] kprobes: Remove dependency to the module_mutex
Message-ID: <20200725024834.GE17052@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
 <20200724234631.40f4ffec6adae57ac3df8ea3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724234631.40f4ffec6adae57ac3df8ea3@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:46:31PM +0900, Masami Hiramatsu wrote:
> On Fri, 24 Jul 2020 08:05:48 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Add lock_modules() and unlock_modules() wrappers for acquiring module_mutex
> > in order to remove the compile time dependency to it.
> 
> This subject is a bit confusing. This is just wrapping modules_mutex in
> kpprobes. We still have compile time dependency, e.g. module_state, right?

Yes. This more like a preliminary change to make that happen. The
actual flagging is in 6/6 ("Remove CONFIG_MODULE dependency").

Maybe a better angle would be to make this update all sites that
deal with module_mutex [*] and base the whole rationale on that?

[*] https://lore.kernel.org/lkml/20200725024227.GD17052@linux.intel.com/

/Jarkko
