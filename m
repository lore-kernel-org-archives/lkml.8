Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B32C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B728B208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599802701;
	bh=4YlGeAzSk+VGx7Lv2PxADvGdtfP9LG4jw7wIhUBPn2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AtnPBPsCq2l9LAkFxqSDgIjQjsvfESzYIbqrGxdJVjgvrl6AzE/TGbGOK9So9arbQ
	 v2oWBiuLQdx7HEAuCyj9M5y/j5jcTMuoGjf/mat+B6LaPK2dYZvVhiOPIcJ+Zz4FMg
	 YVv5IoT22CKSmZtTAg0Ek8hClzAnbMil7oLAwG9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgIKFiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgIKFiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:38:19 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D0C21D81;
        Fri, 11 Sep 2020 05:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599802699;
        bh=4YlGeAzSk+VGx7Lv2PxADvGdtfP9LG4jw7wIhUBPn2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riUjklHYjcpHSKbAt936DqtmLfL2dDXTo9r+oRDFaOCySYol6MGsWbAfxd+OkCIGj
         tGpQmNFlPWC9oAuPayqkaq7GfDIDM932wcbcZ9VOP1+u1xX5nRG9VXbRQbgte2PJHV
         yMeCyTWt+1oCzEl1ZYPSuURdGxtcHMqiIjbuq7KU=
Date:   Fri, 11 Sep 2020 11:08:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
Message-ID: <20200911053814.GT77521@vkoul-mobl>
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
 <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
 <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
 <ed88432c-e21c-b5fc-3abc-5f574769b722@linux.intel.com>
 <20200910085621.GS77521@vkoul-mobl>
 <f3880470-cdc4-7b84-97a1-303f9a95d3f4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3880470-cdc4-7b84-97a1-303f9a95d3f4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-09-20, 09:02, Pierre-Louis Bossart wrote:
> 
> > > > May be we could make the enumerated devices discovery bit more verbose!
> > > 
> > > Maybe adding a device number sysfs entry would help, e.g. reporting
> > > NotAttched or a value in [0,11] would tell you if the device is actually
> > > present.
> > 
> > Agreed, I cooked this patch to report verbose device status, let me know
> > if you are okay with this. I think this would be useful regardless of
> > current discussion.
> > 
> > On Db845c I see:
> > 
> > root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:1/status
> > Attached
> > root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:2/status
> > Attached
> 
> looks like we are all aligned on the idea, I have a similar patch to at
> https://github.com/thesofproject/linux/pull/2426
> 
> The difference is that the sysfs status and device_number is added even
> without a driver probe and when there's no firmware description. sysfs is
> currently only added after the driver probe, which wouldn't work for the
> case Srinivas was trying to deal with.

Okay sound fine

> but the way you dealt the status below is better than the switch case I
> used, so will merge this into my code.

Why merge? That patch can remain independent and you can add
device_number patch on top and another one for moving sysfs creation
without a driver probe, these three sound like three different patches
to me.

> Srinivas' patch needs a fix for ACPI platforms, won't probe otherwise since
> we don't have an of_node. If that's alright with everyone I can submit a
> patchset that gathers the 3 contributions.

Yes one series should be good, but lets keep one change in a patch
please

-- 
~Vinod
