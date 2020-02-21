Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA9DC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D8E222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582294843;
	bh=BsbXvV1cPAYeHc94oTX4QgLR0NK2OaDVtFgTPk+ODWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ES+74k0e+oHRGpsq5+be/HkLdQ5bx0ewxfK3ur+C48CiJ0CRwlubl8r1WCQYiSwNW
	 tzaL4leZml02LsgkeE08p3RkKFgWqYmnWlrPBWcMzWGY08Lzk/Ow3lm1OzqOcORE4W
	 CHexskSl+f5BX7LTIyHY4x/uIslwm3CDyYYEBLbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgBUOUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbgBUOUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:20:41 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCBC206EF;
        Fri, 21 Feb 2020 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582294841;
        bh=BsbXvV1cPAYeHc94oTX4QgLR0NK2OaDVtFgTPk+ODWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/G66Rhi956XQadbBUtgVu06y/KePgw4nmsPgJJ9V7GFETCBBF58JwOxFPoxbtr7U
         Iz6xy7wfZ/FszKYmPQ5kbRIvCFCCps/6Zb09xELR97sKw+I6o8v82hUJgbSMaZ0pti
         syb9tVwxIVVdQwJvKszKbmBRaAqFXtKP5U/rtoC0=
Date:   Fri, 21 Feb 2020 14:20:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/3] samples/hw_breakpoint: Drop use of
 kallsyms_lookup_name()
Message-ID: <20200221142035.GA17979@willie-the-truck>
References: <20200221114404.14641-1-will@kernel.org>
 <20200221114404.14641-3-will@kernel.org>
 <20200221141354.GC6968@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221141354.GC6968@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:13:54PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 21, 2020 at 11:44:03AM +0000, Will Deacon wrote:
> > -static char ksym_name[KSYM_NAME_LEN] = "pid_max";
> > +static char ksym_name[KSYM_NAME_LEN] = "jiffies";
> 
> Is jiffies actually an exported symbol on all configfs?  I thought
> there was some weird aliasing going on with jiffies64.

There is some weird aliasing with jiffies_64, but kernel/time/jiffies.c
has an unconditional:

EXPORT_SYMBOL(jiffies);

so I think we're ok.

> Except for the symbol choice this looks fine, though:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Brill, cheers.

Will
