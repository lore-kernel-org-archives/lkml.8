Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D25C433EC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB4220738
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Wdrlps37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGZUde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 16:33:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:16529 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGZUde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:33:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BFF566vwDz4D;
        Sun, 26 Jul 2020 22:33:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1595795611; bh=hWSgLNCRAj4HMVVvAZmSUOr1NZo4lGA3zytqEYdGgus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wdrlps37SNaSjxBzBoDAzcV2fEu9KPPOZR8rLCrSmSSvSLUcXV2d5ILw1DaOy2cwj
         TYOp5rb6zyroDpDPOzxib9sGpQN7iVXEyQ3NIQ+lxg0q0MWbDd+eWnoVwtThQfSjvF
         zWLwQimdz2/KVJK8tXrdds5n0jnjRr9gpQz8XYQyRSVJQZxc/ROvKMo8Uka2lmUsUo
         5U1ivdBb+ijMILLBDHEEsSfIlftBeK9ONg0P24zl4R8QPG/5GueKA8gZt8Jisas3Om
         6S4TgLmaEA9uqEyvYEZoKtlcY0pMBFYwwZszzn0ymppkUPPovkFmBmOAEz5go+m3+e
         4OOZel3UKezyA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Sun, 26 Jul 2020 22:33:28 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Joe Perches <joe@perches.com>, SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: checkpatch: support deprecated terms checking
Message-ID: <20200726203328.GA8321@qmqm.qmqm.pl>
References: <5f5679b4c76bf0e16064f3a45319bc35938ad96b.camel@perches.com>
 <20200726180748.29924-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200726180748.29924-1-sj38.park@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 08:07:48PM +0200, SeongJae Park wrote:
> On Sun, 26 Jul 2020 09:42:06 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Sun, 2020-07-26 at 17:36 +0200, SeongJae Park wrote:
> > > On Sun, 26 Jul 2020 07:50:54 -0700 Joe Perches <joe@perches.com> wrote:
> > []
> > > > I do not want to encourage relatively inexperienced people
> > > > to run checkpatch and submit inappropriate patches.
> > > 
> > > Me, neither.  But, I think providing more warnings and references is better for
> > > that.
> > 
> > Unfortunately, the inexperienced _do_ in fact run
> > checkpatch on files and submit inappropriate patches.
> > 
> > It's generally a time sink for the experienced
> > maintainers to reply.
> > 
> > > Simply limiting checks could allow people submitting inappropriate patches
> > > intorducing new uses of deprecated terms.
> > 
> > Tradeoffs...
> > 
> > I expect that patches being reviewed by maintainers
> > are preferred over files being inappropriately changed
> > by the inexperienced.
> > 
> > Those inappropriate changes should not be encouraged
> > by tools placed in the hands of the inexperienced.
> 
> Right, many things are tradeoff.  Seems we arrived in the point, though we
> still have different opinions.  To summarize the pros and cons of my patch from
> my perspective:
> 
> Pros 1: Handle future terms deprecated with different reasons and coverages.
> Pros 2: Inappropriate patches are avoided if the submitters carefully read the
> warning messages.
> Cons: Careless people could still bother maintainers by not carefully reading
> the message and sending inappropriate patches.
> 
> To me, the pros still seems larger than the cons.  I would like to also again
> mention that the maintainer who first reported the problem, Michal, told it's
> ok with the explicit messaging.  Nonethelss, this is just my opinion.
> 
> Attaching the patch addressing your comments for the previous version.  The
> changes from the previous version are:
> 
>  - Make the name of reported terms not too verbose
>  - Avoid unnecessary initialization of the reported terms hash
>  - Warn multiple deprecated terms in same line

Hi,

Maybe you could split the meaning of --subjective and --strict, and
enable those checks only for --subjective? The test is really hard to do
right: you would have to consider the context and not only mere occurrence
of a word (heh, I even wrote 'blacklisted' here, since it really is about
a night/danger analogy and not political/ethical one).

Best Regards,
Micha³ Miros³aw
