Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16021215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599560767;
	bh=wWnN8wIGdEYRQeyZKiDo3zvwQLQ/nImIw3EzYlJq4Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZylUBug9e8Gf9ZKbWQwaaZKbPLrKMP1laCFM43tjAEY3N8lpgd2JmtnWKZ/m/M9KD
	 NcysmEChNyAUMWtinsK4z4xhW3vkqa/Uccdi2//jC+xXdxbHr9aiVXMqg09I59CPSa
	 fuY2OpiVumKoNOqq4LM/eRQRb+hmNqsdXornmfAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIHKZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgIHKZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:25:52 -0400
Received: from localhost (unknown [122.182.239.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E6B20672;
        Tue,  8 Sep 2020 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560752;
        bh=wWnN8wIGdEYRQeyZKiDo3zvwQLQ/nImIw3EzYlJq4Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W75xSdOthz2YfDEqQ6Y6fTbdMUTwjPxK0P2ioDuwOlLUrb69hyZtEjVEJe5FlKoYZ
         iBHcF6xvQUmBzXQfFQ6ZQXidFYF0sZBO7q3nOJnCILx3TK8iROksvMSgiVcCpUVVap
         qBO2ld5YB33YTuIOcp8OqGeAXBCmZVybvxHk6bZA=
Date:   Tue, 8 Sep 2020 15:55:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, nsekhar@ti.com, vigneshr@ti.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-binding: phy: convert ti,omap-usb2 to YAML
Message-ID: <20200908102548.GD77521@vkoul-mobl>
References: <20200831142130.21836-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831142130.21836-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 17:21, Roger Quadros wrote:
> Move ti,omap-usb2 to its own YAML schema.

Applied, thanks

-- 
~Vinod
