Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E39C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C8F20870
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583143691;
	bh=OffZQerAS2WJSpc9mMTLQe6T/x5CNUDFyO/TPtYpBaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HBM6Unr9Ucfs+1i1qEigZHmB3EJu+MISxCpQBjUbp+xREgRyptS9SSStzT6DAcJro
	 KL6LVyiQ/Ik4rsCzSJ9/SMGb0FWWJ+/l90cRYNfj/I7laFDycqPVEMPvD+rMOfNpcR
	 JEj40u05ShtIJvbh2+k42PcLao7JzWaamnAn0UaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCBKIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgCBKIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:08:09 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4802086A;
        Mon,  2 Mar 2020 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583143689;
        bh=OffZQerAS2WJSpc9mMTLQe6T/x5CNUDFyO/TPtYpBaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuJeI0fX/2v3teEA+TQJOQbmpZEmaKFKiNJPS7jPHCZ2OUa7F0hehlxOZHQtICCLN
         gy6P6eXSIa/pE7DxjfGw8o8lR1E4CxO8YG26ZZkvBpITnCkTSJ1Q6ZPaPLInH8u4QD
         /TK9dEBsg6eqGk+wQmsD8oN6lDL+9aYDkbNd6ooc=
Date:   Mon, 2 Mar 2020 15:38:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, natechancellor@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: Adding shutdown hook
Message-ID: <20200302092630.GK4148@vkoul-mobl>
References: <20200227042841.18358-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227042841.18358-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-02-20, 12:28, Peng Ma wrote:
> We need to ensure DMA engine could be stopped in order for kexec
> to start the next kernel.
> So add the shutdown operation support.

Applied, thanks

-- 
~Vinod
