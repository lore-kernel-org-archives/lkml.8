Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D41C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC154206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgFASks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:40:48 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:44408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729949AbgFASkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:40:40 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id C99A98204787;
        Mon,  1 Jun 2020 18:23:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 94961837F24F;
        Mon,  1 Jun 2020 18:23:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fear85_350d3b926d7f
X-Filterd-Recvd-Size: 6754
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Jun 2020 18:22:59 +0000 (UTC)
Message-ID: <2e96576791604862a11f094665b0c4e9c3263fd4.camel@perches.com>
Subject: [RFC PATCH -next] MAINTAINERS: Update F: and X: entry ordering (was
 Re: [PATCH v2 6/6] MAINTAINERS: Add maintainers for MIPS core drivers)
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paul.burton@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 01 Jun 2020 11:22:58 -0700
In-Reply-To: <CAHp75Vej9gRAVspzfruciQ7weFunNBtj8GxbgBCVWtGwk5_ntQ@mail.gmail.com>
References: <20200601122121.15809-1-Sergey.Semin@baikalelectronics.ru>
         <20200601122121.15809-7-Sergey.Semin@baikalelectronics.ru>
         <CAHp75Vec8DA+dVDGif7UhBtxDPFZG0nnCav=qLJON=j8=9QxSA@mail.gmail.com>
         <20200601151903.ipd5ikw35z53eq2t@mobilestation>
         <CAHp75VdQYBqRUbUEHqjp0XE8bEsRcfTuDRn=R-j4c9TYH6niqw@mail.gmail.com>
         <20200601155204.hsatjbukj6haxhld@mobilestation>
         <CAHp75Vej9gRAVspzfruciQ7weFunNBtj8GxbgBCVWtGwk5_ntQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-01 at 19:04 +0300, Andy Shevchenko wrote:
> On Mon, Jun 1, 2020 at 6:52 PM Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote:
> > On Mon, Jun 01, 2020 at 06:30:22PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 1, 2020 at 6:19 PM Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote:
> > > > On Mon, Jun 01, 2020 at 04:56:21PM +0300, Andy Shevchenko wrote:
> > > > > On Mon, Jun 1, 2020 at 3:26 PM Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote:
> > > > > > Add myself as a maintainer of MIPS CPU and GIC IRQchip, MIPS GIC timer
> > > > > > and MIPS CPS CPUidle drivers.
> > > > > ...
> > > > > > +MIPS CORE DRIVERS
> > > > > > +M:     Serge Semin <fancer.lancer@gmail.com>
> > > > > > +L:     linux-mips@vger.kernel.org
> > > > > > +S:     Supported
> > > > > > +F:     drivers/bus/mips_cdmm.c
> > > > > > +F:     drivers/irqchip/irq-mips-cpu.c
> > > > > > +F:     drivers/irqchip/irq-mips-gic.c
> > > > > > +F:     drivers/clocksource/mips-gic-timer.c
> > > > > > +F:     drivers/cpuidle/cpuidle-cps.c
> > > > > 
> > > > > I think nowadays checkpatch.pl warns on wrong ordering in this data base.
[]
> > Next time I won't forget that then. BTW the notes at the top of the MAINTAINERS
> > file don't explicitly say about the files-list order. Only about the
> > whole maintainers list entries order. Seeing the rest of the sub-entries like
> > L:, M:, etc. aren't ordered then it's probably better to have an explicit
> > statement, that files should be alphabetically listed, especially when
> > checkpatch.pl starts warning about that.
> 
> Joe, what do you think?

Fine by me.  Maybe something like the below.

Another thing might be to intermix the F and X entries so that
exclusions are more obviously against the F: entries.

There aren't many MAINTAINERS lines changed when the modified
parse-maintainers is run, but I think it reads better.

It doesn't seem the last major reordering with parse-maintainers
caused any significant issue for anyone.

I think having Linus run scripts/parse-maintainers.pl just before
every release or every few releases would make this issue go away.
---
 MAINTAINERS                  |  1 +
 scripts/checkpatch.pl        | 17 +++++++----------
 scripts/parse-maintainers.pl |  5 ++---
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b045b70e54df..4b53119504ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -118,6 +118,7 @@ Descriptions of section entries and preferred order
 	   F:	net/
 	   X:	net/ipv6/
 	   matches all files in and below net excluding net/ipv6/
+	   F: and X: entries are intermixed in case sensitive alphabetic order
 	N: Files and directories *Regex* patterns.
 	   N:	[^a-z]tegra	all files whose path contains tegra
 	                        (not including files like integrator)
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dd750241958b..499c85be0b2f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3099,16 +3099,13 @@ sub process {
 				if ($curindex < 0) {
 					WARN("MAINTAINERS_STYLE",
 					     "Unknown MAINTAINERS entry type: '$cur'\n" . $herecurr);
-				} else {
-					if ($previndex >= 0 && $curindex < $previndex) {
-						WARN("MAINTAINERS_STYLE",
-						     "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
-					} elsif ((($prev eq 'F' && $cur eq 'F') ||
-						  ($prev eq 'X' && $cur eq 'X')) &&
-						 ($prevval cmp $curval) > 0) {
-						WARN("MAINTAINERS_STYLE",
-						     "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev);
-					}
+				} elsif ($previndex >= 0 && $curindex < $previndex && !($prev =~ /[FX]/ && $cur =~ /[FX]/)) {
+					WARN("MAINTAINERS_STYLE",
+					     "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
+				} elsif ((($prev =~ /[FX]/ && $cur =~ /[FX]/) &&
+					  ($prevval cmp $curval) > 0)) {
+					WARN("MAINTAINERS_STYLE",
+					     "Misordered MAINTAINERS entry - list F and X file patterns in alphabetic order\n" . $hereprev);
 				}
 			}
 		}
diff --git a/scripts/parse-maintainers.pl b/scripts/parse-maintainers.pl
index 2ca4eb3f190d..8d2247a596f0 100755
--- a/scripts/parse-maintainers.pl
+++ b/scripts/parse-maintainers.pl
@@ -84,9 +84,8 @@ sub by_pattern($$) {
     $a_index = 1000 if ($a_index == -1);
     $b_index = 1000 if ($b_index == -1);
 
-    if (($a1 =~ /^F$/ && $b1 =~ /^F$/) ||
-	($a1 =~ /^X$/ && $b1 =~ /^X$/)) {
-	return $a cmp $b;
+    if (($a1 =~ /^[FX]$/ && $b1 =~ /^[FX]$/)) {
+	return substr($a, 1) cmp substr($b, 1);
     }
 
     if ($a_index < $b_index) {


