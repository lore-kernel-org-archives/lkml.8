Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1CBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10022070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF27Y2jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgGFRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:22:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729297AbgGFRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594056161;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lA+RHGhMqAzGJ1ls+U/TLssCbOeODGIQqdu8s4E0s7k=;
        b=dF27Y2jl2If/TWwaw5EABBliEgwuLn3fVekqKnxJqe1RUy/Bx2+vxMYaV2UBlXOoC5Qo7s
        5RMpEhHrJbEMqOZnIqczZQxCydZBd+FXbsrfTNvxLviDP7gJQZAF/LwIQboYo/OiAuz/UR
        AUZDXEob7BVxx+nDtKRMH5FcfsEgzNU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-G3fUyo0UOrmMfAtF3lKbIg-1; Mon, 06 Jul 2020 13:22:37 -0400
X-MC-Unique: G3fUyo0UOrmMfAtF3lKbIg-1
Received: by mail-qv1-f72.google.com with SMTP id j6so25304200qvl.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 10:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=lA+RHGhMqAzGJ1ls+U/TLssCbOeODGIQqdu8s4E0s7k=;
        b=cOeMsodU/64ID5K8QmGhEHQKmS9z/F/Ksumd5imZgG4LYh6xC9y+sUdhek3nfL6e+G
         oXuAz1ndxRj/WnQHBtOIAKKyBWsfYGjEHF14tuehdXxkOtvYnYLraa7AFWAVFeuGXGYk
         IMD6PU0aI4pBatmJsBOIEq6ayILdzCdlGZnmrLXa6jzKSpDNHo88I0dXfWDMguBVjayN
         LyVH5A3MJMezff17N2VknpcG6yfEjQUZx2Iauyzie3P2s/ooyaaYRHgNdHpky41Acfpf
         KL0kAvaUk/Ro/XvmSP2VamS1Qt7CV30NBknz3BTq1m31IxShvm9Elbuhitb/Xz3rnPxp
         So0Q==
X-Gm-Message-State: AOAM533a8ITIE/ZV4VJHV2V48eP68WUn6Dpv7kUFVzARoiPynNXAeNVL
        pl+n5zNCIVDxYR3Rq6hZ53ToKcZ6R9cGI7HibnH9DTvxd29kCWhKCr9tFRoADW7IDhYUInNHeEP
        hJXfSPtJeuZoXwfzN1pO1yBS7
X-Received: by 2002:a05:6214:72c:: with SMTP id c12mr45379495qvz.76.1594056157142;
        Mon, 06 Jul 2020 10:22:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqJSu168JvbM66NiFDodqfcshO3V3kFDEU5JUhxTjCQi+4k9Gi9OaaiE8zyZb4GGxaILrYKA==
X-Received: by 2002:a05:6214:72c:: with SMTP id c12mr45379478qvz.76.1594056156902;
        Mon, 06 Jul 2020 10:22:36 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f15sm18865654qka.120.2020.07.06.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:22:36 -0700 (PDT)
Message-ID: <2f68590f3352c6384efdf9838f16837d5990d1fe.camel@redhat.com>
Subject: Re: [PATCH] input/synaptics: enable InterTouch for ThinkPad X1E 1st
 gen
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     K900 <me@0upti.me>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gaurav Agrawal <agrawalgaurav@gnome.org>,
        Yussuf Khalil <dev@pp3345.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dennis Kadioglu <denk@eclipso.email>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Joe Perches <joe@perches.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jul 2020 13:22:35 -0400
In-Reply-To: <20200703143457.132373-1-me@0upti.me>
References: <20200703143457.132373-1-me@0upti.me>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW it's not placebo, it's why I always immediately notice when starting up a
new ThinkPad sample from lenovo if RMI4 is enabled or not :).

Anyway thank you for the patch, assuming you double-checked that clicking with
the clickpad still works (I made this mistake last time when trying to enable
this for the second generation X1 extreme):

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2020-07-03 at 17:34 +0300, K900 wrote:
> From: Ilya Katsnelson <me@0upti.me>
> 
> Tested on my own laptop, touchpad feels slightly more responsive with
> this on, though it might just be placebo.
> 
> Signed-off-by: Ilya Katsnelson <me@0upti.me>
> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 758dae8d6500..4b81b2d0fe06 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0093", /* T480 */
>  	"LEN0096", /* X280 */
>  	"LEN0097", /* X280 -> ALPS trackpoint */
> +	"LEN0099", /* X1 Extreme 1st */
>  	"LEN009b", /* T580 */
>  	"LEN200f", /* T450s */
>  	"LEN2044", /* L470  */

