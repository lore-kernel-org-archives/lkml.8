Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A46C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E079220882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KejOEjjs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yo2ir058"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDTAHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 20:07:47 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50323 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgDTAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:07:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DE8E8458;
        Sun, 19 Apr 2020 20:07:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 19 Apr 2020 20:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=t
        CGTCYij53Y5eRWvqAR4daOqpsfyW4OV2+tWac0W1G8=; b=KejOEjjsoNTf14bWi
        vLaOpZjumX3BPHpQCkiU0wtvX5qKDm4vc7++9KwM2cuc2QCGOQ7DjST+JCdxGYqs
        PEmca1Eu8fWAGFG/UCuuuPKa//mbUmu2D4QbYj0v9EnVONUKesYl5Ms1k2yRPyl2
        mTOOcJM+r4qMIlj/X/YIfyWSDH5PhyPWlv867tpz+qyn5xsgZtgPFln5Xyq+J3A5
        6Q00vKPEGu1EmsO3x1cmD0RFqHu7m73ZkxLuPD8u2PCmoUWzKsULlWwBCxcoKujA
        kGr8Z7PF7jOHM/bFVR92n1GarIe7HHcabgl5Yf0nY9qy9G+HeSjrSyITx2R5Z243
        pjUMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=tCGTCYij53Y5eRWvqAR4daOqpsfyW4OV2+tWac0W1
        G8=; b=yo2ir058chFYdlqtw0lUXOad3CJ/PL8atK138wHdxnOfpwCXbNmDhozHs
        LY5qhJFdg8ikcssEI4YoUFrTk7zbzJ8Lwg4EU8YBs9lB4AxxtZVSjPoRNjA0ejqX
        4qWx+9/giz+xHNdbv7vP1TMGWvYQUGui63gtINm+qTU9HDwN7/8OWLCtd+hbjjxX
        Q4vKKEZ55d+QdVMP62BEd8P4D2XvcW3bjhhagCCdVuDFGuw0Hes/RfLUJ6DPV4J/
        XO2rPXG5srw+k6V6qFH0AFMxvxhzFesNrg4RwrH6n6nzP/824VVWlTtUHhfriMfl
        /vZFsGSAqfxuLqT2bHwDB+HDgRc9g==
X-ME-Sender: <xms:0OecXuz7spCTHmHnJVpVKE2LhbD84TqW64mh93IHfW4OR81Cyk2THQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgedvgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:0OecXjwujIsUQMqkiIl1v2S1rR8j8UXHaumGgCQB2-_VZB4jJHC2mA>
    <xmx:0OecXknEPDasFDMyN8WzObW7UNJAAMFKDK29FrWcCxRtAQB8g4kH2Q>
    <xmx:0OecXsFzAmBaMuIGolObgGJnG8r7Ybh9SK71rvuvUXcj2PlN9ckvDw>
    <xmx:0OecXkvV4qxDKwpnpGsEvk6oBn4mdBb7WxVcxu1Ax0rSZ2QL2NQywg>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 08ECF3280065;
        Sun, 19 Apr 2020 20:07:44 -0400 (EDT)
Subject: Re: [PATCH v4 2/2] firmware: google: Expose coreboot tables over
 sysfs
To:     patrick.rudolph@9elements.com, linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
 <20200407082923.2001556-3-patrick.rudolph@9elements.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0ad55572-c889-cb0d-7f76-4097b381d4a0@sholland.org>
Date:   Sun, 19 Apr 2020 19:07:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407082923.2001556-3-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 3:29 AM, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Make all coreboot table entries available to userland. This is useful for
> tools that are currently using /dev/mem.
> 
> Besides the tag and size also expose the raw table data itself.
> 
> Update the ABI documentation to explain the new sysfs interface.
> 
> Tools can easily scan for the right coreboot table by reading
> /sys/bus/coreboot/devices/coreboot*/attributes/id
> The binary table data can then be read from
> /sys/bus/coreboot/devices/coreboot*/attributes/data
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

Cheers,
Samuel
