Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DCAC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB2222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582295274;
	bh=OHkc41Ewzlq6yQkTtkKDt/JRxgXyYlL7UsaHQsVwVwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oh1DvQcbiAaVO32INwo4QMeC29DRAu9PCtDC4Dx7zStoz23oleRe8WuzIEqXlTywG
	 T8J/+BYMI3/PSxHm2PsdAC9IGWabw6YIPViQKn7vyv32/tnewEd5UDTrl582pTItDn
	 wszyM0QDepiCBppJUuB6hnBCN8EKIkPm1RKDvb10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgBUO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:27:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgBUO1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:27:52 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F8E208C4;
        Fri, 21 Feb 2020 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582295272;
        bh=OHkc41Ewzlq6yQkTtkKDt/JRxgXyYlL7UsaHQsVwVwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQtMMLuKKo/t/cAEesylrkbofSEiztAfZDQSeuzIJtqjrd5UXpwFb2XXYwu7m2c6b
         xfp7biZEpr9LuxDDBXehsh77kDdTYzzEmURcY/KIubmS42ZJ8l12c0nb0mTdzwihif
         yWpt/F81vGUF0pkCJ6nKrwHagNj14JUWEYHIg6hU=
Date:   Fri, 21 Feb 2020 23:27:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-Id: <20200221232746.6eb84111a0d385bed71613ff@kernel.org>
In-Reply-To: <20200221114404.14641-1-will@kernel.org>
References: <20200221114404.14641-1-will@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, 21 Feb 2020 11:44:01 +0000
Will Deacon <will@kernel.org> wrote:

> Hi folks,
> 
> Despite having just a single modular in-tree user that I could spot,
> kallsyms_lookup_name() is exported to modules and provides a mechanism
> for out-of-tree modules to access and invoke arbitrary, non-exported
> kernel symbols when kallsyms is enabled.
> 
> This patch series fixes up that one user and unexports the symbol along
> with kallsyms_on_each_symbol(), since that could also be abused in a
> similar manner.

What kind of issue would you like to fix with this?
There are many ways to find (estimate) symbol address, especially, if
the programmer already has the symbol map, it is *very* easy to find
the target symbol address even from one exported symbol (the distance
of 2 symbols doesn't change.) If not, they can use kprobes to find
their required symbol address. If they have a time, they can use
snprintf("%pF") to search symbol.

So, for me, this series just make it hard for casual developers (but
maybe they will find the answer on any technical Q&A site soon).

Hmm, are there other good way to detect such bad-manner out-of-tree
module and reject them? What about decoding them and monitor their
all call instructions? 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
