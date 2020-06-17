Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F6AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA52A2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592433707;
	bh=YUvm+FXf9gBPKzsr8POx9R4mVM7vfdQP4+DPhupgonQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YzO91P0JNV70hDYNmiM9nZRUqVlRUw8bAt2UgLe2bQwmUE+/kWFQ9FNoKI4cKBo2F
	 LEeRof1yDk/RcXHxq8WbRKiFX6vDzbkc674TEXb7gcFOeh8nVUMyVVrMo66pCyG01D
	 vucPwQkxByut9qKcoJDw3+YcIqwPWmEtuk18eExg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFQWlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:41:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37079 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQWlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:41:44 -0400
Received: by mail-il1-f193.google.com with SMTP id e11so3950594ilr.4;
        Wed, 17 Jun 2020 15:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xlfwwG2vm/RgPye0RWrcVCc+HKgMqaKW+0Ot0JPSfJs=;
        b=nDRyf5rwqMzG7n1Zg1B4Ae+C8o3p3UJNem0GMJ1Qa6ywQb3v4a+caJeom2Ma1lHQ5p
         V3TPETL1VUP2/YEIModaDQDqlbywBTy3aK3teE79j3s+7ZsAHIacLHrU4wb8niGUt9Dx
         fqAM/dGtyXlOn0ClwzOiTK0+y6Th4UvPsTbX+CnSaSEOYndmAnIUmDtq+A+MaaXwkEhI
         O9RR9tfcwlLGLYfW3m6PyTylaS/5YYne0O1UcacvMFY2/tTi/MSu67Be1Q2vIb8/oC1e
         6VF94E6Pm+7QhgXqaYsREWys40DgRvQOF0cvJ6NOBDj3WsaB4ryWVtF6egUiik9BklgQ
         FctA==
X-Gm-Message-State: AOAM533HWn0O0zyxoKTtCZg210m+JrxBfyz0GMVbDZRDWr20JcovmqaV
        jMcOq+7FXGkabjH5ummYKA==
X-Google-Smtp-Source: ABdhPJzdEBr14d5Rgh0EtjpCqbK5agDJX2lPwsxyKJHzXxGUsCUQwcc4dbDzsuyamrfKPQAZAUOXGQ==
X-Received: by 2002:a92:5e59:: with SMTP id s86mr1274594ilb.104.1592433703988;
        Wed, 17 Jun 2020 15:41:43 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z4sm648964iot.24.2020.06.17.15.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:41:43 -0700 (PDT)
Received: (nullmailer pid 2972301 invoked by uid 1000);
        Wed, 17 Jun 2020 22:41:42 -0000
Date:   Wed, 17 Jun 2020 16:41:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH RESEND v2 2/4] dt-bindings: display: simple: add Tianma
 TM070JVHG33
Message-ID: <20200617224142.GA2972272@bogus>
References: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
 <20200612072219.13669-3-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612072219.13669-3-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 09:22:17 +0200, Matthias Schiffer wrote:
> Add the Tianma Micro-electronics TM070JVHG33 7.0" WXGA display to the
> panel-simple compatible list.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: no changes
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
