Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D518C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E47206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466633;
	bh=mPGiTVcftIoSXUZ6f1pWsVTJ28Byph4d25oaNFRkBPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G7DhPP88ib5gMDlzVL/7m40kDKqW3GvGcoqRbJhrn6FztJ/m+WPo12Skl0p0F/MM3
	 6oiY4FjtQ1uSYhqu8mXHapZX0kFj5C7Pn0njsuLus9W9nsJaEovz6G23iaLtV7hfhw
	 gSjVVmOl1iOV++cYHXUvOqn0O/LU/r9OfKFLDb94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbgF2VhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgF2Ski (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:38 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E1423437;
        Mon, 29 Jun 2020 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593424174;
        bh=mPGiTVcftIoSXUZ6f1pWsVTJ28Byph4d25oaNFRkBPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkBvIT/XpoNOV/3SQ5LCkp7Sta+rrT6l0NHlJ87pF/Ct/Sm1OBCD2lf5OiCN723X/
         ANew8yU8tLPCBqz32Jzge5OMl9ifu7G7DAkRh9dU3Fl9tcHTOoxvLXIyjxUbx/ALSE
         uBlg1hU9MDuDLlGsuj0g+R2HCfOz3iARq19Lsolo=
Date:   Mon, 29 Jun 2020 15:19:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: qcom: Fix missing 'ranges' and example
 addresses
Message-ID: <20200629094930.GF2599@vkoul-mobl>
References: <20200611151835.1100883-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611151835.1100883-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-20, 09:18, Rob Herring wrote:
> The QCom QMP PHY bindings have child nodes with translatable (MMIO)
> addresses, so a 'ranges' property is required in the parent node.
> Additionally, the examples default to 1 address and size cell, so let's
> fix that, too.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
