Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D7C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A7207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgDTRal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:30:41 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:39548 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgDTRaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:30:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CD7071802EC18;
        Mon, 20 Apr 2020 17:30:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wire77_794acccb34a52
X-Filterd-Recvd-Size: 2900
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Apr 2020 17:30:33 +0000 (UTC)
Message-ID: <0cff04825062a6e4b04a19cac80152b9943402b1.camel@perches.com>
Subject: Re: [PATCHv3 01/50] kallsyms/printk: Add loglvl to print_ip_sym()
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Burton <paulburton@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Mon, 20 Apr 2020 10:28:17 -0700
In-Reply-To: <7616c5f4-def1-7362-ceef-db76107b9c2b@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
         <20200418201944.482088-2-dima@arista.com>
         <24a1f021e52ccabfd53baa22b93947ef10e6bf3b.camel@perches.com>
         <7616c5f4-def1-7362-ceef-db76107b9c2b@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-20 at 18:25 +0100, Dmitry Safonov wrote:
> Hi Joe,

Hi Dmitry.

> On 4/18/20 9:40 PM, Joe Perches wrote:
> > On Sat, 2020-04-18 at 21:18 +0100, Dmitry Safonov wrote:
> > > print_ip_sym() needs to have a log level parameter to comply with other
> > > parts being printed. Otherwise, half of the expected backtrace would be
> > > printed and other may be missing with some logging level.
> > 
> > I'd rather create another extension to %ps that also emits
> > the [<address>] along with the symbol lookup and retire
> > print_ip_sym altogether.
> 
> Makes sense.
> Would you mind if I'll do it on the top of these patches?
> [not to mix new printk-format with patches those add loglvl parameter]

Of course not, but the proposal below doesn't compile
and I've been playing with a slightly different
implementation.

I'll post it in a few days.


