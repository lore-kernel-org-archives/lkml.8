Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D88C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6912083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579270576;
	bh=4qSApj3kP2KygbojYW6xtWszdgOndInNtrCKFim9YTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OtuWX+5Mu1nL4P9FvjEtHqCIEh3uKQGWYfd/AL7W70R8CJ8H60yxoB1Cx4XTCLwsC
	 kemLz0o1Ah6EloOt0IwQQHhsD4/VZxSalzc9GQFVmiG1KSX7uDykbDfDMWCSaILEof
	 TI+OKFFyisC6AOhZMBrG5fHUlLpNcikexL3WWH1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAQOQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQOQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:16:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5FF2082F;
        Fri, 17 Jan 2020 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579270574;
        bh=4qSApj3kP2KygbojYW6xtWszdgOndInNtrCKFim9YTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+4F2dL3F84tNrmeuvWtZB3t9Hej6s2EVIzAv1pjdkuFUbDb9SGrNyIrNP87WUN3z
         PT5i+gtg9XHqijkWr6X8DrcJ7mjd3QVwYY3pGYMMHe0cc4Y7/NsgSQ9sl00WxPUcnG
         EFHHyv1y89ZnGSBleUDNry4sbdeEj9/+Q5JAJlXQ=
Date:   Fri, 17 Jan 2020 15:16:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     roman.sudarikov@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 1/2] perf x86: Infrastructure for exposing an Uncore
 unit to PMON mapping
Message-ID: <20200117141612.GB1856891@kroah.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-2-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117133759.5729-2-roman.sudarikov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:37:58PM +0300, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
> significant changes in the integrated I/O (IIO) architecture. The new
> solution introduces IIO stacks which are responsible for managing traffic
> between the PCIe domain and the Mesh domain. Each IIO stack has its own
> PMON block and can handle either DMI port, x16 PCIe root port, MCP-Link
> or various built-in accelerators. IIO PMON blocks allow concurrent
> monitoring of I/O flows up to 4 x4 bifurcation within each IIO stack.
> 
> Software is supposed to program required perf counters within each IIO
> stack and gather performance data. The tricky thing here is that IIO PMON
> reports data per IIO stack but users have no idea what IIO stacks are -
> they only know devices which are connected to the platform.
> 
> Understanding IIO stack concept to find which IIO stack that particular
> IO device is connected to, or to identify an IIO PMON block to program
> for monitoring specific IIO stack assumes a lot of implicit knowledge
> about given Intel server platform architecture.
> 
> Usage example:
>     /sys/devices/uncore_<type>_<pmu_idx>/mapping
> 
> Each Uncore unit type, by its nature, can be mapped to its own context,
> for example:
> 1. CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice
>    of LLC capacity;
> 2. UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel
>    UPI Subsystem;
> 3. IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the
>    IIO module;
> 4. IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of
>    Memory Controller.
> 
> Implementation details:
> Two callbacks added to struct intel_uncore_type to discover and map Uncore
> units to PMONs:
>     int (*get_topology)(struct intel_uncore_type *type, int max_dies)
>     int (*set_mapping)(struct intel_uncore_type *type, int max_dies)
> 
> Details of IIO Uncore unit mapping to IIO PMON:
> Each IIO stack is either DMI port, x16 PCIe root port, MCP-Link or various
> built-in accelerators. For Uncore IIO Unit type, the mapping file
> holds bus numbers of devices, which can be monitored by that IIO PMON block
> on each die.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore.c | 46 ++++++++++++++++++++++++++++++++++
>  arch/x86/events/intel/uncore.h |  6 +++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 86467f85c383..55201bfde2c8 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -825,6 +825,44 @@ static const struct attribute_group uncore_pmu_attr_group = {
>  	.attrs = uncore_pmu_attrs,
>  };
>  
> +static ssize_t mapping_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct intel_uncore_pmu *pmu = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%s\n", pmu->mapping);
> +}
> +static DEVICE_ATTR_RO(mapping);
> +
> +static struct attribute *mapping_attrs[] = {
> +	&dev_attr_mapping.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group mapping_group = {
> +	.attrs = mapping_attrs,
> +};
> +
> +static umode_t
> +not_visible(struct kobject *kobj, struct attribute *attr, int i)
> +{
> +	return 0;
> +}
> +
> +static const struct attribute_group *attr_update[] = {
> +	&mapping_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?


> +
> +static void uncore_platform_mapping(struct intel_uncore_type *t)
> +{
> +	if (t->get_topology && t->set_mapping &&
> +	    !t->get_topology(t, max_dies) && !t->set_mapping(t, max_dies))
> +		mapping_group.is_visible = NULL;

No need to set something to NULL that is already set to NULL, right?

thanks,

greg k-h
