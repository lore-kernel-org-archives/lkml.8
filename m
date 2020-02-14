Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AA4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACE42168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSB0ODoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394768AbgBNRi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:38:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389979AbgBNRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581701933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkNDcKP8WfZzEgb1FMJ+6cGSN8qV8eyUCjq3RWyKemo=;
        b=eSB0ODoXEkySTCD+lfr3FbRId4esqRa0hbDjBTd3vy7yhTlUFsoKcTqpB6i160ghYS/QoF
        eyNCOloW7UxsaZV5SVf8HwKf+JQOFUNFPfF1u/RXrKst62axFSdh4q6Jg+aPDXa2W92T/F
        PUPDDaX+CCoPEkVR5DQJK9RYiqWfHB4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-87JngVzSMTiWpXx8ab4HmQ-1; Fri, 14 Feb 2020 12:38:47 -0500
X-MC-Unique: 87JngVzSMTiWpXx8ab4HmQ-1
Received: by mail-qv1-f72.google.com with SMTP id dc2so6151846qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=LkNDcKP8WfZzEgb1FMJ+6cGSN8qV8eyUCjq3RWyKemo=;
        b=NV6NVaq1wPc2CxWAkvEE0ZykIRoRdk5SF6hQrGJR3V60AU3gWjgwNMUsp9+Sciq7hH
         PLcZOvpUKXn86fFKOSge/76pM5Zo1+WkUeo+b1lzQOtF8jBvyg4OlqF0+n7RgaCGOWXN
         GM/f/F4l3wOqS+veaoMaITx8SsZDEWBWmmTuQOQ5/XMHFCLHcD/ee8+v5QTKi05jEEZF
         M+zxEe7a7g+U64jS9ctUU9usDFFD48KpBa2kFmpsAtp3HmsQQygI0HYK108EOdIq/mGU
         Drt3B3qU6kiKtRyzz0fRFJl/NZMrVny36a/H+O+W+s6xVnhB1buPV+X3VKkQaR2TLMDY
         pU1g==
X-Gm-Message-State: APjAAAULzzGoyLh0oxSKZ0+ViyXQyKV/xIbrbcFISbh+qiRkCrcsQf2G
        XhzOKhVJXZnF5lk8bfjsH/1xS1bRxO5PJw0Lvrw+ZjJjSafZ2XP/WdvIiy+kaQ8s8PU/YcKyAB9
        lkbwVetBwswhjtgq5iJBG+3MD
X-Received: by 2002:a37:6c45:: with SMTP id h66mr3584212qkc.360.1581701926139;
        Fri, 14 Feb 2020 09:38:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYO2nGgtY9wiWp/sFhAYQ2hS7P1MCs1W6nqmfBghB9oJYriPY8kbNaYKdzQGMJrePguHQxGw==
X-Received: by 2002:a37:6c45:: with SMTP id h66mr3584200qkc.360.1581701925875;
        Fri, 14 Feb 2020 09:38:45 -0800 (PST)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f32sm3801569qtk.89.2020.02.14.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:38:45 -0800 (PST)
Message-ID: <6fa270d0d395d87c41b7d0a9ec87eadea5398eb6.camel@redhat.com>
Subject: Re: [PATCH 4.9 087/116] drm/dp_mst: Remove VCPI while disabling
 topology mgr
From:   Lyude Paul <lyude@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Wayne Lin <Wayne.Lin@amd.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 14 Feb 2020 12:38:44 -0500
In-Reply-To: <20200213151916.429278047@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
         <20200213151916.429278047@linuxfoundation.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should drop this and the versions for all of the other kernel versions.
This patch later got reverted in a86675968e2300fb567994459da3dbc4cd1b322a in
drm-misc/drm-misc-next, and then replaced with a proper fix in
8732fe46b20c951493bfc4dba0ad08efdf41de81

On Thu, 2020-02-13 at 07:20 -0800, Greg Kroah-Hartman wrote:
> From: Wayne Lin <Wayne.Lin@amd.com>
> 
> [ Upstream commit 64e62bdf04ab8529f45ed0a85122c703035dec3a ]
> 
> [Why]
> 
> This patch is trying to address the issue observed when hotplug DP
> daisy chain monitors.
> 
> e.g.
> src-mstb-mstb-sst -> src (unplug) mstb-mstb-sst -> src-mstb-mstb-sst
> (plug in again)
> 
> Once unplug a DP MST capable device, driver will call
> drm_dp_mst_topology_mgr_set_mst() to disable MST. In this function,
> it cleans data of topology manager while disabling mst_state. However,
> it doesn't clean up the proposed_vcpis of topology manager.
> If proposed_vcpi is not reset, once plug in MST daisy chain monitors
> later, code will fail at checking port validation while trying to
> allocate payloads.
> 
> When MST capable device is plugged in again and try to allocate
> payloads by calling drm_dp_update_payload_part1(), this
> function will iterate over all proposed virtual channels to see if
> any proposed VCPI's num_slots is greater than 0. If any proposed
> VCPI's num_slots is greater than 0 and the port which the
> specific virtual channel directed to is not in the topology, code then
> fails at the port validation. Since there are stale VCPI allocations
> from the previous topology enablement in proposed_vcpi[], code will fail
> at port validation and reurn EINVAL.
> 
> [How]
> 
> Clean up the data of stale proposed_vcpi[] and reset mgr->proposed_vcpis
> to NULL while disabling mst in drm_dp_mst_topology_mgr_set_mst().
> 
> Changes since v1:
> *Add on more details in commit message to describe the issue which the
> patch is trying to fix
> 
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> [added cc to stable]
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Link: 
> https://patchwork.freedesktop.org/patch/msgid/20191205090043.7580-1-Wayne.Lin@amd.com
> Cc: <stable@vger.kernel.org> # v3.17+
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 17aedaaf364c1..8b1d497b7f99f 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2042,6 +2042,7 @@ static bool drm_dp_get_vc_payload_bw(int dp_link_bw,
>  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr,
> bool mst_state)
>  {
>  	int ret = 0;
> +	int i = 0;
>  	struct drm_dp_mst_branch *mstb = NULL;
>  
>  	mutex_lock(&mgr->lock);
> @@ -2106,10 +2107,21 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> drm_dp_mst_topology_mgr *mgr, bool ms
>  		/* this can fail if the device is gone */
>  		drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL, 0);
>  		ret = 0;
> +		mutex_lock(&mgr->payload_lock);
>  		memset(mgr->payloads, 0, mgr->max_payloads * sizeof(struct
> drm_dp_payload));
>  		mgr->payload_mask = 0;
>  		set_bit(0, &mgr->payload_mask);
> +		for (i = 0; i < mgr->max_payloads; i++) {
> +			struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
> +
> +			if (vcpi) {
> +				vcpi->vcpi = 0;
> +				vcpi->num_slots = 0;
> +			}
> +			mgr->proposed_vcpis[i] = NULL;
> +		}
>  		mgr->vcpi_mask = 0;
> +		mutex_unlock(&mgr->payload_lock);
>  	}
>  
>  out_unlock:
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

