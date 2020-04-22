Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B67C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57D82076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDVXpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:45:24 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:42166 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDVXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:45:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4BDCF182CED2A;
        Wed, 22 Apr 2020 23:45:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slope31_118e74ec0bf03
X-Filterd-Recvd-Size: 5035
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Apr 2020 23:45:20 +0000 (UTC)
Message-ID: <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
Subject: Re: Rule for bridge yaml dt binding maintainers?
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Wed, 22 Apr 2020 16:43:03 -0700
In-Reply-To: <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
References: <87d082jtfn.fsf@collabora.com>
         <20200420175909.GA5810@ravnborg.org>
         <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-22 at 15:02 -0500, Rob Herring wrote:
> On Mon, Apr 20, 2020 at 12:59 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > Hi Adrian
> > 
> > On Mon, Apr 20, 2020 at 02:19:24PM +0300, Adrian Ratiu wrote:
> > > Hello,
> > > 
> > > I got confused while doing the txt -> yaml conversion at [1] and it's still
> > > not clear to me who should be added in the "maintainers" field.  Clearly not
> > > the maintainers as returned by get_maintainer.pl. :)
> > > 
> > > Rob mentioned that "owners" should be manintainers but I also have trouble
> > > picking the persons who should be owners / yaml maintainers.
> > > 
> > > Looking at the completed bridge conversions in the latest linux-next, I
> > > couldn't find a rule and the majority of bindings are still txt:
> > > 
> > > $ find ./devicetree/bindings/display/bridge/ -name *txt | wc -l
> > > 23
> > > $ find ./devicetree/bindings/display/bridge/ -name *yaml | wc -l
> > > 5
> > > 
> > > So my questions are:
> > > 1. Is there a general rule for assigning yaml file owners/maintainers?
> > > 
> > > 2. Is this vagueness specific to the bridge dt bindings only?
> > > 
> > > 3. Who should step up and maintain these bindings? Original/new authors,
> > > SoC, bridge, DRM maintainers etc.?
> > > 
> > > It would be useful to have a rule to make it easier to do these conversions.
> > > We (Collabora) are considering doing the conversion work.
> > 
> > For the panel conversion I did recently it was simple:
> > 1) If listed in MAINTAINERS - use this info
> > 2) Otherwise use the person(s) that authored the original .txt file.
> >    Using git log --follow foo.txt
> > 3) In a few cases I may have decided otherwise, but the above covers the
> >    majority.
> 
> Yes.
> 
> > I would also be great if you or someone else could:
> > - teach get_maintainers about .yaml file listed maintainers
> 
> It already does to some extent. IIRC, there's a mode to extract email
> addresses from files.

--file-emails

> I was hoping that the MAINTAINERS file split happens sometime and we
> can just generate a MAINTAINERS file for bindings.

I don't see the value really.

> > - teach checkpatch that it is OK to convert .txt to .yaml

I suppose that get_maintainer _could_ enable --file-emails
for .yaml files.

something like this (more comments below too)
---
 scripts/get_maintainer.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6cbcd1..9d947a0 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -527,7 +527,7 @@ foreach my $file (@ARGV) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
 	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
 	push(@files, $file);
-	if ($file ne "MAINTAINERS" && -f $file && ($keywords || $file_emails)) {
+	if ($file ne "MAINTAINERS" && -f $file && ($keywords || $file_emails || $file =~ /\.yaml$/)) {
 	    open(my $f, '<', $file)
 		or die "$P: Can't open $file: $!\n";
 	    my $text = do { local($/) ; <$f> };
@@ -539,7 +539,7 @@ foreach my $file (@ARGV) {
 		    }
 		}
 	    }
-	    if ($file_emails) {
+	    if ($file_emails || $file =~ /\.yaml$/) {
 		my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
 		push(@file_emails, clean_file_emails(@poss_addr));
 	    }

---

> Yeah, I should fix my bug.
> 
> > - teach checkpatch about some simple yaml validation (maybe)
> 
> I don't see checkpatch being able to check much of what comes up in
> review. Maybe indentation.

Likely better done with another external tool.

Could be added to checkpatch as an external
call like spdxcheck.py



