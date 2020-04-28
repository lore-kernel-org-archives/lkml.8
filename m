Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A4DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD86206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puXUkMQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgD1OIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgD1OIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:08:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DFC03C1A9;
        Tue, 28 Apr 2020 07:08:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so8411490pll.8;
        Tue, 28 Apr 2020 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=94emFmHhVMLIqH1FnfHLBqh0QPdARlrRgQOBWYDXeAE=;
        b=puXUkMQbAty4Yv7dMOIf2jzoS877pDwF6IeR1EERCAHCNdy9VaWtBvmmRmL1Mu6+7U
         PP7cz5IHH3mL7BOJ6ubcFLmDN8ZOuVvGcCu1Go82Aow6rSJhay3T1BqrW7kq6Eb2ZtY4
         pq/uzqHg5R/WWSPPdzATgdD3VoWd9OTN5Dyqbxa15Qs3DqTlKvoFrha5/JW4a3bILRSA
         +l1vKHWvom7tTLiT9jjl3+uNW8M5WOosRSDs23W23OZHVjwR9QAKvizaMtk6leuKUDQa
         OAfvlfMLZIRlVyilvcjEUZyn2zhY4PKDCRNkA2yC/XYuutRsYiolZy9GKKiWq8eMpQul
         TPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=94emFmHhVMLIqH1FnfHLBqh0QPdARlrRgQOBWYDXeAE=;
        b=o5a0k2zzfAqfbyVvfRXMj146uSMuFTwQCBBpZP6XKlSd8Qx/m9MfUbv1ifUWeAmkYn
         c/nt3dEJja5mOtF2iyKepyi9SXseBi8W+O//YgyZ0lUiW+yzNmAjCcnNr0GQWDvZiLBC
         XS4/hoPSdCyQ0FJV10JTQWI6MnDloy8xy0hdPJ+jqyW84nBfPXhxNboreaY10A8PsIPn
         IXEOLv/PJ6xKDEelDmjOrpEPbAlb+xtmI79S/DPJWe/KbI2Er/SkBgYzGvyJOmyWfYNr
         40yQbqMHJU3K1a1F/9JLeAdoc6S7XhH9Exm5jSxOS+tq3gS+dLlTD2y8n5HNwHbIiePm
         YWFQ==
X-Gm-Message-State: AGi0PuaVLcNnybrBHwpUfW5IED4VOJAn9I1yYjI95961JqlIMsp4QaeP
        OwwFG+jQLJfpyIz/JEfXkRU=
X-Google-Smtp-Source: APiQypJgrauW/p2udBB1X6xYkg9rZreD+vk4+9m5imQck8Tum/C6ra7aq+Cb5WCgnqNP5m15S+Ytyw==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr5258141pjv.171.1588082884438;
        Tue, 28 Apr 2020 07:08:04 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id m24sm13057604pgn.91.2020.04.28.07.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:08:03 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 03SE6tUb030545;
        Tue, 28 Apr 2020 22:06:55 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 03SE6nQT030543;
        Tue, 28 Apr 2020 22:06:49 +0800
Date:   Tue, 28 Apr 2020 22:06:49 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
Message-ID: <20200428140649.GA30042@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
References: <20200428020223.GA28074@udknight>
 <35069ae9-cdb4-4728-5e94-6d863dd2721c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35069ae9-cdb4-4728-5e94-6d863dd2721c@web.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 08:21:37AM +0200, Markus Elfring wrote:
> > ...
> > Do not split the tag across multiple
> > lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> > parsing scripts
> > ...
> 
> I suggest to reformat the quotation.
> 
> “…
> Do not split the tag across multiple lines, tags are exempt from
> the "wrap at 75 columns" rule in order to simplify parsing scripts.
> …”
> 
> 
> > And there is no 'Fixes:' tag format checker in checkpatch to check
> > the commit id length too, so let's add dedicated checker to check
> > these conditions for 'Fixes:' tag.
> 
> It seems that there are further challenges to consider for an imperative wording
> in such a change description.
> 
> How do you think about the following wording variant?
> 
>    The script “checkpatch.pl” did not provide a check for the commit
>    identification length. Thus add a dedicated check.
> 
> 
> >  v2-v3
> 
> I would find a shorter version identification (without the arrow)
> also sufficient.
> 
> 
> >  1:No modification to GIT_COMMIT_ID checker.
> 
> Would you like to add a space character for the item enumeration?
> 
> 
> >    I make a mistake previously, …
> 
> Would you like to use the word “made” here?
> 
> 
> > +		    my $id = '0123456789ab';
> > +		    my $orig_desc = "commit description";
> 
> How much do these variable initialisations matter?
>

Well! Thanks and you are right,  I will fix them in next version.

> 
> > +			$lines = 0 if ($1 =~ /^\(\"(?:.*)\"\)$/i);
> 
> I wonder why you see a need to use a non-capturing group in such
> a regular expression (when no alternatives were specified there).

I guess it is a better perl programming practice that use non-capturing group always when
you don't need to use the '$' to access it, it will make code a little faster I guess.

> 
> 
> > +				ERROR("FIXES_TAG",
> > +					"Please use 'Fixes:' tag with commit description style '<12+ chars of sha1> (\"<title line>\")', and the title line doesn't across multiple lines - ie: '$fixes_tag_fmt'\n" . $herecurr);
> 
> * Would we like to support any other quotation characters around
>   the commit summary?
>

I think we don't need now and people could patch it easily when
we need others in future:)

> * I propose to split the error message.
>   May it become multi-line?

Yes

> 
> * How do you think about another wording variant?
> 
>   The title must be specified as a single line (without line breaks).
>

Ok

> * Would you like to point questionable commit titles out?
> 
> Regards,
> Markus

No, I think your previous wording variant is clear enough.

Thanks again! 
