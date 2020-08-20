Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9832054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgHTQie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:38:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbgHTQiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:38:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C367E31B;
        Thu, 20 Aug 2020 09:38:09 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120893F6CF;
        Thu, 20 Aug 2020 09:38:08 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:38:44 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: add of_match_full_name boolean flag
Message-ID: <20200820163844.GA7292@e119603-lin.cambridge.arm.com>
References: <20200819140448.51373-1-cristian.marussi@arm.com>
 <20200819182245.GE5441@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819182245.GE5441@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark 

thanks for the review.

On Wed, Aug 19, 2020 at 07:22:45PM +0100, Mark Brown wrote:
> On Wed, Aug 19, 2020 at 03:04:48PM +0100, Cristian Marussi wrote:
> 
> > Property 'regulator-compatible' is now deprecated (even if still widely
> > used in the code base), and the node-name fallback works fine only as long
> 
> I'm seeing a very small number of DTs using it, the majority of which
> are pretty old - the arm64 ones are just mistakes on the part of
> reviewers.
> 

Yes indeed 'widely' was a bit of an exaggeration, what I (poorly) meant to point
out was that beside still used is deprecated and so not a viable option to solve
my issue.

> > as the nodes are named in an unique way; if it makes sense to use a common
> > name and identifying them using an index through a 'reg' property the
> > standard advices to use a naming in the form <common-name>@<unit>.
> 
> > In this case the above matching mechanism based on the simple (common) name
> > will fail and the only viable alternative would be to properly define the
> > deprecrated 'regulator-compatible' property equal to the full name
> > <common-name>@<unit>.
> 
> This seems like a massive jump.  You appear to be saying that the reg
> property is unusable which doesn't seem right to me?
> 

The 'issue' I observed while working on another series was that with the
following example DT:

firmware {
	scmi {
		...
		scmi_voltage: scmi_protocol@17 {
			reg = <0x17>;
			
			regulators {
				#address-cells = <1>;
				#size-cells = <0>;

				regulator_scmi_discrete: regulator_scmi_discrete@0 {
					reg = <0>;
				};
				
				regulator_scmi_range: regulator_scmi_range@2 {
					reg = <2>;
				};
				
				regulator_scmi_vd3: regulator_scmi@3 {
					reg = <3>;
				};

				regulator_scmi_vd4: regulator_scmi@4 {
					reg = <4>;
				};
			};
		};
};

and the struct regulator_desc configured roughly as:

	sreg->desc.regulators_node = "regulators";
	sreg->desc.of_match = sreg->of_node->name;    <<< This being the regulator_* nodes

the regulator framework standard initialization routines were able to match univocally the
first two regulators above (and parse autonomously the constraints without me explicitly
calling of_get_regulator_init_data() as in a previous version of the series), but got fooled
by the last two since the node name is the same and they differ only by the index, which in
turn anyway seemed to me a sensible thing to be able to do when a node uses reg indexing.

Note that with these SCMI regulators this .of_match configuration happens dynamically at
run-time (as above) since it is defined by the DT and the SCMI fw platform which regulators are
visible and defined and the common SCMI regulator driver handles them all if defined in the DT
and known to the SCMI fw, while with the normal regulators the .of_match setup happens statically
at compile time with macros driver by driver, since the DT defines what is present and the driver
declares what can support.

With this patch you could support both the above naming instead configuring like:

	sreg->desc.regulators_node = "regulators";
	sreg->desc.of_match_full_name = true;
	sreg->desc.of_match = sreg->of_node->full_name;

but I'm not sure that this is needed and worth the effort sincerely at this point,
and probably makes more sense to look at this possible naming issue after I post
the whole original series (without this patch) just to be sure I'm not getting
something wrong somewhere else instead.

> > In order to address this case without using such deprecated property,
> > define a new boolean flag .of_match_full_name in struct regulator_desc to
> > force the core to match against the node full-name instead.
> 
> I can't tell from this description what this change is intended to do,
> and I suspect it'd be difficult for anyone trying to figure out if they
> should use this or not.  What is a full name and what should people put
> in there?  What would one look like for example?  I have to look at the
> code to see that this is changing to compare against the full_name field
> in the node and there's no kerneldoc for struct device_node.
> 

Yes I agree it is hard to understand how to use this from the commit log and if
it is useful or not in a specific use case.

> I'm also wondering why we can't just add this to the list of fallbacks
> rather than requiring some custom per driver thing?
> 

It's an option but it would have doubled the following strncmp() if we just started
checking against full_name every time we fail to find against name so I thought
to make it configurable with the new of_match_full_name....but, given it is far from
clear with this proposed patch, maybe it's better to use a default fallback as you said.

> > -			name = child->name;
> > +			name = !desc->of_match_full_name ?
> > +				child->name : child->full_name;
> 
> Please write normal conditional statements for the benefits of people
> who have to read this code, the extra ! in there isn't adding anything
> here either.

At this point I could just hold this patch and post the original series ignoring
the above issue at first and discuss around that code if this is needed at all
(so to have more context to discuss this), or simplify the patch as above if you
think this fix is still worth.

Regards

Cristian


