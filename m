Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ABAC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A32424679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579011715;
	bh=oysHKD0CamKNbJNBQDnVaXo90v5lwFZkCg6i8EicVEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bsHmpTIdu0AuWmKXMh74XtyX8SolWl0u+kNVwibD1z7/6sTUjp3X2mvJxe/nzR6/d
	 7g947YQ1zAOP/kffwzNi7W7kcP4c8/UjlTTRVu5Mv76ygzsPU3wHeVe+eUtLs6KPIS
	 GJr7eQ3YDfWKrkDLpXTUpsu6xbrB4AtbKJETNo1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgANOVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgANOVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:21:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E620B2465A;
        Tue, 14 Jan 2020 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579011713;
        bh=oysHKD0CamKNbJNBQDnVaXo90v5lwFZkCg6i8EicVEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joEEb77XZsTSw/mGCaNiMPNFlsWIpW8xpbbPcsGVsq7N/n3NTMVjVj41uW3J0CuLD
         YjV5K0XJLZN++K/fOZkOGA0YIVgfyQ5OWCl8bU8mMkvNz944DgkadkotV9O5hpvBDZ
         cE5Tde4H/gl0CYr3Xz5fK/ZiV09wlHcIbvMtOwlA=
Date:   Tue, 14 Jan 2020 15:21:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v3 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200114142150.GB1784266@kroah.com>
References: <20200113135444.12027-1-roman.sudarikov@linux.intel.com>
 <20200113135444.12027-3-roman.sudarikov@linux.intel.com>
 <20200113143818.GB390411@kroah.com>
 <cdce3529-a953-41e4-740a-36193e7931b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdce3529-a953-41e4-740a-36193e7931b4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:55:03PM +0300, Sudarikov, Roman wrote:
> On 13.01.2020 17:38, Greg KH wrote:
> > On Mon, Jan 13, 2020 at 04:54:44PM +0300, roman.sudarikov@linux.intel.com wrote:
> > > From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> > > 
> > > Current version supports a server line starting Intel® Xeon® Processor
> > > Scalable Family and introduces mapping for IIO Uncore units only.
> > > Other units can be added on demand.
> > > 
> > > IIO stack to PMON mapping is exposed through:
> > >      /sys/devices/uncore_iio_<pmu_idx>/platform_mapping
> > >      in the following format: domain:bus
> > > 
> > > For example, on a 4-die Intel Xeon® server platform:
> > >      $ cat /sys/devices/uncore_iio_0/platform_mapping
> > >      0000:00,0000:40,0000:80,0000:c0
> > That's horrid to parse.  Sysfs should be one value per file, why not
> > have individual files for all of these things?
> > 
> > > Which means:
> > > IIO PMON block 0 on die 0 belongs to IIO stack on bus 0x00, domain 0x0000
> > > IIO PMON block 0 on die 1 belongs to IIO stack on bus 0x40, domain 0x0000
> > > IIO PMON block 0 on die 2 belongs to IIO stack on bus 0x80, domain 0x0000
> > > IIO PMON block 0 on die 3 belongs to IIO stack on bus 0xc0, domain 0x0000
> > Where did you get the die number from the above data?
> > 
> Mapping algorithm requires domain:bus pair for each IO stack for each die.
> Current implementation provides comma separated list of domain:bus pairs
> for each stack where offset in the list corresponds to die index.
> 
> Technically similar approach which was already implemented for the cpumask
> attribute.
> > 
> > > Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> > > Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>

Also, to be a bit of a pest, you all are NOT following the internal
Intel rules for submitting kernel patches.  You need a lot more reviews
before this should have "escaped" to lkml.

greg k-h
