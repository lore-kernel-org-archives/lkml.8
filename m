Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79775CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEB420736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589299174;
	bh=GcSuARZnjzHzIHxazwT2+9mc/w9gn8B3hHEScotCwcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bzAljA5DoeAQF1sJavvQE884epc0Y3YLGq0peRC1YMQpo2OPDcllHCssvKhma1l9Y
	 FCm/z68yRIWy1irWk9db8QD+KEPMOuKByAehaemkJeCy3WtN0icoIsR/LoSinabKye
	 4UdLxDKp4i5OKR2uZh3VHcXWEwBhOWCh5KXMR7o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgELP7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgELP7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:59:33 -0400
Received: from localhost (unknown [171.76.78.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7282054F;
        Tue, 12 May 2020 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589299172;
        bh=GcSuARZnjzHzIHxazwT2+9mc/w9gn8B3hHEScotCwcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7lI9soG/SmwG2yUhc9KJyezmXo/Gk4Jf220jVov/Caf09EzhlUcyfLclXTbdZa/l
         8emUysqo5CvmTlokYxi6Q8LOHC4Murg51DmwS1atarMjEqU3O/Sj0M0ygc2zKgr5Cc
         EHEEqJooAKAed1/nPEOCTQ8HawNLFwvCvLrRWEac=
Date:   Tue, 12 May 2020 21:29:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200512155927.GA4297@vkoul-mobl>
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
 <20200511063227.GS1375924@vkoul-mobl>
 <e214d308-1b92-a7a5-3c76-da05dca99cc5@linux.intel.com>
 <20200512033035.GV1375924@vkoul-mobl>
 <84f09843-3245-5fa4-530f-c915b28e9bc5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f09843-3245-5fa4-530f-c915b28e9bc5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-20, 09:36, Pierre-Louis Bossart wrote:
> On 5/11/20 10:30 PM, Vinod Koul wrote:
> > On 11-05-20, 14:00, Pierre-Louis Bossart wrote:
> > > > > +	md = &bus->md;
> > > > > +	md->dev.bus = &sdw_bus_type;
> > > > > +	md->dev.type = &sdw_master_type;
> > > > > +	md->dev.parent = parent;
> > > > > +	md->dev.of_node = parent->of_node;
> > > > > +	md->dev.fwnode = fwnode;
> > > > > +	md->dev.dma_mask = parent->dma_mask;
> > > > > +
> > > > > +	dev_set_name(&md->dev, "sdw-master-%d", bus->link_id);
> > > > 
> > > > This give nice sdw-master-0. In DT this comes from reg property. I dont
> > > > seem to recall if the ACPI/Disco spec treats link_id as unique across
> > > > the system, can you check that please, if not we would need to update
> > > > this.
> > > Table 3 in the Disco for Soundwire 1.0 spec: "all LinkID values are relative
> > > to the immediate parent Device."
> > > 
> > > There isn't any known implementation with more than one controller.
> > 
> > But then it can come in "future" right. So lets try to make it future
> > proof by not using the link_id (we can expose that as a sysfs if people
> > want to know). So a global unique id needs to allocated (hint: idr or
> > equivalent) and used as master_id
> 
> Can you clarify if you are asking for a global ID for Intel/ACPI platforms,
> or for DT as well? I can't figure out from the soundwire-controller.yaml
> definitions if there is already a notion of unique ID.

If ACPI was unique, then I was planning to update the definition below
to include that. Given that it is not the case, let's make it agnostic to
underlying firmware.

> 
> properties:
>   $nodename:
>     pattern: "^soundwire(@.*)?$"
> 
>    soundwire@c2d0000 {
>         #address-cells = <2>;
>         #size-cells = <0>;
>         reg = <0x0c2d0000 0x2000>;

-- 
~Vinod
