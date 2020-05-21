Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A33C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A3720748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgEUHHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:07:44 -0400
Received: from foss.arm.com ([217.140.110.172]:41328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgEUHHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:07:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4DCBD6E;
        Thu, 21 May 2020 00:07:43 -0700 (PDT)
Received: from bogus (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAF093F52E;
        Thu, 21 May 2020 00:07:40 -0700 (PDT)
Date:   Thu, 21 May 2020 08:07:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 7/7] firmware: smccc: Add ARCH_SOC_ID support
Message-ID: <20200521061228.GA1131@bogus>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <20200518091222.27467-8-sudeep.holla@arm.com>
 <CAK8P3a20R+H6m5GZj2_0w3s-xF+J_qSVrQH8EjyQXe6+9WTYxw@mail.gmail.com>
 <20200518115546.GB16262@bogus>
 <CAK8P3a3bOEL5wYFc1Fjg1vAT51NumzO0iUSroHQLSUt8WpZL7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3bOEL5wYFc1Fjg1vAT51NumzO0iUSroHQLSUt8WpZL7g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 11:51:47PM +0200, Arnd Bergmann wrote:
> On Mon, May 18, 2020 at 1:55 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, May 18, 2020 at 11:30:21AM +0200, Arnd Bergmann wrote:
> > > On Mon, May 18, 2020 at 11:12 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > > +static ssize_t
> > > > +jep106_cont_bank_code_show(struct device *dev, struct device_attribute *attr,
> > > > +                          char *buf)
> > > > +{
> > > > +       return sprintf(buf, "0x%02x\n", JEP106_BANK_CONT_CODE(soc_id_version));
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RO(jep106_cont_bank_code);
> > > > +
> > > > +static ssize_t
> > > > +jep106_identification_code_show(struct device *dev,
> > > > +                               struct device_attribute *attr, char *buf)
> > > > +{
> > > > +       return sprintf(buf, "0x%02x\n", JEP106_ID_CODE(soc_id_version));
> > > > +}
> > >
> > > I think we should try hard to avoid nonstandard attributes for the soc device.
> > >
> >
> > I agree with that in general but this is bit different for below mentioned
> > reason.
> >
> > > Did you run into a problem with finding one of the existing attributes
> > > that can be used to hold the fields?
> > >
> >
> > Not really! The 2 JEP106 codes can be used to derive the manufacturer which
> > could match one of the existing attributes. However doing so might require
> > importing the huge JEP106 list as it needs to be maintained and updated
> > in the kernel. Also that approach will have the compatibility issue and
> > that is the reason for introducing these attributes representing raw
> > values for userspace.
>
> I was thinking they codes could just be part of the normal strings rather
> than get translated. Can you give an example what they would look like
> with your current code?
>

Sure. Couple of example:
Cont Code   Identifier       Manufacturer
0		0x1		AMD
0		0x0e		Freescale (Motorola)
4		0x3b		ARM

I initially thought of value like "jep106-0-1" for AMD "jep-4-3b" for
ARM,..etc for the standard attribute family or machine. But I was not
convinced fully on that approach as it will be deviation from normal
values in those attributes. Further this represents the vendor name
rather than the family or machine.

> If  you think they should be standard attributes, how about adding them
> to the default list, and hardcoding them in the other soc device drivers
> based on the information we have available there?
>

That may be possible, I can take a look at the existing drivers and
check if that is feasible(which I think should be). Thanks for that
suggestion.

--
Regards,
Sudeep

[1] https://github.com/skottler/memtest86/blob/master/jedec_id.h
