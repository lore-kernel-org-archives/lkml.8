Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB50C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8CC20776
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQOE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:04:29 -0400
Received: from foss.arm.com ([217.140.110.172]:58464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQOE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:04:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CE5B31B;
        Wed, 17 Jun 2020 07:04:28 -0700 (PDT)
Received: from bogus (unknown [10.37.12.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E57BF3F73C;
        Wed, 17 Jun 2020 07:04:25 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:04:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Harb Abdulhamid (harb@amperecomputing.com)" 
        <harb@amperecomputing.com>,
        Francois Ozog <francois.ozog@linaro.org>,
        Jose Marinho <Jose.Marinho@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Etienne Carriere <etienne.carriere@st.com>
Subject: Re: [PATCH v2] firmware: smccc: Add ARCH_SOC_ID support
Message-ID: <20200617140420.GA18881@bogus>
References: <20200617100559.55209-1-sudeep.holla@arm.com>
 <ccbbae8d-8ca8-4688-4cec-58ae9962d766@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccbbae8d-8ca8-4688-4cec-58ae9962d766@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:34:41PM +0100, Steven Price wrote:
> On 17/06/2020 11:05, Sudeep Holla wrote:
> > SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
> > SiP defined SoC identification value. Add support for the same.
> > 
> > Also using the SoC bus infrastructure, let us expose the platform
> > specific SoC atrributes under sysfs.
> > 
> > There are various ways in which it can be represented in shortened form
> > for efficiency and ease of parsing for userspace. The chosen form is
> > described in the ABI document.
> > 
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Etienne Carriere <etienne.carriere@st.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   Documentation/ABI/testing/sysfs-devices-soc |  30 ++++++
> >   drivers/firmware/smccc/Kconfig              |   9 ++
> >   drivers/firmware/smccc/Makefile             |   1 +
> >   drivers/firmware/smccc/soc_id.c             | 114 ++++++++++++++++++++
> >   include/linux/arm-smccc.h                   |   5 +
> >   5 files changed, 159 insertions(+)
> >   create mode 100644 drivers/firmware/smccc/soc_id.c
> > 
> > Changes from v1[1] -> v2:
> > 	- Dropped new jep106_id added to SoC infrastructure
> > 	- Dropped all the tags(acks/reviews) as there is change in the format
> > 	- Updated the format for SoC id to ensure there will be no
> > 	  conflict in the namespace
> > 
> > [1] https://lore.kernel.org/lkml/20200522124951.35776-1-sudeep.holla@arm.com/
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
> > index ba3a3fac0ee1..50707f316ea9 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-soc
> > +++ b/Documentation/ABI/testing/sysfs-devices-soc
> > @@ -26,6 +26,30 @@ contact:	Lee Jones <lee.jones@linaro.org>
> >   		Read-only attribute common to all SoCs. Contains SoC family name
> >   		(e.g. DB8500).
> > +		On many of ARM based silicon with SMCCC v1.2+ compliant firmware
> > +		this will contain the JEDEC JEP106 manufacturer’s identification
> > +		code. The format is "jep106:XXYY" where XX is identity code and
> > +		YY is continuation code.
> > +
> > +		This manufacturer’s identification code is defined by one
> > +		or more eight (8) bit fields, each consisting of seven (7)
> > +		data bits plus one (1) odd parity bit. It is a single field,
> > +		limiting the possible number of vendors to 126. To expand
> > +		the maximum number of identification codes, a continuation
> > +		scheme has been defined.
> > +
> > +		The specified mechanism is that an identity code of 0x7F
> > +		represents the "continuation code" and implies the presence
> > +		of an additional identity code field, and this mechanism
> > +		may be extended to multiple continuation codes followed
> > +		by the manufacturer's identity code.
> > +
> > +		For example, ARM has identity code 0x7F 0x7F 0x7F 0x7F 0x3B,
> > +		which is code 0x3B on the fifth 'page'. This can be shortened
>
> NIT: s/can be/is/ - since the format always uses the short form.
>

Will fix it.

[...]

> > +
> > +	sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
> > +	sprintf(soc_id_jep106_id_str, "jep106:%02x%02x",
> > +		JEP106_BANK_CONT_CODE(soc_id_version),
> > +		JEP106_ID_CODE(soc_id_version));
> > +	sprintf(soc_id_str, "%s:%04x", soc_id_jep106_id_str,
> > +		IMP_DEF_SOC_ID(soc_id_version));
> 
> My maths might be wrong, but I think this is one byte too long:
> 
> soc_id_jep106_id_str can be 11 characters (without the NUL), then we have a
> ':' byte followed by 4 hex digits and a trailing NUL: 11 + 1 + 4 + 1 = 17,
> but the char array is 16 bytes long.
>

Nope, you are right. I was changing the format multiple times without
bothering much about that size. Thanks for the catch.

> With that fixed feel free to add my "Reviewed-by".
>

I will fix it up and thanks for the review.

-- 
Regards,
Sudeep
