Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0A2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT1obods"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgHDQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:10:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27069 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729637AbgHDQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596557365;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TOZI/E+BsRvqjNsmDqX3uA6qiqbuGX8gbX4xv94uh60=;
        b=JT1obodsIUNTqb7Z2WMc9d1WgVIAjniv3gnMDMwcCthN6ha/uhOe/1QLpeYRxXZka0FiLQ
        pg4Le06a+KYi3smAeoLFn4aCBQb0/Ietxydh0AfUe+RVN/IfFJbux+uANOdkJsxi+gfrGB
        gtp/wT9Qs8T3YQk4sQ+hTSpT2XG0cFY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-HdIYAyraMo6tqiDGrogJSg-1; Tue, 04 Aug 2020 12:09:23 -0400
X-MC-Unique: HdIYAyraMo6tqiDGrogJSg-1
Received: by mail-qv1-f72.google.com with SMTP id q4so21256965qvu.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=TOZI/E+BsRvqjNsmDqX3uA6qiqbuGX8gbX4xv94uh60=;
        b=LQVrmZd245SH9oXOEaSKM6E/gHQNTOVEUVJaZgXahtdVYpsiwRGx63ejVANsdhRNnY
         bXPMIptyIW/iE7BnCZgNekvCbALfVoQT0cPZxPpcpjWGUHzIJuSSMtXy4HS/tpFq5YqK
         /DLN8wPdtHREJf7xgSCZ67fnp++Fbp9WjnSfTwIq6XUn6ZQv6Q76hPcYbCbNOI4c1DUK
         y3MNQTP4GlOS1y6QFpbKvFxkBRn8MmLOEVAhoRqCNnm5MtyBzMv+7JbKDMOAnXqdB32x
         NMPYDTKReHViGTsl2+mMHw0QfpfbVaU+pSDK0YunJ4/ZoGkAAri8YKTzk8UHZf57SWUt
         rQWA==
X-Gm-Message-State: AOAM533CmKP3MVWthPWZqEk5zKoNklN3S9zzcPGQYZ0nLQ5ed+j1RHHt
        DO3O+mOexXNQEUA5JxK9xEF58CaU3TAoIfwap+3aSSTh5InJ0mmsM6AZcgx7O7dNVzzWGvSviOA
        ZfQkIbLrPYxAts8eEJ2rTmyl+
X-Received: by 2002:ad4:44f2:: with SMTP id p18mr22615982qvt.137.1596557362969;
        Tue, 04 Aug 2020 09:09:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg1lwYfJiUKDd9A7sOq/yUBkUA9nvcJIWHNxakoYrfXE1SbGb9q/0d7jCgk4FUC+Zw2TTYww==
X-Received: by 2002:ad4:44f2:: with SMTP id p18mr22615957qvt.137.1596557362713;
        Tue, 04 Aug 2020 09:09:22 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id h13sm24414469qtu.7.2020.08.04.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 09:09:21 -0700 (PDT)
Message-ID: <69429828565406cca0134b45f98b1879676f0371.camel@redhat.com>
Subject: Re: [PATCH] drm: fix drm_dp_mst_port refcount leaks in
 drm_dp_mst_allocate_vcpi
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Xin Xiong <xiongx18@fudan.edu.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>
Date:   Tue, 04 Aug 2020 12:09:20 -0400
In-Reply-To: <20200719154545.GA41231@xin-virtual-machine>
References: <20200719154545.GA41231@xin-virtual-machine>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heh, I remember this being mentioned to me way back but completely forgot to
ever go fix it. Thanks for the patch!

Reviewed-by: Lyude Paul <lyude@redhat.com>

This is missing a Fixes: tag though:

   Fixes: 1e797f556c61 ("drm/dp: Split drm_dp_mst_allocate_vcpi")
   Cc: <stable@vger.kernel.org> # v4.12+

So I will go ahead and add that, then push this to drm-misc-next-fixes. Thanks!

On Sun, 2020-07-19 at 23:45 +0800, Xin Xiong wrote:
> drm_dp_mst_allocate_vcpi() invokes
> drm_dp_mst_topology_get_port_validated(), which increases the refcount
> of the "port".
> 
> These reference counting issues take place in two exception handling
> paths separately. Either when “slots” is less than 0 or when
> drm_dp_init_vcpi() returns a negative value, the function forgets to
> reduce the refcnt increased drm_dp_mst_topology_get_port_validated(),
> which results in a refcount leak.
> 
> Fix these issues by pulling up the error handling when "slots" is less
> than 0, and calling drm_dp_mst_topology_put_port() before termination
> when drm_dp_init_vcpi() returns a negative value.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1e26b89628f9..97b48b531ec6 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4261,11 +4261,11 @@ bool drm_dp_mst_allocate_vcpi(struct
> drm_dp_mst_topology_mgr *mgr,
>  {
>  	int ret;
>  
> -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> -	if (!port)
> +	if (slots < 0)
>  		return false;
>  
> -	if (slots < 0)
> +	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> +	if (!port)
>  		return false;
>  
>  	if (port->vcpi.vcpi > 0) {
> @@ -4281,6 +4281,7 @@ bool drm_dp_mst_allocate_vcpi(struct
> drm_dp_mst_topology_mgr *mgr,
>  	if (ret) {
>  		DRM_DEBUG_KMS("failed to init vcpi slots=%d max=63 ret=%d\n",
>  			      DIV_ROUND_UP(pbn, mgr->pbn_div), ret);
> +		drm_dp_mst_topology_put_port(port);
>  		goto out;
>  	}
>  	DRM_DEBUG_KMS("initing vcpi for pbn=%d slots=%d\n",

