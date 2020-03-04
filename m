Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC31FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F720732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQnbNT43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgCDO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:57:39 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53813 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbgCDO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:57:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE1E822028;
        Wed,  4 Mar 2020 09:57:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 04 Mar 2020 09:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=RpoQ1huL7zGeKqGEJkj7F3VzgOoyyCAyMSmbqbd6H
        S4=; b=mQnbNT43lD4XXySmgRBs3C67DgNJTge1eoqVieRmgF7BvRYJjQXHaWN9R
        lA4ML7Bf7BtK7HnWgDRnktq2D9xg1Z+0WJI6clkJS1IzatYbeupRUhMtII7tekjI
        QwZx0Iztetua6mF33vJGinR1nrtfLUAvUotmezvGodcOX71DfyBGAAgjgtPuEFkt
        rCVbESvaCPu2FqxkARKlw8KEo0JVwJe/waKzmd5Xy4bzoLYkJFviuXZ3f8X41cGd
        tt4wviy5vszvyxpq9yIK1DagxSoLjnvsKWcnQd1dDy85/JREIAtvPnbFpaaiuVqp
        J86u+f7vopMc0/RJRYyUnQqipop/A==
X-ME-Sender: <xms:4MFfXh0V-5D2tgqmioBOLZHFFHqZPekei0o-CuI72cANFqvln9n-Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtkedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheprfgvkhhk
    rgcugfhnsggvrhhguceophgvnhgsvghrghesihhkihdrfhhiqeenucfkphepkeelrddvje
    drfeefrddujeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphgvnhgsvghrghesihhkihdrfhhi
X-ME-Proxy: <xmx:4MFfXuN6YTaoejeOq48pwWMp_aNnDe9Y-7E5Ur6GrPZQ_FqEXMENGw>
    <xmx:4MFfXo1pT0cre-FUGwGRVk3v5PaS-fFgmrMJn_3esK6xfi9kJMYd4Q>
    <xmx:4MFfXl8cxxioV45GH5-O8uWUYJPWlXYSD-Ypnvh8CBDJGhcIGJLg_A>
    <xmx:4cFfXqeEP_cgNi7SOPQnMYGfnGHNvDHhO5O9t3wc-QfqjKWj4-v0lQ>
Received: from [192.168.1.105] (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF4563280063;
        Wed,  4 Mar 2020 09:57:34 -0500 (EST)
Subject: Re: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
To:     David Rientjes <rientjes@google.com>, Jann Horn <jannh@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>
References: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
 <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <de62c9f9-2274-8a28-22c9-3b704016e7d3@iki.fi>
Date:   Wed, 4 Mar 2020 16:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/20 3:26 AM, David Rientjes wrote:
> On Wed, 4 Mar 2020, Jann Horn wrote:
> 
>> Hi!
>>
>> FYI, I noticed that if you do something like the following as root,
>> the system blows up pretty quickly with error messages about stuff
>> like corrupt freelist pointers because SLUB actually allows root to
>> force a page order that is smaller than what is required to store a
>> single object:
>>
>>      echo 0 > /sys/kernel/slab/task_struct/order
>>
>> The other SLUB debugging options, like red_zone, also look kind of
>> suspicious with regards to races (either racing with other writes to
>> the SLUB debugging options, or with object allocations).
>>
> 
> Thanks for the report, Jann.  To address the most immediate issue,
> allowing a smaller order than allowed, I think we'd need something like
> this.
> 
> I can propose it as a formal patch if nobody has any alternate
> suggestions?
> ---
>   mm/slub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3598,7 +3598,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>   	 */
>   	size = ALIGN(size, s->align);
>   	s->size = size;
> -	if (forced_order >= 0)
> +	if (forced_order >= slab_order(size, 1, MAX_ORDER, 1))
>   		order = forced_order;
>   	else
>   		order = calculate_order(size);
> 

Reviewed-by: Pekka Enberg <penberg@iki.fi>
