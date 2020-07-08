Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53B520772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="DErv8HYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jR5+jUM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgGHNGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:06:35 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47585 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728677AbgGHNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:06:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 04C01B36;
        Wed,  8 Jul 2020 09:06:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 08 Jul 2020 09:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=5euriczBNHgvO+QkGvKaxx3LEAQ
        +A5gmsFTqDV9t2VE=; b=DErv8HYtIB09+qRx+5eA9nK5WTLXeHlmaABOwwhU3aJ
        5rYe0RexKQeWmUiKZJihNZB8z4HqoOThjXFd0HmLQeDGjuopV1hbzD0ao9ReyLg6
        wGUASy/OAUzeaDWQMHYafJExhXQJ8zWEV9nodvpntTFRgVnV/bVvm/b1jh8DiV3c
        Fn8psVEM8GabfsckGLuDQD+uMO16kgM3Vq6gsoyFV4oCZ2grV41EIIc8ajTG6+Is
        fpQhRQs7l7kG7+rlDnGvI/jezv1P94WJkdgmCjGACVpzBXU0jvpo+sjhlaxiW7hj
        C5lrxMdMtgi0QYnbJqopR9HVYTE5KOpZFyw9e7cfYqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5euric
        zBNHgvO+QkGvKaxx3LEAQ+A5gmsFTqDV9t2VE=; b=jR5+jUM1p7trulT+NtIoSG
        RIV0hjnnqg08/swNFfdU/fz6TZmx6xGAIewN7rTkT9qRPwK1jbwmhwp0/qLXIMrX
        bjPg3xHKciC8Y9/njClzJBqZxmss2Ra5tf9WuyCZym/PLFqiPQRg2LLlfAHtJ/d8
        a6DCasahhqk0dQn3H0ezDlQjY+DCW5HfTgpDtPWVIANdwOZQnNJ4J4+qTYa0qzQy
        c8jO4HvIQSLCakg/gVHB1LrPmw11KWvytwUqi+eZcVtDAA7cEDzCoPFG7xkOVf7O
        cUgqRSepwsB/OQXa/58c++vB7xYUmZtwe4DWnCwPJo8tGqnGBW5+0r/44Kgbs+qw
        ==
X-ME-Sender: <xms:2MQFXxgEzegge4Avo9LDEsQoj7OXbJszPiUfBa2rvRQ9EPVRjkRxuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepvdevgfevudfhledukeefteelleeghfffkeeludehtedu
    gedvtddttefhtdegleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghlshgrqd
    hprhhojhgvtghtrdhorhhgnecukfhppedukedtrddvfeehrdefrdehgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2MQFX2BqDi-iOAlvT-5Fspgs0I0_jPB7jfXEHhNCCMaciscyiXYG4g>
    <xmx:2MQFXxHjlUQ0HilrIBG-bhPF40ODlwe4l-HsjdWLhDfT0PLIuKIi3Q>
    <xmx:2MQFX2RgYjTWc-ic4kwT4QvjNtzHzQcvowUYGvhQIWTbCApeUM_hKQ>
    <xmx:2MQFX58lmYflQejM40MiUsjJNEVIBVFIpi4lzNmdyqSHVe20Z0Fhlw>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp [180.235.3.54])
        by mail.messagingengine.com (Postfix) with ESMTPA id 83EE33280071;
        Wed,  8 Jul 2020 09:06:30 -0400 (EDT)
Date:   Wed, 8 Jul 2020 22:06:28 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        kernel-hardening@lists.openwall.com,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] firewire: Remove function callback casts
Message-ID: <20200708130628.GA21753@workstation>
Mail-Followup-To: Oscar Carter <oscar.carter@gmx.com>,
        Kees Cook <keescook@chromium.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        kernel-hardening@lists.openwall.com,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20200530090839.7895-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530090839.7895-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry to be late but I was stuck at my work for ALSA control
service programs for audio and music units on IEEE 1394 bus[1].

On Sat, May 30, 2020 at 11:08:39AM +0200, Oscar Carter wrote:
> In 1394 OHCI specification, Isochronous Receive DMA context has several
> modes. One of mode is 'BufferFill' and Linux FireWire stack uses it to
> receive isochronous packets for multiple isochronous channel as
> FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL.
> 
> The mode is not used by in-kernel driver, while it's available for
> userspace. The character device driver in firewire-core includes
> cast of function callback for the mode since the type of callback
> function is different from the other modes. The case is inconvenient
> to effort of Control Flow Integrity builds due to
> -Wcast-function-type warning.
> 
> This commit removes the cast. A static helper function is newly added
> to initialize isochronous context for the mode. The helper function
> arranges isochronous context to assign specific callback function
> after call of existent kernel API. It's noticeable that the number of
> isochronous channel, speed, and the size of header are not required for
> the mode. The helper function is used for the mode by character device
> driver instead of direct call of existent kernel API.
> 
> The same goal can be achieved (in the ioctl_create_iso_context function)
> without this helper function as follows:
> - Call the fw_iso_context_create function passing NULL to the callback
>   parameter.
> - Then setting the context->callback.sc or context->callback.mc
>   variables based on the a->type value.
> 
> However using the helper function created in this patch makes code more
> clear and declarative. This way avoid the call to a function with one
> purpose to achieved another one.
> 
> Co-developed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Co-developed-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
> Hi,
> 
> this is another proposal to achieved the goal of remove function callback
> cast start by me with the first [1] and second [2] versions, and followed
> by the work of Takashi Sakamoto with his first [3] and second [4] versions,
> and the code of Stefan Richter [5].
> 
> The purpose of this third version is to put together all the work done
> until now following the comments of all reviewed patches.
> 
> I've added the "Co-developed-by" and "Signed-off-by" tags to give credit to
> Takashi Sakamoto and Stefan Richter if there are no objections.
 
In my opinion, it's no need to add my and Stefan's sign-off tag to patch
in which you firstly wrote even if it includes ideas from the others ;)

> Changelog v1->v2
> -Set explicity to NULL the "ctx->callback.sc" variable and return an error
>  code in "fw_iso_context_create" function if both callback parameters are
>  NULL as Lev R. Oshvang suggested.
> -Modify the commit changelog accordingly.
> 
> Changelog v2->v3
> -Put togeher all the work done in different patches by different authors.
> -Modify the previous work following the comments in the reviewed patches.
> 
> [1] https://lore.kernel.org/lkml/20200516173934.31527-1-oscar.carter@gmx.com/
> [2] https://lore.kernel.org/lkml/20200519173425.4724-1-oscar.carter@gmx.com/
> [3] https://lore.kernel.org/lkml/20200520064726.31838-1-o-takashi@sakamocchi.jp/
> [4] https://lore.kernel.org/lkml/20200524132048.243223-1-o-takashi@sakamocchi.jp/
> [5] https://lore.kernel.org/lkml/20200525015532.0055f9df@kant/
> 
>  drivers/firewire/core-cdev.c | 32 ++++++++++++++++++++++++++------
>  include/linux/firewire.h     | 11 +++++++----
>  2 files changed, 33 insertions(+), 10 deletions(-)

Anyway this patch looks good to me. I test this patch with libhinoko and
find no regression.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Testeb-by: Takashi Sakamoto<o-takashi@sakamocchi.jp>


[1] [RFT] ALSA control service programs for Digidesign Digi 002/003 family
and Tascam FireWire series
https://mailman.alsa-project.org/pipermail/alsa-devel/2020-July/170331.html

Thanks

Takashi Sakamoto
