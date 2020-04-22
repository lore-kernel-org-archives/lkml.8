Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32007C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA6F20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587572567;
	bh=ZoZyVaq22s38SwgSlAoEzZWSyA1+oaavMoyBfVfMs8U=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=er+aFLHOuG4wg1bmwMDnckhbtRcRDdalTWfVCmJJnlC6hz0rWbwjR8JfDS038M3QO
	 n+7kYx/44bDS1VuiRNagbKUn9L4vwMqznWg2Ceyo4YdCtPEgHqyOQd9xUuph+LoBGF
	 dSOIfcFteRvYmg5oAWairiDH10Se7ItcV07usXes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgDVQWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgDVQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:22:42 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6CC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:22:42 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y19so1156664qvv.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EjNhcH/bXfvIZUzEIVKgOCJoMZqdaN2tqLtyNe1ZM7c=;
        b=DTRIJ8iviVnMVICbRDafDZ0ZzbTidI7VRE4I8aJhBLYyvYSzst1rQtmNc8SIu2mR5S
         +OsIC9oE1hLB9e8G6GB9r7LP37oeG8bt5D12jMhzfWUYny1mM4Ospo9TbkRL3W0g9m2U
         ENNiGMWwdGxlHA+HzA//YNhNriKkqhHBiodwIO9I/wsig9loxKVhKqIxVc2v64543C/G
         1K/z4Duh8+B9n2Kvnq5AzY5KKaMyJ2qKPyttM26pFyOiSPPptiz4GrGVl5APASoKpPtL
         sl7ODCd1JmhGb8Dv5DyK6SMgVCoFGwk2cUFXZ9eEVzxZt2DA0eEdzu8hyt6g4dnSOBFU
         sRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EjNhcH/bXfvIZUzEIVKgOCJoMZqdaN2tqLtyNe1ZM7c=;
        b=Vs9i55KZUfX5totTSN/aca0CGzvQhTp3iQTN9P97HF3odnX+IGtUpWNZvNJE6/TW3h
         45dAMq0ZiuPVJtGnP14xCir9TVWjowjqD/9gmlPwympCm3XMPwyZL772ujwIxksIz0fL
         x6iPUvsL4ND4S7aMly3Mf2augudYAU5RqIg1/Ja07rCNAfyWOPsXZ90N4J60/LhigGMx
         kH5DDX/mcV8k/D06Zvj11o7KD8f8NmJGC78we0NubnZ+a5ZGVKbUiUVuGcef5Z5Hvgll
         E1wObCCuxQQNlb/XD0NJoe02diPS0Ge8H3Mshd98JfcNl71G8qgyngw6kZG3b+djMot3
         S9Rw==
X-Gm-Message-State: AGi0PubzWAwQ78KL+EZWC0Gi4K/dHRE51XmQKa7/5NJq5nto8EEwbt9O
        uUrRnbpfK/fmZvqOJ9Ez8K8=
X-Google-Smtp-Source: APiQypLIRBkrRvorZmQzP9AyOatxObc8z0ffbAJgLwrskkjNJkq9DGhP7FwWpCURk/qaK3ZekGrgqQ==
X-Received: by 2002:a0c:ba2e:: with SMTP id w46mr24906882qvf.97.1587572560936;
        Wed, 22 Apr 2020 09:22:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6260])
        by smtp.gmail.com with ESMTPSA id o201sm4228901qke.31.2020.04.22.09.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 09:22:39 -0700 (PDT)
Date:   Wed, 22 Apr 2020 12:22:38 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [Poke: Tejun] Re: [RFC v3 03/11] drm/vblank: Add vblank works
Message-ID: <20200422162238.GC5462@mtj.thefacebook.com>
References: <20200417194145.36350-1-lyude@redhat.com>
 <20200417194145.36350-4-lyude@redhat.com>
 <ef9da9d93022822fe4bec7e906540fcc9852ce59.camel@redhat.com>
 <20200417210356.GD43469@mtj.thefacebook.com>
 <20200421123459.GY3456981@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421123459.GY3456981@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 21, 2020 at 02:34:59PM +0200, Daniel Vetter wrote:
> > > Also, of course, let me know if yu're not happy with the
> > > __kthread_queue_work() changes/kthread_worker usage in drm_vblank_work as well
> > 
> > Just glanced over it and I still wonder whether it needs to be that tightly
> > integrated, but we can look into that once we settle on whether this is the
> > right direction.
> 
> I don't think we absolutely have to do this, simply means some nested
> irq-safe spinlock. One in vblank_work, other in kthread_worker. Since the
> delayed work doesn't do that I think it'd be nice if the drm_vblank
> (instead of timer) delayed work could use the same pattern.

I'd prefer if they were two separate locks unless that makes practical
difference, but if it does, please go ahead.

Thanks.

-- 
tejun
