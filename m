Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD48C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09416206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587420783;
	bh=u8p0jHaF21T4UpqWTkdDV4RwTi3BMeCpFwuNvwfsqJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YNgrwdBMt/yIPX2z8EyIM4Hv8RAZfMfk/+yUImIRvO+Y5S0p4I6bNVkNsVRSFjSVp
	 1915Ucr2IXAGJflhrW/NmhE00Qc6fHUmHKG6uXLM84ktH+CbvU+X0qvkhx2f/LnYtC
	 cqHq1osc+i9sNmxjLPQCP3f6+Ttah5I3T/G7GDh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgDTWNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgDTWM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:12:59 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4053E206E9;
        Mon, 20 Apr 2020 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587420779;
        bh=u8p0jHaF21T4UpqWTkdDV4RwTi3BMeCpFwuNvwfsqJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=glBJYPYaB1Kjc2rK8ALzFmYe5Y8oxFn04YU/W79os1OPzcQ9wLbQjhyZIDiybTDdj
         yv7BaL0HUSVRelCLSKXaNZB3UIUreLhknpimvro5ePfnGawX0uZPMpoBpaXYxawf0Y
         4ENEUpZXJmR3jX6AU4FIcV9beDga5F+fE8Gz6Mhg=
Date:   Tue, 21 Apr 2020 00:12:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/33] docs: update recommended Sphinx version to
 2.4.4
Message-ID: <20200421001255.7c7e5065@coco.lan>
In-Reply-To: <20200420152729.40cb10e1@lwn.net>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
        <498f701c618f7d0cf5f0a37e5889ee926f7c8bf4.1586881715.git.mchehab+huawei@kernel.org>
        <20200420152729.40cb10e1@lwn.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 20 Apr 2020 15:27:29 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 14 Apr 2020 18:48:30 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The Sphinx check script is already smart enough to keep
> > working, with older versions, warning the users that
> > an upgrade is recommended (and explaining how):
> > 
> > 	Sphinx version 1.7.9
> > 	Warning: It is recommended at least Sphinx version 2.4.4.
> > 	Detected OS: Fedora release 31 (Thirty One).
> > 
> > 	To upgrade Sphinx, use:
> > 
> > 		/usr/bin/virtualenv sphinx_2.4.4
> > 		. sphinx_2.4.4/bin/activate
> > 		pip install -r ./Documentation/sphinx/requirements.txt  
> 
> Sigh...that version is all of a month and some old.  I hate to be pushing
> people that hard on the upgrade treadmill.

Yeah, I see the point. 

Please notice that the above will only appear if someone calls "make htmldocs"
and no sphinx-build is found at the patch (or if the version is below the
lower bond - 1.4.x).

> I'm still looking over the set, and will probably apply this, but I think
> we should consider tweaking this before 5.8:
> 
>  - Can we make the warning more explicit that 2.4.4 is needed *if you are
>    generating PDF*?  Most people, I think, don't do that, and can live
>    happily with an older version.

Sure. I can work on a patch for such purpose. 

>  - Perhaps the time has come to raise the lower bound to, say, 1.7?  That
>    might let us get rid of a bit of cruft.

If we move the lower bound, it will start to refuse running "make htmldocs"
with versions below 1.7.

I'm ok on rising the lower limit. Yet, not sure if this is worth.
I mean, last time I checked, html builds fine with older versions.

Ok, if we rise the bar, we may be able to do some cleanups at the
extensions, removing some backward-compatible code. So, I would wait
for some future Sphinx version where the extensions would stop working,
requiring someone to touch them.

Thanks,
Mauro
