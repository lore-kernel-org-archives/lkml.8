Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ABAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37652082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593019120;
	bh=aGZUjn6wDrdbHrCzqvlIqiJqUkFrUgMNUt+T2vibI6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q5KSEYp9OHoYDfQEG8FCsgrFXFW/PKvl7oG/eeihDK3Qknf65C/HMJHoVqk/Wddr/
	 Dqhg02Ykmi/4ansclOMgsUMeulLSQ43bKjh1cm/vPDpFaVgUu5osWmw8dOlNhhVaNU
	 QQv+Z/P4rQ8WED8vhZ3E3FKqR6Gc/qFY2Cca435E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405431AbgFXRSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405280AbgFXRSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:18:39 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E1320823;
        Wed, 24 Jun 2020 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593019118;
        bh=aGZUjn6wDrdbHrCzqvlIqiJqUkFrUgMNUt+T2vibI6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0jRajIBQUNqhxod6nx6oIW481SqqJzySK2W6vtNXd8PDKxfp7WKynpUTXCyxTlkN
         pr7pTbX1Vy+oIzs8h7W2PS9Fg3rJyS1ollTGmecUGFD2xMD2Qe9bxgJqm4w/U5SLzz
         MKMuGLVj4mzdgzm/TBipJ2CsweI99ZqprPKpFqG0=
Date:   Wed, 24 Jun 2020 22:48:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 0/5] Enable USB support in IPQ8074
Message-ID: <20200624171834.GH2324254@vkoul-mobl>
References: <1591625479-4483-1-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591625479-4483-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-20, 19:41, Sivaprakash Murugesan wrote:
> IPQ8074 has two super speed USB ports, with QMP and QUSB2 PHYs.
> This patch set enables the USB PHYs and USB dwc3 in IPQ8074.

Applied 1 thru 4. Bjorn can take the 5th one, thanks

-- 
~Vinod
