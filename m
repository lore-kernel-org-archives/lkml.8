Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F81C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08E6246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582895476;
	bh=ekN33uYg9028hK6SiF2khbsXw9431mFQ3x+40AKHjWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yhOx7JvxDCkoUrkzBvz1JV2EJLu4mNHqapdl/S5XEJ2yn/TD6hofLlBV5Q+E5cfC7
	 KVKPUhiEnt3H+djpOC3q3jlvbrvhak7q1RJij1BrCXSGm1N55JuGMNSZNW7jWDAp5I
	 seqLo0OY3XdVCW2g/9Q69I2TfxnY+Wkt/6jt3RJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1NLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:11:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgB1NLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:11:14 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C0224677;
        Fri, 28 Feb 2020 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582895473;
        bh=ekN33uYg9028hK6SiF2khbsXw9431mFQ3x+40AKHjWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rDvxCRq/uDJOYemW2mKjAuBXZ06V5J3xBjIjzqoK/DZpK9nn/bfd2mo/ENyhxdOIE
         X0UQMRc2ecKLztli97DmNHDq6PGjuLHqSxsePK3/U6MFrp1dxUDBRJ1ThjIotxOFdA
         9sKoGL5VhS1yRvaAH/9KCEnrizItOPtkipx2n3zo=
Date:   Fri, 28 Feb 2020 22:11:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [1/2] Documentation: bootconfig: Update boot configuration
 documentation
Message-Id: <20200228221108.ff392be76fee6925f27103e6@kernel.org>
In-Reply-To: <efe38d09-e73d-97b3-d4be-79194ab2685f@web.de>
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
        <158278835238.14966.16157216423901327777.stgit@devnote2>
        <8514c830-319b-33e9-025a-79d399674fb3@web.de>
        <20200228143528.209db45e5f0f78474ef83387@kernel.org>
        <efe38d09-e73d-97b3-d4be-79194ab2685f@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 09:30:27 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >> How do you think about to add a link to a formal file format description?
> >
> > Oh, nice idea. Please contribute it :)
> 
> Did you provide it (according to a RST include directive in the subsequent
> update step)?

No I didn't. I you think that is important, feel free to write up. You have
a parser code in the kernel already. It might be not hard for you. :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
