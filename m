Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=PDS_HP_HELO_NORDNS,RDNS_NONE,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35183 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:00:56 -0400
Date: Tue, 10 Mar 2020 14:00:54 -0500
From: Rob Herring <robh@kernel.org>
To: Martin Devera <devik@eaxlabs.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Martin Devera <devik@eaxlabs.cz>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add st,swap to stm32-usart
Message-ID: <20200310190054.GA2826@bogus>
References: <20200229160507.31309-1-devik@eaxlabs.cz>
 <20200229160507.31309-2-devik@eaxlabs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229160507.31309-2-devik@eaxlabs.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200310190054.WON20BvU0u33tT6EYJOCqkquqN2XJ6OX2iGcHUDO6JE@z>

On Sat, 29 Feb 2020 17:05:07 +0100, Martin Devera wrote:
> Add new st,swap property to allow for RX & TX pin swapping.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

