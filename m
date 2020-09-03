Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66506C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E62B2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599116959;
	bh=7O6LZSJ9P380GPex1U3QdItSeAXgCMO7Rcd1lexDl78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EQkPvy2CLfBa2fcLeZrtHAAuHGK0m+Fw3QfZHqa8hvhCHbTX5cX45Jb0KapAxa//R
	 U/Tk0WMJcQVjDpglqb9ktnXgrd/1aO+BeuwGblv5k6qOyy2TkMgMQV0wfx6UDIzFPF
	 CISmW+8peWqB7JbQRqCBWmp+naq7BwBqSlVOz1Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgICHJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgICHJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:09:17 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A6720716;
        Thu,  3 Sep 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599116956;
        bh=7O6LZSJ9P380GPex1U3QdItSeAXgCMO7Rcd1lexDl78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNcf1Y2gDZiqYKgu636dhCSh4wtKac8RC3bRtxW98ulKg686+FR9Bz60nCNJT18uS
         IZ/nQByj4fTgJyuzdsQc+I74b8omGBZb2rziC14zFMeiRRUVfsPMAn4iz6LQH4enPd
         NikdMzGZH0XHnS2av8GZXHOZmt7V5ZkcLsLO1uG0=
Date:   Thu, 3 Sep 2020 12:39:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Nicholas Graumann <nick.graumann@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dmaengine: pl330: Simplify with dev_err_probe()
Message-ID: <20200903070912.GH2639@vkoul-mobl>
References: <20200828152637.16903-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828152637.16903-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 17:26, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.

Applied all, thanks

-- 
~Vinod
