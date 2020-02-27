Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E1FC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DC92467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R17iC+ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgB0ISK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:18:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42610 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0ISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:18:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id u3so822485plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XIli+BijBA/J5DkqhUYlYKRGLbW/H23q9FTVuH80Vus=;
        b=R17iC+caUcopb4JLd3Ac4ljtNkDrLWPnu+xj4NNF0iVROFyj5Ci4RFFyIZA3CI2ent
         LdXEbsp23CRgG9PCRjBzKeAksOcf5YGhMPtGhCPRKkvcByS5ucvGmVUtS1Sa9uNb6uUj
         0mXojotf/f4tQkUkYQPXPhbWJtWCrLkl2u9DYZHMmJwwEiQnrvO9o3Slx428L+KAfQXw
         RBXqzceYia14Kg7oxcpoxbfNShV8AG6LMy+vswKJ3QJEcBdJlx+7EveAywzaFe97T6+Z
         JTrMbLTcOiUJe7vU3U0X7zm/+g/+zEKE571BVN1hxXybXn3nLyWSNZxdFTNJNrRy42AX
         KgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XIli+BijBA/J5DkqhUYlYKRGLbW/H23q9FTVuH80Vus=;
        b=t93hzdRE1vdRdbHWhNvLUSWQPeR+quvF68/4sBG7oELk5Xf+jhGNmAfyXTld6jI+F3
         pdHdj6aB6a1pU1Jo+S2B1WIZFsIFYKGK4bUwfGDDpmICOj8n9tnQ84lbAyMgcLLfGkqL
         T451YYps1B1evut89YG04GtMPxGE9zLOhF6eOGPFDQPg01jjQSUmd23iMQYBx+P8qySW
         +pFqI4byCCVedDXw/+uy5ep/2eCViSMz/iR1cNgUOdm9FqoK6i5hkJk10kVg7/ZypepF
         WfxVuVAr7Ua+6ASjywZucS5NlG5723By0W9num5rWsxUfO9DTq7E8aG4M/i8tU4CIpHv
         hdjA==
X-Gm-Message-State: APjAAAWrH8HZ5XWEpPbykrpMZDOgfaNzGW/2PWtWvmlmcIJ2AfYK8EHK
        xP3ZDatnf0HmwE/GbD6pGB9N7IWY
X-Google-Smtp-Source: APXvYqymLmsSYQqjVPxQTDDjL8cx4m65wBUByVxVHjjchClXsz7CHLnshuIN6jQ37s9SFgh6pD9cNw==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr3812101pjr.142.1582791488574;
        Thu, 27 Feb 2020 00:18:08 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id t189sm5835686pfd.168.2020.02.27.00.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 00:18:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:48:05 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200227081805.GA5746@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
 <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg & Finn,

On Wed, Feb 26, 2020 at 10:42:00AM +1000, Greg Ungerer wrote:

> > -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> > +	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
> > +		pr_err("%s: request_irq() failed\n", "timer");
> 
> Why not just:
> 
>                 pr_err("timer: request_irq() failed\n");

The reason to use %s was that it could be automated by cocci script &
the o/p didn't look bad. Second arg to pr_err is what cocci
presents me & there is wide variation in the name across the tree as
Finn noted.

Excerpts from v1 cover letter [1], 

- setup_irq(E1,&act);
+ if (request_irq(E1,f_handler,f_flags,f_name,f_dev_id))
+ 	pr_err("request_irq() on %s failed\n", f_name);

[ don't get mislead by string contents used, this was for v1, just to
 show how the result was obtained. To take care of Finn's suggesstion,
 instead of modifying cocci & then making changes other changes over
 that (i could not fully automate w/ cocci, and Julia said my script
 is fine as is), it was easier to run sed over the v1  patches ]

> And maybe would it be useful to print out the error return code from a
> failed request_irq()?

Since most of the existing setup_irq() didn't even check & handle
error return, my first thought was just s/setup_irq/request_irq, it
was easier from scripting pointing of view. i felt uncomfortable doing
nothing in case of error. Also noted that request_irq() definition has
a "__much_check", so decided to add it.

And there is a wide variation in the way return value is handled by
the caller, some already have a local variable, some don't. Moreover
in many cases caller cannot return any value, i.e. void, so what
to be done with return value was another issue, in some cases in
addition to printing error value, the error value can't be returned,
while some others it can.

> What about displaying the requested IRQ number as well?
> Just a thought.

i initially did the cocci to display IRQ number as the 3rd arg to
pr_err, but then it was observed that most of the those lines were
exceeding 80 chars, though cocci could align args properly in next
line, it could not put flower braces to the preceeding
'if request_irq()' & in next line (though it is a single C statement
inside 'if', per kernel coding style, flower brace had to be put for a
single statement that spans multiple lines ], else it had to be
manually added treewide.

On Wed, Feb 26, 2020 at 12:11:55PM +1100, Finn Thain wrote:

> Moreover, compare this change,
> 
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> 
> with this change,
> 
> +	int err;
> 
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> +	if (err)
> +		return err;
> 
> Isn't the latter change the more common pattern? It prints nothing.
> 
> And arguably, the former example is actually the change that's described 
> in the commit description.
> 
> This patch seems to be making two orthogonal changes but I'll leave that 
> question to the maintainer. (I'm not really trying to NAK this patch.)

Instead of not checking the error value as in the existing cases &
mechanically replace w/ request_irq(), thought of at least giving user
the indication by way of pr_err (but i think most of the use is for
tick timer, if it fails, in most cases, system would not even boot)
due to the reasons mentioned above.

On Wed, Feb 26, 2020 at 12:11:38PM +1000, Greg Ungerer wrote:

> Hmm, in my experience the much more common pattern is:
> 
> > +	int err;
> > 
> > -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> > +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> > +	if (err) {
> > +             pr_err("timer: request_irq() failed with err=%d\n", err);
> > +		return err;
> > +     }

This is my preferred style, but note that returning error is not
possible in many of these cases as callers are void return type.

On Wed, Feb 26, 2020 at 05:39:57PM +1100, Finn Thain wrote:

> Besides, introducing local variables and altering control flow seems well 
> out-of-scope for this kind of refactoring, right?

To make changes perfect, it would be required to get into context of
each case (>150), and do it manually as there is wide variation like
whether caller can return error code, whether already a local integer
is defined to catch the error, whether it returns error after a goto,
whether we should allow it to proceed if it fails and so on.

And handling manually all the cases tree wide would be more error
prone & time consuming. i was relieved that there was only one build
error reported by test robot (i had done build & boot test only on ARM
& x86_64), given the amount of manual changes i had to do on top of
cocci generated ones.

At the same time, i didn't want to just mechanically replace & wanted
to add some value to the existing setup, which resulted in this patch.

My thought process was to do treewide removal of setup_irq() and
possibly low hanging cleanup's at the places where setup_irq() lives
to make sure that surrounding situation will be better than or at
least equal to the current.

But if the consensus is that all these situations have to be taken
care, let me know.

On Wed, Feb 26, 2020 at 10:26:55PM +1000, Greg Ungerer wrote:

> A quick grep shows
> that "%s: request_irq() failed\n" has no other exact matches in the current
> kernel source.

git grep -n '%s: request_irq' gives a few somewhat similar ones, i
remember it because searching this string after my changes to verify
gave more than that i added :)

Regards
afzal

[1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com
