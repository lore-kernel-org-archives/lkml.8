Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1CAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305482086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598610691;
	bh=hCoLvbGXlkZBTTiGnuuZWSYxKwCz1cZiW4EFFwLGsb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xtsGITXRoxQgWXyZPQayBbde+bQxFJtNZvzL3Q0qfmiumX9urOP8szAgHWLV2soil
	 6JC6ELaqQGPxMYPZdUiPXOXENnExVnj4/aKF0tXqyMSoIOfdaVEvYUAoPQgcs2zz2e
	 KlYQVfe76dHx+hkTnOhUcskQQiIEn9Q+OIc56WEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgH1Kb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbgH1KbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:31:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D2B02086A;
        Fri, 28 Aug 2020 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598610653;
        bh=hCoLvbGXlkZBTTiGnuuZWSYxKwCz1cZiW4EFFwLGsb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kl/Jq2PJVEg7IftSj4886qARRDU9B9OoZNhlBNZOm6huI04V82iFq/zpg9SKfD00M
         BXBLaqdH9LH3IaL6y4qmY+w9yNIAB+OR6HRjrxf4W8Ahqt1wim7YAQGA4fO4NwGzmT
         u+rjvHvHDP8F6e7EWSHrYff4fw51r36cMTFWvviQ=
Date:   Fri, 28 Aug 2020 12:31:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dyndbg: fix problem parsing format="foo bar"
Message-ID: <20200828103106.GE1470435@kroah.com>
References: <20200825173339.2082585-1-jim.cromie@gmail.com>
 <20200825173339.2082585-4-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825173339.2082585-4-jim.cromie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:33:39AM -0600, Jim Cromie wrote:
>  14775b049642 dyndbg: accept query terms like file=bar and module=foo
> 

What does that above line mean???

> That commit broke on a tokenization modality where a word could start
> with a quote, but couldnt continue with one.  So the above would
> tokenize as 'format="foo' and 'bar"', and fail hard.
> 
> This commit fixes the tokenizer by terminating an unquoted token on
> the '=', avoiding that problem.  And since ddebug-parse-query will
> never see a combined 'keyword=value', revert those parts of the
> previous commit.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Again, a Fixes: tag, and fix up your text above please.

Can you do this and send a v3 of this series and any other pending
dyndbg fixes for 5.9-final?

thanks,

greg k-h
