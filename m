Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADECC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531932054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598540133;
	bh=y90su4zGAKQF6PiuAyW0kkYzgnN+AT/BAiFKfzHsF+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZBJA8N99vvRBZTRj79vjrYJblZs3tW+6yBjOCj0CcKZmKiYqmo9j1tbBV9H+MBiQ7
	 H9ZhEIwXX39njPTgjeZCbHkOjStQgmIo3/AkShsAQrgp1AYWb+GvonMY1pW0CyH3xT
	 2dJTxTH2rAZoAhXwgFmVD/TZi03SOnpllkGU1FS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgH0Ozc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:55:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45372 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgH0NKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:10:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id i17so3322421edx.12;
        Thu, 27 Aug 2020 06:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MO4XT5vfILQQQs7m8NAXIZICzPk5ma+oMaf+AWE/M2Q=;
        b=SyeXlwn2OZEYHP1CAZ+WTjWFGFQULm6vkjC04zsP5MQPrFWohfCfQRAw03DPbhPLio
         fPUUhAhdMoi4bt8QnG1tzZcPLOx515x8aQJJyTVmgpitpQ5kIgHKR2ynP+/0rxkx20lg
         Pz+PDx+GdcnbdhOwyRhodvOtKaFXHBuiXufszhjRlJLWULBfveYmdRDeOcignZ0sZrJm
         M5/uzmXZzKX+ojEeaJWe9nGx/E9wFyv55BhXLya6N1baTBZMIe4UzYUqWVGxGvOr8lpj
         GglIQ1D0ibmZErnID9JWOrRXYlCHT6X+0hb+Jjue5N6s4r+NuCle7iI+kvF+5orjT0wV
         PM2g==
X-Gm-Message-State: AOAM531sNxQYjRHOu8s5KF7zNnqYk4uSNZON1vJXoPFjp/1aQu1pnV8j
        xjnjg2G9fqPEZNuE+LqBfd0=
X-Google-Smtp-Source: ABdhPJy3DhoRQwhFz7pG2UXliaNjzznIPsFx/Ttim2NepQAK9i66MyfFwvIK0wowQlP1k42Y0lL1pw==
X-Received: by 2002:a50:ef15:: with SMTP id m21mr20164933eds.300.1598533807483;
        Thu, 27 Aug 2020 06:10:07 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id a26sm1867497eju.83.2020.08.27.06.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 06:10:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:10:04 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] docs: admin-guide: Not every security bug should be
 kept hidden
Message-ID: <20200827131004.GA2736@kozik-lap>
References: <20200827105319.9734-1-krzk@kernel.org>
 <20200827105319.9734-2-krzk@kernel.org>
 <20200827121123.GC417381@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827121123.GC417381@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:11:23PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 27, 2020 at 12:53:19PM +0200, Krzysztof Kozlowski wrote:
> > Document describes the process of handling security bugs but does not
> > mention any criteria what is a "security bug".  Unlike
> > submitting-patches.rst which explicitly says - publicly exploitable bug.
> > 
> > Many NULL pointer exceptions, off-by-one errors or overflows tend
> > to look like security bug, so there might be a temptation to discuss
> > them behind security list which is not an open list.
> > 
> > Such discussion limits the amount of testing and independent reviewing.
> > Sacrificing open discussion is understandable in the case of real
> > security issues but not for regular bugs.  These should be discussed
> > publicly.
> > 
> > At the end, "security problems are just bugs".
> > 
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Follow up to:
> > https://lore.kernel.org/linux-usb/1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com/
> > ---
> >  Documentation/admin-guide/security-bugs.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> > index c32eb786201c..7ebddbd4bbcd 100644
> > --- a/Documentation/admin-guide/security-bugs.rst
> > +++ b/Documentation/admin-guide/security-bugs.rst
> > @@ -78,6 +78,12 @@ include linux-distros from the start. In this case, remember to prefix
> >  the email Subject line with "[vs]" as described in the linux-distros wiki:
> >  <http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
> >  
> > +Fixes for non-exploitable bugs which do not pose a real security risk, should
> > +be disclosed in a regular way of submitting patches to Linux kernel (see
> > +:ref:`Documentation/process/submitting-patches.rst <submitting-patches>`).
> > +Just because patch fixes some off-by-one or NULL pointer exception, does not
> > +classify it as a security bug which should be discussed in closed channels.
> 
> I said this on another thread, but almost always, when we get reports
> like this on security@k.o, we do push them back to public lists.

Then let's hope that next time someone will read this documentation
before submitting such report to @security.

> 
> For the most part, this paragraph is not going to help much (mostly for
> the reason that no one seems to read it, but that's a different
> topic...)

All of our documentation is our wish that someone will read it and
follow it. Just because people might not follow it, is not necessarily a
reason to skip documentation.

> We get crazy reports all the time, and that's fine, because
> sometimes, there is a real issue in some of them.  And for that, we do
> want to be careful.  We also have many docuemented "off-by-one" bugs
> that were real security issues (there's a blog post somewhere about how
> a developer turned such a bug into a root hole, can't find it right
> now...)

I understand. That's why I also mentioned the criteria of exploitable
and posing a security risk. First case (even stricter - publicly
exploitable) is already mentioned in submitting-patches so I am not
changing the current status.

I merely want to document it based on recent discussion.

> So while I understand the temptation here, based on the current
> security@k.o traffic, I doubt this will really change much :(
> 
> Also, you should have cc:ed that group when you are changing things that
> will affect them.

Indeed, I will update the maintainers as well.

Best regards,
Krzysztof

