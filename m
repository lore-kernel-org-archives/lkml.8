Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C2C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB864206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594792550;
	bh=4L0r9v5FkgrxWwvK9GlcmCOK5aunuxeotemRIOEWfkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oQbypEfgFIRSJkQHIhNN+iX7Mlm9x3EmZg1Rdj/+Xfswqm6eAiXpSQghnVY8pcTa1
	 qds3ah0sR0hergfPRE/ANtmhGLK5cj4JOW3TMbPD/oztJC/mWUAsyFNSUMGbB1ZCOU
	 6HyL6ImEAYRqnyViecg7bqUCY938qGYwC6Op0pyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgGOFzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgGOFzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:55:49 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF2220663;
        Wed, 15 Jul 2020 05:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594792549;
        bh=4L0r9v5FkgrxWwvK9GlcmCOK5aunuxeotemRIOEWfkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdClUSI2QoX3y8jh2UXmzcPqsnAEbz2/Lh0LRc8GTpt7f+6XYufh7CzGYGjmPZzE6
         ZZToJw+z5qU7GGNYhP6lqPRNlSNAVCM14vnM5uvfmXhoCFnr/EYZTCRMf/S7UkNnGg
         qmgDTm9urp340rQd/09+5zFIHhSdsjMkTfmwFRNQ=
Date:   Wed, 15 Jul 2020 11:25:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] dt-bindings: dma: pl330: Document the quirk
 'arm,pl330-periph-burst'
Message-ID: <20200715055545.GU34333@vkoul-mobl>
References: <1593439555-68130-1-git-send-email-sugar.zhang@rock-chips.com>
 <1593439555-68130-4-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593439555-68130-4-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 22:05, Sugar Zhang wrote:
> This patch Adds the quirk 'arm,pl330-periph-burst' for pl330.

Applied, thanks

-- 
~Vinod
