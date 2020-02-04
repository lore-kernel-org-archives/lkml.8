Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C1C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6682F2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E67Ydxos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBDTAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:00:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727308AbgBDTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580842814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy3/WknZKcXoyQ8Ctf5hA6Q8cxOwETrXdgigIPAPWAo=;
        b=E67YdxosXkwiIEaiLLy5Ayg0/fsSWOsydm0KoiAucMlrVKVyJFzQdtyofiqcuGhEHe4OIx
        HnyZwQZlguA9RQXKd61XnflDm970zPYR7cXq4MQMkmiA2AxTB/oI7JwtGYuf8MKZWBjAB1
        KkWb372KB12RzXAACKS6I7Fl/vmWQVs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Y0V6Nn6dO2CSILuaKjBRhg-1; Tue, 04 Feb 2020 14:00:12 -0500
X-MC-Unique: Y0V6Nn6dO2CSILuaKjBRhg-1
Received: by mail-qt1-f197.google.com with SMTP id x8so13005990qtq.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=jy3/WknZKcXoyQ8Ctf5hA6Q8cxOwETrXdgigIPAPWAo=;
        b=AxZw+C68HW233s9Dpyv9DyZvL8amhOBksy8u1nNXQJf2KOFgIIddaMkhlY50aCydlC
         kLxp3blXeQKe6RTm2LepDBgxOJyTIbBlcvCiSlIBy+F4p6cZIZx8mH2gfVaybmFsC+8X
         Dak21kY4qojUaaRXKHu2p47IfMi+rwTgLS4DdnqM8C2wefxsk1Nw8JIYZmgpEIJ7pckk
         YMcdhEpOHUJOhbH0wHdc7fA+tGxE5buzDXKXGToXwwBSuSZFVabEc5k0P9ZCgkDF6yKz
         /pJTDgs5T+Yhi29R6CV0lESUHhHu6HjhwzMbvDdTWcybMHTe+Wa7U11uU7v0WA2C4JYx
         weIQ==
X-Gm-Message-State: APjAAAW6KmEZ99pniISVMMqHIomI7ubjH2T2WWQreu6UwIJfhomKJMMi
        GQVa67wwjszuioWm8t5ENXjgqLDP/N9Tew8rG16zfnVuhYxV9Q9ocPX1PPBpW28aZqKCM1bP0++
        /XBaIfgHcQ0QC6RFFLpy3/qmo
X-Received: by 2002:a37:4747:: with SMTP id u68mr8830703qka.12.1580842812068;
        Tue, 04 Feb 2020 11:00:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfVxWGoPKvyTdEclTSIxPTHIC/Jkx8ggqXgfUxWEJ0NCBN9c5eHNh8ijv7eERd26CVyo4s2Q==
X-Received: by 2002:a37:4747:: with SMTP id u68mr8830681qka.12.1580842811741;
        Tue, 04 Feb 2020 11:00:11 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id o7sm11551971qkd.119.2020.02.04.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:00:10 -0800 (PST)
Message-ID: <75b302aa739511b3cc2abf4360d5780a08e7c17a.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Check crc4 value while building sideband
 message
From:   Lyude Paul <lyude@redhat.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com
Date:   Tue, 04 Feb 2020 14:00:09 -0500
In-Reply-To: <20200203121620.9002-1-benjamin.gaignard@st.com>
References: <20200203121620.9002-1-benjamin.gaignard@st.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Mon, 2020-02-03 at 13:16 +0100, Benjamin Gaignard wrote:
> Check that computed crc value is matching the one encoded in the message.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> CC: lyude@redhat.com
> CC: airlied@linux.ie
> CC: jani.nikula@linux.intel.com
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 822d2f177f90..eee899d6742b 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -736,6 +736,10 @@ static bool drm_dp_sideband_msg_build(struct
> drm_dp_sideband_msg_rx *msg,
>  	if (msg->curchunk_idx >= msg->curchunk_len) {
>  		/* do CRC */
>  		crc4 = drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_len -
> 1);
> +		if (crc4 != msg->chunk[msg->curchunk_len - 1])
> +			print_hex_dump(KERN_DEBUG, "wrong crc",
> +				       DUMP_PREFIX_NONE, 16, 1,
> +				       msg->chunk,  msg->curchunk_len, false);
>  		/* copy chunk into bigger msg */
>  		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len -
> 1);
>  		msg->curlen += msg->curchunk_len - 1;
-- 
Cheers,
	Lyude Paul

