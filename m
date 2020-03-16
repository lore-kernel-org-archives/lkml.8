Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A7EC3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FFF206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RRRaKsZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgCPJyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:54:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42422 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgCPJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:54:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so20337568wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zSC6oywTzGEcsERVAal6BgbGEUVylhtga/Ve0wR+QRc=;
        b=RRRaKsZunyqDMQVwDP9D6Nu+AmSqGr/H4565L2bBRQhll0tBF9qebcJGYMlHrB2gds
         h9Y1J9KgmKQy8VpoQ4FMYiIfSnhwuft5cTK+obEJAswssCVZ+kYxv6DWBlz4i07R9FCM
         6JIwhFd4Ew3+W57/EHzL40CxmKzFKvwJCHbeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=zSC6oywTzGEcsERVAal6BgbGEUVylhtga/Ve0wR+QRc=;
        b=ZvUXgJ5V9DTPhRbei7cs/wKNr0U3IgWH1uxF0AsMxvFZraFuqpGxOGUuHEGavo/3+u
         P/jIGu8ORdunbiURxA6JEEOOIIkEerm7DagKkd7NOe0wzg2Xn9AuUcyhm4LCL3wCoK7W
         wawV1KzC2Mv+9sAcoj3XzI7qRpo0nUWXTorSclC0UTgGa9/ZqqgS5hO5QAZc8QpBeaYu
         ixjzxSv+G+xuJ6HK+tiwi1nvBIZhw9s52CbwMcab06oVuwaBcGRfL8eW0nrwiFkFGa0p
         Vr3/xRSxy+TUZzW//m8ef4Fucyv/AGH6UrhIg7i8URB164WFUVi/C8aoreaowNqiwB38
         3eGA==
X-Gm-Message-State: ANhLgQ2cF2gYDIzskomPcUJdjeNFzujM+ionS0dI8F0hJc802n4AsfHq
        7lJp7VLSWfWhgKWI37FYPee38g==
X-Google-Smtp-Source: ADFU+vurrbpA/epmkOYU7s8Kn94q0u3aqT2RnagU7067QxIDTERhlXeUzcuowJp9G/4OzldwVyDHEg==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr1681118wrq.178.1584352459668;
        Mon, 16 Mar 2020 02:54:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a186sm29813829wmh.33.2020.03.16.02.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:54:18 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:54:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/edid: Distribute switch variables for
 initialization
Message-ID: <20200316095417.GJ2363188@phenom.ffwll.local>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <202003060930.DDCCB6659@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003060930.DDCCB6659@keescook>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:32:13AM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, lift such variables up into the next code
> block.
> 
> drivers/gpu/drm/drm_edid.c: In function ‘drm_edid_to_eld’:
> drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be
> executed [-Wswitch-unreachable]
>  4395 |     int sad_count;
>       |         ^~~~~~~~~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch, applied to drm-misc-next.
-Daniel

> ---
> v2: move into function block instead being switch-local (Ville Syrjälä)
> ---
>  drivers/gpu/drm/drm_edid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 805fb004c8eb..46cee78bc175 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -4381,6 +4381,7 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
>  
>  	if (cea_revision(cea) >= 3) {
>  		int i, start, end;
> +		int sad_count;
>  
>  		if (cea_db_offsets(cea, &start, &end)) {
>  			start = 0;
> @@ -4392,8 +4393,6 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
>  			dbl = cea_db_payload_len(db);
>  
>  			switch (cea_db_tag(db)) {
> -				int sad_count;
> -
>  			case AUDIO_BLOCK:
>  				/* Audio Data Block, contains SADs */
>  				sad_count = min(dbl / 3, 15 - total_sad_count);
> -- 
> 2.20.1
> 
> 
> -- 
> Kees Cook

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
