Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB6CC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FAA2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9lUBZom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgG0Rse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:48:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21115 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728532AbgG0Rse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595872111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvywyydKtvU7UWO2R7W9XiQvniUsbDBtaqqTLrDrpqU=;
        b=f9lUBZomXUGMGDG6ao2klCKLFwW8AXxhHUO3P1ueXlMDyfCQb/uxLPnVLyYS2E5LIxJRIj
        suGeBtvwllR5yPWFdOebd1BxB6ZVspuVGw++UbQd+fTfMNMS+7ksfsu8hlhzhGhsJVy8M7
        41uwOeM21Y2JIZhpQLNjbbnCT8Vwk0g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-cKD1u02UMO60Hc4i1UwXXQ-1; Mon, 27 Jul 2020 13:48:22 -0400
X-MC-Unique: cKD1u02UMO60Hc4i1UwXXQ-1
Received: by mail-qv1-f69.google.com with SMTP id g17so11715522qvw.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=OvywyydKtvU7UWO2R7W9XiQvniUsbDBtaqqTLrDrpqU=;
        b=BuJLQ0eGoa84O8KGQZybHTDT1I4F8jEjPZMMu+ZJ5BsoiVKB8ykHPVo3L6wGNzwAQr
         BPFKQ9QzgDJ1NVZAK6Z9qmtY93Ul9v8i8ubMLTmFVWJPO1eF9Y8dwbA/FVEGVV6qgWRL
         VTz9l8GWYVjq2W3Fl8FkAfAJmlcYfcygAmVYPqHLyIMQExXrtuZ1kWH3velApNNgKfbL
         VQjX724byUZQD8uWVkEKLf91LgSQeJQ9qIXtryk6xDZ3HdgpEQK43bxuroOYrCF3Hnt9
         WNrwi+rPedkZykRCzXK8foXdjeyiLiBg43TGPV/IHjQuIRTzCKK6SdR2uDHzZJDtQSYL
         nnMg==
X-Gm-Message-State: AOAM530b6O+was5pEIXn8oLMDSFFRzPlNoVXGsTEVY6u119n/XjQ5Mol
        ccIuSEzAW3Qg5lG87yRrcZYu/iHONn2rmK/Lr435hFyWnxWuzej1xE9e248LHaB96xNbFjmnyeC
        BLeOXAvWEMUYvHRZFSxZ3UYSt
X-Received: by 2002:ac8:3772:: with SMTP id p47mr22041840qtb.355.1595872101646;
        Mon, 27 Jul 2020 10:48:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxAlqzrvxdidWWYd7oWy2hAuX08PzCqqlLmZCnl/DeCg+vSX3fT2kkWs8kyW0q41M/xVmDwA==
X-Received: by 2002:ac8:3772:: with SMTP id p47mr22041806qtb.355.1595872101165;
        Mon, 27 Jul 2020 10:48:21 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id h13sm109535qtu.7.2020.07.27.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:48:20 -0700 (PDT)
Message-ID: <27ca01615cf456b08762003192d825a0f558d86e.camel@redhat.com>
Subject: Re: [PATCH -next] crc:Fix build errors
From:   Lyude Paul <lyude@redhat.com>
To:     Peng Wu <wupeng58@huawei.com>, bskeggs@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, airlied@gmail.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 13:48:19 -0400
In-Reply-To: <1595822418-34124-1-git-send-email-wupeng58@huawei.com>
References: <1595822418-34124-1-git-send-email-wupeng58@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I actually already sent a patch for this:

https://patchwork.freedesktop.org/patch/378202/

I'm guessing it hasn't gotten picked up upstream yet?

On Mon, 2020-07-27 at 12:00 +0800, Peng Wu wrote:
> If CONFIG_DRM_NOUVEAU=y,the following errors
> are seen while building crc.h.
> 
> In file included from
> /scratch/linux/drivers/gpu/drm/nouveau/nouveau_display.c:47:
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
> ‘nv50_head_crc_late_register’:
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:109:47: error:
> parameter name omitted
>  static inline int nv50_head_crc_late_register(struct nv50_head *) {}
>                                                ^~~~~~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:109:54: warning: no
> return statement in function returning non-void [-Wreturn-type]
>  static inline int nv50_head_crc_late_register(struct nv50_head *) {}
>                                                       ^~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
> ‘nv50_crc_handle_vblank’:
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:111:57: warning:
> ‘return’ with a value, in function returning void
>  nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
>                                                          ^
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:111:1: note: declared
> here
>  nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
>  ^~~~~~~~~~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
> ‘nv50_crc_atomic_check_head’:
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:114:28: error:
> parameter name omitted
>  nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
>                             ^~~~~~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:114:48: error:
> parameter name omitted
>  nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
>                                                 ^~~~~~~~~~~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:115:7: error:
> parameter name omitted
>        struct nv50_head_atom *) {}
>        ^~~~~~~~~~~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:115:14: warning: no
> return statement in function returning non-void [-Wreturn-type]
>        struct nv50_head_atom *) {}
>               ^~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
> ‘nv50_crc_atomic_stop_reporting’:
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:118:32: error:
> parameter name omitted
>  nv50_crc_atomic_stop_reporting(struct drm_atomic_state *) {}
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
> ‘nv50_crc_atomic_init_notifier_contexts’:
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:120:40: error:
> parameter name omitted
>  nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *) {}
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
> ‘nv50_crc_atomic_release_notifier_contexts’:
> /scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:122:43: error:
> parameter name omitted
> 
> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/crc.h | 44 +++++++++++++++++------------
> -----
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.h
> b/drivers/gpu/drm/nouveau/dispnv50/crc.h
> index 4bc59e7..3da16cd 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/crc.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/crc.h
> @@ -76,22 +76,22 @@ struct nv50_crc {
>  };
>  
>  void nv50_crc_init(struct drm_device *dev);
> -int nv50_head_crc_late_register(struct nv50_head *);
> +int nv50_head_crc_late_register(struct nv50_head *head);
>  void nv50_crc_handle_vblank(struct nv50_head *head);
>  
> -int nv50_crc_verify_source(struct drm_crtc *, const char *, size_t *);
> -const char *const *nv50_crc_get_sources(struct drm_crtc *, size_t *);
> -int nv50_crc_set_source(struct drm_crtc *, const char *);
> +int nv50_crc_verify_source(struct drm_crtc *crtc, const char *source_name,
> size_t *values_cnt);
> +const char *const *nv50_crc_get_sources(struct drm_crtc *crtc, size_t
> *count);
> +int nv50_crc_set_source(struct drm_crtc *crtc, const char *source_str);
>  
> -int nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
> -			       struct nv50_head_atom *);
> +int nv50_crc_atomic_check_head(struct nv50_head *head, struct
> nv50_head_atom *asyh,
> +			       struct nv50_head_atom *armh);
>  void nv50_crc_atomic_check_outp(struct nv50_atom *atom);
> -void nv50_crc_atomic_stop_reporting(struct drm_atomic_state *);
> -void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *);
> -void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *);
> -void nv50_crc_atomic_start_reporting(struct drm_atomic_state *);
> -void nv50_crc_atomic_set(struct nv50_head *, struct nv50_head_atom *);
> -void nv50_crc_atomic_clr(struct nv50_head *);
> +void nv50_crc_atomic_stop_reporting(struct drm_atomic_state *state);
> +void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state
> *state);
> +void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state
> *state);
> +void nv50_crc_atomic_start_reporting(struct drm_atomic_state *state);
> +void nv50_crc_atomic_set(struct nv50_head *head, struct nv50_head_atom
> *asyh);
> +void nv50_crc_atomic_clr(struct nv50_head *head);
>  
>  extern const struct nv50_crc_func crc907d;
>  extern const struct nv50_crc_func crcc37d;
> @@ -106,26 +106,26 @@ struct nv50_crc_atom {};
>  #define nv50_crc_set_source NULL
>  
>  static inline void nv50_crc_init(struct drm_device *dev) {}
> -static inline int nv50_head_crc_late_register(struct nv50_head *) {}
> +static inline int nv50_head_crc_late_register(struct nv50_head *head) {
> return 0; }
>  static inline void
> -nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
> +nv50_crc_handle_vblank(struct nv50_head *head) {}
>  
>  static inline int
> -nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
> -			   struct nv50_head_atom *) {}
> +nv50_crc_atomic_check_head(struct nv50_head *head, struct nv50_head_atom
> *asyh,
> +			   struct nv50_head_atom *armh) { return 0; }
>  static inline void nv50_crc_atomic_check_outp(struct nv50_atom *atom) {}
>  static inline void
> -nv50_crc_atomic_stop_reporting(struct drm_atomic_state *) {}
> +nv50_crc_atomic_stop_reporting(struct drm_atomic_state *state) {}
>  static inline void
> -nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *) {}
> +nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *state) {}
>  static inline void
> -nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *) {}
> +nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *state)
> {}
>  static inline void
> -nv50_crc_atomic_start_reporting(struct drm_atomic_state *) {}
> +nv50_crc_atomic_start_reporting(struct drm_atomic_state *state) {}
>  static inline void
> -nv50_crc_atomic_set(struct nv50_head *, struct nv50_head_atom *) {}
> +nv50_crc_atomic_set(struct nv50_head *head, struct nv50_head_atom *asyh) {}
>  static inline void
> -nv50_crc_atomic_clr(struct nv50_head *) {}
> +nv50_crc_atomic_clr(struct nv50_head *head) {}
>  
>  #endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
>  #endif /* !__NV50_CRC_H__ */
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

