Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA5C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B1720C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598600750;
	bh=/YlQq3kq0scE8VOOqA9neEBCKThA211wcq3Ihbr6a8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=croZ1ND1JBMGvjqZZkSl/V8MNsuPlN0XSKsCQf/vSK6jqdzxBx6mFjxGOk0tmJiU2
	 lwawCxwbQv0BfETz1LH6Zw203pd6fPEG8LkcD5MvZ+kFnqaR+ksYebgd3peTJTvxIp
	 XIN9wPEtW1N/d3uyulv3VuTPbAdqQXIa/itFmJ5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgH1Hpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgH1Hps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:45:48 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CDD206EB;
        Fri, 28 Aug 2020 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598600748;
        bh=/YlQq3kq0scE8VOOqA9neEBCKThA211wcq3Ihbr6a8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pbww8oqmOt9a4DplZPurSROVGyyNuGnD1BkYUy3UmRwQjlX94Nn5MDdbp0Ghx/GCx
         bIfpyWE7amwwYs8tyIwiIcrLyTGZ3F+rNV27azj2jIyh9q0xYfWsxscDNNHWB+FN/4
         XisAOqb3R4iWKmdJ7saU5dQahEpCuuyRCZgZL4TA=
Date:   Fri, 28 Aug 2020 13:15:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for
 the first cpu_dai
Message-ID: <20200828074544.GM2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
 <20200826094636.GB2639@vkoul-mobl>
 <DM6PR11MB407494AEF6D05EFF627CFAFBFF520@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB407494AEF6D05EFF627CFAFBFF520@DM6PR11MB4074.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 01:47, Liao, Bard wrote:
> > snd_pcm_substream *substream,
> > >  			goto err;
> > >  	}
> > >
> > > -	ret = sdw_prepare_stream(dma->stream);
> > > +	/*
> > > +	 * All cpu dais belong to a stream. To ensure sdw_prepare_stream
> > > +	 * is called once per stream, we should call it only when
> > > +	 * dai = first_cpu_dai.
> > > +	 */
> > > +	if (first_cpu_dai == dai)
> > > +		ret = sdw_prepare_stream(dma->stream);
> > 
> > Hmmm why not use the one place which is unique in the card to call this,
> > hint machine dais are only called once.
> 
> Yes, we can call it in machine driver. But, shouldn't it belong to platform
> level? The point is that if we move the stuff to machine driver, it will
> force people to implement these stuff on their own Intel machine driver.

nothing stops anyone from doing that right! machine driver is another
component so it can be moved there as well

-- 
~Vinod
