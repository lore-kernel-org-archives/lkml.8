Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F02C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3618420774
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586888264;
	bh=+a/BOvyF1nFbSF2+1Glhbzw9VpNuc7PaYgVijezPBm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fzmQoTLMoZf6KIfktZE1jozVdrLlECQk+lVkyIrYId3WQeaQzt7V91KJe5uuMBJe8
	 9Uxogr0SNv3tqSzqbjUZAYJBHKQ/4hx5V4cwQVBb8VhCJ+spIkeWsKHJzQL07IxY6Y
	 RRH4w7iK7qI8Gx2lm69znz4qnnwcPbV3l23yEJzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503751AbgDNSRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503749AbgDNSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:17:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:17:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x66so14331416qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jmuf5ljJDQYQlumUw5CE4lMT7WuPAzl9vVKIeyphu/Q=;
        b=q4t7D7Nx9JdZPx0ByfS5AhxNJq9N2BxvE7kQG90ceCIGO5LHNUuCJE6btrAga0AyWK
         Ff8ULgZiDRnV39I2hUlFDmOa8qxrHFJ8rVFNqdn4RGEeolN5EjwpSbbJSvQn+W/Yu4n1
         j3UfEfjmQbJrVg562qwy/l0ov5FGFXcRC3D4wJCNgn76zgoc/2ePVTDhapWyX4tqqMAy
         MFCFFFln8sPijvSY7noESgdjGJNyVQJrrcRcfK7ABGULVyVVxeQqcAXb8Q86keCL5ErN
         SkWfBqrs+TjaPW9eVkIOCxuPzdtI9rCSIceTO4/2tI0dJ/hySVWkz3hlxhmP000wJadG
         IglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Jmuf5ljJDQYQlumUw5CE4lMT7WuPAzl9vVKIeyphu/Q=;
        b=qUjoOtI3sdtYypTLrW8n0HkreFUugaXIHS8y/bQDwcqcdYDT4GCwFjUo+KCCG+9/9V
         EUiB0LcS0e41dxrRFLzNIJaM8OKuZeSLv2p175Cthc9GbDGcbK8khxGB+r984McP0vvI
         KKgkL7S4Ofohe1M74Vu0bdEluRSpnE3Ofcq5U0O9QkxxCzOlON2F7TZ5Ab76+w1Zif1q
         UzdVc1ZMTK8Rh/uu0mSN2dQ8EZMVxSeiXITxmu/Cyu0XQMxRgiHBlUyfbjQTW5FRwO56
         5rXN6JUiNrr4ed/umhcNcF1MqCggslE/QfQDj7FT+TJeBvcmxtEcqO0poQaq7Mlu0q5G
         5rfQ==
X-Gm-Message-State: AGi0PuYSOH0NYm+oKVnrS/wnYMzzl6Np+Bt+HJPJsPepIYX5TixIrcYx
        DrdDmUC/T2tUTeAty8jJbYc=
X-Google-Smtp-Source: APiQypIWgAuJlpzTd7frVJeC8OfRdbf5Qx0nhzJhmfIbqCvJwjb7wZkVSJLAZq5w+foJkNOJYG9YtQ==
X-Received: by 2002:a37:a5d7:: with SMTP id o206mr11623774qke.90.1586888234033;
        Tue, 14 Apr 2020 11:17:14 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id m1sm11805229qtm.22.2020.04.14.11.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:17:13 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:17:11 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] drm/vblank: Add vblank works
Message-ID: <20200414181711.GO60335@mtj.duckdns.org>
References: <20200318004159.235623-1-lyude@redhat.com>
 <20200318004159.235623-2-lyude@redhat.com>
 <20200318134657.GV2363188@phenom.ffwll.local>
 <e4fb0c39ec024d60587e5e1e70b171b99eb537f4.camel@redhat.com>
 <faf63d8a9ed23c16af69762f59d0dca6b2bf085f.camel@redhat.com>
 <96cb912809f99d04cd5cdd46c77b66b8c1163380.camel@redhat.com>
 <20200413204243.GL60335@mtj.duckdns.org>
 <a2d9da054ace3f0ff59373c5a6252f25e1c3df4b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d9da054ace3f0ff59373c5a6252f25e1c3df4b.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 14, 2020 at 12:52:51PM -0400, Lyude Paul wrote:
> Hi, thanks for the response! And yes-I think this would actually be perfect
> for what we need, I guess one question I might as well ask since I've got you
> here: would patches to expose an unlocked version of kthread_queue_worker() be
> accepted? With something like that I should be able to just reuse the
> delayed_work_list and spinlocks that come with kthread_worker which would make
> the vblank works implementation a bit easier

Difficult to tell w/o looking at the code but if technically reasonable and
justified, I don't see a reason why something like that couldn't be accepted.
That said, whatever gain coming from sharing an inner lock like that usually
is miniscule and API and logic simplicity often easily outweighs.

Thanks.

-- 
tejun
