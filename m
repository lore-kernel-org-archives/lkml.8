Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE97C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BF42074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593582152;
	bh=z+2RJZHyQny9rynb3BmYF5r0RdYoLOR7Ccd9JyesxtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JLujciP/9UiN+LBDgcxA2BM5jJvmb6qeEJGjFTyVX/MpzCXZkkFqS89i6plwmBCvb
	 O34Dfk8QzfOMHyTyndkc+plVtCZQUfl8xP+8sYt7iN7CVVi2VQ3WmAHrsB/YKw2r5Y
	 KU4/E0VvtugTIjfIZltiGpJTMViJBQ+6F+o7wY0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGAFmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 01:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgGAFma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:42:30 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D306A20722;
        Wed,  1 Jul 2020 05:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593582149;
        bh=z+2RJZHyQny9rynb3BmYF5r0RdYoLOR7Ccd9JyesxtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1/U8k8t8jnr0MVIBLl3Q8dNbc3WGFzi3WFym1Qi9Ar3/Vh60em4504wWCovTjrtOk
         QV9+Zhq+sW0ax5ylUO6pMiVuzlFkT1A22j3LOkHVKjXF4K4M/pawujPLjz+BKdBd1X
         Eiw3i2HROaC03z20QBbGvpQqsVuVkdlHWAHSf/D0=
Date:   Wed, 1 Jul 2020 11:12:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 7/9] soundwire: intel/cadence: merge Soundwire interrupt
 handlers/threads
Message-ID: <20200701054224.GV2599@vkoul-mobl>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
 <20200623173546.21870-8-yung-chuan.liao@linux.intel.com>
 <20200630162448.GS2599@vkoul-mobl>
 <55fbc41e-cb41-8bdf-bdbd-1d1b76938683@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fbc41e-cb41-8bdf-bdbd-1d1b76938683@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-20, 11:46, Pierre-Louis Bossart wrote:
 
> > Is this called from irq context or irq thread or something else?
> 
> from IRQ thread, hence the name, see pointers above.
> 
> The key part is that we could only make the hardware work as intended by
> using a single thread for all interrupt sources, and that patch is just the
> generalization of what was implemented for HDaudio in mid-2019 after months
> of lost interrupts and IPC errors. See below the code from
> sound/soc/sof/intel/hda.c for interrupt handling.

Sounds good. Now that you are already in irq thread, does it make sense
to spawn a worker thread for this and handle it there? Why not do in the
irq thread itself. Using a thread kind of defeats the whole point behind
concept of irq threads

-- 
~Vinod
