Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E61C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A322087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDWFXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:23:11 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59348 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWFXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:23:11 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6E5D68046E;
        Thu, 23 Apr 2020 07:23:05 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:22:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: Rule for bridge yaml dt binding maintainers?
Message-ID: <20200423052258.GA9926@ravnborg.org>
References: <87d082jtfn.fsf@collabora.com>
 <20200420175909.GA5810@ravnborg.org>
 <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
 <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=pbkAPnaIUECbBO13-8AA:9
        a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe.

> > 
> > > I would also be great if you or someone else could:
> > > - teach get_maintainers about .yaml file listed maintainers
> > 
> > It already does to some extent. IIRC, there's a mode to extract email
> > addresses from files.
> 
> --file-emails
> 
> > I was hoping that the MAINTAINERS file split happens sometime and we
> > can just generate a MAINTAINERS file for bindings.
> 
> I don't see the value really.
> 
> > > - teach checkpatch that it is OK to convert .txt to .yaml
> 
> I suppose that get_maintainer _could_ enable --file-emails
> for .yaml files.
> 
> something like this (more comments below too)
> ---
>  scripts/get_maintainer.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 6cbcd1..9d947a0 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -527,7 +527,7 @@ foreach my $file (@ARGV) {
>  	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
>  	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
>  	push(@files, $file);
> -	if ($file ne "MAINTAINERS" && -f $file && ($keywords || $file_emails)) {
> +	if ($file ne "MAINTAINERS" && -f $file && ($keywords || $file_emails || $file =~ /\.yaml$/)) {
>  	    open(my $f, '<', $file)
>  		or die "$P: Can't open $file: $!\n";
>  	    my $text = do { local($/) ; <$f> };
> @@ -539,7 +539,7 @@ foreach my $file (@ARGV) {
>  		    }
>  		}
>  	    }
> -	    if ($file_emails) {
> +	    if ($file_emails || $file =~ /\.yaml$/) {
>  		my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
>  		push(@file_emails, clean_file_emails(@poss_addr));
>  	    }
>
That would be a good step forward. So people editing yaml file
will actually copy the maintainers and not just Rob as it is today.
There is a growing tendency to rely on tools only for the
list of people on cc, which is fine, but we should make those tools
then do a good job.

Thanks for looking into this.

Patch is:
Acked-by: Sam Ravnborg <sam@ravnborg.org>


> > I don't see checkpatch being able to check much of what comes up in
> > review. Maybe indentation.
> 
> Likely better done with another external tool.
> 
> Could be added to checkpatch as an external
> call like spdxcheck.py

If we grow anything more than:
"Indent shall always be an even number of spaces and no tabs" kind of
rules then yes, an external tool would be fine.

	Sam
