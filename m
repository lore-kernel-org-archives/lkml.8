Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E66320823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgESQKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgESQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:10:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EDEC08C5C0;
        Tue, 19 May 2020 09:10:53 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1FDF2EC;
        Tue, 19 May 2020 16:10:51 +0000 (UTC)
Date:   Tue, 19 May 2020 10:10:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
Message-ID: <20200519101043.4471069a@lwn.net>
In-Reply-To: <1bc96da4-49d7-1c8e-de15-858641aba59f@al2klimov.de>
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
        <20200517134544.7d649bbb@lwn.net>
        <1bc96da4-49d7-1c8e-de15-858641aba59f@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 22:18:23 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> >   - Various documents have maintainers who are likely to be interested in
> >     changes and should be copied; that is what the get_maintainer.pl script
> >     is for.  If that generates a massive list of recipients, that's a cue
> >     that your patch is too large.  
> Huh? I *did* run that script (automated) per file and grouped files per 
> identical set of patch recipients. I.e. this patch should contain only 
> changes for the recipients I've sent it to.
> If your invocation of the script doesn't agree with me, please share the 
> output and how to reproduce (as if I had just my own patch eMail, the 
> upstream Git repo and all the tools of course).

OK, I fed your patch to the script, waited a fair while, and got what's
below.  And yes, you don't want to actually send a patch to such a list of
recipients - it's a sign that your patch is too large.

Thanks,

jon

Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/1=100%,commit_signer:1/2=50%,commit_signer:4/5=80%,authored:1/5=20%,commit_signer:2/4=50%,commit_signer:21/109=19%,commit_signer:3/5=60%,commit_signer:2/2=100%,commit_signer:3/3=100%,authored:1/3=33%,added_lines:8/17=47%,removed_lines:5/15=33%,commit_signer:3/16=19%,commit_signer:11/11=100%,commit_signer:3/4=75%,commit_signer:2/3=67%,commit_signer:1/3=33%,authored:1/1=100%,added_lines:23/23=100%,removed_lines:17/17=100%,commit_signer:4/4=100%,commit_signer:3/7=43%,authored:1/7=14%)
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:1/1=100%,removed_lines:1/1=100%,added_lines:98/98=100%,commit_signer:2/2=100%,authored:2/2=100%,commit_signer:1/5=20%,authored:1/5=20%,commit_signer:23/109=21%,authored:23/109=21%,added_lines:57/585=10%,removed_lines:60/200=30%,commit_signer:3/3=100%,authored:3/3=100%,commit_signer:4/5=80%,authored:4/5=80%,added_lines:2/2=100%,removed_lines:2/2=100%,commit_signer:3/5=60%,authored:3/5=60%,added_lines:488/488=100%,commit_signer:1/3=33%,authored:1/3=33%,commit_signer:1/2=50%,authored:1/2=50%,added_lines:8/17=47%,removed_lines:9/15=60%,commit_signer:2/4=50%,authored:2/4=50%,authored:1/16=6%,commit_signer:4/4=100%,authored:4/4=100%,removed_lines:359/359=100%,commit_signer:1/11=9%,authored:1/11=9%,commit_signer:1/4=25%,authored:1/4=25%,added_lines:115/115=100%,added_lines:147/147=100%,added_lines:1/12=8%,removed_lines:1/12=8%,added_lines:176/176=100%,added_lines:593/593=100%,added_lines
 :458/458=100%,added_lines:18/18=100%,added_lines:1334/1334=100%,commit_signer:2/7=29%,authored:2/7=29%)
"Rafael J. Wysocki" <rafael.j.wysocki@intel.com> (commit_signer:2/2=100%)
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:62/64=97%)
Randy Dunlap <rdunlap@infradead.org> (commit_signer:1/2=50%,authored:1/2=50%,removed_lines:2/2=100%,commit_signer:1/1=100%,authored:1/4=25%,added_lines:9/15=60%,removed_lines:5/25=20%,commit_signer:1/7=14%)
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> (commit_signer:1/1=100%)
Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> (commit_signer:1/2=50%)
Alexandre Belloni <alexandre.belloni@bootlin.com> (commit_signer:1/2=50%,commit_signer:2/3=67%,commit_signer:1/7=14%,authored:1/7=14%)
David Sterba <dsterba@suse.com> (commit_signer:1/2=50%,commit_signer:1/5=20%,commit_signer:1/4=25%,commit_signer:1/1=100%)
"Jonathan Neuschäfer" <j.neuschaefer@gmx.net> (commit_signer:3/5=60%,authored:3/5=60%,commit_signer:1/2=50%,authored:1/2=50%,commit_signer:1/1=100%,authored:1/1=100%,added_lines:5/5=100%,removed_lines:5/5=100%)
Cornelia Huck <cohuck@redhat.com> (commit_signer:1/5=20%)
Logan Gunthorpe <logang@deltatee.com> (commit_signer:1/5=20%)
Mark Greer <mgreer@animalcreek.com> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:2/14=14%,removed_lines:2/5=40%)
"David S. Miller" <davem@davemloft.net> (commit_signer:1/4=25%)
Ian Abbott <abbotti@mev.co.uk> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:10/14=71%,removed_lines:1/5=20%)
Colin Ian King <colin.king@canonical.com> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:1/14=7%,removed_lines:1/5=20%)
Jacob Keller <jacob.e.keller@intel.com> (authored:1/4=25%,added_lines:1/14=7%,removed_lines:1/5=20%)
"Theodore Ts'o" <tytso@mit.edu> (commit_signer:2/2=100%)
Eric Biggers <ebiggers@google.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:2/13=15%,authored:1/7=14%)
Jan Kara <jack@suse.cz> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:11/13=85%,removed_lines:8/8=100%)
Thomas Gleixner <tglx@linutronix.de> (commit_signer:16/109=15%,commit_signer:1/4=25%)
"Paul E. McKenney" <paulmck@kernel.org> (commit_signer:8/109=7%,added_lines:30/585=5%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:8/109=7%,commit_signer:17/16=100%,authored:11/16=69%,commit_signer:1/1=100%)
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> (added_lines:67/585=11%)
Juergen Gross <jgross@suse.com> (removed_lines:21/200=10%)
Oliver Neukum <oneukum@suse.com> (removed_lines:10/200=5%)
Andy Shevchenko <andy.shevchenko@gmail.com> (commit_signer:2/2=100%,commit_signer:3/3=100%,commit_signer:3/5=60%)
Pavel Machek <pavel@ucw.cz> (commit_signer:1/5=20%,commit_signer:1/1=100%)
Alexander Schremmer <alex@alexanderweb.de> (authored:1/5=20%)
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:292/292=100%,commit_signer:2/5=40%,authored:2/5=40%)
Nicolas Ferre <nicolas.ferre@microchip.com> (commit_signer:2/3=67%,authored:2/3=67%)
Changbin Du <changbin.du@intel.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:16/17=94%,removed_lines:13/14=93%)
Sheriff Esseson <sheriffesseson@gmail.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:1/17=6%,removed_lines:1/14=7%)
"André Almeida" <andrealmeid@collabora.com> (commit_signer:1/3=33%,authored:1/3=33%,added_lines:1/17=6%,removed_lines:1/15=7%)
Dan Williams <dan.j.williams@intel.com> (commit_signer:2/4=50%,commit_signer:2/2=100%)
Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> (commit_signer:1/4=25%,authored:1/4=25%)
Michal Suchanek <msuchanek@suse.de> (commit_signer:1/4=25%,authored:1/4=25%)
Zhang Rui <rui.zhang@intel.com> (commit_signer:2/2=100%)
Mark Brown <broonie@kernel.org> (commit_signer:1/1=100%,commit_signer:1/3=33%)
"Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu> (commit_signer:1/1=100%)
Bjorn Helgaas <bhelgaas@google.com> (commit_signer:1/1=100%,commit_signer:1/3=33%)
"Joakim Lönnegren" <joakimlonnegren@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:5/5=100%)
Geert Uytterhoeven <geert+renesas@glider.be> (commit_signer:3/16=19%,authored:3/16=19%)
Viresh Kumar <viresh.kumar@linaro.org> (commit_signer:2/16=12%)
Rikard Falkeborn <rikard.falkeborn@gmail.com> (commit_signer:1/16=6%,authored:1/16=6%)
Al Viro <viro@zeniv.linux.org.uk> (commit_signer:2/2=100%,authored:1/2=50%,removed_lines:5/11=45%)
Aleksa Sarai <cyphar@cyphar.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:62/64=97%,removed_lines:6/11=55%)
Rob Herring <robh@kernel.org> (commit_signer:1/3=33%)
"Tobin C. Harding" <tobin@kernel.org> (commit_signer:10/11=91%,authored:10/11=91%)
Federico Vaga <federico.vaga@vaga.pv.it> (commit_signer:2/4=50%,commit_signer:1/1=100%,commit_signer:1/2=50%,commit_signer:1/4=25%)
Stephen Boyd <swboyd@chromium.org> (commit_signer:2/4=50%,authored:2/4=50%,added_lines:89/93=96%,removed_lines:89/93=96%)
Kees Cook <keescook@chromium.org> (commit_signer:1/4=25%)
Stephen Kitt <steve@sk2.org> (authored:1/4=25%)
Jacek Anaszewski <jacek.anaszewski@gmail.com> (commit_signer:1/1=100%)
Linus Walleij <linus.walleij@linaro.org> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:30/30=100%)
Marco Villegas <git@marvil07.net> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:1/1=100%,removed_lines:1/1=100%)
Tony Fischetti <tony.fischetti@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:55/55=100%,removed_lines:53/53=100%,commit_signer:1/4=25%,authored:1/4=25%,added_lines:9/12=75%,removed_lines:9/12=75%,commit_signer:1/2=50%,authored:1/2=50%,added_lines:9/10=90%,removed_lines:8/9=89%)
Chris Packham <chris.packham@alliedtelesis.co.nz> (commit_signer:1/3=33%,authored:1/3=33%)
Borislav Petkov <bp@suse.de> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:2/15=13%,removed_lines:2/25=8%)
Arnd Bergmann <arnd@arndb.de> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:2/15=13%,removed_lines:14/25=56%,commit_signer:1/7=14%)
"Jason A. Donenfeld" <Jason@zx2c4.com> (commit_signer:1/4=25%)
"Darrick J. Wong" <darrick.wong@oracle.com> (commit_signer:1/4=25%)
"Chang S. Bae" <chang.seok.bae@intel.com> (authored:1/4=25%,added_lines:2/15=13%,removed_lines:4/25=16%)
Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com> (authored:1/4=25%,added_lines:1/12=8%,removed_lines:1/12=8%)
Joe Perches <joe@perches.com> (authored:1/4=25%,added_lines:1/12=8%,removed_lines:1/12=8%)
Jacob Huisman <jacobhuisman@kernelthusiast.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:1/10=10%,removed_lines:1/9=11%,removed_lines:1/2=50%,commit_signer:1/1=100%,authored:1/1=100%,added_lines:1/1=100%,removed_lines:1/1=100%,commit_signer:1/4=25%,authored:1/4=25%)
Konstantin Ryabitsev <konstantin@linuxfoundation.org> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:17/17=100%,removed_lines:14/14=100%,commit_signer:1/2=50%,authored:1/2=50%,added_lines:52/53=98%,removed_lines:1/2=50%)
Tejun Heo <tj@kernel.org> (commit_signer:2/3=67%)
"Martin K. Petersen" <martin.petersen@oracle.com> (commit_signer:1/1=100%)
Khalid Aziz <khalid@gonehiking.org> (commit_signer:1/1=100%)
SeongJae Park <sjpark@amazon.de> (commit_signer:3/4=75%,authored:3/4=75%,added_lines:30/31=97%,removed_lines:32/33=97%)
Oded Gabbay <oded.gabbay@gmail.com> (authored:1/7=14%)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)
clang-built-linux@googlegroups.com (open list:CLANG/LLVM BUILD SUPPORT)
