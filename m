Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64BDC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABCE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="nuEayf3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9jFKAkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgAQAJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:09:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54941 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgAQAJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:09:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D3381220A9;
        Thu, 16 Jan 2020 19:09:54 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 16 Jan 2020 19:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=4y285Mn+nF0hNakty6Ped9kTCwL0aOB
        qAFumkJVyMi4=; b=nuEayf3B1FaV744Uv9IaAHYAg2yJ2lIc+Zw2glZ04dF89A8
        RL6SXwX08LExha9D01aXgbmCVNPJgKH7yl/UWQlo1v4ePBU3jYA/kU0vtS3ONL46
        ztID4DuVaOKc+DG0tdNQVWrTrC6+Zi2zQ+NzWxaVp4/jNv5yDUnakMw6l9jmIrro
        BZb4pXLfzUUMPyfuJKjJOaBnoqUwb4juTiyQJFw5EN1hnE1oTt1RDp0c9k/6kbtJ
        6HypW5wwK5Ha/HzfUcozpJeBafV2cO99gnZmVoXsdfkFQPnSVPKl3/RiPSpXtAu7
        IFugnJMJIleynsF9OzYOuGklT1xF8iuJu19PnmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4y285M
        n+nF0hNakty6Ped9kTCwL0aOBqAFumkJVyMi4=; b=K9jFKAkEM0xhlNwIb99nsw
        iJWmDSEEumZc0x27W3teLKnVx2i8dr9eYKXJKoh4UV68IKmHIIEtFJc+YlR4gaNe
        YFq/8IBLCCqFm/7z23Iae2TUF1tQcU84MWuci2MPt5eXlZilbaZ8ajjpJfiUngPN
        jPpNmlRr3UxdF8h+dr5CVIK6G0g3DwIKJ73U8DtxGOIGAqHSo6O7ew2FuXUAc3uy
        SkWHosKkpdYTsyCCjmaECod4T7Efes++9dDopUfqFWDjSnSC701vJadCUB4V1F8Q
        uxInZRHHEd5obM/cG7lT1idLd5a0Mn4CWgQuRT0zCV++MjwBQ/MI6iSzsDPEjwBg
        ==
X-ME-Sender: <xms:UvsgXgi5hyaYPqtHY1Yc2vqXQhl7YnnJYdL0ncspUwNa1engiOcywQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:UvsgXgsoLAnSNiH2i2f9_S9wZYbbJKXwvdjCqhoCr8AgzhfbblMlgQ>
    <xmx:UvsgXt6EiU0I_kw1fOmgHS91SqFN-NAfy60ssAfuiSNG35jnM3dcCw>
    <xmx:UvsgXipJZ2xQc7-G68_q3lvJOES4VMSRaMlDLOZXZO2xP4JEKrbNiQ>
    <xmx:UvsgXgTwou8eJ5pcuBxtyObp2YdOQAZrd1Ir-1TiTKtv5cDW7uT_Kw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E76C1E00A2; Thu, 16 Jan 2020 19:09:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <3e28410b-805b-4599-88d1-98aa39c926d5@www.fastmail.com>
In-Reply-To: <1579123790-6894-8-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-8-git-send-email-eajames@linux.ibm.com>
Date:   Fri, 17 Jan 2020 10:39:33 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v6 07/12] soc: aspeed: xdma: Add user interface
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jan 2020, at 07:59, Eddie James wrote:
> This commits adds a miscdevice to provide a user interface to the XDMA
> engine. The interface provides the write operation to start DMA
> operations. The DMA parameters are passed as the data to the write call.
> The actual data to transfer is NOT passed through write. Note that both
> directions of DMA operation are accomplished through the write command;
> BMC to host and host to BMC.
> 
> The XDMA driver reserves an area of physical memory for DMA operations,
> as the XDMA engine is restricted to accessing certain physical memory
> areas on some platforms. This memory forms a pool from which users can
> allocate pages for their usage with calls to mmap. The space allocated
> by a client will be the space used in the DMA operation. For an
> "upstream" (BMC to host) operation, the data in the client's area will
> be transferred to the host. For a "downstream" (host to BMC) operation,
> the host data will be placed in the client's memory area.
> 
> Poll is also provided in order to determine when the DMA operation is
> complete for non-blocking IO.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
