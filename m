Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CEBC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F320709
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jEp5UsDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1uN4zty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgDEHKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 03:10:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49265 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgDEHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 03:10:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F7B45C0181;
        Sun,  5 Apr 2020 03:10:13 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 05 Apr 2020 03:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=cMUy/0M6Ps5KAccSUTnVJZlazBQbL82
        Nr711Y5cq5Zw=; b=jEp5UsDNDzEdJr4xg+a9XUu5oegqdIn21hAziN9HDqM/qwP
        9C9Vuo6NBklX8jZaZnZDp3s1v7eWpoX+WXBnrq2JMnYH5xeimjxvq8v4GhtNuVst
        x8yjHj3bzfbT/UBqwisvQMahV29V8VOyW4RfHlXtSsEOfYhA6TY8GahvfU5S/fqV
        iPefDGtZBs9C3zaCfIi3Hyrwx4O47HnNENHHTN29ELZRVBOhtXrct1RB41IuZDN8
        ErPSkIeGVfhCxkWFyLkwm6JbQXyd5h1Vyob+NIrsO+AuMFDg0l4zCGEAFIimjqz2
        EAPrnLIkjK4S0yjcBqbSFKCEr1TB6fBm7VUJSsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cMUy/0
        M6Ps5KAccSUTnVJZlazBQbL82Nr711Y5cq5Zw=; b=C1uN4ztykx2E4JQ3M/5Brq
        h0oGBXc0EPPv2Tuw/+gLX9FxnOIAK92z2CS3Qa9irHMPrvS1+f3IrS0Ps75uIMTe
        pTCf9CA6dGYH4CEVwubXXSh7adLJ64EWmSCNxajdU923VZhv99n41u0YdCb5h0Ip
        c2XGjbUks+90vgXebkNLjlXqe3xmlJqhD707FqGaMdOJDCu6kP+XY4Wy9GyS3vV3
        eYn+jWVrBAg2Y0NuJ18qg/Pecxh0eGl6glaaydYBO0fa3Z8B13sTn5uXx+x6Plcd
        4jXAZ1KjpIRVsFI4k+PFYyBnbRjg/ZkQtMIkzBzkNMQjEPNkTgNd+fOzcem0sDhw
        ==
X-ME-Sender: <xms:VISJXsHX7wxfxUwOOxeVaR6LTmM3TWxlW2DE3nRyHq68jOrP5wyeMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:VISJXuQ3lCfnyo6ZsU_O-0ivpCc-JaQyHgPCLl8hejlpc0lyy9U_TA>
    <xmx:VISJXu7J_qg9os4_kOm-W8wUHfhxDd2cuHyN4kUoDyxMyLwlSl8DhQ>
    <xmx:VISJXhPp2ZP1_Iisi7Sg-CFSwL0oixvsaMIugWXSdPiiXHUfYAmPUQ>
    <xmx:VYSJXqVUVJiZ0DY_y7vixFYGVHs4vSMhawEMV1-nTWZiTS1RvPb48Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 37AFDE00B1; Sun,  5 Apr 2020 03:10:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1082-g13d7805-fmstable-20200403v1
Mime-Version: 1.0
Message-Id: <8307d2cd-3bd2-4447-a244-89d0da1a71fe@www.fastmail.com>
In-Reply-To: <20200403162901.21106-2-eajames@linux.ibm.com>
References: <20200403162901.21106-1-eajames@linux.ibm.com>
 <20200403162901.21106-2-eajames@linux.ibm.com>
Date:   Sun, 05 Apr 2020 16:40:33 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Rob Herring" <robh+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v8 1/5] dt-bindings: soc: Add Aspeed XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Apr 2020, at 02:58, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Changes since v6:
>  - Add PCI-E root complex reset documentation
>  - Add reset-names documentation
>  - Switch to memory-region phandle instead of memory regs
> 
>  .../devicetree/bindings/soc/aspeed/xdma.txt   | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt 
> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 000000000000..c3d7cdeb1db6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> @@ -0,0 +1,44 @@
> +Aspeed AST25XX and AST26XX XDMA Engine
> +
> +The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform 
> automatic
> +DMA operations over PCI between the SOC (acting as a BMC) and a host 
> processor.
> +
> +Required properties:
> + - compatible		: must be "aspeed,ast2500-xdma" or
> +			  "aspeed,ast2600-xdma"
> + - reg			: contains the address and size of the memory region
> +			  associated with the XDMA engine registers
> + - clocks		: clock specifier for the clock associated with the
> +			  XDMA engine
> + - resets		: reset specifier for the syscon reset associated with
> +			  the XDMA engine, and, for the AST2600, a second reset
> +			  associated with the PCI-E root complex
> + - reset-names		: required only for the AST2600; must be "dev, "rc"

Bit of a nit, but I find "root-complex" to not be so onerous as to shorten it to "rc".
Is there a need to be so economical? Contracting it makes it harder to read.
While we're here we might also expand "dev" to "device".

Thoughts?

Also you're missing the closing quote on "dev".

> + - interrupts-extended	: two interrupt cells; the first specifies the 
> global
> +			  interrupt for the XDMA engine and the second
> +			  specifies the PCI-E reset or PERST interrupt.
> + - aspeed,scu		: a phandle to the syscon node for the system control
> +			  unit of the SOC
> + - memory-region	: a phandle to the reserved memory region to be used 
> by
> +			  the XDMA engine for DMA operations

Might have been worth dropping the tags for this patch given the changes. I
feel Rob will welcome the switch to describing the memory with a phandle
to a reserved region, but removing his tag makes it easier for him to protest :)

Andrew
