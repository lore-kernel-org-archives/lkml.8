Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DF7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA652073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgFVR32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:29:28 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:60360 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729605AbgFVR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:29:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4DE6318026A02;
        Mon, 22 Jun 2020 17:29:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need47_4e04c3f26e34
X-Filterd-Recvd-Size: 3750
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jun 2020 17:29:22 +0000 (UTC)
Message-ID: <adf85348dcbfbf64157e6519115b3a0c9f35df55.camel@perches.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/process
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 22 Jun 2020 10:29:20 -0700
In-Reply-To: <CANiq72m6BNYe2ETNXJ2oLc6Jzad6kBBJK7_dz+BwZCeqYFXZqg@mail.gmail.com>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
         <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
         <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
         <CANiq72=Y+beqZ8Dmieo_GKbyaLN8Nf1n3bVntj_o90Cn-nADRQ@mail.gmail.com>
         <20200622070623.086f1623@lwn.net>
         <CANiq72m6BNYe2ETNXJ2oLc6Jzad6kBBJK7_dz+BwZCeqYFXZqg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-22 at 19:03 +0200, Miguel Ojeda wrote:
> On Mon, Jun 22, 2020 at 3:06 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > As has been noted elsewhere, checkpatch.pl seems like the appropriate
> > place to make this check.  As for "the entire tree"...if this job gets
> > completed, "git grep" should be a fine way to do that.
> 
> `checkpatch` is not really enforced in many subsystems, no? Further,
> some existing and future HTTP links may support HTTPS later on.
> 
> As for `git grep`, agreed if we reach near 100%. Otherwise, no. In the
> general case, including the code for a task that has some likelihood
> of needing repetition is a safe bet, which is why I suggested it. The
> same script could be also used to check for broken links and related
> maintenance.

scripts/get_maintainer.pl --self-test=links has a reachability test
using wget.

Perhaps a script like that could be used for http:// vs https://

	## Link reachability
	} elsif (($type eq "W" || $type eq "Q" || $type eq "B") &&
		 $value =~ /^https?:/ &&
		 ($self_test eq "" || $self_test =~ /\blinks\b/)) {
	    next if (grep(m@^\Q$value\E$@, @good_links));
	    my $isbad = 0;
	    if (grep(m@^\Q$value\E$@, @bad_links)) {
	        $isbad = 1;
	    } else {
		my $output = `wget --spider -q --no-check-certificate --timeout 10 --tries 1 $value`;
		if ($? == 0) {
		    push(@good_links, $value);
		} else {
		    push(@bad_links, $value);
		    $isbad = 1;
		}
	    }
	    if ($isbad) {
	        print("$x->{file}:$x->{linenr}: warning: possible bad link\t$x->{line}\n");
	    }


