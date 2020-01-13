Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D7C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3E72080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgAMMVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:21:09 -0500
Received: from foss.arm.com ([217.140.110.172]:38724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMMVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:21:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21E9013D5;
        Mon, 13 Jan 2020 04:21:08 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C61B3F68E;
        Mon, 13 Jan 2020 04:21:07 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:21:01 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
 nodes
Message-ID: <20200113122101.GA49933@bogus>
References: <1578725620-39677-1-git-send-email-prime.zeng@hisilicon.com>
 <20200113101922.GE52694@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E41D1@DGGEMM506-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340E41D1@DGGEMM506-MBX.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 12:06:11PM +0000, Zengtao (B) wrote:
> > -----Original Message-----
> > From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> > Sent: Monday, January 13, 2020 6:19 PM
> > To: Zengtao (B)
> > Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki; Sudeep Holla;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
> > nodes
> >
> > On Sat, Jan 11, 2020 at 02:53:40PM +0800, Zeng Tao wrote:
> > > When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the
> > device
> > > tree, all the cpu nodes parsing will fail.
> > > And this is not reasonable for a legal device tree configs.
> > > In this patch, skip such cpu nodes rather than return an error.
> > > With CONFIG_NR_CPUS = 128 and cpus nodes num in device tree is
> > 130,
> > > The following warning messages will be print during boot:
> > > CPU node for /cpus/cpu@128 exist but the possible cpu range
> > is :0-127
> > > CPU node for /cpus/cpu@129 exist but the possible cpu range
> > is :0-127
> > > CPU node for /cpus/cpu@130 exist but the possible cpu range
> > is :0-127
> > >
> > > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> > > ---
> > > Changelog:
> > > v1->v2:
> > >  -Remove redundant -ENODEV assignment in get_cpu_for_node
> > >  -Add comment to describe the get_cpu_for_node return values
> > >  -Add skip process for cpu threads
> > >  -Update the commit log with more detail
> > > ---
> > >  drivers/base/arch_topology.c | 37
> > +++++++++++++++++++++++++++++--------
> > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/base/arch_topology.c
> > b/drivers/base/arch_topology.c
> > > index 5fe44b3..01f0e21 100644
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -248,22 +248,44 @@ core_initcall(free_raw_capacity);
> > >  #endif
> > >
> > >  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> > > +/*
> > > + * This function returns the logic cpu number of the node.
> > > + * There are totally three kinds of return values:
> > > + * (1) logic cpu number which is > 0.
> > > + * (2) -ENDEV when the node is valid one which can be found in the
> > device tree
> > > + * but there is no possible cpu nodes to match, when the
> > CONFIG_NR_CPUS is
> > > + * smaller than cpus node numbers in device tree, this will happen.
> > It's
> > > + * suggested to just ignore this case.
> >
> > s/ENDEV/ENODEV/
> Good catch, thanks.
>
> >
> > Also as I mentioned earlier, I prefer not to add any extra logic here
> > other than the above comment to make it explicit. This triggers
> > unnecessary
> > warnings when someone boots with limited CPUs for valid reasons.
> >
>
> So , what 's your suggestion here? Just keep the comments but remove
>  the warning message print?

Yes for all the "found" logic. I am fine to update the existing err

> >
> > > + * (3) -EINVAL when other errors occur.
> > > + */
> > >  static int __init get_cpu_for_node(struct device_node *node)
> > >  {
> > > -	struct device_node *cpu_node;
> > > +	struct device_node *cpu_node, *t;
> > >  	int cpu;
> > > +	bool found = false;
> > >
> > >  	cpu_node = of_parse_phandle(node, "cpu", 0);
> > >  	if (!cpu_node)
> > > -		return -1;
> > > +		return -EINVAL;
> > > +
> > > +	for_each_of_cpu_node(t)
> > > +		if (t == cpu_node) {
> > > +			found = true;
> > > +			break;
> > > +		}
> > > +
> > > +	if (!found) {
> > > +		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> > > +		return -EINVAL;
> > > +	}

Drop all the above change.

> > >
> > >  	cpu = of_cpu_node_to_id(cpu_node);
> > >  	if (cpu >= 0)
> > >  		topology_parse_cpu_capacity(cpu_node, cpu);

You can add here: else if (cpu == -ENODEV)
	pr_info(...whatever you have below..)

Other things as is. Warning may be too harsh if one is running with
reduced number of CPUs.

> > >  	else
> > > -		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> > > +		pr_warn("CPU node for %pOF exist but the possible cpu range
> > is :%*pbl\n",
> > > +			cpu_node, cpumask_pr_args(cpu_possible_mask));
> > >
> > > -	of_node_put(cpu_node);
> >
> > Why is this dropped ?
>
> It's unnecessary here since no one get the node ref.
>

Please read the description of of_parse_phandle. If you find other
issues with existing code, address it in separate patch and don't mix
with the issue in $subject.

--
Regards,
Sudeep
