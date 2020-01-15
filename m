Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BDC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA424679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579125465;
	bh=fqJ3cgdhflak8k+kX0Uut8rPPX0mIkcp3KI055/GYdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OSUNatMsC6XHm4lcM4dLETvgF+q58MlYiok7P7xTpb2PriH3r8f1c0fH+ebvbsAs2
	 QkJCz1uFey3P09Lf1xDh0dtHP/csYici9kQl+mBq5r4dAcx2QWhpIzmWyQVuHCTLR1
	 KV7E/2VRAPIOQ/l2VPrEibN0KPojQDQ4m4zX8ALw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgAOV5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgAOV5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:57:44 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4FA2467E;
        Wed, 15 Jan 2020 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579125464;
        bh=fqJ3cgdhflak8k+kX0Uut8rPPX0mIkcp3KI055/GYdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tBOqUOCC/hxuRJ1teE4c6OYQxRpqB3ufp5uMDE1InjmLIpLR1EvdmWo8zC38v5uLX
         qVfQbB4yQxgGV8QvVAxE0EB8pp2SafeFSZGtRkVHQbNXZbd42suZ4X3AEVEQhbaLcu
         z4rG3SIDU07GiEeYxkIpEmEIW2PDWx7X5C7u+u+k=
Received: by mail-qv1-f44.google.com with SMTP id z3so8152453qvn.0;
        Wed, 15 Jan 2020 13:57:44 -0800 (PST)
X-Gm-Message-State: APjAAAVqoQAE2sP4JxCiz+PovBMGuuiFEhfUdSUAMgw0lOEEtq+DhCBX
        p4jE+sLF6ZBHJfrWl1u+KiywBe3LcIsENhsiVg==
X-Google-Smtp-Source: APXvYqwAHtQlCQbeWq+CY8J9zcxqv2xb+B5FaW0KvQ7TuzjbZQrBiC5F7M17O44wnq6FJ6CZL3h2DX0j3QQwkVCVgsY=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr27776404qvo.20.1579125463304;
 Wed, 15 Jan 2020 13:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20200115194216.173117-1-jernej.skrabec@siol.net> <20200115194216.173117-2-jernej.skrabec@siol.net>
In-Reply-To: <20200115194216.173117-2-jernej.skrabec@siol.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Jan 2020 15:57:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-KBd9PF7nKK976vVYjRwfm-ZxJSnEbhiWC=X3AnvpeA@mail.gmail.com>
Message-ID: <CAL_JsqK-KBd9PF7nKK976vVYjRwfm-ZxJSnEbhiWC=X3AnvpeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: add OrangePi 3 with eMMC
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 1:42 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> OrangePi 3 can optionally have eMMC. Add a compatible for it.

Is this just a population option or a different board layout? If the
former, I don't think you need a new compatible, just add/enable a
node for the eMMC.

Rob
