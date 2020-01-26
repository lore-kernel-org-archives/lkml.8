Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B212075D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580052514;
	bh=WRUUtesK4qd1zdh5jOh2P9Vyhrpx1MsrofV4bN3ZABI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Nlw1ARJDdhubroOLlEGxsaptFDDu62q+GA10aYmfrLYQojSG262yYnBkwGbdvsNY0
	 6rRFj0LleuXgHCF8vGPoTFkIMxr667w5MIr3MDUMSjfvbTZvTzX8ZJaklMinVjTxIa
	 8vMAtNKD2okRMnwFOfx2r7UXUyydl0aok334maDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgAZP2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 10:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgAZP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 10:28:32 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA9D02071A;
        Sun, 26 Jan 2020 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580052512;
        bh=WRUUtesK4qd1zdh5jOh2P9Vyhrpx1MsrofV4bN3ZABI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cNGyFWbpUyL9oSB6EG/ZVbFy1jFUtscaHF9QR69+eWe8WaK5CCxCY31msS6gKu8En
         Koj0Igb7tMZTXl3+5FRu8hPRioABp1gvmL+O54qC9uo7k4MHd/YRb30aSKXMQFkBCp
         TmW1nwgJiVcBLblu/RsxrJ+bKliJLgTDMJMgLFDY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C6772352277B; Sun, 26 Jan 2020 07:28:31 -0800 (PST)
Date:   Sun, 26 Jan 2020 07:28:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200126152831.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
 <20200125194846.GF2935@paulmck-ThinkPad-P72>
 <20200126014318.GA5122@paulmck-ThinkPad-P72>
 <20200126112540.GA5714@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126112540.GA5714@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 12:25:40PM +0100, Borislav Petkov wrote:
> On Sat, Jan 25, 2020 at 05:43:18PM -0800, Paul E. McKenney wrote:
> > And it passes my rcutorture testing as well!  If it does fine with 0day
> > and -next, I will send a pull request Sunday evening, Pacific Time.
> > In the meantime, it is right here in -rcu:
> > 
> > 59d8cc6b2e37 ("rcu: Forgive slow expedited grace periods at boot time")
> 
> Yap, testing looks good here too.
> 
> Thx Paul.

And thank you for finding this and for the testing!

May I add your Tested-by?

							Thanx, Paul
