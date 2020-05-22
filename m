Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ECDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12459206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbgEVROG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:14:06 -0400
Received: from foss.arm.com ([217.140.110.172]:39628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbgEVROG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:14:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32AE855D;
        Fri, 22 May 2020 10:14:05 -0700 (PDT)
Received: from bogus (unknown [10.37.12.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BF493F305;
        Fri, 22 May 2020 10:14:02 -0700 (PDT)
Date:   Fri, 22 May 2020 18:13:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        harb@amperecomputing.com, Jose.Marinho@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francois Ozog <francois.ozog@linaro.org>
Subject: Re: [PATCH 2/2] firmware: smccc: Add ARCH_SOC_ID support
Message-ID: <20200522171359.GB18810@bogus>
References: <20200522124951.35776-1-sudeep.holla@arm.com>
 <20200522124951.35776-3-sudeep.holla@arm.com>
 <CAK8P3a1t6BrB_Gti138VDRbmaiR_TjwR9d6qMstLBFDWxZ1kjQ@mail.gmail.com>
 <20200522165422.GA18810@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522165422.GA18810@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 05:54:22PM +0100, Sudeep Holla wrote:
> (+ Jose (SMCCC Spec author))
> 
> On Fri, May 22, 2020 at 04:46:12PM +0200, Arnd Bergmann wrote:
> > On Fri, May 22, 2020 at 2:50 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > +
> > > +       soc_id_rev = res.a0;
> > > +
> > > +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > > +       if (!soc_dev_attr)
> > > +               return -ENOMEM;
> > > +
> > > +       sprintf(soc_id_str, "0x%04x", IMP_DEF_SOC_ID(soc_id_version));
> > > +       sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
> > > +       sprintf(soc_id_jep106_id_str, "0x%02x%02x",
> > > +               JEP106_BANK_CONT_CODE(soc_id_version),
> > > +               JEP106_ID_CODE(soc_id_version));
> > > +
> > > +       soc_dev_attr->soc_id = soc_id_str;
> > > +       soc_dev_attr->revision = soc_id_rev_str;
> > > +       soc_dev_attr->jep106_id = soc_id_jep106_id_str;
> >
> > Ok, let me try to understand how this maps the 64-bit ID into the
> > six strings in user space:
> >
> > For a chip that identifies as
> >
> > JEP106_BANK_CONT_CODE = 12
> > JEP106_ID_CODE = 34
> > IMP_DEF_SOC_ID = 5678
> > soc_id_rev = 9abcdef0
> >
> > the normal sysfs attributes contain these strings:
> >
> > machine = ""
> > family = ""
> > revision = "0x9abcdef0
> > serial_number = ""
> > soc_id = "0x5678"
> >
> > and the new attribute is
> >
> > jep106_identification_code = "0x1234"
> >
> > This still looks like a rather poorly designed interface to me, with a
> > number of downsides:
> >
> > - Nothing in those strings identifies the numbers as using jep106
> >   numbers rather than some something else that might use strings
> >   with hexadecimal numbers.
> >
> 
> Not sure if I understand your concerns completely here.
> 
> Anyways I wanted to clarify that the jep106 encoding is applicable only
> for manufacturer's id and not for SoC ID or revision. Not sure if that
> changes anything about your concerns.
> 
> > - I think we should have something unique in "family" just because
> >   existing scripts can use that as the primary indentifier
> >
> 
> I agree with your idea of combining attributes, not sure exactly which
> ones yet.
> 
> > - It seems odd that there is no way to read the serial number through
> >   the same interface and publish it the usual way.
> 
> Valid concern and I will pass this to interface authors.
> 
> >   Francois Ozog
> >   recently asked for a generic way to find out a serial number for
> >   inventory management, and this would be the obvious place to have it.
> 
> Agreed, but not sure what author(s) have to say. I have cc-ed one of them.
> 
> >   It can of course be added later when the next revision of the spec
> >   is there, it just seems like a surprising omission.
> >
> 
> Yes, definitely. Good to get feedback.
> 
> > How about making the contents:
> >
> > machine = "" /* could be a future addition, but board specific */
[...]
> > serial_number = "0xfedcba987654321" /* to be implemented later */

OK more thoughts and few points I missed earlier. The SoC infrastructure
is more wider than the SoC itself IMO. The machine and serial_number
are beyond the SoC and this SMCCC SOC_ID confined itself to SoC for
simple reason that it is part of SoC vendor firmware which could be
used across various machines/boards/platforms.

I wonder now that rather than adding this as a SoC sysfs driver on it's
own, does it make sense to keep it as library which existing drivers
can use. Or we need to standardise the machine level interface that may
like outside SoC firmware and use both to have a generic SoC sysfs driver.

Sorry, I am just writing as I am thinking and may be talking garbage.

-- 
Regards,
Sudeep
