Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB00C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754D2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PemyobeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgCXVPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:15:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7w5K20uYBDk5hVpEpM8Ff2vkm/jWQtncYQJqoaKJkLU=; b=PemyobeRcL6DwoTmdd6YX2ou/D
        QSdtl6ZdQORTzBCJ1dFvoZUiYrtOB832L+uUxVUI4VG+tLr8zQ49zJcitht2p2yO2K+3bJq/Hifv/
        dRwYRIs5oyzvxjY32NGsX+gnW80vwrd5cJFZG+nhwgfp8MXFfChSUue2OxYYCARTW/PT2PHhYnisP
        lILrAhP2LNMNspE0nWi7ey8RO8BX9tz4DflBZD4SLeblxUVSiewBNLzK4PyOU0da4j1ql0h6l8yJu
        YZ9u0E5fcZDneB7zKBpIV63lJxdHukjHnZlM1Gk1PXqhffXX7PrrZfG7XL1Jmqzhkue3p706996mR
        GPaSP9vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGqtY-0005cj-TR; Tue, 24 Mar 2020 21:15:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E081983502; Tue, 24 Mar 2020 22:15:31 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:15:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 17/26] objtool: Re-arrange validate_functions()
Message-ID: <20200324211531.GR2452@worktop.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.924304616@infradead.org>
 <20200324211006.vaocsz2s7xcalr2i@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324211006.vaocsz2s7xcalr2i@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:10:06PM -0500, Josh Poimboeuf wrote:
> On Tue, Mar 24, 2020 at 04:31:30PM +0100, Peter Zijlstra wrote:
> > +		if (!func->len) {
> > +			WARN("%s() is missing an ELF size annotation",
> > +					func->name);
> 
> wonky indentation

Argh, clearly I need to update my .vimrc on that machine. That's the
default C indenting per Vim and I'm pretty sure I reflowed that function
with =%.


