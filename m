Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A81FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5908F20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxrNaQhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbgFXHqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389961AbgFXHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:46:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7253C061755
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:46:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t194so1527383wmt.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=epcuiGqVlmnY4nv0TpcFlJgIf53mrnQAjcQ2iWd8n20=;
        b=lxrNaQhURYbDOacetuAOB4rqihVjeFhPrFku/MctijJgTEB6swEolAYoXWCGDNjxfe
         Wqs5E39Z4cE5O8xnsPvjSQnheb8F7BeqLBrQXIDuYGW4zsGKcuaDlr79IHoHHGXa+lbr
         /s+ASmZCc2IP0khedmhvjUqUCjQrxrzXPqV4zNwdvVqM8NLJtk/d9wM3+8BaPdzCZTQi
         6XscRwZ6rn9V4IGRq1poGAG1quK8yg9jVg204Ty4mC08Aswn2wjZZ0+4xJ4jo19C+9mA
         pAJ1NH/0KfUJ3tGf39JUt91YqNjjMP0dKcNOa9evgsbCCbiT1NuvKltfInrj9egcbCG6
         H5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=epcuiGqVlmnY4nv0TpcFlJgIf53mrnQAjcQ2iWd8n20=;
        b=lsoTrMJ+01TjqRYG7eh9o2+2wRJBbmkCrdDR/fbOPm42eY9xxcTsTjRdDcUgikpWSB
         xTmGRuscgdKYczNc48d/avaGkjB7wWw+p58Vo+629Kkin3uxYyxBaehtdPMNcrQylVsP
         4jFJn0OZN2U5d412aw3u9gcSGG6m1aBcPd+BA3D2+ObwOGGh9QB+NeJmSEJzInoEckzK
         k1o5n56wswaGbe2Xx4tF+C/Ika2MllDURpBp8MM+yJdxs/5e2FzgKEbaCsSZvZQip5ou
         +x4tVPMBvr9XKj9vY/2EB/hBo5VtlsVshaSKNc9ua3mPYdGXQidmfBxRBJH8Q9vzj4iD
         Sc5g==
X-Gm-Message-State: AOAM531N2gHHl847bKsKf9OjW50iEBxWxhfItTXryPzBpSz6UB8hgo1l
        G4jD63AUabFVEWspxkQgtppwJg==
X-Google-Smtp-Source: ABdhPJwABrQgNhzh+ctnmNgoeNQCk2WyukwHXPTFPW0rrC3LNFzgwwXryqZIsCHShyMS5hYSJyHmHw==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr29006254wma.33.1592984794170;
        Wed, 24 Jun 2020 00:46:34 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x14sm25926377wrt.60.2020.06.24.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:46:33 -0700 (PDT)
Date:   Wed, 24 Jun 2020 08:46:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200624074631.GE954398@dell>
References: <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
 <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
 <20200623064723.GZ954398@dell>
 <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
 <20200623195905.GB954398@dell>
 <6684101d-1013-2964-c247-394f9b12a194@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6684101d-1013-2964-c247-394f9b12a194@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020, Frank Rowand wrote:

> On 2020-06-23 14:59, Lee Jones wrote:
> > Suggestion #2
> > 
> >>>>>> 2) Modify patch 1/3.  The small part of the patch to modify is:
> >>>>>>
> >>>>>> +static int mfd_match_of_node_to_dev(struct platform_device *pdev,
> >>>>>> +				    struct device_node *np,
> >>>>>> +				    const struct mfd_cell *cell)
> >>>>>> +{
> >>>>>> +	struct mfd_of_node_entry *of_entry;
> >>>>>> +	const __be32 *reg;
> >>>>>> +	u64 of_node_addr;
> >>>>>> +
> >>>>>> +	/* Skip devices 'disabled' by Device Tree */
> >>>>>> +	if (!of_device_is_available(np))
> >>>>>> +		return -ENODEV;
> >>>>>> +
> >>>>>> +	/* Skip if OF node has previously been allocated to a device */
> >>>>>> +	list_for_each_entry(of_entry, &mfd_of_node_list, list)
> >>>>>>
> >>>>>> Change:
> >>>>>>
> >>>>>> +		if (of_entry->np == np)
> >>>>>> +			return -EAGAIN;
> >>>>>>
> >>>>>> To:
> >>>>>>
> >>>>>> +		if (of_entry->np == np) {
> >>>>>> +			if (!cell->use_of_reg)
> >>>>>> +				return -EINVAL;
> >>>>>> +			else
> >>>>>> +				return -EAGAIN;
> >>>>>>
> >>>>>> There may be a better choice than EINVAL, but I am just showing the method.
> >>>>>>
> >>>>>> You may also want to refactor this section of the patch slightly
> >>>>>> differently to achieve the same result.  It was just easiest to
> >>>>>> show the suggested change the way I did it.
> >>>>>>
> >>>>>> The test that returns EINVAL detects the issue that the FDT does
> >>>>>> not match the binding (there is more one child node with the
> >>>>>> "stericsson,ab8500-pwm" compatible.
> > 
> > My reply to suggestion #2
> > 
> >>>>> So here, instead of just failing a single device, we fail everything?
> >>>>> Sounds a lot like throwing the baby out with the bath water.  How is
> >>>>> that an improvement?
> 
> I could have sworn that I had replied with a solution to this issue.  So I
> searched and searched and searched my emails in the thread.  And checked my
> drafts email folder.  Then finally realized I had made a stupid mistake.
> 
> I did reply about this, but I had put my "-Frank" signature at the end
> of a comment much higher in the email.  So of course I expect you stopped
> reading at that point and never saw my answer.  My apologies!!!
> 
> The email in question is:
> 
>   https://lore.kernel.org/linux-devicetree/eae9cc00-e67a-cb6a-37c2-f2235782ed77@gmail.com/
> 
> and what I wrote at this point in that email is:
> 
>   You can modify more extensively than my simple example, changing
>   mfd_add_device() to more gracefully handle an EINVAL returned by
>   mfd_match_of_node_to_dev().
> 
> Thus a modification to my suggestion #2 to make it _not_ fail
> everything.
> 
> I didn't really flesh out all that "more gracefully handle" means.
> Among other things, it could include a pr_warn() that provides
> a fairly specific possible cause of the problem (eg the corner
> case mentioned near the end of the patch 1/3 header that shows
> mixing OF_MFD_CELL() and OF_MFD_CELL_REG() for the same compatible
> value.  It may be tricky coming up with good phrasing in a pr_warn()
> that describes the generic issue instead of the specific example.

The current solution already provides a warning if we fail to match a
device with its requested OF node.  It's also semantically incorrect
to error out just because a node with the same compatible string is
already taken, since there maybe another one coming up (which will be
found on the next iteration post return of -EAGAIN).

Providing a more accurate warning describing *why* a node wasn't found
it also non-trivial, for the same reasons as it's hard to do during a
pre-validation routine.

> >>> [0]
> >>
> >> Is "[0]" the patch series, especially patch 1/3?
> > 
> > No, this is my reply to your suggestion #2.
> > 
> > The [0] is referenced further down.
> > 
> > [...]
> > 
> >>>>>  * False positives can occur and will fail as a result
> >>>>
> >>>> ((What is an example of a false positive?))  Never mind, now that
> >>>> I see that the previous issue is a fatal flaw, this becomes
> >>>> academic.
> >>>
> >>> That's okay, I don't mind discussing.
> >>>
> >>> Ironically, the 'ab8500-pwm' is a good example of a false positive,
> >>> since it's fine for the DT nodes to be identical.  So long as there
> >>> are nodes present for each instance, it doesn't matter which one is
> >>> allocated to which device .Forcing a 'reg' property onto them for no> good reason it not a valid solution here.
> >>
> 
> Start of my comment that I wrote with "too many shortcuts" (see below):
> 
> >> I thought that one of the points of this patch series was to add a
> >> "reg" property to any mfd child that was described by the
> >> OF_MFD_CELL_REG() macro.
> > 
> > The OF_MFD_CELL_REG() macro didn't exist until this patch-set.
> 
>   
> Maybe the way I wrote that took too many shortcuts.  Let me re-phrase.
> 
> I thought that one of the points of this patch set was to add the
> of_reg and use_of_reg fields to struct mfd_cell.  The expected use
> of the of_reg and use_of_reg fields was to allow the presence of a
> "reg" property in a devicetree mfd child node to be used to match
> specific child nodes to specific elements of the mfd_add_devices()
> cell array parameter, with the match occurring when the array elements
> are processed (currently in mfd_match_of_node_to_dev(), which is
> called by mfd_add_device()).
> 
> The key point being the matching specific devicetree mfd child nodes
> to specific cell array members.
> 
> The OF_MFD_CELL_REG() is simply a helper macro related to the above.

Correct so far.

> > There are currently no users.
> 
> Yes.  And as I pointed out elsewhere, I would expect a user of new
> functionality to be added as part of a patch series that adds the
> new functionality.  Or at least a mention of a specific plan to
> use the functionality.

There have been 2 such use-cases in recent months.

The most recent is Michael's (CC'ed) use-case.

Moreover, this patch-set actually fixes something that has been known
to be broken (actually not broken per-say, just 'less featureful') for
a number of years.  Since the original support was authored, only 2
potential issues have arisen.  The first time we deemed it a problem
too complex to fix (I can't, for the life of me find that thread, but
I'm pretty sure it involved Robin from Arm [which is why he is
CC'ed]).  Michael's use-case is the second.  This time I thought I'd
have a stab at fixing (or at least bettering) it.

> I had been assuming that the intended user was the one use case that
> I had identified, and that you let me continue to assume was the one
> existing use case.

Sorry if you feel misled, but that is not the case.

> >> And that was meant to fix the problem where multiple indistinguishable
> >> children existed.  The only instance I found of that (using the
> >> weak search on OF_MFD_CELL()) was of compatible "stericsson,ab8500-pwm"
> >> in drivers/mfd/ab8500-core.c.  You agreed with my email that
> >> reported that.
> > 
> > No, I agreed with you that there is a current problem with
> > "stericsson,ab8500-pwm", as identified by Michael.  I didn't actually
> > know about this issue until *after* drafting this patch-set.  To be
> > clear the "stericsson,ab8500-pwm" scenario is not the reason for this
> > set's existence.
> 
> So now I know that drivers/mfd/ab8500-core.c is totally unrelated to
> this patch series, and not the intended user of the new functionality.
> 
> > 
> > Also, please forget about the OF_MFD_* macros, they are totally
> > agnostic to this effort.  The only relevance they have here is the
> > addition of 1 extra macro which *could* be used to provide the 'reg'
> > property where appropriate.
> 
> My point was that my search for the data that comprised the "cell"
> parameter passed to mfd_add_devices() was inadequate, because I
> was searching on OF_MFD_CELL() instead of mfd_add_devices.  I was
> admitting that part of my ignorance was because of this poor search.
> 
> I was searching for where the problem case actually occurred in the
> kernel.  Maybe you did not realize that I have been thinking that
> the only place where the problem case occurred was the single case
> I found with this insufficient search method.
> 
> In some or many or all (I don't know, I'm not going to go back
> and search for all of them) you can probably replace mention
> of the OF_MFD_* with either my search for input data to
> mfd_add_devices() _or_ a concise reference to the new of_reg
> and use_of_reg fields of struct mfd_cell and the use of the
> new fields.
> 
> Where is the problem that the patch set was intended to fix?

Firstly, the problem is present, as described in the commit message.
It is *not correct to re-match an OF node with multiple devices.  Even
if there wasn't a current *real* user, this patch is still the right
thing to do, as it makes the situation *sooo* much better.

However, there is a prospective user also [1].

[1] https://lore.kernel.org/linux-arm-kernel/20200423174543.17161-1-michael@walle.cc/

> >> So I thought that drivers/mfd/ab8500-core.c would be modified to
> >> replace the multiple instances of compatible "stericsson,ab8500-pwm"
> >> in OF_MFD_CELL() with OF_MFD_CELL_REG().
> > 
> > That is not my vision.  There is no need for "stericsson,ab8500-pwm"
> > to have 'reg' properties as far as I see it.
> 
> In that case the binding document for the mfd child node with
> compatible "stericsson,ab8500-pwm" should be updated to state
> that if there are multiple such child nodes with the same parent
> then they must contain exactly the same set of properties and
> values.
> 
> Maybe not your problem, I have no idea who is responsible for
> that update.

This is the case for all OF nodes, not just 'ab8500-pwm'.

Fell free to submit a patch.

> However, 
> 
> >> This is another problem with the patch series: there is no user
> >> of OF_MFD_CELL_REG().  Please add one to the series.
> > 
> > That's not a problem with this patch-set, it's a problem with your
> > understanding of this patch-set. :)
> 
> I have already responded above about whether there should be a user
> of OF_MFD_CELL_REG() in the patch set.

No need, as it's indented for *future* users.

That said, once applied, I will have a look around for some more
potential current issues/users.  My plan it so also start converting
users to other OF_MFD_* macros.

> > As far as I know, there aren't any current users who would benefit
> > from this work.
> 
> Sigh.  From the original patch 1/3 header:
> 
>   "Currently, when a child platform device (sometimes referred to as a
>   sub-device) is registered via the Multi-Functional Device (MFD) API,
>   the framework attempts to match the newly registered platform device
>   with its associated Device Tree (OF) node.  Until now, the device has
>   been allocated the first node found with an identical OF compatible
>   string.  Unfortunately, if there are, say for example '3' devices
>   which are to be handled by the same driver and therefore have the same
>   compatible string, each of them will be allocated a pointer to the
>   *first* node."
> 
> This implies that there is a current instance where multiple devices
> are "allocated a pointer to the *first* node".
> 
> If the patch header had instead said something like:
> 
>   adding the ability for an mfd device to have multiple children
>   with the same value of "compatible" property
> 
> then my whole approach to trying to analyze and understand the
> patch series would have been entirely different.  One of my
> early replies described my attempt to find the code that was
> encountering the problem that the patch series claimed to fix.
> One of my concerns was handling potential compatibility issues
> with existing FDTs.
> 
> And my understanding of your response to my analysis and investigation
> was that I had indeed found a problem case in existing code.  But now
> you tell me that the driver and mfd child node compatible value that
> I identified are not at all a problem.

Again, I'm sorry that you took that path, but my replies have only
conveyed the facts as I see them.  The snippet that you quote above
was and is still an accurate and precise description of the issue with
the current matching code.

Maybe now that you have identified your issue, we can move on.

> > Instead, it is designed to provide future submitters
> > with another tool to help them link their child devices to the correct
> > OF nodes.
> 
> And that is what I was looking for above in this reply, looking for
> a user of the new functionality in the patch series, where I stated:
> 
>    "Or at least a mention of a specific plan to
>    use the functionality."

One more time; this patch-set addresses an present in-kernel issue.

The current code does it's best to match device with OF node, but
there are corner-cases where the matching semantics are not
sufficient.  Even if there weren't any prospective users (but there
are), improving the current matching logic is something that *must* be
seen as a positive step in the right direction.

If this code was already present when 'ab8500-pwm' was OF enabled, it
would have identified the potential issue which you (and Michael)
correctly identified with missing OF nodes.

> > That's not to say that current users can't and won't
> > benefit from this.  Just that they are not the target audience.
> > 
> >>>>> The above actually makes the solution worse, not better.
> >>>>>
> >>>>
> >>>> Patch 1/3 silently fails to deal with a broken devicetree.
> >>>> It results on one of the three ab8500-pwm child nodes in
> >>>> the hypothetical devicetree source tree not being added.
> >>>>
> >>>> That is not a good result either.
> >>>
> >>> No it doesn't.  In the case of 'ab8500-pwm' the OF node is not set for
> >>> 2 of the devices and warnings are presented in the kernel log.
> >>
> >> OK, I was wrong about "silent".  There is a warning:
> >>    pr_warn("%s: Failed to locate of_node [id: %d]\n",
> >>
> >>> The
> >>> device will continue to probe and function as usual.
> >>
> >> If the device probes and functions as usual without the child of_node,
> >> then why does the node have any properties (for the cases of
> >> arch/arm/boot/dts/ste-ab8500.dtsi and arch/arm/boot/dts/ste-ab8505.dtsi
> >> the properties "clocks" and "clock-names").
> > 
> > Because DT is meant to describe the hardware, not the implementation.
> > 
> > DT does not know, or care that in our case most operations that happen
> > on the platform are passed back via an API to a central controlling
> > location.  Or that in reality, the OF node in this situation is
> > superfluous.
> > 
> > Can we please stop talking about the AB8500.  It doesn't have anything
> > to do with this series besides the fact that if it (this set) had
> > existed *before* 'ab8500-pwm' was OF enabled, it wouldn't now be
> > wonky.
> 
> OK.  I now understand that you don't expect the new functionality of
> the of_reg and use_of_reg fields of struct mfd_cell to be used by
> in relation to "ab8500-pwm" and drivers/mfd/ab8500-core.c.  I will
> drop them from the discussion.

\o/

> >> Digging through that leads to yet another related question, or actually
> >> sort of the same question.  Why do the child nodes with compatible
> >> "stericsson,ab8500-pwm" have the properties "clocks" and "clock-names"
> >> since the binding Documentation/devicetree/bindings/mfd/ab8500.txt
> >> does not list them?
> > 
> > If you want to talk about the AB8500, please start a new thread.
> > 
> >>>> OK, so my solution #3 is a no go.  How about my solution #2,
> >>>> which you did not comment on?
> >>>
> >>> I did [0].  You must have missed it. :)
> >>
> 
> >> But yes or no to my solution #2 (with some slight changes to
> >> make it better (more gracious handling of the detected error) as
> >> discussed elsewhere in the email thread)?
> > 
> > Please see "[0]" above!
> > 
> > AFAICT your solution #2 involves bombing out *all* devices if there is
> > a duplicate compatible with no 'reg' property value.  This is a)
> > over-kill and b) not an error, as I mentioned:
> 
> As I mentioned above, I set you up to have this misunderstanding by
> a mistake in one of my earlier emails.  So now that I have pointed
> out what I meant here by "more gracious handling of the detected
> error", what do you think of my amended solution #2?

Explained above, but the LT;DR is that it's not correct.

> >>> It also suffers with false positives.
> > 
> 
> Sorry for the very long response, but it seemed we were operating
> under some different understandings and I hope I have clarified some
> things.

Likewise. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
